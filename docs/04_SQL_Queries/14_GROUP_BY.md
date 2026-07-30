---
title: GROUP BY Clause
difficulty: Intermediate
reading_time: 75 minutes
practice_time: 150 minutes
estimated_total_time: 225 minutes
prerequisites:
  - Aggregate Functions
  - WHERE Clause
  - Alias
last_updated: 2026-07-30
---

# GROUP BY Clause

## Overview

The `GROUP BY` clause groups rows that have the same values into summary groups.

Instead of calculating one result for the entire table, SQL calculates one result **for each group**.

Examples:

- Total salary by department
- Total sales by region
- Average salary by job role
- Number of orders by customer
- Revenue by month

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand how GROUP BY works.
- Group data correctly.
- Combine GROUP BY with aggregate functions.
- Use multiple grouping columns.
- Avoid common GROUP BY errors.
- Prepare for HAVING and JOINS.

---

# Why GROUP BY?

Suppose the employee table contains:

| Employee | Department | Salary |
|-----------|------------|--------:|
|Rahul|IT|50000|
|Priya|IT|60000|
|Amit|HR|45000|
|Neha|HR|55000|
|Rohan|Finance|70000|

Without GROUP BY:

```sql
SELECT AVG(salary)
FROM hr.employees;
```

Result

```text
56000
```

This is the average salary of **all employees**.

But what if you need the average salary **for each department**?

Use `GROUP BY`.

---

# Basic Syntax

```sql
SELECT
    column_name,
    aggregate_function(column_name)
FROM table_name
GROUP BY column_name;
```

---

# First Example

Average salary by department.

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM hr.employees
GROUP BY department_id;
```

Output

| Department | Average Salary |
|------------|---------------:|
|1|52000|
|2|61000|
|3|47000|

---

# Visual Explanation

```text
Employee Table

IT        50000
IT        60000
IT        65000

HR        45000
HR        50000

Finance   70000
Finance   75000

        │
        ▼

GROUP BY department

        │
        ▼

IT        AVG = 58333

HR        AVG = 47500

Finance   AVG = 72500
```

---

# GROUP BY with COUNT

Count employees in each department.

```sql
SELECT
    department_id,
    COUNT(*) AS total_employees
FROM hr.employees
GROUP BY department_id;
```

---

# GROUP BY with SUM

Total salary paid by department.

```sql
SELECT
    department_id,
    SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id;
```

---

# GROUP BY with MIN and MAX

```sql
SELECT
    department_id,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM hr.employees
GROUP BY department_id;
```

---

# Multiple Aggregate Functions

```sql
SELECT
    department_id,
    COUNT(*) AS employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM hr.employees
GROUP BY department_id;
```

---

# GROUP BY Multiple Columns

Group by department and job title.

```sql
SELECT
    department_id,
    job_title,
    COUNT(*) AS total_employees
FROM hr.employees
GROUP BY
    department_id,
    job_title;
```

---

# GROUP BY with WHERE

`WHERE` filters rows **before** grouping.

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM hr.employees
WHERE salary > 50000
GROUP BY department_id;
```

Only employees earning more than 50,000 are included.

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
SELECT
   ↓
ORDER BY
```

Understanding this order explains why `WHERE` cannot use aggregate functions.

---

# Business Scenarios

## HR Dashboard

Employees by department.

```sql
SELECT
    department_id,
    COUNT(*) AS total_employees
FROM hr.employees
GROUP BY department_id;
```

---

## Sales Dashboard

Revenue by region.

```sql
SELECT
    region,
    SUM(total_amount) AS total_sales
FROM sales.orders
GROUP BY region;
```

---

## Inventory Dashboard

Average price by category.

```sql
SELECT
    category_name,
    AVG(unit_price) AS average_price
FROM inventory.products
GROUP BY category_name;
```

---

# GROUP BY vs DISTINCT

```sql
SELECT DISTINCT department_id
FROM hr.employees;
```

Returns only unique departments.

```sql
SELECT
    department_id,
    COUNT(*)
FROM hr.employees
GROUP BY department_id;
```

Returns unique departments **plus** summary information.

---

# Common Errors

## Selecting a Non-Grouped Column

❌ Wrong

```sql
SELECT
    department_id,
    first_name,
    AVG(salary)
FROM hr.employees
GROUP BY department_id;
```

Error:

```text
column "first_name" must appear in the GROUP BY clause
or be used in an aggregate function
```

---

## Correct Version

```sql
SELECT
    department_id,
    AVG(salary)
FROM hr.employees
GROUP BY department_id;
```

---

# NULL Values

`GROUP BY` treats all `NULL` values as one group.

Example:

| Department |
|------------|
|IT|
|HR|
|NULL|
|NULL|

Result:

```text
IT

HR

NULL
```

---

# Performance Tips

- Group only the columns you need.
- Filter early with `WHERE`.
- Index columns frequently used for grouping.
- Avoid grouping very large text columns unless necessary.

---

# Best Practices

- Always use meaningful aliases.
- Keep grouped columns first in the `SELECT` list.
- Format long GROUP BY clauses with one column per line.
- Filter before grouping whenever possible.

---

# Interview Questions

### What is GROUP BY?

It groups rows with the same values and allows aggregate calculations for each group.

---

### Can GROUP BY be used without aggregate functions?

Yes, but it's often equivalent to `SELECT DISTINCT`.

---

### Can WHERE use aggregate functions?

No.

Use `HAVING` instead.

---

### Why does SQL require non-aggregated columns to appear in GROUP BY?

Because SQL needs to know how to summarize those columns consistently for each group.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `GROUP BY department_id` | Group by department |
| `COUNT(*)` | Count rows |
| `SUM(column)` | Total |
| `AVG(column)` | Average |
| `MIN(column)` | Smallest value |
| `MAX(column)` | Largest value |

---

# Production Example

## Sales KPI Dashboard

```sql
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue,
    AVG(total_amount) AS average_order_value,
    MAX(total_amount) AS largest_order
FROM sales.orders
GROUP BY region
ORDER BY revenue DESC;
```

Example Output

| Region | Orders | Revenue | Avg Order | Largest Order |
|--------|-------:|---------:|----------:|--------------:|
|North|425|845000|1988.24|18500|
|West|310|610000|1967.74|16200|
|South|280|555000|1982.14|15400|

---

# Practice Exercises

## 🟢 Beginner

1. Count employees in each department.
2. Find total salary by department.
3. Find average salary by department.

---

## 🟡 Intermediate

1. Count customers in each city.
2. Find total sales by region.
3. Find average product price by category.

---

## 🔴 Advanced

Write queries to:

1. Display department-wise employee count and average salary.
2. Display monthly sales totals.
3. Display customer count by city, ordered by highest count.

---

# Common Business KPIs

## Human Resources

- Employees by Department
- Average Salary by Department
- Highest Salary by Department

## Sales

- Revenue by Region
- Orders by Month
- Revenue by Salesperson

## Inventory

- Products by Category
- Average Product Price
- Total Inventory Value

---

# Summary

The `GROUP BY` clause transforms detailed row-level data into meaningful summaries. It is the foundation of reporting, dashboards, and business analytics. Once you understand `GROUP BY`, you can build department-wise, region-wise, customer-wise, and product-wise reports—the same kinds of summaries used in Power BI, Tableau, Excel PivotTables, and executive dashboards.

---

# Related Topics

**Previous**

- `13_AGGREGATE_FUNCTIONS.md`

**Next**

- `15_HAVING.md`

**Related**

- `03_WHERE.md`
- `15_HAVING.md`
- `16_JOINS/`
