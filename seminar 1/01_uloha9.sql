SELECT p.sub_category, AVG(o.discount) 
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.sub_category