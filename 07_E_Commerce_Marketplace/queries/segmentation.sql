-- Clients: city, registration date, days since registration
WITH clients_demograph AS (
    SELECT 
        customer_id, 
        customer_city,
        DATE_TRUNC('month',created_at)::date AS cohort,
        created_at AS registration_date,
        '2024-03-31'::date-created_at::date AS days_since_registration
    FROM customers
),
-- N delivered orders, avg delivery time
client_order_info AS (
    SELECT 
        customer_id, 
        COUNT(order_id) AS orders_count,
        AVG(EXTRACT(EPOCH FROM (order_delivered_customer_time - order_created_time)) / 86400.0) AS avg_delivery_days
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
),
-- Revenue 
customer_revenue AS (
    SELECT 
        o.customer_id,
        SUM(oi.price) AS revenue
    FROM orders o
        LEFT JOIN order_items oi 
            ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.customer_id
)
-- Join all datasets together
SELECT
    cd.customer_id, cd.customer_city, cd.cohort, cd.registration_date, cd.days_since_registration,
    coi.orders_count, coi.avg_delivery_days,
    cr.revenue,
    CASE 
        WHEN coi.orders_count >= 3 THEN 'regular'
        WHEN coi.orders_count >= 1 THEN 'one_time'
        WHEN cd.days_since_registration > 30 THEN 'inactive'
        ELSE 'new'
    END AS segment
FROM clients_demograph AS cd
    LEFT JOIN client_order_info AS coi ON cd.customer_id = coi.customer_id
    LEFT JOIN customer_revenue AS cr ON cd.customer_id = cr.customer_id
ORDER BY cd.customer_id
