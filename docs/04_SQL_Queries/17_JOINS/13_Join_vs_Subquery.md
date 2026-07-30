---
title: JOIN vs Subquery
difficulty: Intermediate
reading_time: 90 minutes
practice_time: 180 minutes
estimated_total_time: 270 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
  - Multiple Table Joins
  - Subqueries (Basic)
last_updated: 2026-07-30
---

# JOIN vs Subquery

## Overview

In SQL, data from multiple tables can often be retrieved using either:

- JOIN
- Subquery

Both approaches can produce the same result, but they differ in readability, flexibility, maintainability, and sometimes performance.

Choosing the right approach is an important skill for SQL developers.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand the difference between JOINs and subqueries.
- Decide when each approach is appropriate.
- Compare performance considerations.
- Rewrite queries between JOIN and subquery forms.
- Answer interview questions confidently.

---

# What is a JOIN?

A JOIN combines rows from two or more tables based on a relationship.

Example:

```sql
SELECT
    e.employee_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

Result

| Employee | Department |
|-----------|------------|
|Rahul|IT|
|Priya|HR|

---

# What is a Subquery?

A subquery is a query inside another SQL statement.

Example

```sql
SELECT
    employee_name
FROM hr.employees
WHERE department_id = (
    SELECT department_id
    FROM hr.departments
    WHERE department_name = 'IT'
);
```

Result

| Employee |
|-----------|
|Rahul|
|Amit|

---

# Visual Comparison

JOIN

```text
Employees

↓

Departments

↓

Result
```

Subquery

```text
Departments

↓

department_id

↓

Employees

↓

Result
```

---

# Same Problem Using JOIN

Find employees in the IT department.

Using JOIN

```sql
SELECT
    e.employee_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'IT';
```

---

Using Subquery

```sql
SELECT
    employee_name
FROM hr.employees
WHERE department_id = (
    SELECT department_id
    FROM hr.departments
    WHERE department_name = 'IT'
);
```

Both queries return the same result.

---

# When to Use JOIN

JOINs are ideal when:

- Data from multiple tables must be displayed.
- Relationships between tables are important.
- Building reports and dashboards.
- Working with normalized databases.

Example

```sql
SELECT
    c.customer_name,
    o.order_date
FROM sales.customers AS c
JOIN sales.orders AS o
ON c.customer_id = o.customer_id;
```

---

# When to Use a Subquery

Subqueries are useful when:

- Filtering based on another query.
- Performing calculations.
- Using aggregate results.
- Checking existence with `EXISTS`.

Example

```sql
SELECT
    employee_name
FROM hr.employees
WHERE salary > (
    SELECT AVG(salary)
    FROM hr.employees
);
```

---

# Comparison

| Feature | JOIN | Subquery |
|----------|------|----------|
|Combine tables|✅|Indirectly|
|Display columns from multiple tables|✅|❌|
|Nested logic|⚠️|✅|
|Readability (reports)|✅|⚠️|
|Filtering|⚠️|✅|
|Aggregates|⚠️|✅|
|Complex reporting|✅|⚠️|

---

# Performance Considerations

Modern PostgreSQL can optimize many subqueries into joins internally.

Performance depends on:

- Query structure
- Indexes
- Statistics
- Data size

Always verify with:

```sql
EXPLAIN ANALYZE
```

Do not assume one approach is always faster.

---

# Business Scenarios

## Employee Report

JOIN

```sql
SELECT
    e.employee_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

---

## Employees Above Average Salary

Subquery

```sql
SELECT
    employee_name,
    salary
FROM hr.employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM hr.employees
);
```

---

## Customers Who Placed Orders

Subquery with EXISTS

```sql
SELECT
    customer_name
FROM sales.customers AS c
WHERE EXISTS
(
    SELECT 1
    FROM sales.orders AS o
    WHERE o.customer_id = c.customer_id
);
```

---

# JOIN Replacing a Subquery

Subquery

