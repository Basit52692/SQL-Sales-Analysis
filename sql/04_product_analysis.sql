-- 04. PRODUCT AND CATEGORY ANALYSIS

-- Category performance
SELECT
    category,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY category
ORDER BY sales DESC;

-- Sub-category ranking by sales
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM sales_orders
GROUP BY sub_category
ORDER BY sales_rank, sub_category;

-- Top products by sales
SELECT
    product_name,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY product_name
ORDER BY sales DESC
LIMIT 10;

-- Products with the weakest margin (minimum 100 orders to avoid tiny groups)
SELECT
    product_name,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY product_name
HAVING COUNT(*) >= 100
ORDER BY margin_pct ASC, sales DESC;
