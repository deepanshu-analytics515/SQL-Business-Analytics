-- KPI Report

-- Total Revenue
SELECT SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM sales;

-- Average Order Value
SELECT AVG(s.quantity * p.price) AS avg_order_value
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- Top 5 Customers by Revenue
SELECT c.customer_name, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 5;
