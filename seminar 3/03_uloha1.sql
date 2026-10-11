CREATE OR REPLACE VIEW high_value_customers AS
SELECT SUM(o.sales) AS total_sales, c.customer_id, c.customer_name
FROM customers c
JOIN orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(sales) > 2000;

SELECT *
FROM high_value_customers;