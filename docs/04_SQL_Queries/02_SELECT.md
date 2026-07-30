---
title: SELECT Statement
difficulty: Beginner
reading_time: 40 minutes
practice_time: 90 minutes
estimated_total_time: 130 minutes
prerequisites:
  - INSERT Statement
last_updated: 2026-07-30
---

# SELECT Statement

## Overview

The `SELECT` statement is used to retrieve data from one or more tables.

It is the most frequently used SQL command and forms the foundation of reporting, dashboards, analytics, and business intelligence.

Every time you view employee records, customer information, product details, or sales reports, a `SELECT` query is executed.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Retrieve all rows from a table.
- Retrieve specific columns.
- Rename columns using aliases.
- Perform simple calculations.
- Understand query execution basics.
- Follow SQL formatting best practices.

---

# Basic Syntax

```sql
SELECT column1, column2
FROM table_name;
```

---

# Select All Columns

```sql
SELECT *
FROM hr.employees;
```

Output:

| employee_id | first_name | last_name | salary |
|-------------|------------|-----------|---------|
|1|Rahul|Sharma|55000|
|2|Priya|Verma|72000|
|3|Amit|Kumar|42000|

`*` means "all columns."

---

# Select Specific Columns

```sql
SELECT
    first_name,
    last_name,
    salary
FROM hr.employees;
```

Output:

| first_name | last_name | salary |
|------------|-----------|---------|
|Rahul|Sharma|55000|
|Priya|Verma|72000|

Selecting only required columns improves readability and performance.

---

# Change Column Names (Alias)

```sql
SELECT
    first_name AS "First Name",
    last_name AS "Last Name",
    salary AS "Monthly Salary"
FROM hr.employees;
```

Output:

| First Name | Last Name | Monthly Salary |
|------------|-----------|----------------|
|Rahul|Sharma|55000|

The `AS` keyword assigns a temporary name to a column in the query result.

---

# Aliases Without AS

The `AS` keyword is optional.

```sql
SELECT
    first_name "First Name",
    salary "Salary"
FROM hr.employees;
```

---

# Selecting Constant Values

```sql
SELECT
    'Company Database' AS database_name,
    CURRENT_DATE AS today;
```

Output:

| database_name | today |
|---------------|------------|
|Company Database|2026-07-30|

---

# Simple Calculations

Increase every employee's salary by 10%.

```sql
SELECT
    first_name,
    salary,
    salary * 1.10 AS revised_salary
FROM hr.employees;
```

Output:

| Employee | Salary | Revised Salary |
|----------|---------|----------------|
|Rahul|55000|60500|
|Priya|72000|79200|

The database performs the calculation without modifying stored data.

---

# String Concatenation

Combine first and last names.

```sql
SELECT
    first_name || ' ' || last_name AS full_name
FROM hr.employees;
```

Output:

| full_name |
|------------|
|Rahul Sharma|
|Priya Verma|

The `||` operator concatenates strings in PostgreSQL.

---

# Selecting Data From Another Table

```sql
SELECT
    product_name,
    unit_price
FROM inventory.products;
```

---

# Selecting Customer Information

```sql
SELECT
    first_name,
    city,
    country
FROM sales.customers;
```

---

# Query Execution Order

Although SQL is written as:

```sql
SELECT
FROM
```

PostgreSQL logically processes it as:

```text
FROM

↓

SELECT
```

This concept becomes important when learning filtering, grouping, and joins.

---

# Best Practices

- Select only the columns you need.
- Use descriptive aliases.
- Format queries consistently.
- Avoid `SELECT *` in production code unless all columns are required.

---

# Common Mistakes

❌ Missing commas

```sql
SELECT
first_name
last_name
FROM hr.employees;
```

Correct:

```sql
SELECT
    first_name,
    last_name
FROM hr.employees;
```

---

❌ Using single quotes for aliases

Wrong:

```sql
SELECT salary AS 'Salary';
```

Correct:

```sql
SELECT salary AS "Salary";
```

Or:

```sql
SELECT salary AS Salary;
```

---

# Interview Questions

### What does `SELECT *` do?

It retrieves all columns from a table.

---

### Why avoid `SELECT *`?

It returns unnecessary data, reduces readability, and may impact performance.

---

### What is an alias?

A temporary name assigned to a column or expression in the query result.

---

### Does an alias change the table structure?

No.

Aliases only affect the current query result.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `SELECT *` | Retrieve all columns |
| `SELECT column1, column2` | Retrieve specific columns |
| `AS` | Create an alias |
| `||` | Concatenate strings |
| `CURRENT_DATE` | Current database date |

---

# Business Scenario

The HR manager needs a report showing employee names and salaries.

Write a query that returns:

- First Name
- Last Name
- Monthly Salary

```sql
SELECT
    first_name,
    last_name,
    salary
FROM hr.employees;
```

---

# Practice Exercises

## 🟢 Beginner

1. Display all employees.
2. Display all departments.
3. Display all customers.

---

## 🟡 Intermediate

1. Display only employee names.
2. Display product names and prices.
3. Display customer names and cities.

---

## 🔴 Advanced

Write a query that displays:

- Employee Full Name
- Salary
- Salary After a 15% Increment

using appropriate aliases.

---

# Summary

The `SELECT` statement retrieves data from tables and is the foundation of SQL reporting and analysis. Mastering `SELECT` prepares you for filtering, sorting, grouping, joins, and advanced analytical queries.

---

# Related Topics

**Previous**

- `01_INSERT.md`

**Next**

- `03_WHERE.md`

**Related**

- `04_ORDER_BY.md`
- `05_LIMIT_OFFSET.md`
