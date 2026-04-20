-- FILE: 03_top_products.sql
-- PURPOSE: Top 10 products by net sales (FY 2021)

SELECT 
    dp.product,
    ROUND(SUM(ns.net_sales)/1000000,2) AS total_net_sales_mln
FROM total_net_sales ns
JOIN dim_product dp 
    ON ns.product_code = dp.product_code
WHERE ns.fiscal_year = 2021
GROUP BY dp.product
ORDER BY total_net_sales_mln DESC
LIMIT 10;