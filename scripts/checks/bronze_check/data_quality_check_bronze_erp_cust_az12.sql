--//-- Check for out-of-range dates
SELECT DISTINCT 
bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE() OR bdate < '1926-01-01'

--//-- Check data consistency
SELECT DISTINCT 
CASE 
	WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	ELSE 'n/a'
END gen
FROM bronze.erp_cust_az12