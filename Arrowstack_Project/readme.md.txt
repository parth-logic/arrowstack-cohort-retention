# Customer Cohort Retention Analysis

## Project Overview
This project analyzes customer purchasing behavior and monthly retention using SQL and SQLite.

## Objective
To group customers by their first completed purchase month and measure how many return to make purchases in subsequent months.

## Tools Used
- DB Browser for SQLite
- SQL
- Microsoft Excel (for reviewing exported results)

## Methodology
1. Identified each customer's first completed purchase.
2. Assigned customers to monthly cohorts.
3. Identified customer activity in each calendar month.
4. Calculated the month number relative to the cohort month.
5. Counted retained customers for each cohort and month.
6. Calculated retention percentage using the original cohort size.

## Key Metrics
- Cohort month
- Cohort size
- Month number
- Retained customers
- Retention percentage

## Files
- `sql/cohort_retention.sql` — Final SQL query.
- `results/cohort_retention_results.csv` — Exported cohort retention results.

## Conclusion
The analysis provides a month-by-month view of customer purchasing retention. It demonstrates the use of SQL aggregation, common table expressions (CTEs), joins, date functions, and percentage calculations.

Note: Findings should be interpreted in the context of the supplied dataset. No business performance claims are made without supporting evidence.
