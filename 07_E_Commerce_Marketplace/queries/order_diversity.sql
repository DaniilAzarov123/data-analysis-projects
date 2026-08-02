-- All delivered orders
WITH all_orders AS (
    SELECT 
        o.customer_id, o.order_id,
        oi.product_id, oi.order_item_id
    FROM orders o
        LEFT JOIN order_items oi ON o.order_id=oi.order_id
    WHERE o.order_status='Delivered'
),
-- How many unique products has a customer ordered
bag_diversity_table AS (
    SELECT 
        ao.customer_id, 
        COUNT(DISTINCT ao.product_id) AS customers_unique_products_count_total, -- products
        COUNT(DISTINCT p.product_brand) AS customers_unique_brands_count_total, -- brands
        COUNT(DISTINCT p.product_category_name) AS customers_unique_category_count_total -- categories
    FROM all_orders ao
        LEFT JOIN products p ON ao.product_id = p.product_id
    GROUP BY customer_id
),
-- How many items are in an order
order_size_table AS (
    SELECT 
        customer_id, 
        order_id, 
        MAX(order_item_id) AS order_size
    FROM all_orders
    GROUP BY customer_id, order_id
)
-- Join all together
SELECT 
    os.customer_id, os.order_id, os.order_size,
    bd.customers_unique_products_count_total,
    bd.customers_unique_brands_count_total,
    bd.customers_unique_category_count_total
FROM order_size_table os 
    LEFT JOIN bag_diversity_table bd 
        ON os.customer_id = bd.customer_id
ORDER BY os.customer_id, os.order_id
