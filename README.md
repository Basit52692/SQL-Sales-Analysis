# 📊 SQL Sales Analysis Project

## 📌 Project Overview
This project analyzes a sales dataset using SQL to extract business insights such as top products, revenue trends, and category performance.

---

## 🛠 Tools & Technologies
- MySQL
- SQL Queries
- Data Aggregation
- Data Filtering
- Group By Analysis

---

## 📂 Dataset
The dataset contains sales transaction records including:
- Order ID
- Date
- Product
- Category
- City
- Quantity
- Price
- Total Revenue

---

## 🔎 Key Analysis Performed

### 1️⃣ Total Orders
```sql
SELECT COUNT(*) FROM sales;
```

### 2️⃣ Top Selling Product
```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
ORDER BY total_qty DESC
LIMIT 1;
```

### 3️⃣ Highest Revenue City
```sql
SELECT city, SUM(total) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;
```

### 4️⃣ Category-wise Revenue
```sql
SELECT category, SUM(total) AS total_sales
FROM sales
GROUP BY category;
```

---

## 📈 Insights Generated
- Total number of orders analyzed
- Best performing product identified
- Highest revenue generating city detected
- Revenue distribution across categories

---

## 🚀 Project Purpose
This project demonstrates practical SQL skills for:
- Data analysis
- Query writing
- Business insights extraction
- Real-world dataset handling

---

## 👨‍💻 Author
**Basit Hussain**  
Aspiring Data Analyst | SQL | Python | Data Visualization

---

⭐ If you found this project useful, consider giving it a star!


