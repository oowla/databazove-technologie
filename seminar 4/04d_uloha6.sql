WITH customer_activity AS (
    SELECT customer_id,
        MAX(order_date) OVER (PARTITION BY customer_id) AS last_order_date,
        MAX(order_date) OVER () AS latest_order_date
    FROM orders
)
SELECT DISTINCT c.customer_id, c.customer_name, a.last_order_date
FROM customer_activity a
JOIN customers c ON c.customer_id = a.customer_id
WHERE a.last_order_date < a.latest_order_date - INTERVAL '90 days'
ORDER BY a.last_order_date;
