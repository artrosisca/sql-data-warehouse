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

--//-- Check data
SELECT *
FROM silver.erp_px_cat_g1v2