---
title: ORDER BY Clause
difficulty: Beginner
reading_time: 35 minutes
practice_time: 75 minutes
estimated_total_time: 110 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
last_updated: 2026-07-30
---

# ORDER BY Clause

## Overview

The `ORDER BY` clause sorts query results in ascending or descending order.

Sorting makes reports easier to read and helps users quickly identify the highest, lowest, newest, or oldest records.

Examples:

- Highest-paid employees
- Cheapest products
- Latest customer orders
- Products sorted alphabetically

---

# Learning Objectives

After completing this chapter, you will be able to:

- Sort data in ascending order.
- Sort data in descending order.
- Sort by multiple columns.
- Sort using aliases.
- Understand NULL sorting behavior.
- Write readable sorting queries.

---

# Basic Syntax

```sql
SELECT column_name
FROM table_name
ORDER BY column_name;
```

---

# Ascending Order (ASC)

Ascending is the default order.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
ORDER BY salary ASC;
```

Output:

| Employee | Salary |
|----------|---------|
|Amit|42000|
|Rahul|55000|
|Neha|68000|
|Priya|72000|
|Rohit|95000|

---

# Descending Order (DESC)

Display the highest salaries first.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
ORDER BY salary DESC;
```

Output:

| Employee | Salary |
|----------|---------|
|Rohit|95000|
|Priya|72000|
|Neha|68000|
|Rahul|55000|
|Amit|42000|

---

# Sort Alphabetically

```sql
SELECT
    first_name,
    last_name
FROM hr.employees
ORDER BY first_name;
```

---

# Sort Products by Price

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
ORDER BY unit_price DESC;
```

---

# Sort Orders by Date

Newest orders first.

```sql
SELECT
    order_id,
    order_date
FROM sales.orders
ORDER BY order_date DESC;
```

---

# Sort by Multiple Columns

Sort by department first and salary second.

```sql
SELECT
    first_name,
    department_id,
    salary
FROM hr.employees
ORDER BY
    department_id ASC,
    salary DESC;
```

PostgreSQL first sorts by `department_id`.

If multiple employees belong to the same department, it sorts them by salary.

---

# Sort Using Column Position

```sql
SELECT
    first_name,
    salary
FROM hr.employees
ORDER BY 2 DESC;
```

Here, `2` refers to the second selected column (`salary`).

> ⚠️ Although valid SQL, using column positions is discouraged because queries become harder to maintain.

---

# Sort Using an Alias

```sql
SELECT
    first_name,
    salary * 12 AS annual_salary
FROM hr.employees
ORDER BY annual_salary DESC;
```

---

# NULL Values

Suppose some employees have no phone number.

```sql
SELECT
    first_name,
    phone_number
FROM hr.employees
ORDER BY phone_number;
```

PostgreSQL allows explicit control over NULL placement.

Move NULL values to the end:

```sql
ORDER BY phone_number NULLS LAST;
```

Move NULL values to the beginning:

```sql
ORDER BY phone_number NULLS FIRST;
```

---

# Combining WHERE and ORDER BY

Display employees earning more than 60,000, sorted from highest to lowest salary.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary > 60000
ORDER BY salary DESC;
```

---

# Query Execution Order

Although SQL is written as:

```sql
SELECT
FROM
WHERE
ORDER BY
```

PostgreSQL logically processes it as:

```text
FROM

↓

WHERE

↓

SELECT

↓

ORDER BY
```

Sorting is one of the final steps before the result is returned.

---

# Best Practices

- Always specify `ASC` or `DESC` for clarity.
- Sort only when needed.
- Use meaningful columns.
- Prefer column names over column numbers.
- Combine `WHERE` and `ORDER BY` for cleaner reports.

---

# Common Mistakes

## Forgetting DESC

```sql
ORDER BY salary;
```

This sorts in ascending order.

If you need the highest salary first:

```sql
ORDER BY salary DESC;
```

---

## Sorting by a Non-Selected Column

This is valid SQL.

```sql
SELECT first_name
FROM hr.employees
ORDER BY salary DESC;
```

The `salary` column does not have to appear in the `SELECT` list.

---

## Using Multiple ORDER BY Clauses

❌ Wrong

```sql
ORDER BY salary
ORDER BY first_name;
```

✅ Correct

```sql
ORDER BY salary, first_name;
```

---

# Business Scenarios

## HR Report

Display employees from highest salary to lowest.

```sql
SELECT
    first_name,
    last_name,
    salary
FROM hr.employees
ORDER BY salary DESC;
```

---

## Inventory Report

Display products from cheapest to most expensive.

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
ORDER BY unit_price ASC;
```

---

## Sales Report

Display the newest customer orders first.

```sql
SELECT
    order_id,
    order_date,
    order_status
FROM sales.orders
ORDER BY order_date DESC;
```

---

# Interview Questions

### What is the default sorting order?

Ascending (`ASC`).

---

### Can ORDER BY sort multiple columns?

Yes.

Columns are evaluated from left to right.

---

### Does ORDER BY modify the table?

No.

It only affects the order of rows returned by the query.

---

### Can you sort by an alias?

Yes.

PostgreSQL allows sorting using column aliases.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `ORDER BY column ASC` | Ascending order |
| `ORDER BY column DESC` | Descending order |
| `ORDER BY col1, col2` | Sort by multiple columns |
| `NULLS FIRST` | Show NULL values first |
| `NULLS LAST` | Show NULL values last |

---

# Practice Exercises

## 🟢 Beginner

1. Display employees sorted by salary (ascending).
2. Display products sorted by price (descending).
3. Display customers sorted by first name.

---

## 🟡 Intermediate

1. Display employees sorted by department and salary.
2. Display orders sorted by date (newest first).
3. Display products sorted alphabetically.

---

## 🔴 Advanced

Write queries to:

1. Display employees earning more than 50,000 sorted by salary.
2. Display products with stock less than 100 sorted by stock.
3. Display customers sorted by city and then by last name.

---

# Summary

The `ORDER BY` clause controls the order in which query results are returned. It can sort by one or more columns, aliases, or expressions and is commonly combined with `WHERE` to create clear, useful reports.

---

# Related Topics

**Previous**

- `03_WHERE.md`

**Next**

- `05_LIMIT_OFFSET.md`

**Related**

- `06_DISTINCT.md`
- `07_ALIAS.md`
