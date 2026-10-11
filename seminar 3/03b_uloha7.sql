WITH RECURSIVE monthly_revenue AS (
    SELECT DATE_TRUNC('month', sale_date)::DATE AS month,
        SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY DATE_TRUNC('month', sale_date)::DATE
),
ordered_months AS (
    SELECT ROW_NUMBER() OVER (ORDER BY month) AS rn,
        month, revenue
    FROM monthly_revenue
),
cumulative_target AS (
    SELECT rn, month, revenue,
        revenue AS cumulative_revenue
    FROM ordered_months
    WHERE rn = 1

    UNION ALL

    SELECT m.rn, m.month, m.revenue,
        c.cumulative_revenue + m.revenue
    FROM cumulative_target c
    JOIN ordered_months m ON m.rn = c.rn + 1
    WHERE c.cumulative_revenue < 500000000
)
SELECT month, revenue, cumulative_revenue
FROM cumulative_target
ORDER BY rn;
