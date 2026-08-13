-- =========================================================
-- Customer Order Analysis — SQL Project
-- Schema: Customers, Products, Orders, Order_Items
-- =========================================================

-- 1. Total revenue and order volume overview
SELECT
    COUNT(DISTINCT o.order_id)      AS total_orders,
    COUNT(DISTINCT o.customer_id)   AS unique_customers,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS total_revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- 2. Top 10 customers by total spend (purchase behavior)
SELECT
    c.customer_name,
    c.city,
    c.country,
    COUNT(DISTINCT o.order_id) AS orders_placed,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Revenue by product category (product trend analysis)
SELECT
    p.category,
    COUNT(oi.order_item_id) AS items_sold,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS category_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 4. Monthly order trend (filtering + grouping by date)
SELECT
    strftime('%Y-%m', o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY order_month
ORDER BY order_month;

-- 5. Top 5 best-selling products by quantity
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_units_sold DESC
LIMIT 5;

-- 6. Customers by country (segment-level view using LEFT JOIN to include zero-order customers)
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COALESCE(SUM(oi.quantity * p.unit_price), 0), 2) AS revenue
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.country
ORDER BY revenue DESC;

-- 7. Average order value (AOV)
SELECT
    ROUND(SUM(oi.quantity * p.unit_price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- 8. Query optimization note:
-- Indexes were added on Orders.customer_id, Order_Items.order_id, and
-- Order_Items.product_id (see build_db.py) to speed up the joins above
-- when retrieving results from larger tables.
