-- 06. DISCOUNT AND PROFITABILITY ANALYSIS

-- Profitability by exact discount level
SELECT
    ROUND(discount * 100, 0) AS discount_pct,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY discount
ORDER BY discount;

-- Business-friendly discount bands using CASE WHEN
SELECT
    CASE
        WHEN discount = 0 THEN 'No discount'
        WHEN discount <= 0.10 THEN 'Low (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium (11-20%)'
        ELSE 'High (21%+)'
    END AS discount_band,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY 1
ORDER BY MIN(discount);

-- Category x discount matrix: where does discount pressure hurt margin most?
SELECT
    category,
    ROUND(discount * 100, 0) AS discount_pct,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY category, discount
ORDER BY category, discount;
