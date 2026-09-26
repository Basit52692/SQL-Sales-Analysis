-- 07. ADVANCED SQL: CTEs AND WINDOW FUNCTIONS

-- Rank regions inside each year by sales
WITH yearly_region AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::INT AS year,
        region,
        SUM(sales) AS sales,
        SUM(profit) AS profit
    FROM sales_orders
    GROUP BY 1, 2
)
SELECT
    year,
    region,
    ROUND(sales, 2) AS sales,
    ROUND(profit, 2) AS profit,
    DENSE_RANK() OVER (PARTITION BY year ORDER BY sales DESC) AS sales_rank
FROM yearly_region
ORDER BY year, sales_rank;

-- Running monthly sales total
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS sales
    FROM sales_orders
    GROUP BY 1
)
SELECT
    month,
    ROUND(sales, 2) AS sales,
    ROUND(SUM(sales) OVER (ORDER BY month), 2) AS running_sales
FROM monthly_sales
ORDER BY month;

-- Each category's share of company sales
WITH category_sales AS (
    SELECT category, SUM(sales) AS sales
    FROM sales_orders
    GROUP BY category
)
SELECT
    category,
    ROUND(sales, 2) AS sales,
    ROUND(100.0 * sales / SUM(sales) OVER (), 2) AS company_sales_share_pct
FROM category_sales
ORDER BY sales DESC;

-- Top 2 sub-categories within each category
WITH subcat AS (
    SELECT
        category,
        sub_category,
        SUM(sales) AS sales
    FROM sales_orders
    GROUP BY category, sub_category
),
ranked AS (
    SELECT
        category,
        sub_category,
        sales,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY sales DESC) AS rank_in_category
    FROM subcat
)
SELECT
    category,
    sub_category,
    ROUND(sales, 2) AS sales,
    rank_in_category
FROM ranked
WHERE rank_in_category <= 2
ORDER BY category, rank_in_category;
