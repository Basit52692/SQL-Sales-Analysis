# SQL Sales Performance Analysis

A PostgreSQL portfolio project that analyzes **10,000 retail orders from 2019–2022** using data-quality checks, aggregations, CTEs, `CASE WHEN`, window functions, ranking, trend analysis, and profitability analysis.

The project is designed around a practical business question:

> **Which products, regions, segments and discount levels contribute to sales and profit, and where is profitability under pressure?**

## Project Highlights

- **10,000** order records analyzed
- **10,033,715.95** total sales (source units)
- **1,711,180.34** total profit
- **17.05%** overall profit margin
- Monthly and yearly trend analysis with `LAG()`
- Category / regional ranking with `DENSE_RANK()`
- Running totals and contribution analysis with window functions
- Discount profitability analysis with `CASE WHEN`
- Explicit data-quality and dataset-grain checks

## Tech Stack

**PostgreSQL · SQL · CTEs · Window Functions · Aggregations · Data Quality · Business Analysis**

## Repository Structure

```text
SQL_Sales_Analysis_Professional/
├── README.md
├── data/
│   └── sales_orders.csv
├── docs/
│   ├── analysis_notes.md
│   └── data_dictionary.md
└── sql/
    ├── 00_setup.sql
    ├── 01_data_quality.sql
    ├── 02_kpi_analysis.sql
    ├── 03_sales_trends.sql
    ├── 04_product_analysis.sql
    ├── 05_region_segment_analysis.sql
    ├── 06_discount_profitability.sql
    ├── 07_advanced_window_functions.sql
    └── 08_business_questions.sql
```

## Dataset

The practice dataset contains order, customer, product, geography, sales, quantity, discount and profit fields. The analysis period is **2019-01-01 to 2022-12-31**.

Important limitation: all 10,000 supplied `order_id`, `customer_id`, and `product_id` values are unique. That makes retention / repeat-customer analysis inappropriate for this dataset. Product-level business analysis therefore focuses on `product_name`, `sub_category`, and `category`.

See [`docs/data_dictionary.md`](docs/data_dictionary.md) for field definitions.

## Business Questions

1. What are the overall sales, profit, margin, order and quantity KPIs?
2. How are sales changing month-over-month and year-over-year?
3. Which categories and sub-categories generate the most sales and profit?
4. Which regions and customer segments contribute most to performance?
5. Which shipping modes are used most often, and how quickly do they ship?
6. How does profitability differ across discount levels?
7. Which region-category combinations have high sales but below-company-average margins?
8. Which months are unusually strong or weak versus their recent moving average?

## Key Findings

- Total sales are **10,033,715.95**, with **1,711,180.34** profit and an overall margin of **17.05%**.
- **Furniture** is the largest category by sales at **3,397,158.85**.
- **East** leads regional sales at **3,388,646.96**, while **West** has the strongest regional margin at **17.17%**.
- **Corporate** is the largest customer segment by sales at **3,399,048.25**.
- Zero-discount orders have a **20.35%** margin versus **13.99%** at a 30% discount — a **6.35 percentage-point** gap.
- 2022 sales reached **2,535,711.07**, a **3.36%** change from 2021.

The discount result is descriptive: it shows an association in the supplied data and does not, by itself, prove causation.

## SQL Skills Demonstrated

```sql
GROUP BY
HAVING
CASE WHEN
CTEs
DATE_TRUNC
FILTER
NULLIF
LAG
DENSE_RANK
SUM() OVER()
AVG() OVER()
PARTITION BY
Running totals
Moving averages
Contribution percentages
```

## How to Run

### Option 1 — pgAdmin
1. Create a PostgreSQL database, for example `sales_portfolio`.
2. Run `sql/00_setup.sql`.
3. Import `data/sales_orders.csv` into the `sales_orders` table using pgAdmin Import/Export.
4. Run the remaining SQL files in numerical order.

### Option 2 — psql

```sql
\i sql/00_setup.sql
\copy sales_orders FROM 'data/sales_orders.csv' WITH (FORMAT csv, HEADER true);
\i sql/01_data_quality.sql
\i sql/02_kpi_analysis.sql
```

Then continue through the remaining scripts.

## Example: Month-over-Month Growth

```sql
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
    ROUND(100.0 * (sales - previous_month_sales)
          / NULLIF(previous_month_sales, 0), 2) AS mom_growth_pct
FROM with_previous
ORDER BY month;
```

## What I Would Improve With Production Data

For a real commercial dataset, I would separate the model into customer, product and order dimensions / facts, enforce stable customer and SKU identifiers, add cost and return data, and analyze repeat purchases, cohort retention, customer lifetime value and product-level unit economics.

## Author

**Basit Hussain**  
Data Analyst | SQL · Python · Excel · Power BI  
GitHub: [Basit52692](https://github.com/Basit52692)
