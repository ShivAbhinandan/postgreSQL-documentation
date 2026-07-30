---
title: SQL Aliases (AS)
difficulty: Beginner
reading_time: 35 minutes
practice_time: 60 minutes
estimated_total_time: 95 minutes
prerequisites:
  - SELECT Statement
  - WHERE Clause
  - ORDER BY Clause
last_updated: 2026-07-30
---

# SQL Aliases (AS)

## Overview

An **alias** is a temporary name assigned to a column, table, or expression during the execution of a query.

Aliases improve:

- Readability
- Report presentation
- Query maintainability
- Complex joins
- Subqueries

Aliases exist **only for the duration of the query**. They do not rename the actual table or column in the database.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Create column aliases.
- Create table aliases.
- Use aliases with expressions.
- Use aliases in joins.
- Use aliases in subqueries.
- Follow alias naming best practices.

---

# Why Use Aliases?

Suppose your table contains:

```text
employee_first_name
```

Instead of displaying:

```text
employee_first_name
```

you can display:

```text
Employee Name
```

using an alias.

---

# Column Alias

## Syntax

```sql
SELECT column_name AS alias_name
FROM table_name;
```

---

# Example

```sql
SELECT
    first_name AS employee_name,
    salary AS monthly_salary
FROM hr.employees;
```

Output

| employee_name | monthly_salary |
|---------------|---------------:|
|Rahul|55000|
|Priya|72000|

---

# AS is Optional

The following queries are equivalent.

```sql
SELECT first_name AS employee_name
FROM hr.employees;
```

```sql
SELECT first_name employee_name
FROM hr.employees;
```

Using `AS` is recommended because it improves readability.

---

# Alias with Spaces

Use double quotes.

```sql
SELECT
    first_name AS "Employee Name",
    salary AS "Monthly Salary"
FROM hr.employees;
```

Output

| Employee Name | Monthly Salary |
|---------------|---------------:|
|Rahul|55000|

---

# Alias for Expressions

```sql
SELECT
    first_name,
    salary * 12 AS annual_salary
FROM hr.employees;
```

---

# Multiple Aliases

```sql
SELECT
    first_name AS employee,
    salary AS monthly_salary,
    salary * 12 AS annual_salary
FROM hr.employees;
```

---

# Table Aliases

Large queries become easier to read using table aliases.

Without alias:

```sql
SELECT
    employees.first_name,
    employees.salary
FROM hr.employees;
```

With alias:

```sql
SELECT
    e.first_name,
    e.salary
FROM hr.employees AS e;
```

---

# Aliases in Joins

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
JOIN hr.departments AS d
ON e.department_id = d.department_id;
```

This is much shorter than repeatedly writing full table names.

---

# Aliases in Subqueries

```sql
SELECT *
FROM
(
    SELECT
        first_name,
        salary
    FROM hr.employees
) AS employee_data;
```

Every derived table (subquery in the FROM clause) must have an alias.

---

# Alias with ORDER BY

```sql
SELECT
    salary * 12 AS annual_salary
FROM hr.employees
ORDER BY annual_salary DESC;
```

---

# Alias with Aggregate Functions

```sql
SELECT
    COUNT(*) AS total_employees
FROM hr.employees;
```

---

# Business Scenarios

## HR Report

```sql
SELECT
    first_name AS employee_name,
    hire_date AS joining_date
FROM hr.employees;
```

---

## Sales Dashboard

```sql
SELECT
    order_date AS sale_date,
    total_amount AS revenue
FROM sales.orders;
```

---

## Inventory Report

```sql
SELECT
    product_name AS product,
    unit_price AS price
FROM inventory.products;
```

---

# Naming Conventions

Good aliases:

```text
employee_name
annual_salary
total_sales
customer_count
```

Avoid:

```text
x
abc
temp1
column1
```

Choose aliases that clearly describe the data.

---

# Best Practices

- Use meaningful alias names.
- Use `AS` for clarity.
- Keep aliases consistent throughout a project.
- Use table aliases in joins.
- Use snake_case for SQL identifiers.

---

# Common Mistakes

## Forgetting Quotes Around Aliases with Spaces

❌ Wrong

```sql
SELECT
    salary AS Monthly Salary
FROM hr.employees;
```

✅ Correct

```sql
SELECT
    salary AS "Monthly Salary"
FROM hr.employees;
```

---

## Forgetting Subquery Alias

❌ Wrong

```sql
SELECT *
FROM
(
    SELECT *
    FROM hr.employees
);
```

✅ Correct

```sql
SELECT *
FROM
(
    SELECT *
    FROM hr.employees
) AS employee_data;
```

---

## Using Ambiguous Column Names

When joining tables that contain the same column name:

❌

```sql
SELECT department_id
```

✅

```sql
SELECT e.department_id
```

---

# Interview Questions

### What is an alias?

A temporary name assigned to a column, table, or expression within a query.

---

### Does an alias change the database structure?

No.

It only affects the query result.

---

### Is AS mandatory?

No.

It is optional, but recommended for readability.

---

### Why are table aliases important?

They make joins easier to read and reduce repetitive typing.

---

### Can aliases be used in ORDER BY?

Yes.

```sql
SELECT salary * 12 AS annual_salary
FROM hr.employees
ORDER BY annual_salary DESC;
```

---

# Cheat Sheet

| Syntax | Purpose |
|---------|---------|
| `AS alias` | Column alias |
| `table AS t` | Table alias |
| `"Employee Name"` | Alias containing spaces |
| `ORDER BY alias` | Sort using alias |

---

# Practice Exercises

## 🟢 Beginner

1. Rename `first_name` as `employee_name`.
2. Rename `salary` as `monthly_salary`.
3. Display annual salary using an alias.

---

## 🟡 Intermediate

1. Use table aliases for employees and departments.
2. Display product price as `selling_price`.
3. Display total employees using `COUNT()` and an alias.

---

## 🔴 Advanced

Write queries to:

1. Display employee full names using aliases.
2. Use aliases in a subquery.
3. Write a join using table aliases only.

---

# When NOT to Use Aliases

Avoid aliases when they reduce clarity.

Poor example:

```sql
SELECT
    first_name AS a,
    salary AS b
FROM hr.employees;
```

Better:

```sql
SELECT
    first_name AS employee_name,
    salary AS monthly_salary
FROM hr.employees;
```

---

# Summary

Aliases provide temporary, meaningful names for columns, tables, and expressions. They make SQL queries easier to read, simplify joins and subqueries, and improve the presentation of query results without changing the underlying database structure.

---

# Related Topics

**Previous**

- `11_IS_NULL.md`

**Next**

- `13_AGGREGATE_FUNCTIONS.md`

**Related**

- `04_ORDER_BY.md`
- `16_JOINS/`
- `07_Subqueries/`
