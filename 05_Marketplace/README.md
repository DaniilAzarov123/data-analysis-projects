# 05 · Brazilian Marketplace — Product Analytics

> **Course project** completed as part of the [Karpov Courses](https://karpov.courses/analytics) Data Analytics program.

---

## Goal

A Brazilian e-commerce startup has been experiencing revenue stagnation for several months. Acting as a data analyst, the task is to diagnose the problem, assess product/market fit, identify the key metrics to track, and prioritise a hypothesis for an A/B test — all without negatively impacting customer experience.

**Dataset:** Olist public e-commerce data (Sep 2016 – Aug 2018), ~100k orders across three tables: customers, orders, and order items.

---

## Tasks & Methods

| # | Task                                     | Approach                                                                  |
| - | ---------------------------------------- | ------------------------------------------------------------------------- |
| 1 | Monthly retention in order placement     | Cohort analysis (purchase month as cohort key)                            |
| 2 | Product/Market Fit assessment            | Retention curve comparison against PMF thresholds                         |
| 3 | Identify 5 key metrics for the PM        | Business metric framework (GMV, MAU, ARPU, Conversion Rate, M1 Retention) |
| 4 | Hypothesis prioritisation                | ICE scoring framework                                                     |
| 5 | Define metrics for the chosen hypothesis | Primary / Proxy / Guardrail metric structure                              |
| 6 | Final report for the Product Manager     | Written narrative summary with recommendations                            |

---

## Key Findings

**Retention & PMF** — M1 retention across all cohorts falls below 1% (median ~0.37%) and never stabilises. No cohort reaches the 5–10% M3+ threshold considered the minimum signal for marketplace PMF. PMF is absent.

**Root causes** — Payment confirmation averages over 10 hours; order handoff to logistics averages ~67 hours. Both are significant friction points affecting repeat purchase behaviour.

**Metric landscape** — GMV and MAU are trending upward, but ARPU and retention remain low, confirming that growth is acquisition-driven rather than engagement-driven.

**Hypothesis prioritisation (ICE):**

- Hypothesis 1 — Fix order processing bug: **ICE = 192** ✅ selected
- Hypothesis 3 — ICE = 180
- Hypothesis 2 — ICE = 40

**A/B test metrics for Hypothesis 1:**

- **Primary:** Cancellation Rate — expected to decrease
- **Proxy:** Share of delivered orders — expected to increase
- **Guardrails:** Support Ticket Rate and GMV — must not worsen

**Recommendation:** Fix the processing bug first (highest impact, lowest risk), run the A/B test, and hold off on geographic expansion until PMF is demonstrated.

---

## Stack

Python · pandas · NumPy · matplotlib · seaborn

---

## Dataset Structure

| File                              | Description                             |
| --------------------------------- | --------------------------------------- |
| `olist_customers_dataset.csv`   | Customer identifiers and geography      |
| `olist_orders_dataset.csv`      | Orders with timestamps and statuses     |
| `olist_order_items_dataset.csv` | Line items with price and freight value |
