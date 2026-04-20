/*
============================
Stored Procedure: load 'bronze' layer (source -> bronze).
============================
Script Purpose:
  Loads the data from external CSV files into the 'bronze' schema.
  -Truncates the bronze tables before loading the data.
  -Uses 'BULK INSERT' command to load the data.
Usage example:
  EXEC bronze.load_bronze
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_bronze_time DATETIME, @end_bronze_time DATETIME;
	BEGIN TRY
		SET @start_bronze_time = GETDATE();
		PRINT '========================';
		PRINT 'Loading bronze layer';
		PRINT '========================';

		PRINT '--------------------';
		PRINT 'Loading crm tables';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT 'INSERTING DATA INTO: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\sql-datawarehouse\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT 'INSERTING DATA INTO: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\sql-datawarehouse\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';
		
		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT 'INSERTING DATA INTO: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\sql-datawarehouse\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		PRINT '--------------------'
		PRINT 'Loading erp tables'
		PRINT '--------------------'

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT 'INSERTING DATA INTO: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\sql-datawarehouse\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT 'INSERTING DATA INTO: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\sql-datawarehouse\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @start_time = GETDATE();
		PRINT 'TRUNCATING TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT 'INSERTING DATA INTO: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\sql-datawarehouse\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';

		SET @end_bronze_time = GETDATE();
		PRINT '=======================================================';
		PRINT 'Bronze layer COMPLETED - load duration: '+ CAST (DATEDIFF(second, @start_bronze_time, @end_bronze_time) AS NVARCHAR) + ' seconds';
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
