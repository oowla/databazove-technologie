SELECT c.customer_name, COUNT(o.customer_id) 
FROM customers c 
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name