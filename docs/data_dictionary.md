# Data Dictionary

| Column | Type | Description |
|---|---|---|
| order_id | VARCHAR | Unique order identifier |
| order_date | DATE | Date the order was placed |
| ship_date | DATE | Date the order was shipped |
| ship_mode | VARCHAR | Shipping service level |
| customer_id | VARCHAR | Customer identifier |
| customer_name | VARCHAR | Customer display name |
| segment | VARCHAR | Consumer, Corporate, or Home Office |
| country | VARCHAR | Country |
| city | VARCHAR | City |
| state | VARCHAR | State |
| postal_code | VARCHAR | Postal/ZIP code stored as text |
| region | VARCHAR | Sales region |
| product_id | VARCHAR | Product identifier |
| category | VARCHAR | Product category |
| sub_category | VARCHAR | Product sub-category |
| product_name | VARCHAR | Simplified product name |
| sales | NUMERIC | Order sales amount in source units |
| quantity | INTEGER | Units ordered |
| discount | NUMERIC | Discount rate from 0.00 to 0.30 |
| profit | NUMERIC | Order profit amount in source units |

## Important dataset limitation
This is a practice dataset with 10,000 rows. Every order ID, customer ID and product ID is unique in the supplied snapshot. Therefore, repeat-customer retention and SKU-level repeat-purchase analysis are **not supported** by this dataset. Product analysis should use `product_name` / `sub_category` rather than assuming `product_id` represents repeated SKUs.
