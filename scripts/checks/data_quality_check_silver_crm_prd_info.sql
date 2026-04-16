--\\-- Check for nulls or duplicates in PK

SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;
--No results, 
--\\-- Check for unwanted spaces

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)
--No results,
--\\-- Check for consistency

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL
--No results,

SELECT DISTINCT prd_line
FROM silver.crm_prd_info
--No results,

--//-- Check for date orders

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt
--No results,