CREATE OR REPLACE PROCEDURE get_customer_sales(
    p_customer_id VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
DECLARE
    total_sales NUMERIC(18, 2);
BEGIN
    SELECT SUM(o.sales)
    INTO total_sales
    FROM orders o
    WHERE o.customer_id = p_customer_id;

    RAISE NOTICE 'Zakaznik: %, celkovy predaj: %',
        p_customer_id, total_sales;
END;
$$;

CALL get_customer_sales('C001');
