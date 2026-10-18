WITH monthly_totals AS (
    SELECT DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)::DATE
), monthly_comparison AS (
    SELECT month, monthly_sales,
        LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales
    FROM monthly_totals
)
SELECT month, monthly_sales, prev_month_sales,
    monthly_sales - prev_month_sales AS sales_change,
    ROUND((monthly_sales - prev_month_sales) /
        NULLIF(prev_month_sales, 0) * 100, 2) AS growth_percentage
FROM monthly_comparison
ORDER BY month;
