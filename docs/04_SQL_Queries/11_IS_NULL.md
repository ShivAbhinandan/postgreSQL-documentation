---
title: IS NULL and IS NOT NULL
difficulty: Beginner
reading_time: 40 minutes
practice_time: 75 minutes
estimated_total_time: 115 minutes
prerequisites:
  - WHERE Clause
  - SQL Operators
  - LIKE Operator
last_updated: 2026-07-30
---

# IS NULL and IS NOT NULL

## Overview

A `NULL` value represents **missing, unknown, or unavailable data**.

It does **not** mean:

- Zero (`0`)
- An empty string (`''`)
- FALSE

Because `NULL` means "unknown", it requires special comparison operators.

Examples:

- Employee has no phone number.
- Customer has not provided an email.
- Product has no supplier assigned.
- Order has not been delivered yet.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand what NULL represents.
- Find NULL values.
- Find non-NULL values.
- Avoid common NULL comparison mistakes.
- Understand NULL behavior in SQL.

---

# What is NULL?

Consider this employee table.

| employee_id | first_name | phone_number |
|-------------|------------|--------------|
|1|Rahul|9876543210|
|2|Priya|NULL|
|3|Amit|9988776655|
|4|Neha|NULL|

Here,

`NULL` means the phone number is unknown or missing.

It does **not** mean:

```text
0

or

''
```

---

# Checking for NULL

Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NULL;
```

---

# Find Employees Without Phone Numbers

```sql
SELECT
    first_name,
    phone_number
FROM hr.employees
WHERE phone_number IS NULL;
```

Output

| first_name | phone_number |
|------------|--------------|
|Priya|NULL|
|Neha|NULL|

---

# IS NOT NULL

Find employees who have phone numbers.

```sql
SELECT
    first_name,
    phone_number
FROM hr.employees
WHERE phone_number IS NOT NULL;
```

---

# NULL Comparison Mistake

❌ Wrong

```sql
SELECT *
FROM hr.employees
WHERE phone_number = NULL;
```

Returns **no rows**.

---

❌ Also Wrong

```sql
SELECT *
FROM hr.employees
WHERE phone_number <> NULL;
```

Returns **no rows**.

---

✅ Correct

```sql
SELECT *
FROM hr.employees
WHERE phone_number IS NULL;
```

---

# Why?

`NULL` means **unknown**.

Can SQL answer:

```text
Is unknown equal to unknown?
```

No.

The answer is still **unknown**.

Therefore:

```sql
NULL = NULL
```

does **not** evaluate to TRUE.

Instead, SQL provides:

```sql
IS NULL
```

---

# Three-Valued Logic

Unlike most programming languages, SQL uses **three-valued logic**.

A condition can evaluate to:

| Result | Meaning |
|----------|---------|
| TRUE | Condition matches |
| FALSE | Condition does not match |
| UNKNOWN | Result involves NULL |

Example

```sql
salary > NULL
```

Result:

```text
UNKNOWN
```

---

# Using IS NULL with AND

Display employees from department 2 who do not have a phone number.

```sql
SELECT
    first_name,
    department_id
FROM hr.employees
WHERE department_id = 2
AND phone_number IS NULL;
```

---

# Using IS NOT NULL with ORDER BY

```sql
SELECT
    first_name,
    email
FROM sales.customers
WHERE email IS NOT NULL
ORDER BY first_name;
```

---

# NULL in Calculations

Suppose:

```text
salary = 50000

bonus = NULL
```

Query

```sql
SELECT
    salary + bonus
FROM hr.employees;
```

Result

```text
NULL
```

Because any arithmetic involving `NULL` results in `NULL`.

---

# COALESCE Preview

To replace NULL values:

```sql
SELECT
    COALESCE(phone_number, 'Not Available')
FROM hr.employees;
```

Output

```text
9876543210

Not Available

9988776655

Not Available
```

You'll learn `COALESCE()` in detail later.

---

# Business Scenarios

## HR Report

Find employees without email addresses.

```sql
SELECT
    first_name,
    email
FROM hr.employees
WHERE email IS NULL;
```

---

## Sales Report

Display customers who have provided phone numbers.

```sql
SELECT
    first_name,
    phone_number
FROM sales.customers
WHERE phone_number IS NOT NULL;
```

---

## Inventory Report

Display products that have not yet been assigned a supplier.

```sql
SELECT
    product_name,
    supplier_id
FROM inventory.products
WHERE supplier_id IS NULL;
```

---

# Best Practices

- Always use `IS NULL` or `IS NOT NULL`.
- Never compare NULL using `=` or `<>`.
- Understand that NULL is not a value.
- Consider `COALESCE()` when displaying reports.

---

# Common Mistakes

## Using = NULL

❌

```sql
WHERE email = NULL;
```

✅

```sql
WHERE email IS NULL;
```

---

## Using <> NULL

❌

```sql
WHERE email <> NULL;
```

✅

```sql
WHERE email IS NOT NULL;
```

---

## Confusing NULL with Empty String

```text
NULL

≠

''
```

They are different.

---

# Performance Tip

Columns containing many NULL values can still be indexed.

PostgreSQL also supports **partial indexes**, which are useful when queries frequently filter on `IS NULL` or `IS NOT NULL`.

Example:

```sql
CREATE INDEX idx_employee_email
ON hr.employees(email)
WHERE email IS NOT NULL;
```

You'll learn indexing later in this course.

---

# Interview Questions

### What is NULL?

A marker representing missing, unknown, or unavailable data.

---

### Is NULL equal to zero?

No.

---

### Can NULL be compared using = ?

No.

Use:

```sql
IS NULL
```

---

### Which operator finds non-NULL values?

```sql
IS NOT NULL
```

---

### What happens when NULL is used in arithmetic?

The result is usually `NULL`.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `IS NULL` | Find missing values |
| `IS NOT NULL` | Find existing values |
| `COALESCE()` | Replace NULL values |
| `NULL = NULL` | Not TRUE |

---

# Practice Exercises

## 🟢 Beginner

1. Display employees without phone numbers.
2. Display customers with email addresses.
3. Display products without suppliers.

---

## 🟡 Intermediate

1. Display employees from department 2 without phone numbers.
2. Display customers with phone numbers sorted alphabetically.
3. Display products with assigned suppliers.

---

## 🔴 Advanced

Write queries to:

1. Display employees whose bonus is NULL.
2. Display customers without email addresses.
3. Display products with NULL supplier IDs ordered by product name.

---

# When NOT to Use IS NULL

Do not use `IS NULL` to check for:

- Zero values (`0`)
- Empty strings (`''`)
- FALSE values

Example:

```sql
WHERE quantity = 0
```

is different from:

```sql
WHERE quantity IS NULL
```

---

# Summary

`NULL` represents missing or unknown information in SQL. Because it is not a regular value, it must be checked using `IS NULL` and `IS NOT NULL`. Correct NULL handling is essential for writing accurate SQL queries and avoiding subtle bugs.

---

# Related Topics

**Previous**

- `10_LIKE.md`

**Next**

- `12_ALIAS.md`

**Related**

- `03_WHERE.md`
- `13_AGGREGATE_FUNCTIONS.md`
- `14_GROUP_BY.md`
