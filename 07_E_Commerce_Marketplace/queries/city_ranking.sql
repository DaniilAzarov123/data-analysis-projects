-- info by city
WITH city_table AS (
    SELECT
        o.customer_id, c.customer_city,
        o.order_id, o.order_status
    FROM orders o
        LEFT JOIN customers c 
            ON o.customer_id=c.customer_id
),
-- Revenue by order
order_revenue AS (
    SELECT 
        order_id,
        SUM(price) AS order_revenue
    FROM order_items
    GROUP BY order_id
),
-- Add revenue info to city table
city_revenue AS (
    SELECT 
        c_t.customer_id, c_t.customer_city, 
        c_t.order_id, c_t.order_status, 
        o_r.order_revenue
    FROM city_table c_t 
        LEFT JOIN order_revenue o_r 
            ON c_t.order_id = o_r.order_id
)

-- City, customers, orders, revenue
SELECT
    customer_city,
    
    -- Rank
    RANK() OVER(
        ORDER BY COUNT(DISTINCT customer_id) DESC
        ) AS rank_paying_customers_count,
        
    -- Customers
    COUNT(DISTINCT customer_id) AS paying_customers_count,
    
    -- Orders
    COUNT(order_id) AS orders_count_total,
    SUM(CASE WHEN order_status='Delivered' THEN 1 ELSE 0 END) AS orders_count_delivered,
    SUM(CASE WHEN order_status='Delivered' THEN 1 ELSE 0 END)::numeric / COUNT(order_id) AS redemption_rate,
    
    -- Revenue
    SUM(CASE WHEN order_status='Delivered' THEN order_revenue ELSE 0 END) AS revenue,
    SUM(CASE WHEN order_status='Delivered' THEN order_revenue ELSE 0 END) /
        SUM(SUM(CASE WHEN order_status='Delivered' THEN order_revenue ELSE 0 END)) OVER() AS revenue_prop_total
FROM city_revenue
GROUP BY customer_city
ORDER BY rank_paying_customers_count
