CREATE OR REPLACE PROCEDURE apply_regional_discount(
    region_name VARCHAR(50),
    discount_rate NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders o
    SET sales = o.sales * (1 - discount_rate)
    WHERE o.region = region_name;

    RAISE NOTICE 'Zlava: %, region: %',
        discount_rate, region_name;
END;
$$;

CALL apply_regional_discount('West', 0.10);
