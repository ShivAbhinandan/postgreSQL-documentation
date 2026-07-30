---
title: LIMIT and OFFSET
difficulty: Beginner
reading_time: 35 minutes
practice_time: 60 minutes
estimated_total_time: 95 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
  - ORDER BY Clause
last_updated: 2026-07-30
---

# LIMIT and OFFSET

## Overview

The `LIMIT` clause restricts the number of rows returned by a query.

The `OFFSET` clause skips a specified number of rows before returning results.

Together, they are commonly used for:

- Pagination
- Dashboards
- Reports
- APIs
- Large datasets

---

# Learning Objectives

After completing this chapter, you will be able to:

- Retrieve only the first few rows.
- Skip rows using OFFSET.
- Build paginated queries.
- Combine LIMIT with ORDER BY.
- Understand best practices.

---

# LIMIT Syntax

```sql
SELECT column_name
FROM table_name
LIMIT number;
```

---

# Display First Three Employees

```sql
SELECT *
FROM hr.employees
LIMIT 3;
```

Example Output

| employee_id | first_name | salary |
|--------------|------------|---------|
|1|Rahul|55000|
|2|Priya|72000|
|3|Amit|42000|

Only three rows are returned.

---

# Display First Two Products

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
LIMIT 2;
```

---

# Why ORDER BY Matters

Consider this query:

```sql
SELECT *
FROM hr.employees
LIMIT 5;
```

Although it returns five rows, PostgreSQL does **not** guarantee which five rows you'll get unless an `ORDER BY` clause is used.

Preferred approach:

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 5;
```

Now the result is predictable.

---

# OFFSET Syntax

```sql
SELECT *
FROM table_name
OFFSET number;
```

---

# Skip First Two Employees

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
OFFSET 2;
```

The first two rows are skipped.

---

# LIMIT with OFFSET

Retrieve three employees after skipping the first two.

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 3
OFFSET 2;
```

Example

| employee_id | first_name |
|--------------|------------|
|3|Amit|
|4|Neha|
|5|Rohit|

---

# Pagination Example

Imagine a page displays 10 employees.

### Page 1

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 10 OFFSET 0;
```

---

### Page 2

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 10 OFFSET 10;
```

---

### Page 3

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 10 OFFSET 20;
```

---

# Formula

```text
OFFSET = (Page Number - 1) × Page Size
```

Example:

| Page | LIMIT | OFFSET |
|------|------:|-------:|
|1|10|0|
|2|10|10|
|3|10|20|
|4|10|30|

---

# Top Five Highest Salaries

```sql
SELECT
    first_name,
    salary
FROM hr.employees
ORDER BY salary DESC
LIMIT 5;
```

---

# Lowest Three Product Prices

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
ORDER BY unit_price
LIMIT 3;
```

---

# Business Scenarios

## Dashboard

Display the five newest customer orders.

```sql
SELECT
    order_id,
    order_date
FROM sales.orders
ORDER BY order_date DESC
LIMIT 5;
```

---

## Inventory Report

Display the ten products with the highest stock.

```sql
SELECT
    product_name,
    units_in_stock
FROM inventory.products
ORDER BY units_in_stock DESC
LIMIT 10;
```

---

## HR Report

Display the three highest-paid employees.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
ORDER BY salary DESC
LIMIT 3;
```

---

# Best Practices

- Always use `ORDER BY` with `LIMIT`.
- Keep pagination consistent.
- Use meaningful sorting columns.
- Retrieve only the rows you need.

---

# Common Mistakes

## Using LIMIT Without ORDER BY

```sql
SELECT *
FROM hr.employees
LIMIT 5;
```

The returned rows are not guaranteed to be in any particular order.

Preferred:

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id
LIMIT 5;
```

---

## Forgetting OFFSET

Without OFFSET, every page shows the same rows.

---

## Large OFFSET Values

```sql
OFFSET 100000;
```

Large OFFSET values can become slow because PostgreSQL still processes the skipped rows.

For very large datasets, techniques such as keyset pagination are often more efficient. You'll learn about these in advanced topics.

---

# Interview Questions

### What does LIMIT do?

It restricts the number of rows returned.

---

### What does OFFSET do?

It skips a specified number of rows before returning results.

---

### Why should LIMIT usually be combined with ORDER BY?

To ensure the results are returned in a predictable order.

---

### Can OFFSET be used without LIMIT?

Yes.

However, pagination usually combines both.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `LIMIT 5` | Return first five rows |
| `OFFSET 10` | Skip first ten rows |
| `LIMIT 10 OFFSET 20` | Return ten rows after skipping twenty |
| `ORDER BY ... LIMIT` | Return top or bottom records predictably |

---

# Practice Exercises

## 🟢 Beginner

1. Display the first three employees.
2. Display the first five products.
3. Display the first two customers.

---

## 🟡 Intermediate

1. Skip the first two employees.
2. Display four products after skipping one.
3. Display the five newest orders.

---

## 🔴 Advanced

Write queries to:

1. Display the top three highest-paid employees.
2. Display the five cheapest products.
3. Display page 3 of customer records assuming each page contains two customers.

---

# Performance Tip

`LIMIT` reduces the amount of data returned to the client, which can improve response times.

For large tables, combining `ORDER BY` with an index on the sorting column can significantly improve performance.

---

# Summary

`LIMIT` and `OFFSET` are essential for controlling the size of query results. They are widely used in reporting, dashboards, APIs, and web applications to implement efficient pagination and display manageable subsets of data.

---

# Related Topics

**Previous**

- `04_ORDER_BY.md`

**Next**

- `06_DISTINCT.md`

**Related**

- `03_WHERE.md`
- `04_ORDER_BY.md`
