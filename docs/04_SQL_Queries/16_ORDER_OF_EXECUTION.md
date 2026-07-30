---
title: SQL Logical Query Processing Order
difficulty: Intermediate
reading_time: 55 minutes
practice_time: 90 minutes
estimated_total_time: 145 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
  - GROUP BY
  - HAVING
  - ORDER BY
last_updated: 2026-07-30
---

# SQL Logical Query Processing Order

## Overview

Although SQL queries are written starting with the `SELECT` clause, SQL **does not execute them in that order**.

Understanding SQL's logical execution order explains:

- Why aliases usually don't work in `WHERE`
- Why aggregate functions can't be used in `WHERE`
- Why `HAVING` exists
- Why `GROUP BY` changes available columns
- Why `ORDER BY` can use aliases

This chapter is one of the most important concepts in SQL.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand SQL's logical execution order.
- Explain why common SQL errors occur.
- Predict query behavior.
- Write cleaner analytical queries.
- Prepare for joins and window functions.

---

# The Logical Execution Order

A typical query is written like this:

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM hr.employees
WHERE salary > 50000
GROUP BY department_id
HAVING AVG(salary) > 60000
ORDER BY average_salary DESC
LIMIT 5;
```

However, SQL processes it in this order:

```text
1. FROM
2. WHERE
3. GROUP BY
4. Aggregate Functions
5. HAVING
6. SELECT
7. DISTINCT
8. ORDER BY
9. LIMIT / OFFSET
```

---

# Step 1 — FROM

SQL first finds the source table(s).

```sql
FROM hr.employees
```

At this point:

- Rows are loaded.
- Joins (if any) are performed.
- A working dataset is created.

---

# Step 2 — WHERE

Rows are filtered.

```sql
WHERE salary > 50000
```

Rows that don't satisfy the condition are removed.

Aggregate functions are **not available** here because grouping hasn't happened yet.

---

# Step 3 — GROUP BY

Rows are grouped.

```sql
GROUP BY department_id
```

Instead of individual rows, SQL now works with groups.

---

# Step 4 — Aggregate Functions

SQL calculates:

```sql
COUNT()

SUM()

AVG()

MIN()

MAX()
```

Each group now has summarized values.

---

# Step 5 — HAVING

Groups are filtered.

```sql
HAVING AVG(salary) > 60000
```

Unlike `WHERE`, `HAVING` can use aggregate functions because they already exist.

---

# Step 6 — SELECT

Only now does SQL choose which columns to return.

```sql
SELECT
department_id,
AVG(salary)
```

This surprises many beginners because `SELECT` appears first in the query but executes much later.

---

# Step 7 — DISTINCT

Duplicate rows are removed.

```sql
SELECT DISTINCT department_id
```

`DISTINCT` operates on the result produced by `SELECT`.

---

# Step 8 — ORDER BY

Rows are sorted.

```sql
ORDER BY average_salary DESC
```

At this stage:

- Aliases are available.
- Aggregate values are available.
- Final rows are ready to sort.

---

# Step 9 — LIMIT / OFFSET

Finally:

```sql
LIMIT 10;
```

SQL returns only the requested rows.

---

# Visual Execution Flow

```text
           SQL Query

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT

        │
        ▼

Logical Processing

FROM
   │
   ▼
WHERE
   │
   ▼
GROUP BY
   │
   ▼
Aggregate Functions
   │
   ▼
HAVING
   │
   ▼
SELECT
   │
   ▼
DISTINCT
   │
   ▼
ORDER BY
   │
   ▼
