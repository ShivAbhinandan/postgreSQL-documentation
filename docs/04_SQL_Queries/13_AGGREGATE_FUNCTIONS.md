---
title: SQL Aggregate Functions
difficulty: Beginner
reading_time: 60 minutes
practice_time: 120 minutes
estimated_total_time: 180 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
  - IS NULL
  - Alias
last_updated: 2026-07-30
---

# SQL Aggregate Functions

## Overview

Aggregate functions perform calculations on multiple rows and return a **single summarized value**.

Instead of displaying every row, aggregate functions answer questions like:

- How many employees are there?
- What is the total sales amount?
- What is the average salary?
- Which product is the most expensive?
- What is the lowest stock quantity?

These functions are the foundation of reporting, dashboards, KPIs, and business intelligence.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Use all five aggregate functions.
- Understand how NULL values affect aggregates.
- Filter aggregated results.
- Write business reports.
- Prepare for GROUP BY.

---

# Aggregate Functions

| Function | Purpose |
|----------|----------|
| COUNT() | Counts rows |
| SUM() | Adds values |
| AVG() | Calculates average |
| MIN() | Finds smallest value |
| MAX() | Finds largest value |

---

# Visual Overview

```text
Employees

Salary

45000
52000
67000
73000
81000

        │
        ▼

Aggregate Function

        │
        ▼

Single Result

Average Salary = 63600
```

Unlike normal queries, aggregate functions return one summarized value.

---

# COUNT()

Counts rows.

## Syntax

```sql
SELECT COUNT(*)
FROM hr.employees;
```

Example Output

| count |
|-------:|
|150|

---

# COUNT(column)

Counts only non-NULL values.

```sql
SELECT COUNT(phone_number)
FROM hr.employees;
```

If 20 employees have NULL phone numbers:

```text
Total rows = 150

Phone numbers counted = 130
```

---

# COUNT(DISTINCT)

Count unique values.

```sql
SELECT COUNT(DISTINCT department_id)
FROM hr.employees;
```

Output

| count |
|-------:|
|8|

---

# SUM()

Calculates totals.

```sql
SELECT
    SUM(salary) AS total_salary
FROM hr.employees;
```

---

# AVG()

Calculates the average.

```sql
SELECT
    AVG(salary) AS average_salary
FROM hr.employees;
```

---

# MIN()

Finds the minimum value.

```sql
SELECT
    MIN(salary) AS lowest_salary
FROM hr.employees;
```

---

# MAX()

Finds the highest value.

```sql
SELECT
    MAX(salary) AS highest_salary
FROM hr.employees;
```

---

# Multiple Aggregate Functions

```sql
SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM hr.employees;
```

Output

| Metric | Value |
|--------|-------:|
|Total Employees|150|
|Total Salary|8450000|
|Average Salary|56333.33|
|Minimum Salary|25000|
|Maximum Salary|120000|

---

# Aggregate Functions with WHERE

Display the average salary for department 2.

```sql
SELECT
    AVG(salary) AS average_salary
FROM hr.employees
WHERE department_id = 2;
```

The `WHERE` clause filters rows **before** the aggregate function is applied.

---

# NULL Behavior

Most aggregate functions ignore `NULL` values.

Example:

| Salary |
|--------:|
|50000|
|60000|
|NULL|
|70000|

```sql
SELECT AVG(salary)
FROM hr.employees;
```

Result

```text
60000
```

The NULL value is ignored.

---

# COUNT(*) vs COUNT(column)

Example Data

| employee_id | email |
|-------------|-------|
|1|a@email.com|
|2|NULL|
|3|b@email.com|
|4|NULL|

```sql
SELECT COUNT(*)
FROM hr.employees;
```

Result

```text
4
```

```sql
SELECT COUNT(email)
FROM hr.employees;
```

Result

```text
2
```

---

# Business Scenarios

## HR Dashboard

Total employees

```sql
SELECT COUNT(*) AS total_employees
FROM hr.employees;
```

Average salary

```sql
SELECT AVG(salary) AS average_salary
FROM hr.employees;
```

Highest salary

```sql
SELECT MAX(salary) AS highest_salary
FROM hr.employees;
```

