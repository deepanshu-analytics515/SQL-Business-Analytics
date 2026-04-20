-- FILE: 02_top_customers.sql
-- PURPOSE: Top 10 customers by net sales contribution (FY 2021)

WITH cte AS (
    SELECT 
        dc.customer,
        ROUND(SUM(ns.net_sales)/1000000,2) AS total_net_sales_mln
    FROM total_net_sales ns
    JOIN dim_customer dc 
        ON ns.customer_code = dc.customer_code
    WHERE ns.fiscal_year = 2021
    GROUP BY dc.customer
)

SELECT *,
    ROUND(
        total_net_sales_mln * 100 / SUM(total_net_sales_mln) OVER(),
    2) AS pct
FROM cte
ORDER BY pct DESC
LIMIT 10;