LIMIT
```

---

# Why Aliases Don't Work in WHERE

❌

```sql
SELECT
salary * 12 AS annual_salary
FROM hr.employees
WHERE annual_salary > 700000;
```

Error.

Why?

Because:

```text
WHERE executes before SELECT.
```

The alias doesn't exist yet.

---

# Correct Version

```sql
SELECT
salary * 12 AS annual_salary
FROM hr.employees
WHERE salary * 12 > 700000;
```

---

# Why ORDER BY Can Use Aliases

```sql
SELECT
salary * 12 AS annual_salary
FROM hr.employees
ORDER BY annual_salary DESC;
```

This works because:

```text
ORDER BY executes after SELECT.
```

---

# Why Aggregate Functions Don't Work in WHERE

❌

```sql
SELECT
department_id,
AVG(salary)
FROM hr.employees
WHERE AVG(salary) > 60000
GROUP BY department_id;
```

Aggregate values don't exist during the `WHERE` phase.

---

# Correct Version

```sql
SELECT
department_id,
AVG(salary)
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

---

# Business Example

## Executive Sales Report

```sql
SELECT
region,
SUM(total_amount) AS revenue
FROM sales.orders
WHERE order_status='Completed'
GROUP BY region
HAVING SUM(total_amount)>100000
ORDER BY revenue DESC
LIMIT 3;
```

Execution:

```text
FROM orders

↓

Filter completed orders

↓

Group by region

↓

Calculate revenue

↓

Remove low revenue regions

↓

Select output

↓

Sort

↓

Return top 3
```

---

# Common Errors

## Using Alias in WHERE

❌

```sql
WHERE total_salary > 500000
```

---

## Aggregate Function in WHERE

❌

```sql
WHERE COUNT(*) > 5
```

---

## Using HAVING Without Understanding GROUP BY

Always remember:

```text
WHERE → rows

HAVING → groups
```

---

# Best Practices

- Memorize the logical execution order.
- Filter rows early with `WHERE`.
- Filter groups with `HAVING`.
- Use aliases for readability.
- Use `ORDER BY` with aliases whenever possible.

---

# Interview Questions

### Does SQL execute from top to bottom?

No.

It follows its logical execution order.

---

### Why can't aliases usually be used in WHERE?

Because `WHERE` executes before `SELECT`.

---

### Why can't aggregate functions be used in WHERE?

They are calculated after grouping.

---

### Which clause executes first?

`FROM`

---

### Which clause executes last?

`LIMIT` (or `OFFSET`, if used).

---

# Cheat Sheet

| Logical Order | Clause |
|---------------|--------|
| 1 | FROM |
| 2 | WHERE |
| 3 | GROUP BY |
| 4 | Aggregate Functions |
| 5 | HAVING |
| 6 | SELECT |
| 7 | DISTINCT |
| 8 | ORDER BY |
| 9 | LIMIT / OFFSET |

---

# Practice Exercises

## 🟢 Beginner

1. Explain why aliases don't work in `WHERE`.
2. Explain why `ORDER BY` can use aliases.
3. Identify the first clause executed in a SQL query.

---

## 🟡 Intermediate

1. Rewrite a query that incorrectly uses an aggregate in `WHERE`.
2. Predict the execution order of a query with `GROUP BY` and `HAVING`.
3. Explain why `DISTINCT` is applied after `SELECT`.

---

## 🔴 Advanced

Given the following query, list the logical execution order and describe what happens at each stage:

```sql
SELECT
    department_id,
    COUNT(*) AS total_employees
FROM hr.employees
WHERE salary > 50000
GROUP BY department_id
HAVING COUNT(*) > 5
ORDER BY total_employees DESC
LIMIT 3;
```

---

# Production Tip

When debugging a complex query, mentally walk through the logical execution order rather than reading it from top to bottom. This approach makes it much easier to identify mistakes involving aliases, aggregates, and filtering.

---

# Summary

SQL is written in one order but executed in another. Understanding the logical query processing order is essential for writing correct queries, avoiding common errors, and mastering advanced SQL topics such as joins, subqueries, common table expressions (CTEs), and window functions.

---

# Related Topics

**Previous**

- `15_HAVING.md`

**Next**

- `17_JOINS/01_Introduction.md`

**Related**

- `03_WHERE.md`
- `14_GROUP_BY.md`
- `15_HAVING.md`
