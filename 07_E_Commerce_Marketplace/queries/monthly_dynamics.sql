-- Customers registration date, customer_city, cohort
WITH customers_info AS (
    SELECT 
        customer_id, 
        customer_city, 
        DATE_TRUNC('month',created_at)::date AS cohort,
        COUNT(customer_id) OVER(
            PARTITION BY customer_city, DATE_TRUNC('month',created_at)
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cohort_size
    FROM customers
),
-- N purchases each month by each customer
customer_purchases AS (
    SELECT 
        ci.customer_id,
        ci.customer_city,
        ci.cohort,
        ci.cohort_size,
        DATE_TRUNC('month', ca.event_timestamp)::date AS event_month,
        SUM(CASE WHEN ca.event_type = 'Purchase' THEN 1 ELSE 0 END) AS n_purchases
    FROM customer_actions ca 
        FULL OUTER JOIN customers_info ci 
            ON ca.customer_id = ci.customer_id
    GROUP BY 
        ci.customer_id,
        ci.customer_city,
        ci.cohort,
        ci.cohort_size,
        DATE_TRUNC('month', ca.event_timestamp)
    ORDER BY ci.customer_id, event_month
),
-- Monthly retention by cohort
retention_table AS (
    SELECT 
        customer_city, 
        cohort, 
        cohort_size,
        event_month,
        RANK() OVER(
            PARTITION BY customer_city, cohort
            ORDER BY event_month) - 1 AS which_month,
        COUNT(CASE WHEN n_purchases>0 THEN 1 ELSE NULL END) AS n_customers_made_purchase,
        COUNT(CASE WHEN n_purchases>0 THEN 1 ELSE NULL END)::numeric / cohort_size AS retention
    FROM customer_purchases
    GROUP BY customer_city, cohort,cohort_size, event_month
    ORDER BY customer_city, cohort, event_month
),
-- Revenue from each order
order_prices AS (
    SELECT
        order_id, SUM(price) AS order_price
    FROM order_items
    GROUP BY order_id
),
-- Revenue from each delivered order for each customer
customer_revenue AS (
    SELECT 
        o.customer_id, 
        ci.customer_city,
        ci.cohort,
        DATE_TRUNC('month',o.order_created_time)::date AS order_month,
        o.order_id,
        op.order_price
    FROM orders o 
        LEFT JOIN customers_info ci 
            ON o.customer_id=ci.customer_id
        LEFT JOIN order_prices op 
            ON  o.order_id = op.order_id
    WHERE o.order_status = 'Delivered'
),
-- Revenue for each cohort in each month
cohort_revenue AS (
    SELECT 
        customer_city, 
        cohort, 
        order_month,
        SUM(order_price) AS revenue
    FROM customer_revenue
    GROUP BY customer_city, cohort, order_month
)
-- Cohort's retention, revenue and MoM revenue in every city & month
SELECT 
    rt.customer_city,
    rt.cohort,
    rt.cohort_size,
    rt.event_month,
    rt.which_month,
    rt.n_customers_made_purchase,
    rt.retention,
    cr.revenue,
    (cr.revenue - LAG(cr.revenue, 1) OVER(
        PARTITION BY rt.customer_city, rt.cohort
        ORDER BY rt.event_month)) 
        / 
    LAG(cr.revenue, 1) OVER(
        PARTITION BY rt.customer_city, rt.cohort
        ORDER BY rt.event_month) AS mom_revenue
FROM retention_table rt
    LEFT JOIN cohort_revenue cr
        ON rt.customer_city = cr.customer_city 
            AND rt.cohort = cr.cohort
            AND rt.event_month = cr.order_month
