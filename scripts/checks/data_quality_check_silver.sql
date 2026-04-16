--\\-- Check for nulls or duplicates in PK

SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL; --adding OR so it doesnt miss a single null

--\\-- Check for unwanted spaces

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key)


--\\-- Check for consistency

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info