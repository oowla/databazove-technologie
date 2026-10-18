WITH customer_purchases AS (
    SELECT customer_id, invoice_no, invoice_date, stock_code,
        description, quantity, unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id ORDER BY invoice_date
        ) AS purchase_rank
    FROM retail_sales
)
SELECT customer_id, invoice_no, invoice_date, stock_code,
    description, quantity, unit_price
FROM customer_purchases
WHERE purchase_rank = 1
ORDER BY customer_id;
