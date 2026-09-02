# E-Commerce Marketplace Analysis

## Overview

End-to-end analysis of an e-commerce marketplace using three months of transactional data (January - March 2024). The goal was to assess the health of the business across four dimensions: cohort retention and revenue dynamics, city-level performance, customer segmentation, and delivery reliability. The analysis surfaces operational issues that suppress revenue and proposes concrete next steps grounded in data.

---

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Data](#data)
- [Analysis](#analysis)
  - [1. Cohort Retention &amp; Revenue](#1-cohort-retention--revenue)
  - [2. City-Level Performance](#2-city-level-performance)
  - [3. Customer Segmentation](#3-customer-segmentation)
  - [4. Delivery Lateness](#4-delivery-lateness)
- [Key Conclusions](#key-conclusions)
- [Tools &amp; Methods](#tools--methods)

---

## Project Structure

```
marketplace-analysis/
├── README.md
├── queries/
│   ├── segmentation.sql          # Customer segmentation (RFM-style, 4 segments)
│   ├── city_ranking.sql          # City-level performance: customers, revenue, redemption rate
│   ├── monthly_dynamics.sql      # Cohort retention and MoM revenue dynamics
│   ├── is_late_order.sql         # Delivery lateness relative to estimated delivery date
│   └── order_diversity.sql       # Order size, unique products/brands/categories per customer
├── data/
│   ├── segmentation.csv
│   ├── city_ranking.csv
│   ├── monthly_dynamics.csv
│   ├── is_late_order.csv
│   └── order_diversity.csv
└── analysis.ipynb                # Full analysis with visualizations and conclusions
```

---

## Data

The dataset covers a marketplace operating across 20 cities. It includes four relational tables: `customers`, `orders`, `order_items`, and `customer_actions` (behavioural events). All data extraction and transformation was done in **PostgreSQL** via Redash, using CTEs, window functions (`RANK`, `LAG`, `COUNT OVER`), and conditional aggregation. Results were exported as CSV files for downstream analysis in Python.

---

## Analysis

### 1. Cohort Retention & Revenue

Customers were grouped into monthly cohorts based on registration date. Retention was defined as the share of a cohort that made at least one purchase in a given month. Revenue was tracked per cohort over time.

**Key findings:**

- Month-1 and month-2 retention rates are consistently 20 - 30% across all cities and cohorts, with month-2 frequently exceeding month-1, consistent with a monthly repurchase cycle
- Revenue grows predictably with cohort tenure; all cohorts generate comparable revenue at the same lifecycle stage, indicating a stable and repeatable customer base
- Cohort size is stable (~150 - 165 paying customers/month) but not growing. Scaling acquisition is the primary lever for compounding total revenue

---

### 2. City-Level Performance

Cities were ranked by paying customer count, delivered revenue, and redemption rate (share of orders delivered vs. total placed). A bubble chart was used to surface the relationship between customer volume and revenue, with bubble size encoding redemption rate.

**Key findings:**

- Two city clusters emerge: **underperforming cities** (Perm, Saint Petersburg, Ekaterinburg) with low redemption rates and below-expected revenue; and **high-loyalty, low-volume cities** (Tolyatti, Tyumen, Volgograd, Moscow, Voronezh) where strong redemption rates compensate for fewer customers
- Tolyatti is a striking example: ~130 customers generate comparable revenue to Samara, which has 1.5x more customers
- Underperforming cities warrant diagnosis before any acquisition investment. The root cause is not delivery speed (ruled out via further analysis)

---

### 3. Customer Segmentation

Customers were segmented into four groups based on order history and days since registration: **Regular** (3+ delivered orders), **One-time** (1 - 2 orders), **Inactive** (0 orders, registered 30+ days ago), and **New** (0 orders, registered within 30 days).

Welch's t-tests were used to compare One-time and Regular customers across order count, delivery time, and revenue.

**Key findings:**

- Most registered customers are Inactive or New and have never placed an order. It demonstrates a significant conversion gap and the highest-leverage growth opportunity that requires no additional acquisition spend
- Regular customers generate ~88,000 more in revenue than One-time customers (p < 0.001, Cohen's d = 1.85) and explore 4 - 7 unique products, brands, and categories vs. 2 - 3 for One-time buyers
- **Delivery time does not differ between segments** (p = 0.307, Cohen's d = 0.07), so retention is driven by factors other than logistics speed

---

### 4. Delivery Lateness

Delivery delay was calculated as the difference between actual and estimated delivery dates. In-Transit orders were assigned a delivery date of March 31, 2024 (last available date), making their delay a lower bound rather than a final value.

**Key findings:**

- A substantial share of Inactive and One-time customers have orders still In Transit, delayed 10 - 40+ days beyond the estimated date. These customers are not disengaged, they are waiting for unresolved deliveries
- The Regular segment shows a selection bias effect: customers who received orders reliably are the ones who became loyal buyers; those who experienced severe delays churned before reaching the Regular threshold
- Delivery delays are distributed evenly across all cities, including the underperforming ones, confirming that logistics speed is not the explanation for their low redemption rates

---

## Key Conclusions

The marketplace has a stable retention and revenue base, but two operational issues are suppressing potential:

1. **Systemic delivery delays** are silently churning customers before they can become loyal. This is the most urgent issue to fix
2. **Low conversion from registered to paying customers** represents a large untapped pool that can be activated without additional acquisition spend

Expansion into new audiences is a logical next step, but only after these two issues are resolved, particularly in underperforming cities where the root cause (likely pricing or assortment) still needs to be identified.

---

## Tools & Methods

| Layer             | Tools                                                              |
| ----------------- | ------------------------------------------------------------------ |
| Data extraction   | PostgreSQL, Redash                                                 |
| SQL techniques    | CTEs, window functions, conditional aggregation, multi-table JOINs |
| Analysis          | Python - pandas, scipy, pingouin                                   |
| Visualisation     | matplotlib, seaborn                                                |
| Statistical tests | Welch's t-test, effect size (Cohen's d)                            |
