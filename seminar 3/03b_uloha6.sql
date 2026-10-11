WITH RECURSIVE date_bounds AS (
    SELECT MIN(sale_date) AS start_date,
        MAX(sale_date) AS end_date
    FROM flourmills_sales
),
sales_calendar AS (
    SELECT start_date AS calendar_date
    FROM date_bounds

    UNION ALL

    SELECT c.calendar_date + 1
    FROM sales_calendar c
    CROSS JOIN date_bounds b
    WHERE c.calendar_date < b.end_date
)
SELECT calendar_date
FROM sales_calendar
ORDER BY calendar_date ASC;
