--//-- Check for missing cid 
SELECT 
REPLACE(cid, '-', '') AS cid
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '') 
NOT IN (SELECT cst_key FROM silver.crm_cust_info)

--//-- Check data consistency
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry ASC

--//--
SELECT 
REPLACE(cid, '-', '') AS cid,
cntry,
CASE --quick CASE nao suporta IN ou IS NULL
    WHEN TRIM(cntry) = 'DE' THEN 'Germany'
    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
    WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
    WHEN TRIM(cntry) = 'FR' THEN 'France'
    ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101
WHERE cntry = 'USA'