SELECT c.customer_name, SUM(o.sales) AS celkovy_predaj, AVG(o.discount) AS priemerna_zlava, COUNT(o.customer_id) AS pocet_objednavok, CASE WHEN SUM(o.sales) > 2500 THEN 'VIP' ELSE 'REGULAR' END AS customer_category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name