# 🛒 Customer Order Analysis — SQL Project

Relational database design and SQL analysis of customer orders, built to uncover purchase behavior, product performance, and order trends.

**Tools:** SQL · SQL (Joins, Aggregations, Filtering, Indexing) 

---

## 📌 Overview

This project simulates an e-commerce order system. I designed a normalized relational database from scratch, loaded it with transactional data, and wrote a series of analytical SQL queries to answer real business questions — who the top customers are, which product categories drive revenue, how orders trend month over month, and where performance can be optimized.

## 🗂️ Database Schema

Four related tables, linked by foreign keys:

```
Customers (customer_id, customer_name, city, country, signup_date)
Products  (product_id, product_name, category, unit_price)
Orders    (order_id, customer_id, order_date)
Order_Items (order_item_id, order_id, product_id, quantity)
```

- `Orders.customer_id` → `Customers.customer_id`
- `Order_Items.order_id` → `Orders.order_id`
- `Order_Items.product_id` → `Products.product_id`

Indexes were added on all three foreign key columns to optimize the joins used throughout the analysis.

## 🔍 Analysis Performed

| # | Query | What it answers |
|---|-------|------------------|
| 1 | Orders overview | Total orders, unique customers, total revenue |
| 2 | Top 10 customers by spend | Who are the highest-value customers? |
| 3 | Revenue by category | Which product categories perform best? |
| 4 | Monthly order trend | How do orders and revenue move over time? |
| 5 | Top 5 products by units sold | What's actually flying off the shelf? |
| 6 | Customers & revenue by country | Where is the customer base concentrated? |
| 7 | Average order value | What's the typical basket size in dollars? |

Full queries in [`customer_order_analysis.sql`](./customer_order_analysis.sql).

## 📊 Key Results

- **500 orders** across **60 customers** → **$163,673.18** total revenue
- **Average order value:** $327.35
- **Top category:** Fashion ($52,969 revenue), followed by Electronics ($46,724)
- **Top products by units sold:** Phone Case, Shea Butter Lotion, Electric Kettle
- **Top market by revenue:** Kenya, followed closely by Ghana
- **Top customer:** Yemi Okafor (Ghana) — 12 orders, $5,219.44 total spend

## 📁 Repo Contents

```
├── full_schema_and_data.sql      # Complete schema + data (import into any SQLite tool)
├── customer_order_analysis.sql   # The 7 analytical queries, commented
├── run_queries.py                # Python script that runs the queries and prints results
└── README.md                     # This file
```

## ▶️ How to Run It


# Load the schema + data into SQL
sql customer_orders.db < full_schema_and_data.sql



## 🧠 What This Project Demonstrates

- Relational database design (normalization, primary/foreign keys)
- SQL joins across multiple related tables
- Aggregation and grouping for business-relevant KPIs
- Query optimization through indexing
- Translating raw transactional data into actionable business insight

---
*Author: Bamidele Yetunde — [LinkedIn](https://www.linkedin.com/in/bamidele-yetunde) · [GitHub](https://github.com/bamideleyetunde)*
