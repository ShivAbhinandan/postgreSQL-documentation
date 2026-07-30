---
chapter: 1
difficulty: Intermediate
estimated_time: 60 Minutes
last_updated: 2026-07-30
module: 18 - Query Execution
prerequisites:
- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- JOINS
title: Query Processing Order
version: 1
---

# Query Processing Order

> Understanding how PostgreSQL processes a SQL query is one of the most
> important skills for writing efficient SQL.

## Table of Contents

1.  Introduction
2.  Learning Objectives
3.  Why Query Processing Matters
4.  SQL Writing Order
5.  Logical Query Processing Order
6.  Example Dataset
7.  Step-by-Step Execution
8.  Common Misconceptions
9.  Performance Notes
10. Best Practices
11. Interview Questions
12. Practice Exercises
13. Summary

# Introduction

When writing SQL, developers write queries in one order, but PostgreSQL
logically processes them in a different order.

Example:

``` sql
SELECT employee_name, salary
FROM employees
WHERE salary > 50000
ORDER BY salary DESC;
```

# Learning Objectives

-   Explain logical query processing.
-   Differentiate writing order from execution order.
-   Predict query behavior.
-   Understand WHERE vs HAVING.
-   Build a foundation for optimization.

# Why Query Processing Matters

PostgreSQL determines:

-   Which table to read
-   Which rows to filter
-   Whether to group rows
-   Whether to sort results
-   Whether to apply limits

before returning the final result.

# SQL Writing Order

``` text
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
WINDOW
ORDER BY
LIMIT
```

# Logical Query Processing Order

  Step   Clause           Purpose
  ------ ---------------- ---------------------------
  1      FROM             Choose source tables
  2      JOIN             Combine related tables
  3      WHERE            Filter rows
  4      GROUP BY         Create groups
  5      HAVING           Filter groups
  6      WINDOW           Evaluate window functions
  7      SELECT           Return selected columns
  8      DISTINCT         Remove duplicates
  9      ORDER BY         Sort rows
  10     LIMIT / OFFSET   Return final rows

# Visual Flow

``` text
FROM
 ↓
JOIN
 ↓
WHERE
 ↓
GROUP BY
 ↓
HAVING
 ↓
WINDOW
 ↓
SELECT
 ↓
DISTINCT
 ↓
ORDER BY
 ↓
LIMIT
```

# Example Dataset

  employee_id   employee_name   department     salary
  ------------- --------------- ------------ --------
  1             Alice           HR              45000
  2             Bob             IT              70000
  3             Charlie         Sales           65000
  4             David           IT              90000
  5             Eva             HR              50000

# Example Query

``` sql
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
WHERE salary > 45000
GROUP BY department
HAVING AVG(salary) > 60000
ORDER BY avg_salary DESC;
```

# Step-by-Step Execution

1.  **FROM** → Read the `employees` table.
2.  **WHERE** → Remove rows with `salary <= 45000`.
3.  **GROUP BY** → Group by department.
4.  **HAVING** → Keep only groups with average salary \> 60000.
5.  **SELECT** → Return requested columns.
6.  **ORDER BY** → Sort results.

# Common Misconceptions

-   ❌ SQL executes top to bottom.

-   ✅ PostgreSQL follows logical processing order.

-   ❌ WHERE can use aggregates.

-   ✅ HAVING filters aggregate results.

-   ❌ SELECT aliases are available in WHERE.

-   ✅ Aliases are created after WHERE is processed.

# Performance Notes

-   Filter rows early with WHERE.
-   Use HAVING only for aggregate filters.
-   Learn to read `EXPLAIN` plans.
-   Avoid unnecessary processing.

# Best Practices

-   Think in execution order.
-   Filter early.
-   Use meaningful aliases.
-   Prefer WHERE over HAVING when possible.

# Interview Questions

1.  Why is FROM processed before SELECT?
2.  Why can't WHERE use AVG()?
3.  Difference between WHERE and HAVING?
4.  Why can't WHERE reference a SELECT alias?
5.  Which clause executes first?

# Practice Exercises

## Beginner

-   List the logical processing order.
-   Explain why SELECT is not executed first.

## Intermediate

-   Fix a query that uses AVG() in WHERE.
-   Rewrite a query using HAVING.

## Advanced

-   Compare WHERE vs HAVING for performance.
-   Explain logical processing for a grouped query.

# Summary

SQL is written in one order but logically processed in another.
Understanding the execution sequence helps you write correct, efficient,
and maintainable SQL while preparing you for advanced topics such as
EXPLAIN, indexing, and query optimization.
