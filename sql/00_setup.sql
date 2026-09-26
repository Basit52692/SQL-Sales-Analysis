-- PostgreSQL setup for the Sales Performance Analysis project
-- Run this file first, then import data/sales_orders.csv.

DROP TABLE IF EXISTS sales_orders;

CREATE TABLE sales_orders (
    order_id        VARCHAR(30) PRIMARY KEY,
    order_date      DATE NOT NULL,
    ship_date       DATE NOT NULL,
    ship_mode       VARCHAR(30) NOT NULL,
    customer_id     VARCHAR(30) NOT NULL,
    customer_name   VARCHAR(100) NOT NULL,
    segment         VARCHAR(30) NOT NULL,
    country         VARCHAR(50) NOT NULL,
    city            VARCHAR(80) NOT NULL,
    state           VARCHAR(80) NOT NULL,
    postal_code     VARCHAR(20) NOT NULL,
    region          VARCHAR(30) NOT NULL,
    product_id      VARCHAR(30) NOT NULL,
    category        VARCHAR(50) NOT NULL,
    sub_category    VARCHAR(50) NOT NULL,
    product_name    VARCHAR(120) NOT NULL,
    sales           NUMERIC(12,2) NOT NULL CHECK (sales >= 0),
    quantity        INTEGER NOT NULL CHECK (quantity > 0),
    discount        NUMERIC(5,2) NOT NULL CHECK (discount BETWEEN 0 AND 1),
    profit          NUMERIC(12,2) NOT NULL
);

CREATE INDEX idx_sales_order_date ON sales_orders(order_date);
CREATE INDEX idx_sales_region ON sales_orders(region);
CREATE INDEX idx_sales_category ON sales_orders(category);
CREATE INDEX idx_sales_segment ON sales_orders(segment);

-- psql import example (adjust the path for your machine):
-- \copy sales_orders FROM 'data/sales_orders.csv' WITH (FORMAT csv, HEADER true);
