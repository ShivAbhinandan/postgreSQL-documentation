---
title: INNER JOIN
difficulty: Intermediate
reading_time: 70 minutes
practice_time: 120 minutes
estimated_total_time: 190 minutes
prerequisites:
  - SQL Joins Introduction
  - Primary Key & Foreign Key
last_updated: 2026-07-30
---

# INNER JOIN

## Overview

`INNER JOIN` returns **only the rows that have matching values in both tables**.

If no matching row exists in either table, that row is excluded from the result.

It is the most frequently used join in SQL because most business reports require only valid, related data.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand how INNER JOIN works.
- Join two related tables.
- Join multiple tables.
- Use aliases with joins.
- Avoid common INNER JOIN mistakes.
- Write production-quality join queries.

---

# Syntax

```sql
SELECT column_list
FROM table1
INNER JOIN table2
ON table1.column = table2.column;
```

`INNER` is optional.

These are equivalent:

```sql
FROM employees
INNER JOIN departments
```

```sql
FROM employees
JOIN departments
```

---

# Sample Tables

## Employees

| employee_id | first_name | department_id |
|-------------|------------|---------------|
|1|Rahul|1|
|2|Priya|2|
|3|Amit|1|
|4|Neha|NULL|
|5|Rohan|4|

---

## Departments

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|
|3|Finance|

---

# Visual Representation

```text
Employees                     Departments

Rahul ----------- IT
Priya ----------- HR
Amit ------------ IT
Neha ------------ NULL
Rohan ----------- Department 4 (Not Found)

INNER JOIN returns only:

Rahul  IT
Priya  HR
Amit   IT
```

Neha is excluded because her department is NULL.

Rohan is excluded because department 4 does not exist.

Finance is excluded because no employee belongs to it.

---

# First INNER JOIN

```sql
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM hr.employees AS e
INNER JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

Output

| employee_id | first_name | department_name |
|--------------|------------|----------------|
|1|Rahul|IT|
|2|Priya|HR|
|3|Amit|IT|

---

# Step-by-Step Execution

```text
Step 1

Read Employees

↓

Step 2

Read Departments

↓

Step 3

Compare

employees.department_id

with

departments.department_id

↓

Step 4

Return matching rows only
```

---

# How Matching Works

Employee

```text
department_id = 1
```

Department

```text
department_id = 1
```

Result

```text
MATCH

Included
```

Employee

```text
department_id = NULL
```

No comparison possible.

Result

```text
Not Included
```

Employee

```text
department_id = 4
```

Department 4 doesn't exist.

Result

```text
Not Included
```

---

# Using Table Aliases

Recommended:

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

Avoid:

```sql
SELECT
employees.first_name,
departments.department_name
FROM hr.employees
JOIN hr.departments
ON employees.department_id = departments.department_id;
```

Aliases improve readability.

---

# Selecting Columns

Avoid:

```sql
SELECT *
```

Better:

```sql
SELECT
    e.employee_id,
    e.first_name,
    d.department_name;
```

Selecting only the required columns improves readability and can reduce data transfer.

---

# INNER JOIN with WHERE

Employees in the IT department.

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'IT';
```

Output

| first_name | department_name |
|------------|-----------------|
|Rahul|IT|
|Amit|IT|

---

# INNER JOIN with ORDER BY

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id
ORDER BY d.department_name;
```

---

# INNER JOIN with Aggregate Functions

Employees per department.

```sql
SELECT
    d.department_name,
    COUNT(*) AS total_employees
FROM hr.departments AS d
JOIN hr.employees AS e
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_employees DESC;
```

---

# Joining Three Tables

Employees → Departments → Locations

```sql
SELECT
    e.first_name,
    d.department_name,
    l.city
FROM hr.employees AS e
JOIN hr.departments AS d
    ON e.department_id = d.department_id
JOIN hr.locations AS l
    ON d.location_id = l.location_id;
```

This demonstrates how joins scale to multiple related tables.

---

# Business Scenarios

## Human Resources

Employee → Department

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

---

## Sales

Customer → Orders

```sql
SELECT
    c.customer_name,
    o.order_date,
    o.total_amount
FROM sales.customers AS c
JOIN sales.orders AS o
ON c.customer_id = o.customer_id;
```

---

## Inventory

Product → Category

```sql
SELECT
    p.product_name,
    c.category_name
FROM inventory.products AS p
JOIN inventory.categories AS c
ON p.category_id = c.category_id;
```

---

# Common Mistakes

## Forgetting the ON clause

❌

```sql
SELECT *
FROM employees
JOIN departments;
```

Produces a Cartesian product in PostgreSQL when using an explicit join without an `ON` clause? Actually, PostgreSQL requires a join condition for `JOIN`; to intentionally create every combination, use `CROSS JOIN`. If your intent is an inner join, always include `ON`.

---

## Joining Incorrect Columns

❌

```sql
ON employee_id = department_id
```

✅

```sql
ON employees.department_id = departments.department_id
```

---

## Ambiguous Column Names

❌

```sql
SELECT department_id
```

If both tables contain `department_id`, PostgreSQL reports the column as ambiguous.

✅

```sql
SELECT e.department_id
```

---

## Using SELECT *

Avoid in production code.

Select only the required columns.

---

# Performance Tips

- Index join columns.
- Join on Primary Key / Foreign Key relationships whenever possible.
- Filter early using `WHERE`.
- Avoid unnecessary columns.
- Use meaningful aliases.

---

# Best Practices

- Use explicit `JOIN ... ON`.
- Prefix columns with table aliases.
- Format each join on a separate line.
- Use aliases consistently.

Example:

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

---

# Interview Questions

### What does INNER JOIN return?

Only rows with matching values in both tables.

---

### Is INNER optional?

Yes.

```sql
JOIN
```

means

```sql
INNER JOIN
```

---

### Can multiple INNER JOINs be used?

Yes.

A query can join many related tables.

---

### What happens if one side has NULL?

The row is not returned because NULL does not match a value in the other table.

---

# Cheat Sheet

| Statement | Purpose |
|------------|---------|
| `JOIN` | Same as `INNER JOIN` |
| `ON` | Join condition |
| `WHERE` | Filter joined rows |
| `GROUP BY` | Summarize joined data |

---

# Production Example

## Sales Report

```sql
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_sales
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;
```

Example Output

| Customer | Orders | Total Sales |
|-----------|--------:|------------:|
|ABC Corp|42|$125,000|
|XYZ Ltd|31|$98,500|
|Global Inc|27|$86,200|

---

# Practice Exercises

## 🟢 Beginner

1. Join employees and departments.
2. Display employee names with department names.
3. Display employees working in the HR department.

---

## 🟡 Intermediate

1. Count employees in each department.
2. Join customers with orders.
3. Display product names with category names.

---

## 🔴 Advanced

1. Join employees, departments, and locations.
2. Display department-wise average salary.
3. Display customers with total spending.

---

# Behind the Scenes

Internally, the database chooses an execution strategy for joins based on the query and available indexes. PostgreSQL may use algorithms such as:

- Nested Loop Join
- Hash Join
- Merge Join

You don't need to choose these manually in most cases—the query planner selects the most efficient option. You'll learn query optimization and execution plans later in this guide.

---

# Summary

`INNER JOIN` combines rows from two or more tables and returns only matching records. It is the most commonly used join in SQL and forms the foundation for business reports, dashboards, and relational database queries.

---

# Related Topics

**Previous**

- `01_Introduction.md`

**Next**

- `03_LEFT_JOIN.md`

**Related**

- `../04_SQL_Queries/03_WHERE.md`
- `../04_SQL_Queries/14_GROUP_BY.md`
