---
title: BETWEEN Operator
difficulty: Beginner
reading_time: 30 minutes
practice_time: 60 minutes
estimated_total_time: 90 minutes
prerequisites:
  - WHERE Clause
  - SQL Operators
last_updated: 2026-07-30
---

# BETWEEN Operator

## Overview

The `BETWEEN` operator filters values that fall within a specified range.

It can be used with:

- Numbers
- Dates
- Text (alphabetical ranges)

`BETWEEN` is inclusive, meaning both the starting and ending values are included in the result.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Filter numeric ranges.
- Filter date ranges.
- Filter text ranges.
- Use NOT BETWEEN.
- Understand when BETWEEN is appropriate.

---

# Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
```

---

# Numeric Example

Display employees earning between 50,000 and 80,000.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary BETWEEN 50000 AND 80000;
```

Output

| Employee | Salary |
|----------|--------:|
|Rahul|55000|
|Neha|68000|
|Priya|72000|

Notice that **50000** and **80000** would also be included if present.

---

# Equivalent Query

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary >= 50000
AND salary <= 80000;
```

Both queries return the same result.

---

# Date Example

Display orders placed during January 2025.

```sql
SELECT
    order_id,
    order_date
FROM sales.orders
WHERE order_date
BETWEEN '2025-01-01'
AND '2025-01-31';
```

---

# Product Price Example

Display products priced between 1,000 and 20,000.

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
WHERE unit_price
BETWEEN 1000
AND 20000;
```

---

# Customer ID Example

```sql
SELECT *
FROM sales.customers
WHERE customer_id
BETWEEN 2
AND 4;
```

---

# Text Example

Text values are compared alphabetically.

```sql
SELECT
    first_name
FROM hr.employees
WHERE first_name
BETWEEN 'A'
AND 'M';
```

This returns names that fall alphabetically between **A** and **M** based on the database's collation rules.

> Note: Text comparisons can behave differently depending on the database collation and locale.

---

# NOT BETWEEN

Retrieve employees earning outside the specified salary range.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary NOT BETWEEN 50000 AND 80000;
```

---

# BETWEEN with ORDER BY

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary
BETWEEN 50000 AND 80000
ORDER BY salary DESC;
```

---

# BETWEEN with AND

```sql
SELECT
    product_name,
    unit_price,
    units_in_stock
FROM inventory.products
WHERE unit_price
BETWEEN 1000 AND 20000
AND units_in_stock > 20;
```

---

# Business Scenarios

## HR Report

Display employees hired during 2022.

```sql
SELECT
    first_name,
    hire_date
FROM hr.employees
WHERE hire_date
BETWEEN '2022-01-01'
AND '2022-12-31';
```

---

## Sales Report

Display orders placed in February 2025.

```sql
SELECT
    order_id,
    order_date
FROM sales.orders
WHERE order_date
BETWEEN '2025-02-01'
AND '2025-02-28';
```

---

## Inventory Report

Display products priced between 10,000 and 90,000.

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products
WHERE unit_price
BETWEEN 10000
AND 90000;
```

---

# Best Practices

- Ensure the lower value comes first.
- Remember that `BETWEEN` is inclusive.
- Use `BETWEEN` when it improves readability.
- For timestamps, be careful with end-of-day values.

---

# Common Mistakes

## Reversing the Range

❌ Wrong

```sql
WHERE salary BETWEEN 80000 AND 50000;
```

This returns no rows.

✅ Correct

```sql
WHERE salary BETWEEN 50000 AND 80000;
```

---

## Forgetting That BETWEEN Is Inclusive

```sql
WHERE salary BETWEEN 50000 AND 80000;
```

This includes both **50000** and **80000**.

---

## Filtering Timestamps

If `order_date` is a timestamp:

```sql
WHERE order_date
BETWEEN '2025-01-01'
AND '2025-01-31'
```

Rows on `2025-01-31` after midnight may be excluded depending on the stored time.

A safer pattern is:

```sql
WHERE order_date >= '2025-01-01'
AND order_date < '2025-02-01';
```

---

# Performance Tip

`BETWEEN` can use indexes efficiently because it represents a range condition.

For indexed numeric and date columns, it often performs as well as using `>=` and `<=`.

---

# Interview Questions

### Is BETWEEN inclusive?

Yes.

Both boundary values are included.

---

### Can BETWEEN be used with dates?

Yes.

It works with numbers, dates, timestamps, and text.

---

### What is the opposite of BETWEEN?

```sql
NOT BETWEEN
```

---

### Is BETWEEN faster than >= and <=?

Generally, no. PostgreSQL typically treats them as equivalent range conditions.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `BETWEEN 10 AND 20` | Inclusive numeric range |
| `BETWEEN '2025-01-01' AND '2025-01-31'` | Date range |
| `NOT BETWEEN` | Exclude a range |
| `BETWEEN 'A' AND 'M'` | Alphabetical range |

---

# Practice Exercises

## 🟢 Beginner

1. Display employees earning between 40,000 and 70,000.
2. Display products priced between 1,000 and 20,000.
3. Display customers with IDs between 1 and 3.

---

## 🟡 Intermediate

1. Display employees hired during 2022.
2. Display January 2025 orders.
3. Display products with stock between 40 and 200.

---

## 🔴 Advanced

Write queries to:

1. Display employees not earning between 50,000 and 80,000.
2. Display products priced between 10,000 and 90,000, ordered by price.
3. Display customers whose IDs are between 2 and 4.

---

# Summary

The `BETWEEN` operator provides a concise way to filter values within a range. Because it includes both boundary values, it is commonly used for salary ranges, date intervals, product prices, and other range-based queries.

---

# Related Topics

**Previous**

- `07_OPERATORS.md`

**Next**

- `09_IN.md`

**Related**

- `03_WHERE.md`
- `10_LIKE.md`
