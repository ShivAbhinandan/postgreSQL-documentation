---
title: USING vs ON
difficulty: Intermediate
reading_time: 60 minutes
practice_time: 90 minutes
estimated_total_time: 150 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN
  - NATURAL JOIN
last_updated: 2026-07-30
---

# USING vs ON

## Overview

When joining tables in PostgreSQL, you can specify the join condition using either:

- `ON`
- `USING`

Both produce similar results in many situations, but they are designed for different use cases.

Understanding the difference helps you write SQL that is easier to read, maintain, and debug.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand the difference between `USING` and `ON`.
- Know when each should be used.
- Write cleaner JOIN queries.
- Explain PostgreSQL-specific behavior.
- Avoid common mistakes.

---

# Syntax

## USING

```sql
SELECT columns
FROM employees
JOIN departments
USING (department_id);
```

---

## ON

```sql
SELECT columns
FROM employees
JOIN departments
ON employees.department_id = departments.department_id;
```

---

# Sample Tables

## Employees

| employee_id | employee_name | department_id |
|-------------|---------------|---------------|
|1|Rahul|1|
|2|Priya|2|
|3|Amit|1|

---

## Departments

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|
|3|Finance|

---

# USING Clause

The `USING` clause is used when:

- Both tables contain a column with the same name.
- The join is based on that column.

Example

```sql
SELECT
    employee_name,
    department_name
FROM hr.employees
JOIN hr.departments
USING (department_id);
```

Output

| Employee | Department |
|-----------|------------|
|Rahul|IT|
|Priya|HR|
|Amit|IT|

---

# ON Clause

The `ON` clause specifies the join condition explicitly.

```sql
SELECT
    e.employee_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

Produces the same result.

---

# Key Difference

## USING removes duplicate join columns.

```sql
SELECT *
FROM hr.employees
JOIN hr.departments
USING (department_id);
```

Output columns

```text
employee_id

employee_name

department_id

department_name
```

Only one `department_id` appears.

---

## ON keeps both columns.

```sql
SELECT *
FROM hr.employees e
JOIN hr.departments d
ON e.department_id = d.department_id;
```

Output columns

```text
employee_id

employee_name

department_id

department_id

department_name
```

Both join columns remain in the result.

---

# Visual Comparison

## USING

```text
Employees

department_id

↓

Merged

↓

Departments

department_id

↓

One department_id
```

---

## ON

```text
Employees.department_id

↓

Compared

↓

Departments.department_id

↓

Both columns remain
```

---

# Multiple Columns

USING supports multiple columns.

```sql
SELECT *
FROM table_a
JOIN table_b
USING (
    department_id,
    location_id
);
```

Equivalent to:

```sql
SELECT *
FROM table_a a
JOIN table_b b
ON a.department_id = b.department_id
AND a.location_id = b.location_id;
```

---

# Different Column Names

USING cannot be used.

Example

Employees

```text
dept_id
```

Departments

```text
department_id
```

Correct

```sql
SELECT *
FROM employees e
JOIN departments d
ON e.dept_id = d.department_id;
```

`USING` would not work because the column names differ.

---

# LEFT JOIN with USING

```sql
SELECT
    employee_name,
    department_name
FROM hr.employees
LEFT JOIN hr.departments
USING (department_id);
```

Works exactly like a LEFT JOIN using `ON`.

---

# Business Scenarios

## HR Reporting

```sql
SELECT
    employee_name,
    department_name
FROM hr.employees
JOIN hr.departments
USING (department_id);
```

---

## Sales Dashboard

```sql
SELECT
    product_name,
    category_name
FROM inventory.products
JOIN inventory.categories
USING (category_id);
```

---

## Customer Orders

```sql
SELECT
    customer_name,
    order_date
