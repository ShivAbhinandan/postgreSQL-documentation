---
title: LEFT JOIN
difficulty: Intermediate
reading_time: 70 minutes
practice_time: 120 minutes
estimated_total_time: 190 minutes
prerequisites:
  - INNER JOIN
  - Primary Key & Foreign Key
last_updated: 2026-07-30
---

# LEFT JOIN

## Overview

A `LEFT JOIN` returns:

- Every row from the **left table**
- Matching rows from the **right table**
- `NULL` values where no matching row exists

Unlike `INNER JOIN`, unmatched rows from the left table are **never removed**.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand how LEFT JOIN works.
- Identify unmatched rows.
- Find missing relationships.
- Use LEFT JOIN with aggregate functions.
- Write real-world reporting queries.

---

# Syntax

```sql
SELECT column_list
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;
```

The left table is the table written immediately after `FROM`.

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
LEFT TABLE                     RIGHT TABLE

Rahul -------- IT

Priya -------- HR

Amit --------- IT

Neha --------- NULL

Rohan -------- Department 4 (Missing)

LEFT JOIN Result

Rahul    IT

Priya    HR

Amit     IT

Neha     NULL

Rohan    NULL
```

Notice:

Finance does not appear because it exists only in the right table.

---

# First LEFT JOIN

```sql
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM hr.employees AS e
LEFT JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

Output

| employee_id | first_name | department_name |
|--------------|------------|----------------|
|1|Rahul|IT|
|2|Priya|HR|
|3|Amit|IT|
|4|Neha|NULL|
|5|Rohan|NULL|

---

# Step-by-Step Execution

```text
Read Employees

↓

For each employee

↓

Find matching department

↓

Found?

YES → Return Department

NO → Return NULL
```

---

# LEFT JOIN vs INNER JOIN

### INNER JOIN

```text
Rahul

Priya

Amit
```

Only matching rows.

---

### LEFT JOIN

```text
Rahul

Priya

Amit

Neha

Rohan
```

All employees are returned.

---

# Finding Missing Relationships

One of the most common uses of LEFT JOIN.

Employees without departments.

```sql
SELECT
    e.employee_id,
    e.first_name
FROM hr.employees AS e
LEFT JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
```

Output

| employee_id | first_name |
|--------------|------------|
|4|Neha|
|5|Rohan|

This technique is extremely common in production systems.

---

# LEFT JOIN with Aggregate Functions

Count employees per department.

```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM hr.departments AS d
LEFT JOIN hr.employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;
```

Output

| Department | Employees |
|-------------|----------:|
|IT|2|
|HR|1|
|Finance|0|

Notice:

Finance appears with zero employees.

An INNER JOIN would omit Finance entirely.

---

# LEFT JOIN with WHERE

Employees in HR.

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
LEFT JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE d.department_name = 'HR';
```

Result

```text
Priya
```

---

# Important Note

Adding a condition on the right table in the `WHERE` clause can unintentionally turn a LEFT JOIN into behavior similar to an INNER JOIN because rows with `NULL` values from the right table fail the filter.

For example:

```sql
WHERE d.department_name = 'HR'
```

removes rows where `department_name` is `NULL`.

When appropriate, move the condition into the `ON` clause:

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
LEFT JOIN hr.departments AS d
    ON e.department_id = d.department_id
   AND d.department_name = 'HR';
```

This preserves all employees while matching only HR departments.

---

# Business Scenarios

## Customers Without Orders

```sql
SELECT
    c.customer_name
FROM sales.customers AS c
LEFT JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

---

## Products Never Sold

```sql
SELECT
    p.product_name
FROM inventory.products AS p
LEFT JOIN sales.order_items AS oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

---

## Employees Without Managers

```sql
SELECT
    e.first_name
FROM hr.employees AS e
LEFT JOIN hr.employees AS m
    ON e.manager_id = m.employee_id
WHERE m.employee_id IS NULL;
```

---

# Common Mistakes

## Filtering Right Table in WHERE

❌

```sql
WHERE d.department_name = 'IT'
```

This removes unmatched rows.

---

## Correct Approach

```sql
ON e.department_id = d.department_id
AND d.department_name = 'IT'
```

---

## Using COUNT(*)

```sql
COUNT(*)
```

Counts every row.

To count matching records:

```sql
COUNT(e.employee_id)
```

This returns 0 for unmatched rows.

---

# Performance Tips

- Index join columns.
- Use LEFT JOIN only when unmatched rows are required.
- Filter the left table early with `WHERE`.
- Select only required columns.

---

# Best Practices

- Clearly identify the master (left) table.
- Use aliases consistently.
- Use `COUNT(column)` instead of `COUNT(*)` when counting matches.
- Check for `NULL` values to find missing relationships.

---

# Interview Questions

### What does LEFT JOIN return?

All rows from the left table and matching rows from the right table.

---

### What happens when no match exists?

The right-table columns are returned as `NULL`.

---

### How do you find customers without orders?

Use a LEFT JOIN and filter where the right-table key is `NULL`.

---

### Can LEFT JOIN return more rows than INNER JOIN?

Yes.

It includes unmatched rows from the left table.

---

# Cheat Sheet

| Join | Result |
|------|--------|
| INNER JOIN | Matching rows only |
| LEFT JOIN | All left rows + matches |
| Missing Match | Right columns become NULL |

---

# Production Example

## Customer Activity Report

```sql
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM sales.customers AS c
LEFT JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;
```

Customers with no orders appear with `0`.

---

# Practice Exercises

## 🟢 Beginner

1. Join employees and departments using LEFT JOIN.
2. Display employees without departments.
3. Display all departments with employee counts.

---

## 🟡 Intermediate

1. Find customers without orders.
2. Find products never sold.
3. Display all categories with product counts.

---

## 🔴 Advanced

1. Display all salespeople and their total sales.
2. Find suppliers with no products.
3. Find departments with no employees.

---

# Behind the Scenes

PostgreSQL's optimizer may implement a LEFT JOIN using different algorithms (Nested Loop, Hash Join, or Merge Join) depending on table size, indexes, and statistics. The SQL result remains the same regardless of the chosen algorithm.

---

# Summary

A `LEFT JOIN` returns every row from the left table while including matching data from the right table. It is ideal for identifying missing relationships and building complete business reports where every record from the primary table must be included.

---

# Related Topics

**Previous**

- `02_INNER_JOIN.md`

**Next**

- `04_RIGHT_JOIN.md`

**Related**

- `05_FULL_OUTER_JOIN.md`
- `12_Join_vs_Subquery.md`