---

## Sales Dashboard

Total revenue

```sql
SELECT SUM(total_amount) AS total_sales
FROM sales.orders;
```

Average order value

```sql
SELECT AVG(total_amount) AS average_order_value
FROM sales.orders;
```

Total orders

```sql
SELECT COUNT(*) AS total_orders
FROM sales.orders;
```

---

## Inventory Dashboard

Most expensive product

```sql
SELECT MAX(unit_price)
FROM inventory.products;
```

Lowest stock

```sql
SELECT MIN(units_in_stock)
FROM inventory.products;
```

---

# Execution Order

```text
FROM

↓

WHERE

↓

Aggregate Function

↓

SELECT

↓

ORDER BY
```

Understanding this order makes later topics like `GROUP BY` and `HAVING` much easier.

---

# Best Practices

- Use aliases for aggregate results.
- Understand the difference between `COUNT(*)` and `COUNT(column)`.
- Remember that most aggregate functions ignore `NULL`.
- Filter rows with `WHERE` before aggregation.
- Use meaningful names like `total_sales` or `average_salary`.

---

# Common Mistakes

## Using Aggregate Functions Without Understanding NULL

```sql
SELECT AVG(bonus)
FROM hr.employees;
```

NULL values are ignored.

---

## Confusing COUNT(*) and COUNT(column)

```sql
COUNT(*)
```

Counts all rows.

```sql
COUNT(email)
```

Counts only rows where `email` is not NULL.

---

## Expecting Multiple Rows

Aggregate functions return a summarized result unless used with `GROUP BY`.

---

# Performance Tip

Aggregate functions can take time on very large tables.

To improve performance:

- Create indexes on frequently filtered columns.
- Filter rows using `WHERE` before aggregation.
- Avoid unnecessary calculations inside aggregate functions.

---

# Interview Questions

### Which aggregate functions ignore NULL values?

`SUM()`, `AVG()`, `MIN()`, `MAX()`, and `COUNT(column)` ignore NULL values.

`COUNT(*)` counts every row.

---

### What is the difference between COUNT(*) and COUNT(column)?

- `COUNT(*)` counts all rows.
- `COUNT(column)` counts only non-NULL values.

---

### Can aggregate functions be combined?

Yes.

```sql
SELECT
    COUNT(*),
    AVG(salary),
    MAX(salary)
FROM hr.employees;
```

---

### Which clause filters rows before aggregation?

```sql
WHERE
```

---

# Cheat Sheet

| Function | Description |
|----------|-------------|
| COUNT(*) | Count all rows |
| COUNT(column) | Count non-NULL values |
| COUNT(DISTINCT column) | Count unique values |
| SUM() | Total |
| AVG() | Average |
| MIN() | Lowest |
| MAX() | Highest |

---

# Practice Exercises

## 🟢 Beginner

1. Count all employees.
2. Find the average salary.
3. Find the highest salary.

---

## 🟡 Intermediate

1. Count employees with email addresses.
2. Find the total sales amount.
3. Find the minimum stock quantity.

---

## 🔴 Advanced

Write queries to:

1. Count distinct departments.
2. Find the average salary of department 3.
3. Display total revenue for completed orders only.

---

# Production Example

## Executive KPI Dashboard

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value,
    MAX(total_amount) AS highest_order,
    MIN(total_amount) AS lowest_order
FROM sales.orders
WHERE order_status = 'Completed';
```

Typical Output

| KPI | Value |
|-----|-------:|
|Total Orders|1,245|
|Total Sales|2,458,950|
|Average Order Value|1,975.06|
|Highest Order|18,750|
|Lowest Order|120|

---

# Summary

Aggregate functions summarize data into meaningful business metrics. They are essential for reporting, dashboards, KPIs, and analytics. Mastering these functions prepares you for the next major topic: `GROUP BY`, where aggregates are calculated for each category instead of the entire table.

---

# Related Topics

**Previous**

- `12_ALIAS.md`

**Next**

- `14_GROUP_BY.md`

**Related**

- `03_WHERE.md`
- `11_IS_NULL.md`
- `15_HAVING.md`
