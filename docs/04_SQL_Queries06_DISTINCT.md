---
title: DISTINCT
difficulty: Beginner
reading_time: 30 minutes
practice_time: 60 minutes
estimated_total_time: 90 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
  - ORDER BY Clause
  - LIMIT & OFFSET
last_updated: 2026-07-30
---

# DISTINCT

## Overview

The `DISTINCT` keyword removes duplicate rows from the query result.

It is useful when you want to display only unique values instead of every occurrence.

For example:

- Unique customer cities
- Different job titles
- Available payment methods
- Product categories

Without `DISTINCT`, duplicate values are included in the result.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Retrieve unique values.
- Use DISTINCT with one column.
- Use DISTINCT with multiple columns.
- Combine DISTINCT with ORDER BY.
- Understand when DISTINCT should and should not be used.

---

# Basic Syntax

```sql
SELECT DISTINCT column_name
FROM table_name;
```

---

# Display Unique Cities

```sql
SELECT DISTINCT city
FROM sales.customers;
```

Example Output

| city |
|------|
| Delhi |
| Mumbai |
| Pune |
| Ahmedabad |

Even if multiple customers live in Delhi, it appears only once.

---

# Display Unique Departments

```sql
SELECT DISTINCT department_id
FROM hr.employees;
```

Output

| department_id |
|--------------:|
|1|
|2|
|3|
|4|

---

# Display Unique Payment Methods

```sql
SELECT DISTINCT payment_method
FROM finance.payments;
```

Example Output

| payment_method |
|----------------|
|UPI|
|Credit Card|
|Bank Transfer|

---

# DISTINCT with Multiple Columns

`DISTINCT` considers the combination of all selected columns.

```sql
SELECT DISTINCT
    city,
    country
FROM sales.customers;
```

Example

| city | country |
|------|---------|
|Delhi|India|
|Mumbai|India|
|Pune|India|

If the same city exists in different countries, each combination appears separately.

---

# DISTINCT with ORDER BY

Display unique cities alphabetically.

```sql
SELECT DISTINCT city
FROM sales.customers
ORDER BY city;
```

---

# DISTINCT with WHERE

Display cities where customers have a Gmail address.

```sql
SELECT DISTINCT city
FROM sales.customers
WHERE email LIKE '%gmail.com'
ORDER BY city;
```

---

# DISTINCT with Expressions

Display unique annual salaries.

```sql
SELECT DISTINCT
    salary * 12 AS annual_salary
FROM hr.employees
ORDER BY annual_salary;
```

---

# Understanding How DISTINCT Works

Suppose a table contains:

| city |
|------|
|Delhi|
|Delhi|
|Mumbai|
|Delhi|
|Pune|

Query:

```sql
SELECT DISTINCT city
FROM sales.customers;
```

Result:

| city |
|------|
|Delhi|
|Mumbai|
|Pune|

Only unique values remain.

---

# Business Scenarios

## HR Report

List all departments that currently have employees.

```sql
SELECT DISTINCT department_id
FROM hr.employees
ORDER BY department_id;
```

---

## Sales Report

Display all cities where customers are located.

```sql
SELECT DISTINCT city
FROM sales.customers
ORDER BY city;
```

---

## Finance Report

Display all payment methods used.

```sql
SELECT DISTINCT payment_method
FROM finance.payments;
```

---

# Best Practices

- Use `DISTINCT` only when duplicates should be removed.
- Apply `DISTINCT` to the smallest required set of columns.
- Combine with `ORDER BY` for readable output.
- Understand that removing duplicates requires additional processing.

---

# Common Mistakes

## Expecting DISTINCT to Remove Duplicate Rows Based on One Column

```sql
SELECT DISTINCT
    first_name,
    city
FROM sales.customers;
```

Both columns together determine uniqueness.

---

## Using DISTINCT Unnecessarily

```sql
SELECT DISTINCT employee_id
FROM hr.employees;
```

Since `employee_id` is already unique, `DISTINCT` has no effect.

---

## Confusing DISTINCT with GROUP BY

`DISTINCT`

Removes duplicate rows.

`GROUP BY`

Groups rows for aggregate calculations.

You'll learn `GROUP BY` later in this course.

---

# Performance Tip

`DISTINCT` often requires PostgreSQL to sort or hash data internally.

On large datasets, unnecessary use of `DISTINCT` can increase query execution time.

Before using it, ask yourself:

> "Why are duplicates appearing?"

Sometimes fixing the query (especially joins) is better than adding `DISTINCT`.

---

# Interview Questions

### What does DISTINCT do?

It removes duplicate rows from the query result.

---

### Does DISTINCT work on one column only?

No.

It can be applied to one or multiple selected columns.

---

### Does DISTINCT modify the table?

No.

It only affects the query result.

---

### Is DISTINCT faster than GROUP BY?

Not always.

For simple uniqueness checks they may produce similar execution plans, but they serve different purposes.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `SELECT DISTINCT city` | Unique cities |
| `SELECT DISTINCT city, country` | Unique city-country combinations |
| `DISTINCT + ORDER BY` | Sorted unique values |
| `DISTINCT + WHERE` | Filter then remove duplicates |

---

# Practice Exercises

## 🟢 Beginner

1. Display unique customer cities.
2. Display unique department IDs from employees.
3. Display unique payment methods.

---

## 🟡 Intermediate

1. Display unique city-country combinations.
2. Display unique annual salaries.
3. Display unique supplier email domains (challenge).

---

## 🔴 Advanced

Write queries to:

1. Display unique product categories referenced by products.
2. Display unique employee hire years.
3. Display unique customer cities sorted alphabetically.

---

# Summary

The `DISTINCT` keyword removes duplicate rows from query results, making reports cleaner and easier to interpret. It is especially useful for generating lists of unique values, but should be used thoughtfully because it can add processing overhead on large datasets.

---

# Related Topics

**Previous**

- `05_LIMIT_OFFSET.md`

**Next**

- `07_ALIAS.md`

**Related**

- `14_GROUP_BY.md`
- `15_HAVING.md`
