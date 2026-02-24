CREATE DATABASE sales_project;
USE sales_project;
CREATE TABLE sales (
order_id INT,
date DATE,
product VARCHAR(50),
category VARCHAR(50),
city VARCHAR(50),
quantity INT,
price INT,
total INT
);
SELECT COUNT(*) FROM sales;
SELECT SUM(total) AS total_sales FROM sales;
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
ORDER BY total_qty DESC
LIMIT 1;
SELECT city, SUM(total) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;
SELECT category, SUM(total) AS total_sales
FROM sales
GROUP BY category;
SELECT *
FROM sales
ORDER BY total DESC
LIMIT 1;
