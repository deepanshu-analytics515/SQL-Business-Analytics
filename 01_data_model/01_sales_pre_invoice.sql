-- FILE: 01_sales_pre_invoice.sql
-- PURPOSE: Calculate gross sales and pre-invoice discount
-- =====================================================

SELECT 
    DATE(f.date) AS date,
    f.fiscal_year,
    f.customer_code,
    dc.customer,
    f.market,
    f.product_code,
    dp.product,
    dp.variant,
    f.sold_quantity,

    -- Price per item
    ROUND(g.gross_price, 2) AS gross_price_per_item,

    -- Total gross sales before discount
    ROUND(f.sold_quantity * g.gross_price, 2) AS gross_price_total,

    -- Pre-invoice discount %
    ROUND(pr.pre_invoice_discount_pct, 2) AS pre_invoice_discount_pct

FROM fact_sales_monthly f

JOIN dim_customer dc 
    ON f.customer_code = dc.customer_code

JOIN dim_product dp  
    ON f.product_code = dp.product_code

JOIN gross_price g
    ON f.product_code = g.product_code 
    AND f.fiscal_year = g.fiscal_year

JOIN pre_invoice_deductions pr
    ON f.customer_code = pr.customer_code 
    AND f.fiscal_year = pr.fiscal_year;