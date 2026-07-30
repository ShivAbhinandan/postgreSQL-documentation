---
title: LIKE Operator
difficulty: Beginner
reading_time: 40 minutes
practice_time: 75 minutes
estimated_total_time: 115 minutes
prerequisites:
  - WHERE Clause
  - SQL Operators
  - IN Operator
last_updated: 2026-07-30
---

# LIKE Operator

## Overview

The `LIKE` operator searches for text using patterns instead of exact values.

It is commonly used for:

- Name searches
- Email filtering
- Product searches
- Address searches
- Customer lookups

`LIKE` uses wildcard characters to match text.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Search using patterns.
- Use `%` wildcard.
- Use `_` wildcard.
- Combine LIKE with other SQL clauses.
- Understand LIKE vs ILIKE.

---

# Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name LIKE 'pattern';
```

---

# Wildcards

## Percent (%)

Matches **zero or more characters**.

Examples

| Pattern | Matches |
|----------|----------|
| 'A%' | Amit, Arjun, Alice |
| '%a' | Neha, Pooja |
| '%an%' | Ankit, Rohan, Anand |

---

## Underscore (_)

Matches **exactly one character**.

Examples

| Pattern | Matches |
|----------|----------|
| '_mit' | Amit |
| 'R__it' | Rohit |
| 'P____' | Priya |

---

# Starts With

Display employees whose names start with "A".

```sql
SELECT
    first_name
FROM hr.employees
WHERE first_name LIKE 'A%';
```

---

# Ends With

Display customers whose city ends with "pur".

```sql
SELECT
    first_name,
    city
FROM sales.customers
WHERE city LIKE '%pur';
```

Examples:

- Jaipur
- Kanpur
- Nagpur

---

# Contains

Display products containing "Pro".

```sql
SELECT
    product_name
FROM inventory.products
WHERE product_name LIKE '%Pro%';
```

---

# Exact Length Search

Display four-letter names starting with "R".

```sql
SELECT
    first_name
FROM hr.employees
WHERE first_name LIKE 'R___';
```

Examples:

- Ravi
- Rani

---

# Email Search

Find Gmail users.

```sql
SELECT
    first_name,
    email
FROM sales.customers
WHERE email LIKE '%@gmail.com';
```

---

# Phone Number Example

Display phone numbers beginning with 98.

```sql
SELECT
    phone_number
FROM sales.customers
WHERE phone_number LIKE '98%';
```

---

# LIKE with ORDER BY

```sql
SELECT
    first_name,
    city
FROM sales.customers
WHERE city LIKE 'D%'
ORDER BY city;
```

---

# LIKE with AND

Display employees whose names start with "A" and salary is greater than 60000.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE first_name LIKE 'A%'
AND salary > 60000;
```

---

# Case Sensitivity

In PostgreSQL:

```sql
LIKE
```

is **case-sensitive**.

Example:

```sql
WHERE first_name LIKE 'amit%'
```

will **not** match:

```text
Amit
```

---

# ILIKE

PostgreSQL provides `ILIKE` for **case-insensitive** searches.

```sql
SELECT
    first_name
FROM hr.employees
WHERE first_name ILIKE 'amit%';
```

This matches:

- Amit
- AMIT
- amit
- AmIt

> `ILIKE` is a PostgreSQL-specific feature and is not part of the SQL standard.

---

# Escaping Wildcards

Suppose you need to search for a literal `%`.

Use the `ESCAPE` clause.

```sql
SELECT *
FROM products
WHERE product_name LIKE '%\%%' ESCAPE '\';
```

Likewise, to search for a literal underscore:

```sql
SELECT *
FROM products
WHERE product_name LIKE '%\_%' ESCAPE '\';
```

---

# Business Scenarios

## HR Report

Find employees whose names begin with "S".

```sql
SELECT
    first_name
FROM hr.employees
WHERE first_name LIKE 'S%';
```

---

## Sales Report

Display customers using Gmail.

```sql
SELECT
    first_name,
    email
FROM sales.customers
WHERE email LIKE '%@gmail.com';
```

---

## Inventory Report

Display products containing "Laptop".

```sql
SELECT
    product_name
FROM inventory.products
WHERE product_name LIKE '%Laptop%';
```

---

# Best Practices

- Use `%` only where needed.
- Prefer prefix searches (`'A%'`) over `%A%` when possible.
- Use `ILIKE` for case-insensitive searches in PostgreSQL.
- Consider indexes for frequently searched columns.

---

# Performance Tip

Queries like:

```sql
WHERE product_name LIKE 'Lap%'
```

can often use an index.

However:

```sql
WHERE product_name LIKE '%Lap%'
```

usually cannot use a standard B-tree index efficiently because the pattern begins with a wildcard.

For large text-search workloads, PostgreSQL extensions such as `pg_trgm` or full-text search can provide much better performance.

---

# Common Mistakes

## Using = Instead of LIKE

❌ Wrong

```sql
WHERE first_name = 'A%';
```

✅ Correct

```sql
WHERE first_name LIKE 'A%';
```

---

## Forgetting Case Sensitivity

```sql
LIKE
```

is case-sensitive.

Use:

```sql
ILIKE
```

when appropriate.

---

## Using Too Many Wildcards

Avoid:

```sql
LIKE '%%Laptop%%'
```

One `%` on each side is sufficient.

---

# Interview Questions

### What does % mean?

It matches zero or more characters.

---

### What does _ mean?

It matches exactly one character.

---

### What is the difference between LIKE and ILIKE?

- `LIKE` is case-sensitive.
- `ILIKE` is case-insensitive (PostgreSQL only).

---

### Which query finds names ending with "son"?

```sql
WHERE last_name LIKE '%son';
```

---

# Cheat Sheet

| Pattern | Meaning |
|----------|---------|
| 'A%' | Starts with A |
| '%A' | Ends with A |
| '%A%' | Contains A |
| '_A%' | Second character is A |
| '____' | Exactly four characters |

---

# Practice Exercises

## 🟢 Beginner

1. Display employees whose names start with "R".
2. Display customers living in cities ending with "pur".
3. Display Gmail users.

---

## 🟡 Intermediate

1. Display products containing "Phone".
2. Display names with exactly five letters.
3. Display cities beginning with "M".

---

## 🔴 Advanced

Write queries to:

1. Display employees whose names contain "an".
2. Display customers using Yahoo email.
3. Display products beginning with "Smart".

---

# When NOT to Use LIKE

Avoid using `LIKE` when:

- You need exact equality (`=` is clearer).
- You are comparing numeric values.
- You need advanced linguistic or relevance-based searching (use PostgreSQL Full-Text Search instead).

---

# Summary

The `LIKE` operator enables flexible text searching using wildcard patterns. It is widely used for filtering names, emails, cities, and product descriptions. PostgreSQL also provides `ILIKE` for case-insensitive searches, making it especially useful for user-facing applications.

---

# Related Topics

**Previous**

- `09_IN.md`

**Next**

- `11_IS_NULL.md`

**Related**

- `03_WHERE.md`
- `07_OPERATORS.md`
- `12_ALIAS.md`
