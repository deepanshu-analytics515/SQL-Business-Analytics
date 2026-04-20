-- KPI Report

-- Total Revenue
SELECT SUM(amount) AS total_revenue FROM sales;

-- Total Orders
SELECT COUNT(*) AS total_orders FROM sales;

-- Top Customers
SELECT customer_id, SUM(amount) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC;
