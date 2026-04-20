-- FILE: 01_region_wise_sales.sql
-- PURPOSE: Calculate region-wise % net sales contribution by customers (FY 2021)

WITH cte AS (
    SELECT 
        dc.customer,
        CASE 
            WHEN m.region = 'nan' THEN 'NA'
            ELSE m.region
        END AS region,
        ROUND(SUM(ns.net_sales)/1000000,2) AS net_sales_mln
    FROM total_net_sales ns
    JOIN dim_customer dc 
        ON ns.customer_code = dc.customer_code
    JOIN dim_market m 
        ON ns.market = m.market
    WHERE ns.fiscal_year = 2021
    GROUP BY dc.customer, region
)

SELECT *,
    ROUND(
        net_sales_mln * 100 / SUM(net_sales_mln) OVER(PARTITION BY region),
    2) AS pct
FROM cte
ORDER BY region, pct DESC;