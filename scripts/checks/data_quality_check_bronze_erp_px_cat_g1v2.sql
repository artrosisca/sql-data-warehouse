--//-- Check ids
SELECT 
id
FROM bronze.erp_px_cat_g1v2
WHERE id IN (SELECT cat_id FROM silver.crm_prd_info)

--//-- Check for unwanted sapce
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintence != TRIM(maintence)

--//-- Data consistency and standardization
SELECT DISTINCT
cat,
maintence
FROM bronze.erp_px_cat_g1v2