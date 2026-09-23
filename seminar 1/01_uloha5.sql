SELECT p.product_name, SUM(o.sales)
FROM orders o
FULL OUTER JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name