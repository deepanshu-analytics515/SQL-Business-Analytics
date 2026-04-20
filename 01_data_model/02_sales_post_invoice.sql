-- FILE: 02_sales_post_invoice.sql
-- PURPOSE: Calculate net invoice sales after pre-invoice discount 
--          and apply post-invoice deductions

-- =====================================================

SELECT 
    sp.*,

    -- Net invoice sales after pre-invoice discount
    ROUND(
        sp.gross_price_total * (1 - sp.pre_invoice_discount_pct),
        2
    ) AS net_invoice_sales,

    -- Total post-invoice deductions
    (po.discounts_pct + po.other_deductions_pct) AS post_invoice_deductions

FROM sales_preinv_discount sp

JOIN post_invoice_deductions po
    ON sp.customer_code = po.customer_code
    AND sp.product_code = po.product_code
    AND sp.date = po.date;