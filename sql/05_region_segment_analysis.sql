-- 05. REGION, CUSTOMER SEGMENT AND SHIPPING ANALYSIS

-- Regional performance
SELECT
    region,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY region
ORDER BY sales DESC;

-- Customer segment performance
SELECT
    segment,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(AVG(sales), 2) AS avg_order_value
FROM sales_orders
GROUP BY segment
ORDER BY sales DESC;

-- Shipping mode analysis
SELECT
    ship_mode,
    COUNT(*) AS orders,
    ROUND(AVG(ship_date - order_date), 2) AS avg_days_to_ship,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit
FROM sales_orders
GROUP BY ship_mode
ORDER BY orders DESC;

-- State contribution to total sales
WITH state_sales AS (
    SELECT state, SUM(sales) AS sales
    FROM sales_orders
    GROUP BY state
)
SELECT
    state,
    ROUND(sales, 2) AS sales,
    ROUND(100.0 * sales / SUM(sales) OVER (), 2) AS sales_share_pct
FROM state_sales
ORDER BY sales DESC;