FROM sales.customers
JOIN sales.orders
USING (customer_id);
```

---

# USING vs ON Comparison

| Feature | USING | ON |
|----------|:-----:|:--:|
|Same column names required|✅|❌|
|Supports different column names|❌|✅|
|Duplicate join column removed|✅|❌|
|Supports complex conditions|❌|✅|
|Most flexible|❌|✅|
|Cleaner syntax|✅|⚠️|

---

# When to Use USING

Use `USING` when:

- Column names are identical.
- Join condition is simple.
- Cleaner output is preferred.
- Duplicate join columns are unnecessary.

Example

```sql
JOIN departments
USING (department_id);
```

---

# When to Use ON

Use `ON` when:

- Column names differ.
- Multiple comparison operators are required.
- Complex join conditions are needed.
- Additional predicates are part of the join.

Example

```sql
ON e.department_id = d.department_id
AND e.salary > 50000
```

---

# Common Mistakes

## Using USING with Different Column Names

❌

```sql
USING (dept_id)
```

when the other table contains:

```text
department_id
```

---

## Assuming USING Works Like NATURAL JOIN

`USING` only joins on the columns you specify.

`NATURAL JOIN` joins on every column with the same name.

---

## Forgetting Output Columns

`USING` removes duplicate join columns.

`ON` keeps both.

Choose the one that matches your reporting needs.

---

# Performance

PostgreSQL generates equivalent execution plans for equivalent `USING` and `ON` joins.

The difference is primarily in:

- Readability
- Maintainability
- Output column behavior

Performance differences are generally negligible.

---

# Best Practices

- Prefer `USING` for simple joins on identically named keys.
- Prefer `ON` for complex joins.
- Always use table aliases with `ON`.
- Explicitly list required columns instead of relying on `SELECT *`.

---

> **✅ Production Recommendation**
>
> Use `USING` for straightforward joins where both tables share the same key name.
>
> Use `ON` for all complex joins or whenever column names differ.
>
> Avoid `NATURAL JOIN` in production code because schema changes can alter query behavior unexpectedly.

---

# Interview Questions

### What is the difference between USING and ON?

`USING` joins by a shared column name and removes duplicate join columns.

`ON` allows any join condition and keeps both join columns.

---

### Can USING join columns with different names?

No.

Use `ON`.

---

### Which is more flexible?

`ON`.

---

### Which produces cleaner output?

`USING`.

---

### Which is preferred in production?

Both are appropriate.

Use `USING` for simple, identical keys.

Use `ON` for complex logic.

---

# Cheat Sheet

| Requirement | Recommended |
|-------------|-------------|
|Same column names|USING|
|Different column names|ON|
|Complex conditions|ON|
|Cleaner output|USING|
|Maximum flexibility|ON|

---

# Production Example

```sql
SELECT
    e.employee_name,
    d.department_name,
    d.location
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id
WHERE d.location = 'Delhi';
```

Simple joins can use:

```sql
SELECT
    employee_name,
    department_name
FROM hr.employees
JOIN hr.departments
USING (department_id);
```

---

# Practice Exercises

## 🟢 Beginner

1. Join employees and departments using `USING`.
2. Rewrite the query using `ON`.
3. Compare the output columns.

---

## 🟡 Intermediate

1. Join products and categories using `USING`.
2. Rewrite with `ON`.
3. Join tables with different key names.

---

## 🔴 Advanced

1. Join using two shared columns with `USING`.
2. Rewrite using `ON`.
3. Add an extra condition that requires `ON`.
4. Explain why `USING` cannot express that query.

---

# Complexity & Performance

| Operation | Complexity |
|-----------|------------|
|USING|Equivalent to ON|
|ON|Equivalent to USING for the same join logic|

Performance Checklist

- Prefer readability over micro-optimizations.
- Use indexes on join keys.
- Select only required columns.
- Use `EXPLAIN ANALYZE` to verify execution plans.

---

# Summary

`USING` and `ON` both define join conditions in PostgreSQL. `USING` offers concise syntax and removes duplicate join columns, making it ideal for simple joins on identically named keys. `ON` provides maximum flexibility and is the preferred choice for complex join conditions or when column names differ.

---

# Related Topics

**Previous**

- `09_NATURAL_JOIN.md`

**Next**

- `11_Multiple_Joins.md`

**Related**

- `02_INNER_JOIN.md`
- `03_LEFT_JOIN.md`
- `08_SELF_JOIN.md`
- `09_NATURAL_JOIN.md`
