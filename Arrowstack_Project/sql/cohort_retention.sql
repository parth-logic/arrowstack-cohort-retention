WITH first_purchase AS (
    SELECT
        customer_id,
        DATE(MIN(order_date), 'start of month') AS cohort_month
    FROM orders_clean
    WHERE order_status = 'Completed'
    GROUP BY customer_id
),

active_customer_months AS (
    SELECT DISTINCT
        customer_id,
        DATE(order_date, 'start of month') AS activity_month
    FROM orders_clean
    WHERE order_status = 'Completed'
),

cohort_activity AS (
    SELECT
        f.cohort_month,
        a.activity_month,
        (
            (CAST(strftime('%Y', a.activity_month) AS INTEGER)
             - CAST(strftime('%Y', f.cohort_month) AS INTEGER)) * 12
            +
            (CAST(strftime('%m', a.activity_month) AS INTEGER)
             - CAST(strftime('%m', f.cohort_month) AS INTEGER))
        ) AS month_number,
        f.customer_id
    FROM first_purchase AS f
    JOIN active_customer_months AS a
        ON f.customer_id = a.customer_id
    WHERE a.activity_month >= f.cohort_month
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_customers
    FROM first_purchase
    GROUP BY cohort_month
),

retention AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_id) AS retained_customers
    FROM cohort_activity
    GROUP BY cohort_month, month_number
)

SELECT
    r.cohort_month,
    cs.cohort_customers,
    r.month_number,
    r.retained_customers,
    ROUND(
        100.0 * r.retained_customers / cs.cohort_customers,
        2
    ) AS retention_percentage
FROM retention AS r
JOIN cohort_sizes AS cs
    ON r.cohort_month = cs.cohort_month
ORDER BY r.cohort_month, r.month_number;