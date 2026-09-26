-- 03. SALES TRENDS

-- Monthly sales and profit trend
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(*) AS orders
FROM sales_orders
GROUP BY 1
ORDER BY 1;

-- Month-over-month growth using LAG
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS sales
    FROM sales_orders
    GROUP BY 1
),
with_previous AS (
    SELECT
        month,
        sales,
        LAG(sales) OVER (ORDER BY month) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month,
    ROUND(sales, 2) AS sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(100.0 * (sales - previous_month_sales) / NULLIF(previous_month_sales, 0), 2) AS mom_growth_pct
FROM with_previous
ORDER BY month;

-- Year-over-year growth
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::INT AS year,
        SUM(sales) AS sales
    FROM sales_orders
    GROUP BY 1
),
yoy AS (
    SELECT
        year,
        sales,
        LAG(sales) OVER (ORDER BY year) AS previous_year_sales
    FROM yearly_sales
)
SELECT
    year,
    ROUND(sales, 2) AS sales,
    ROUND(100.0 * (sales - previous_year_sales) / NULLIF(previous_year_sales, 0), 2) AS yoy_growth_pct
FROM yoy
ORDER BY year;
