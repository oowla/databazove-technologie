SELECT c.region, COUNT(CASE WHEN o.sales > 1000 THEN 1 END) AS highvalue, COUNT(CASE WHEN o.sales < 1000 THEN 1 END) AS lowvalue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region