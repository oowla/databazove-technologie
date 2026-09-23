SELECT c.customer_name, o.order_id, o.sales
FROM orders o
FULL OUTER JOIN customers c ON c.customer_id = o.customer_id