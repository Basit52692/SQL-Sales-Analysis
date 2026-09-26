# Analysis Notes

These notes summarize results calculated from the supplied 10,000-row practice dataset. Amounts are reported in **source units** because the original currency is not documented.

## Headline KPIs
- Total orders: **10,000**
- Total sales: **10,033,715.95**
- Total profit: **1,711,180.34**
- Overall profit margin: **17.05%**
- Loss-making orders: **79**
- 2022 sales: **2,535,711.07**
- 2022 YoY sales growth: **3.36%**

## Category performance
- **Furniture** — Sales 3,397,158.85; Margin 17.15%
- **Office Supplies** — Sales 3,329,998.23; Margin 16.80%
- **Technology** — Sales 3,306,558.87; Margin 17.21%

## Region performance
- **East** — Sales 3,388,646.96; Margin 16.98%
- **West** — Sales 3,386,451.21; Margin 17.17%
- **Central** — Sales 3,258,617.78; Margin 17.01%

## Discount signal
- Zero-discount orders: **20.35% margin**
- 30% discount orders: **13.99% margin**
- Difference: **6.35 percentage points**

This is an association in this dataset, not proof that discount alone caused the margin difference.

## Data-quality checks
- Missing source fields: **0**
- Duplicate Order IDs: **0**
- Ship-before-order dates: **0**
- Unique customers: **10,000**
- Unique product IDs: **10,000**
