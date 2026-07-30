---
title: HAVING Clause
difficulty: Intermediate
reading_time: 60 minutes
practice_time: 120 minutes
estimated_total_time: 180 minutes
prerequisites:
  - Aggregate Functions
  - GROUP BY
  - WHERE Clause
last_updated: 2026-07-30
---

# HAVING Clause

## Overview

The `HAVING` clause filters **groups**, not individual rows.

It is used **after** the `GROUP BY` clause and is commonly used with aggregate functions such as:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

Without `HAVING`, SQL cannot filter based on aggregate results.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand the purpose of HAVING.
- Differentiate WHERE and HAVING.
- Filter grouped data.
- Use aggregate functions inside HAVING.
- Write analytical reports.

---

# Why HAVING?

Suppose you need:

> Show only departments where the average salary is greater than 60,000.

This cannot be done using `WHERE`.

Instead, use `HAVING`.

---

# Syntax

```sql
SELECT
    column_name,
    aggregate_function(column_name)
FROM table_name
GROUP BY column_name
HAVING aggregate_function(column_name) condition;
```

---

# First Example

Average salary greater than 60,000.

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

Output

| Department | Average Salary |
|------------|---------------:|
|2|62000|
|5|74500|

---

# Visual Explanation

```text
Employee Table

Department   Salary

IT           50000
IT           60000
IT           70000

HR           40000
HR           45000

Finance      80000
Finance      90000

        │
        ▼

GROUP BY Department

        │
        ▼

IT        AVG = 60000

HR        AVG = 42500

Finance   AVG = 85000

        │
        ▼

HAVING AVG(salary) > 60000

        │
        ▼

Finance
```

---

# HAVING with COUNT()

Departments having more than five employees.

```sql
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > 5;
```

---

# HAVING with SUM()

Departments where total salary exceeds 500000.

```sql
SELECT
    department_id,
    SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) > 500000;
```

---

# HAVING with Multiple Aggregates

```sql
SELECT
    department_id,
    COUNT(*) AS employees,
    AVG(salary) AS average_salary
FROM hr.employees
GROUP BY department_id
HAVING
    COUNT(*) >= 5
    AND AVG(salary) > 60000;
```

---

# WHERE vs HAVING

## WHERE filters rows

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
WHERE salary > 50000
GROUP BY department_id;
```

Employees earning 50,000 or less are removed **before** grouping.

---

## HAVING filters groups

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

All rows are grouped first, then groups are filtered.

---

# WHERE + HAVING Together

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM hr.employees
WHERE hire_date >= '2023-01-01'
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

Execution:

1. Filter employees hired in 2023 or later.
2. Group by department.
3. Calculate averages.
4. Keep only departments whose average salary exceeds 60,000.

---

# Execution Order

```text
FROM
   ↓
WHERE
   ↓
GROUP BY
   ↓
Aggregate Functions
   ↓
HAVING
   ↓
SELECT
   ↓
ORDER BY
   ↓
LIMIT
```

---

# Business Scenarios

## HR Dashboard

Departments with more than 20 employees.

```sql
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > 20;
```

---

## Sales Dashboard

Regions generating more than $100,000 in revenue.

```sql
SELECT
    region,
    SUM(total_amount) AS revenue
FROM sales.orders
GROUP BY region
HAVING SUM(total_amount) > 100000;
```

---

## Inventory Dashboard

Categories with an average product price above $500.

```sql
SELECT
    category_name,
    AVG(unit_price) AS average_price
FROM inventory.products
GROUP BY category_name
HAVING AVG(unit_price) > 500;
```

---

# Common Errors

## Using Aggregate Functions in WHERE

❌ Wrong

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
WHERE AVG(salary) > 60000
GROUP BY department_id;
```

---

✅ Correct

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

---

## Forgetting GROUP BY

❌

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
HAVING AVG(salary) > 60000;
```

---

✅

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

---

# Performance Tips

- Use `WHERE` to reduce rows before grouping.
- Use `HAVING` only for filtering aggregate results.
- Avoid unnecessary grouping on large datasets.
- Index columns frequently used in `WHERE`.

---

# Best Practices

- Filter early using `WHERE`.
- Filter summaries using `HAVING`.
- Use meaningful aliases.
- Keep aggregate expressions readable.
- Format one condition per line in complex HAVING clauses.

---

# Interview Questions

### What is the difference between WHERE and HAVING?

`WHERE` filters rows before grouping.

`HAVING` filters groups after aggregation.

---

### Can HAVING be used without GROUP BY?

Yes.

When no `GROUP BY` is present, the entire result set is treated as a single group.

Example:

```sql
SELECT COUNT(*)
FROM hr.employees
HAVING COUNT(*) > 100;
```

---

### Which clause executes first?

`WHERE`

---

### Can HAVING use aggregate functions?

Yes.

That is its primary purpose.

---

# Cheat Sheet

| Clause | Filters |
|----------|----------|
| WHERE | Individual rows |
| GROUP BY | Creates groups |
| HAVING | Groups |
| ORDER BY | Final output |

---

# Production Example

## Executive Sales Report

```sql
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue,
    AVG(total_amount) AS average_order
FROM sales.orders
WHERE order_status = 'Completed'
GROUP BY region
HAVING SUM(total_amount) > 100000
ORDER BY revenue DESC;
```

Example Output

| Region | Orders | Revenue |
|--------|--------:|---------:|
|North|450|250000|
|West|320|175000|

---

# Practice Exercises

## 🟢 Beginner

1. Display departments with more than five employees.
2. Display categories with an average price greater than 500.
3. Display regions with total sales greater than 100000.

---

## 🟡 Intermediate

1. Display departments with average salary greater than 70000.
2. Display cities with more than ten customers.
3. Display product categories having more than twenty products.

---

## 🔴 Advanced

Write queries to:

1. Display departments with at least ten employees and average salary above 65000.
2. Display months with total revenue above 200000.
3. Display customers with more than five orders.

---

# Production Challenge

Using a sales database:

1. Find regions with revenue above 500000.
2. Find salespersons with more than 100 completed orders.
3. Find categories whose average selling price exceeds 1000.
4. Find customers whose lifetime spending exceeds 50000.

---

# Summary

The `HAVING` clause filters grouped data after aggregation. While `WHERE` removes individual rows before grouping, `HAVING` removes entire groups based on aggregate conditions. Together, `WHERE`, `GROUP BY`, and `HAVING` form the foundation of analytical SQL queries used in reporting and business intelligence.

---

# Related Topics

**Previous**

- `14_GROUP_BY.md`

**Next**

- `16_ORDER_OF_EXECUTION.md`

**Related**

- `13_AGGREGATE_FUNCTIONS.md`
- `03_WHERE.md`
- `17_JOINS/`
