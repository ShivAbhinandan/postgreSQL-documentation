---
title: WHERE Clause
difficulty: Beginner
reading_time: 45 minutes
practice_time: 90 minutes
estimated_total_time: 135 minutes
prerequisites:
  - SELECT Statement
last_updated: 2026-07-30
---

# WHERE Clause

## Overview

The `WHERE` clause filters rows based on one or more conditions.

Instead of returning every row in a table, `WHERE` allows you to retrieve only the records that match your criteria.

Examples:

- Employees earning more than 60,000
- Customers from Delhi
- Products with low stock
- Orders placed today

Without the `WHERE` clause, SQL returns all rows.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Filter rows using conditions.
- Use comparison operators.
- Combine multiple conditions.
- Filter text, numbers, dates, and NULL values.
- Write efficient filtering queries.

---

# Basic Syntax

```sql
SELECT column_name
FROM table_name
WHERE condition;
```

---

# Retrieve Employees From the IT Department

```sql
SELECT *
FROM hr.employees
WHERE department_id = 4;
```

Output:

| employee_id | first_name | salary |
|--------------|------------|---------|
|1|Rahul|55000|
|5|Rohit|95000|

---

# Comparison Operators

| Operator | Meaning |
|----------|---------|
| = | Equal to |
| <> | Not equal to |
| > | Greater than |
| >= | Greater than or equal |
| < | Less than |
| <= | Less than or equal |

---

# Equal To (=)

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary = 55000;
```

---

# Greater Than (>)

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary > 60000;
```

---

# Less Than (<)

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
WHERE unit_price < 10000;
```

---

# Not Equal To (<>)

```sql
SELECT
    first_name,
    city
FROM sales.customers
WHERE city <> 'Delhi';
```

---

# Filter by Date

Employees hired after January 1, 2022:

```sql
SELECT
    first_name,
    hire_date
FROM hr.employees
WHERE hire_date > '2022-01-01';
```

---

# Multiple Conditions (AND)

Return employees with a salary greater than 60,000 who work in the IT department.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary > 60000
AND department_id = 4;
```

---

# Multiple Conditions (OR)

Return customers from Delhi or Mumbai.

```sql
SELECT
    first_name,
    city
FROM sales.customers
WHERE city = 'Delhi'
OR city = 'Mumbai';
```

---

# Combining AND and OR

Use parentheses to make the logic clear.

```sql
SELECT
    first_name,
    salary,
    department_id
FROM hr.employees
WHERE
(
    department_id = 2
    OR department_id = 4
)
AND salary > 50000;
```

---

# Using Mathematical Expressions

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary * 12 > 800000;
```

This calculates annual salary before applying the filter.

---

# Text Comparisons

```sql
SELECT
    first_name,
    last_name
FROM hr.employees
WHERE last_name = 'Sharma';
```

Text values must be enclosed in single quotes.

---

# Query Execution Order

Although SQL is written as:

```sql
SELECT
FROM
WHERE
```

PostgreSQL logically processes it as:

```text
FROM

↓

WHERE

↓

SELECT
```

The database first identifies the table, then filters rows, and finally returns the selected columns.

---

# Best Practices

- Filter as early as possible.
- Use meaningful conditions.
- Write readable SQL with proper indentation.
- Use parentheses when combining `AND` and `OR`.
- Filter only on relevant columns.

---

# Common Mistakes

## Missing Quotes Around Text

❌ Wrong

```sql
WHERE city = Delhi;
```

✅ Correct

```sql
WHERE city = 'Delhi';
```

---

## Using = with NULL

❌ Wrong

```sql
WHERE phone_number = NULL;
```

`NULL` comparisons require `IS NULL`, which we'll cover in a later chapter.

---

## Forgetting Parentheses

❌ Hard to read

```sql
WHERE department_id = 1
OR department_id = 2
AND salary > 60000;
```

✅ Better

```sql
WHERE
(
    department_id = 1
    OR department_id = 2
)
AND salary > 60000;
```

---

# Business Scenarios

## HR Report

Display employees earning more than 70,000.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary > 70000;
```

---

## Inventory Report

Display products with fewer than 50 units in stock.

```sql
SELECT
    product_name,
    units_in_stock
FROM inventory.products
WHERE units_in_stock < 50;
```

---

## Sales Report

Display all customers from Pune.

```sql
SELECT
    first_name,
    last_name
FROM sales.customers
WHERE city = 'Pune';
```

---

# Interview Questions

### What is the purpose of the `WHERE` clause?

It filters rows based on one or more conditions before returning the result.

---

### Can a query have multiple `WHERE` clauses?

No.

A query can contain only one `WHERE` clause, but it can include multiple conditions combined with `AND` and `OR`.

---

### Which operator is used for "not equal"?

```sql
<>
```

(Some database systems also support `!=`, but `<>` is the SQL standard.)

---

### Why are parentheses important?

They make complex logical conditions clear and ensure the intended order of evaluation.

---

# Cheat Sheet

| Operator | Example |
|----------|---------|
| = | `salary = 50000` |
| <> | `city <> 'Delhi'` |
| > | `salary > 60000` |
| < | `salary < 50000` |
| >= | `salary >= 70000` |
| <= | `salary <= 30000` |
| AND | Both conditions must be true |
| OR | At least one condition must be true |

---

# Practice Exercises

## 🟢 Beginner

1. Display employees with a salary greater than 50,000.
2. Display customers from Delhi.
3. Display products with a price greater than 50,000.

---

## 🟡 Intermediate

1. Display employees hired after `2022-01-01`.
2. Display customers from Mumbai or Pune.
3. Display products with stock less than 100.

---

## 🔴 Advanced

Write queries to:

1. Display employees in the IT department earning more than 60,000.
2. Display products priced below 20,000 with stock greater than 50.
3. Display customers who are **not** from Delhi.

---

# Summary

The `WHERE` clause is one of the most powerful SQL features. It allows you to retrieve only the data you need by filtering rows based on specific conditions. Combined with `SELECT`, it forms the basis of most SQL queries used in reporting, analytics, and business applications.

---

# Related Topics

**Previous**

- `02_SELECT.md`

**Next**

- `04_ORDER_BY.md`

**Related**

- `05_LIMIT_OFFSET.md`
- `06_DISTINCT.md`
