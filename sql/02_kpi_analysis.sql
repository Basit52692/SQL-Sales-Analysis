-- 02. CORE KPI ANALYSIS

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct,
    ROUND(AVG(sales), 2) AS avg_order_value,
    SUM(quantity) AS total_units
FROM sales_orders;

-- KPI trend by year
SELECT
    EXTRACT(YEAR FROM order_date)::INT AS year,
    COUNT(*) AS orders,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY 1
ORDER BY 1;
