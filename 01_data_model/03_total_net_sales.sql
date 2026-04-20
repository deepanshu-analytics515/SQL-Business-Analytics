-- FILE: 03_total_net_sales.sql
-- PURPOSE: Calculate final net sales after all discounts

SELECT 
    f.date,
    f.fiscal_year,
    f.customer_code,
    dc.customer,
    f.market,
    f.product_code,
    dp.product,
    dp.variant,
    f.sold_quantity,

    -- Gross price
    ROUND(g.gross_price,2) AS gross_price_per_item,

    -- Gross total
    ROUND(f.sold_quantity * g.gross_price,2) AS gross_price_total,

    -- Pre-invoice discount
    ROUND(pr.pre_invoice_discount_pct,2) AS pre_invoice_discount_pct,

    -- Net invoice sales
    ROUND(
        (f.sold_quantity * g.gross_price) * 
        (1 - pr.pre_invoice_discount_pct),
    2) AS net_invoice_sales,

    -- Post invoice deductions
    (po.discounts_pct + po.other_deductions_pct) AS post_invoice_deductions,

    -- FINAL NET SALES
    ROUND(
        ((f.sold_quantity * g.gross_price) * 
        (1 - pr.pre_invoice_discount_pct)) *
        (1 - (po.discounts_pct + po.other_deductions_pct)),
    2) AS net_sales

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
    AND f.fiscal_year = pr.fiscal_year

JOIN post_invoice_deductions po
    ON f.customer_code = po.customer_code
    AND f.product_code = po.product_code 
    AND f.date = po.date;