```sql
SELECT
    employee_name
FROM hr.employees
WHERE department_id =
(
    SELECT department_id
    FROM hr.departments
    WHERE department_name='HR'
);
```

JOIN

```sql
SELECT
    e.employee_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id=d.department_id
WHERE d.department_name='HR';
```

---

# Common Mistakes

## Using a JOIN for a Simple Aggregate

Instead of:

```sql
JOIN salaries
```

Use:

```sql
WHERE salary >
(
SELECT AVG(salary)
FROM hr.employees
)
```

---

## Returning Unnecessary Columns

If only filtering is required, a subquery or `EXISTS` may be simpler.

---

## Assuming JOIN Is Always Faster

This is incorrect.

The optimizer may transform subqueries into joins.

Measure performance with:

```sql
EXPLAIN ANALYZE
```

---

# Best Practices

- Use JOINs for reports and combining table data.
- Use subqueries for filtering and aggregate comparisons.
- Prefer `EXISTS` over `IN` for large correlated existence checks when appropriate.
- Avoid deeply nested subqueries when a JOIN improves readability.

---

> **✅ Production Recommendation**
>
> Choose the approach that best expresses the business requirement. Prioritize readability and maintainability, then verify performance with `EXPLAIN ANALYZE` instead of relying on assumptions.

---

# Interview Questions

### Which is faster: JOIN or Subquery?

Neither is inherently faster.

PostgreSQL's optimizer may generate similar execution plans.

---

### When should you use a JOIN?

When retrieving related data from multiple tables.

---

### When should you use a subquery?

When filtering, comparing with aggregate values, or checking existence.

---

### Can a JOIN replace a subquery?

Often, yes.

However, not every subquery should be rewritten as a JOIN.

---

### Which is easier for reporting?

JOIN.

---

# Cheat Sheet

| Requirement | Preferred Approach |
|-------------|--------------------|
|Display data from multiple tables|JOIN|
|Compare with aggregate|Subquery|
|Check if related rows exist|EXISTS|
|Business reports|JOIN|
|Average/Maximum comparisons|Subquery|

---

# Production Examples

## Reporting

```sql
SELECT
    c.customer_name,
    o.order_date,
    p.product_name
FROM sales.customers AS c
JOIN sales.orders AS o
ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
ON o.order_id = oi.order_id
JOIN inventory.products AS p
ON oi.product_id = p.product_id;
```

---

## Aggregate Comparison

```sql
SELECT
    employee_name,
    salary
FROM hr.employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM hr.employees
);
```

---

# Practice Exercises

## 🟢 Beginner

1. Find employees in the IT department using a JOIN.
2. Rewrite the query using a subquery.
3. Compare both results.

---

## 🟡 Intermediate

1. Find employees earning above average salary.
2. Rewrite a JOIN as a subquery.
3. Rewrite a subquery as a JOIN.

---

## 🔴 Advanced

1. Compare execution plans using `EXPLAIN ANALYZE`.
2. Solve the same business problem using both approaches.
3. Explain which version is more readable and why.

---

# Complexity & Performance

| Approach | Best For |
|-----------|----------|
|JOIN|Reporting and combining related data|
|Subquery|Filtering and aggregate comparisons|
|EXISTS|Existence checks|
|IN|Small lookup lists|

Performance Checklist

- Index join columns.
- Keep statistics current.
- Use `EXPLAIN ANALYZE`.
- Prioritize readability before micro-optimizations.

---

# Summary

JOINs and subqueries are complementary tools, not competitors. JOINs excel at combining related tables for reporting, while subqueries are well suited for filtering, aggregate comparisons, and existence checks. Choose the approach that communicates your intent most clearly and validate performance using execution plans.

---

# Related Topics

**Previous**

- `12_Join_Order.md`

**Next**

- `14_Real_World_Examples.md`

**Related**

- `EXISTS.md` *(future chapter)*
- `Subqueries.md` *(future chapter)*
- `18_Query_Execution/02_EXPLAIN.md`
