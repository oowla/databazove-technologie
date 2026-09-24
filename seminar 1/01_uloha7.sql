SELECT c.region, SUM(o.sales)
FROM orders o
FULL OUTER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region