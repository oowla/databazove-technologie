SELECT c.region, SUM(o.sales), AVG(o.discount), COUNT(o.order_id)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region