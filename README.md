# Task 1 — Multi-Table SQL Queries & Cohort Retention Analysis

**Status:** Starter project with generated simulated data, executable SQLite database, SQL queries, and validation outputs.

## Business question
How do customer purchase patterns differ across cohorts, and how does repeat purchasing vary over time? The project also demonstrates how related customer, order, order-item and product tables can be joined to answer business questions.

## Dataset and privacy
All records are simulated for learning. They are not Arrowstack customer data or real business records.

## Data model
- `customers`: one row per customer; signup date, city and acquisition channel.
- `products`: one row per product; category and unit price.
- `orders_raw`: one row per order; customer, date and status.
- `order_items_raw`: one row per item line; product, quantity, price and discount.
- `orders_clean` and `order_items_clean`: SQLite views applying documented data-quality rules.

Relationships:
- customers.customer_id → orders.customer_id
- orders.order_id → order_items.order_id
- products.product_id → order_items.product_id

## Requirements
SQLite 3 or DB Browser for SQLite. Python is optional for regenerating/checking outputs.

## Quick start
1. Open `data/cohort_retail.db` with DB Browser for SQLite, or use Python's built-in `sqlite3`.
2. Run `sql/01_schema_and_cleaning.sql` to inspect data quality.
3. Run `sql/02_multi_table_business_queries.sql` for multi-table business analysis.
4. Run `sql/03_cohort_retention.sql` for cohort retention output.
5. Compare results with the CSV files in `evidence/`.

## Cohort method
- Cohort month = calendar month of a customer's first completed order.
- Active month = a calendar month with at least one completed order.
- Month 0 = cohort month.
- Retention % = retained customers in a cohort/month ÷ cohort size × 100.
- Only completed orders count as purchases. Cancelled and returned orders are excluded from retention.
- The latest cohorts have fewer observable follow-up months; compare only months with enough observation time.

## Validation
The `evidence/validation_summary.json` file records checks run against the generated database. Month 0 retention should be 100% for every cohort with a first completed order. Invalid customer references and non-positive quantities are intentionally present in raw data to demonstrate quality checks.

## Limitations
- The dataset is simulated and relatively small.
- This is observational analysis; it does not prove why customers repeat or stop purchasing.
- Retention is based on completed order activity, not website/app sessions.
- SQL uses SQLite date functions; syntax may need adapting for PostgreSQL/MySQL.

## Suggested next steps
- Add a heatmap-style cohort matrix in Excel.
- Add a chart showing retention by cohort month.
- Create a short presentation showing method, validation and key findings.
