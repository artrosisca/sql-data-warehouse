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
	ELSE 'Other'
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