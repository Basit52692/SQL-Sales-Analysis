-- 08. BUSINESS QUESTIONS / FINAL ANALYSIS

-- Q1: Which areas contribute the most sales and profit?
SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY region, category
ORDER BY sales DESC;

-- Q2: Which high-sales combinations have below-company-average margins?
WITH company AS (
    SELECT SUM(profit) / NULLIF(SUM(sales), 0) AS company_margin
    FROM sales_orders
),
combo AS (
    SELECT
        region,
        category,
        SUM(sales) AS sales,
        SUM(profit) / NULLIF(SUM(sales), 0) AS margin
    FROM sales_orders
    GROUP BY region, category
)
SELECT
    region,
    category,
    ROUND(sales, 2) AS sales,
    ROUND(100.0 * margin, 2) AS margin_pct
FROM combo
CROSS JOIN company
WHERE margin < company_margin
ORDER BY sales DESC;

-- Q3: Which months were unusually strong or weak relative to a 3-month moving average?
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS sales
    FROM sales_orders
    GROUP BY 1
),
smoothed AS (
    SELECT
        month,
        sales,
        AVG(sales) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS moving_avg_3m
    FROM monthly
)
SELECT
    month,
    ROUND(sales, 2) AS sales,
    ROUND(moving_avg_3m, 2) AS moving_avg_3m,
    ROUND(100.0 * (sales - moving_avg_3m) / NULLIF(moving_avg_3m, 0), 2) AS variance_vs_3m_avg_pct
FROM smoothed
ORDER BY month;

-- Q4: What is the relationship between discount and profitability?
SELECT
    ROUND(discount * 100, 0) AS discount_pct,
    COUNT(*) AS orders,
    ROUND(AVG(profit), 2) AS avg_profit_per_order,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sales_orders
GROUP BY discount
ORDER BY discount;
