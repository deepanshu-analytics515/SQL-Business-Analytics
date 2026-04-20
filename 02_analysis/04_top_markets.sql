-- FILE: 04_top_markets.sql
-- PURPOSE: Top 5 markets by net sales (FY 2021)

SELECT 
    ns.market,
    ROUND(SUM(ns.net_sales)/1000000,2) AS total_net_sales_mln
FROM total_net_sales ns
WHERE ns.fiscal_year = 2021
GROUP BY ns.market
ORDER BY total_net_sales_mln DESC
LIMIT 5;