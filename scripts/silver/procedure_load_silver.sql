/*
============================
Stored Procedure: load 'silver' layer (bronze -> silver).
============================
Script Purpose:
  Loads the data from the bronze layer to the 'silver' schema.
  -Truncates the silver tables before loading the data.
  -Uses 'INSERT INTO' command to load the data.
Usage example:
  EXEC silver.load_silver
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_silver_time DATETIME, @end_silver_time DATETIME;
	BEGIN TRY
		SET @start_silver_time = GETDATE();
		PRINT '========================';
		PRINT 'Loading silver layer';
		PRINT '========================';

		PRINT '--------------------';
		PRINT 'Loading crm tables';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: silver.crm_cust_info'
		TRUNCATE TABLE silver.crm_cust_info;
		PRINT 'INSERTING DATA INTO: silver.crm_cust_info'
		INSERT INTO silver.crm_cust_info (
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT 
		cst_id, 
		cst_key, 
		TRIM(cst_firstname), 
		TRIM(cst_lastname), 
		CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			ELSE 'n/a'
		END cst_marital_status,
		CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female' --UPPER() só pra garantir que pegue caso tenhamos minusculo
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' --TRIM() parecido com o UPPER, mas para garantir caso algum tenha espaço
			ELSE 'n/a'
		END cst_gndr, --lembrar de dizer qual coluna em que os valores devem ser colocados
		cst_create_date
		FROM (
			SELECT *,
			ROW_NUMBER() OVER (
				PARTITION BY cst_id 
				ORDER BY cst_create_date
				DESC
			) AS flag_last
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT NULL
		) AS f
		WHERE flag_last = 1 
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: silver.crm_prd_info'
		TRUNCATE TABLE silver.crm_prd_info;
		PRINT 'INSERTING DATA INTO: silver.crm_prd_info'
		INSERT INTO silver.crm_prd_info (
			prd_id, 
			cat_id, 
			prd_key, 
			prd_nm, 
			prd_cost, 
			prd_line, 
			prd_start_dt, 
			prd_end_dt
		)
		SELECT 
			prd_id,
			REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
			SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
			prd_nm,
			ISNULL(prd_cost, 0) AS prd_cost, -- Se nullo troca por 0
			CASE UPPER(TRIM(prd_line)) --Quick Case When, use only for mapping
				WHEN 'M' THEN 'Mountain'
				WHEN 'R' THEN 'Road'
				WHEN 'S' THEN 'Other Sales'
				WHEN 'T' THEN 'Touring'
				ELSE 'n/a'
			END AS prd_line,
			CAST((prd_start_dt) AS DATE) AS prd_start_dt,
			CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt_test -- CAST para DATE ao inves de DATETIME, ja que nao tem informacao de horario
		FROM bronze.crm_prd_info
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: silver.crm_sales_details'
		TRUNCATE TABLE silver.crm_sales_details;
		PRINT 'INSERTING DATA INTO: silver.crm_sales_details'
		INSERT INTO silver.crm_sales_details (
			sls_ord_num,
			sls_prod_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price
		)
		SELECT 
			sls_ord_num,
			sls_prod_key,
			sls_cust_id,
			CASE 
				WHEN sls_order_dt = 0 OR LEN(sls_order_dt) !=8 THEN NULL
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) --sql server tem que passar de varchar para date, mas o databricks não tem esse problema
			END AS sls_order_dt,
			CASE 
				WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) !=8 THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) --atualizar no ddl do silver, o type de INT para DATE
			END AS sls_ship_dt,
			CASE 
				WHEN sls_due_dt = 0 OR LEN(sls_due_dt) !=8 THEN NULL
				ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) 
			END AS sls_due_dt,
			CASE 
				WHEN sls_sales IS NULL oR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price) --ABS() converte tudo de negativo para positivo
				THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END AS sls_sales,
			sls_quantity,
			CASE 
				WHEN sls_price IS NULL OR sls_price <= 0
				THEN sls_sales / NULLIF(sls_quantity, 0) --NULLIF() evita divisão por zero, se quantity for zero, retorna NULL
				ELSE sls_price
			END AS sls_price
		FROM bronze.crm_sales_details
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		PRINT '--------------------'
		PRINT 'Loading erp tables'
		PRINT '--------------------'

		SET @start_time = GETDATE()
		PRINT 'TRUNCATING TABLE: silver.erp_cust_az12'
		TRUNCATE TABLE silver.erp_cust_az12;
		PRINT 'INSERTING DATA INTO: silver.erp_cust_az12'
		INSERT INTO silver.erp_cust_az12 (
			cid, 
			bdate, 
			gen
		)
		SELECT 
		CASE 
			WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
			ELSE cid
		END cid,
		CASE 
			WHEN bdate > GETDATE() THEN NULL
			ELSE bdate
		END bdate,
		CASE 
			WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
			WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
			ELSE 'n/a'
		END gen
		FROM bronze.erp_cust_az12

		PRINT 'TRUNCATING TABLE: silver.erp_loc_a101'
		TRUNCATE TABLE silver.erp_loc_a101;
		PRINT 'INSERTING DATA INTO: silver.erp_loc_a101'
		INSERT INTO silver.erp_loc_a101 (
			cid,
			cntry
		)
		SELECT 
		REPLACE(cid, '-', '') AS cid,
		CASE 
			WHEN TRIM(cntry) = 'DE' THEN 'Germany'
			WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
			WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
			WHEN TRIM(cntry) = 'FR' THEN 'France'
			ELSE TRIM(cntry)
		END AS cntry
		FROM bronze.erp_loc_a101
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE()
		PRINT 'TRUNCATING TABLE: silver.erp_px_cat_g1v2'
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		PRINT 'INSERTING DATA INTO: silver.erp_px_cat_g1v2'
		INSERT INTO silver.erp_px_cat_g1v2 (
			id,
			cat,
			subcat,
			maintence
		)
		SELECT 
		id,
		cat,
		subcat,
		maintence
		FROM bronze.erp_px_cat_g1v2
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @end_silver_time = GETDATE();
		PRINT '=======================================================';
		PRINT 'Silver layer COMPLETED - load duration: '+ CAST (DATEDIFF(second, @start_silver_time, @end_silver_time) AS NVARCHAR) + ' seconds';
		PRINT '=======================================================';
	END TRY

	BEGIN CATCH
		PRINT '====================================';
		PRINT 'ERROR during loading bronze layer';
		PRINT 'ERROR Message'+ ERROR_MESSAGE();
		PRINT 'ERROR Number'+ CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR Number'+ CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '====================================';
	END CATCH
END