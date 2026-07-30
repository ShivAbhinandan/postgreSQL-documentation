---
difficulty: All Levels
estimated_total_time: 50 minutes
last_updated: 2026-07-30
practice_time: 30 minutes
prerequisites:
- All JOIN Types
reading_time: 20 minutes
title: SQL JOIN Cheat Sheet
---

# SQL JOIN Cheat Sheet

## Overview

This cheat sheet summarizes all SQL JOIN concepts covered in this
section. It is designed for quick revision before interviews, coding
tests, or day-to-day work.

# JOIN Overview

  JOIN Type         Returns
  ----------------- -----------------------------------------------------
  INNER JOIN        Matching rows only
  LEFT JOIN         All rows from left table + matching rows from right
  RIGHT JOIN        All rows from right table + matching rows from left
  FULL OUTER JOIN   All rows from both tables
  CROSS JOIN        Cartesian Product
  SELF JOIN         A table joined with itself
  NATURAL JOIN      Automatically joins columns with the same name
  USING             Joins using common column names
  ON                Specifies any join condition

# Visual Guide

## INNER JOIN

``` text
Employees          Departments

   ● ● ●              ● ● ●

        ◉ ◉

Only Matching Records
```

## LEFT JOIN

``` text
Employees          Departments

● ● ● ● ●          ● ● ●

◉ ◉

All Employees + Matching Departments
```

## RIGHT JOIN

``` text
Employees          Departments

● ● ●              ● ● ● ● ●

      ◉ ◉

All Departments + Matching Employees
```

## FULL OUTER JOIN

``` text
Employees          Departments

● ● ● ●

◉ ◉

● ● ● ●

Everything
```

## CROSS JOIN

``` text
Rows = A × B
```

## SELF JOIN

``` sql
SELECT
    e.employee_name,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;
```

# USING vs ON

``` sql
-- USING
SELECT *
FROM employees
JOIN departments
USING (department_id);

-- ON
SELECT *
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;
```

# JOIN Algorithms

  Algorithm     Best For
  ------------- -----------------------------
  Nested Loop   Small datasets with indexes
  Hash Join     Large equality joins
  Merge Join    Sorted datasets

# Common Mistakes

-   Missing `ON` clause
-   Wrong JOIN type
-   Using `SELECT *`
-   Wrong join keys
-   Filtering after `LEFT JOIN`
-   Missing indexes
-   Ignoring `NULL`
-   Ambiguous columns

# Best Practices

-   Use meaningful aliases.
-   Join Primary Keys to Foreign Keys.
-   Select only required columns.
-   Format SQL consistently.
-   Use indexes on join columns.
-   Review execution plans with `EXPLAIN ANALYZE`.

# Quick Revision

  Need                Use
  ------------------- -----------------
  Matching rows       INNER JOIN
  All left rows       LEFT JOIN
  All right rows      RIGHT JOIN
  All rows            FULL OUTER JOIN
  Every combination   CROSS JOIN
  Same table          SELF JOIN

# Summary

JOINs are fundamental to SQL. Choose the correct JOIN type, understand
relationships, avoid common mistakes, and optimize performance for
production-quality queries.
