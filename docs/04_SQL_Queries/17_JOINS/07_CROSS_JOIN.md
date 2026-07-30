---
title: CROSS JOIN
difficulty: Intermediate
reading_time: 60 minutes
practice_time: 90 minutes
estimated_total_time: 150 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN
  - FULL OUTER JOIN
last_updated: 2026-07-30
---

# CROSS JOIN

## Overview

A `CROSS JOIN` returns **every possible combination** of rows from two tables.

Unlike `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN`, a `CROSS JOIN` **does not use an ON condition**.

If:

- Table A has **3 rows**
- Table B has **4 rows**

The result contains:

```text
3 × 4 = 12 rows
```

This is called the **Cartesian Product**.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand Cartesian Products.
- Use CROSS JOIN correctly.
- Generate combinations.
- Create calendars.
- Generate reports.
- Avoid performance problems.

---

# Syntax

```sql
SELECT column_list
FROM table1
CROSS JOIN table2;
```

No `ON` clause is used.

---

# Sample Tables

## Colors

| color |
|--------|
|Red|
|Blue|
|Green|

---

## Sizes

| size |
|------|
|S|
|M|
|L|

---

# Visual Representation

```text
Colors

Red

Blue

Green

×

Sizes

S

M

L

↓

Result

Red     S

Red     M

Red     L

Blue    S

Blue    M

Blue    L

Green   S

Green   M

Green   L
```

Every color is paired with every size.

---

# First CROSS JOIN

```sql
SELECT
    c.color,
    s.size
FROM colors AS c
CROSS JOIN sizes AS s;
```

Output

| Color | Size |
|--------|------|
|Red|S|
|Red|M|
|Red|L|
|Blue|S|
|Blue|M|
|Blue|L|
|Green|S|
|Green|M|
|Green|L|

---

# Step-by-Step Execution

```text
Read Colors

↓

Take Red

↓

Pair with every Size

↓

Take Blue

↓

Pair with every Size

↓

Take Green

↓

Pair with every Size
```

---

# Row Count Formula

```text
Rows Returned

=

Rows in Table A

×

Rows in Table B
```

Examples

| Table A | Table B | Result |
|----------|----------|--------|
|5|10|50|
|100|50|5,000|
|1,000|1,000|1,000,000|
|50,000|10,000|500,000,000|

As tables grow, the result size increases rapidly.

---

# Business Scenarios

## Product Variants

Every shirt color with every size.

```sql
SELECT
    c.color,
    s.size
FROM inventory.colors AS c
CROSS JOIN inventory.sizes AS s;
```

---

## Calendar Generation

Combine dates and shifts.

```sql
SELECT
    d.work_date,
    s.shift_name
FROM scheduling.calendar_dates AS d
CROSS JOIN scheduling.shifts AS s;
```

This can generate a complete work schedule template.

---

## Sales Targets

Generate every salesperson for every month.

```sql
SELECT
    e.employee_name,
    m.month_name
FROM sales.employees AS e
CROSS JOIN reporting.months AS m;
```

Useful for target-setting dashboards.

---

## Test Data Generation

Create every possible combination of two datasets.

```sql
SELECT
    a.test_case,
    b.browser
FROM qa.test_cases AS a
CROSS JOIN qa.browsers AS b;
```

---

# CROSS JOIN vs INNER JOIN

INNER JOIN

```text
Only Matching Rows
```

---

CROSS JOIN

```text
Every Possible Combination
```

---

# CROSS JOIN with WHERE

A `WHERE` clause can filter the generated combinations.

```sql
SELECT
    c.color,
    s.size
FROM colors AS c
CROSS JOIN sizes AS s
WHERE s.size <> 'L';
```

Output

| Color | Size |
|--------|------|
|Red|S|
|Red|M|
|Blue|S|
|Blue|M|
|Green|S|
|Green|M|

---

# CROSS JOIN with VALUES

Generate combinations without creating tables.

```sql
SELECT
    c.color,
    s.size
FROM (
    VALUES ('Red'),
           ('Blue')
) AS c(color)
CROSS JOIN (
    VALUES ('S'),
           ('M')
) AS s(size);
```

Output

| Color | Size |
|--------|------|
|Red|S|
|Red|M|
|Blue|S|
|Blue|M|

---

# Common Mistakes

## Forgetting Result Size

Small tables are safe.

Large tables may generate millions or billions of rows.

Always estimate the result size before running the query.

---

## Using CROSS JOIN Instead of INNER JOIN

If tables should be matched by a relationship, use:

```sql
INNER JOIN
```

instead of

```sql
CROSS JOIN
```

---

## Missing Join Condition

Writing:

```sql
SELECT *
FROM employees,
departments;
```

creates a Cartesian product (equivalent to a CROSS JOIN in PostgreSQL). If your intention is to join related rows, use explicit `JOIN ... ON` syntax instead.

---

# Performance Tips

- Be aware of row multiplication.
- Filter data before the CROSS JOIN whenever possible.
- Select only required columns.
- Use CROSS JOIN intentionally, not by accident.

---

# Best Practices

- Estimate the expected row count.
- Use aliases for readability.
- Document why a CROSS JOIN is needed in complex queries.
- Avoid CROSS JOIN on large production tables unless necessary.

---

# Interview Questions

### What is a Cartesian Product?

Every possible combination of rows from two tables.

---

### Does CROSS JOIN use an ON clause?

No.

---

### How many rows are returned?

```text
Rows in Table A × Rows in Table B
```

---

### When is CROSS JOIN useful?

- Product combinations
- Calendar generation
- Scheduling
- Test data
- Matrix reports

---

# Cheat Sheet

| Feature | CROSS JOIN |
|---------|------------|
|Uses ON|❌|
|Requires matching column|❌|
|Returns every combination|✅|
|May generate very large result sets|✅|

---

# Production Example

## Monthly Sales Targets

```sql
SELECT
    e.employee_name,
    m.month_name,
    0 AS target_amount
FROM sales.employees AS e
CROSS JOIN reporting.months AS m
ORDER BY
    e.employee_name,
    m.month_name;
```

This creates a template where every employee has a row for every month.

---

# Practice Exercises

## 🟢 Beginner

1. Cross join colors and sizes.
2. Calculate the expected number of rows.
3. Create combinations of products and regions.

---

## 🟡 Intermediate

1. Generate employee-month combinations.
2. Generate every classroom-seat combination.
3. Create a calendar with days and shifts.

---

## 🔴 Advanced

1. Generate every product-store combination.
2. Build a scheduling matrix for employees and shifts.
3. Estimate the result size before executing each query.

---

# Summary

`CROSS JOIN` creates a Cartesian Product by returning every possible combination of rows from two tables. It is extremely useful for generating combinations, scheduling, planning, reporting, and testing, but it must be used carefully because result sets can grow exponentially.

---

# Related Topics

**Previous**

- `06_JOIN_COMPARISON.md`

**Next**

- `08_SELF_JOIN.md`

**Related**

- `02_INNER_JOIN.md`
- `11_Multiple_Joins.md`
