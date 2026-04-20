--//-- Check for dates
SELECT 
NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) != 8 
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101

--//-- Check for invalid dates orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-- BUSINESS RULES, sales é quantity multiplicado por price (Sales = Quantity * Price)
-- NEGATIVE, ZEROS, NULLS are not allowed tambem!

--//-- Check data consistency between sales, quantity and price
SELECT 
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_sales <= 0 
OR sls_quantity IS NULL OR sls_quantity <= 0 
OR sls_price IS NULL OR sls_price <= 0 
ORDER BY sls_sales, sls_quantity, sls_price	

--//--
SELECT *
FROM silver.crm_sales_details