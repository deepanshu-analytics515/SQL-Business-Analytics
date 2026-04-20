-- Total quantity sold per product
SELECT p.product_name, SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Revenue per product
SELECT p.product_name, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Revenue per customer
SELECT c.customer_name, SUM(s.quantity * p.price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_name;

-- Sales by city
SELECT c.city, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.city;
