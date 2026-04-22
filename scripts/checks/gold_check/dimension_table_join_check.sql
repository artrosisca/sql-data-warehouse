--//-- Checking for duplicates after joining the tables together
SELECT 
cst_id, 
COUNT(*)
FROM (
	SELECT 
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	ca.bdate,
	ca.gen,
	lc.cntry
	FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 AS ca
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS lc
	ON ci.cst_key = lc.cid
	) AS sub
GROUP BY cst_id
HAVING COUNT(*) > 1


--//-- Checking for duplicates after joining the tables together
SELECT prd_key, COUNT(*) 
FROM (
	SELECT 
		pn.prd_id,
		pn.cat_id,
		pn.prd_key,
		pn.prd_nm,
		pn.prd_cost,
		pn.prd_line,
		pn.prd_start_dt,
		pc.cat,
		pc.subcat,
		pc.maintence
	FROM silver.crm_prd_info AS pn
	LEFT JOIN silver.erp_px_cat_g1v2 AS pc
	ON pn.cat_id = pc.id
	WHERE prd_end_dt IS NULL --filter out the historical data // if is null it means it is the current information
) AS sub 
GROUP BY prd_key
HAVING COUNT(*) > 1
