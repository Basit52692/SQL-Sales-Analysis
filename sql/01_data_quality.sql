-- 01. DATA QUALITY CHECKS

-- Record count and date coverage
SELECT
    COUNT(*) AS row_count,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM sales_orders;

-- Duplicate Order IDs (should return no rows because Order ID is the table key)
SELECT order_id, COUNT(*) AS duplicate_count
FROM sales_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Missing-value audit
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_id,
    COUNT(*) FILTER (WHERE product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM sales_orders;

-- Invalid shipping dates
SELECT COUNT(*) AS ship_before_order_count
FROM sales_orders
WHERE ship_date < order_date;

-- Negative-profit records are valid observations, not automatically errors
SELECT
    COUNT(*) AS loss_making_orders,
    ROUND(SUM(profit), 2) AS total_loss
FROM sales_orders
WHERE profit < 0;

-- Dataset grain check: each customer and product ID occurs once in this practice dataset
SELECT
    COUNT(*) AS rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM sales_orders;
