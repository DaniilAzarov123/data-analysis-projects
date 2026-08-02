-- How late each order is
-- Positive values correspond to late orders
-- For returned/in transit orders - set delivery date as of the latest available date (2024-03-31 23:59:59)
SELECT
    o.customer_id, c.customer_city, o.order_id, o.order_status,
    COALESCE(o.order_delivered_customer_time, '2024-03-31 23:59:59'::timestamp) AS order_delivered_customer_time,
    EXTRACT(EPOCH FROM (
        COALESCE(o.order_delivered_customer_time, '2024-03-31 23:59:59'::timestamp) - o.order_estimated_delivery_time
    )) / 86400 AS how_late_days
FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.customer_id, o.order_id
