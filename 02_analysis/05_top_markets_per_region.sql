-- FILE: 05_top_markets_per_region.sql
-- PURPOSE: Top 2 markets in each region by gross sales (FY 2021)

WITH cte1 AS (
    SELECT 
        m.market,
        CASE 
            WHEN m.region = 'nan' THEN 'NA'
            ELSE m.region
        END AS region,
        ROUND(SUM(s.sold_quantity * g.gross_price)/1000000,2) AS gross_sales_mln
    FROM fact_sales_monthly s
    JOIN dim_market m 
        ON s.market = m.market
    JOIN gross_price g
        ON s.product_code = g.product_code
        AND s.fiscal_year = g.fiscal_year
    WHERE s.fiscal_year = 2021
    GROUP BY m.market, region
),

cte2 AS (
    SELECT *,
        DENSE_RANK() OVER(
            PARTITION BY region 
            ORDER BY gross_sales_mln DESC
        ) AS rank_in_region
    FROM cte1
)

SELECT *
FROM cte2
WHERE rank_in_region <= 2
ORDER BY region;