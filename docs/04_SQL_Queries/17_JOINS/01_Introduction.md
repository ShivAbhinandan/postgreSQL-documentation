---
title: SQL Joins - Introduction
difficulty: Intermediate
reading_time: 45 minutes
practice_time: 60 minutes
estimated_total_time: 105 minutes
prerequisites:
  - SELECT
  - WHERE
  - GROUP BY
  - HAVING
last_updated: 2026-07-30
---

# SQL Joins - Introduction

## Overview

A **JOIN** combines rows from two or more tables based on a related column.

Instead of storing all information in one large table, relational databases divide data into multiple related tables. Joins allow SQL to retrieve and combine that related information.

Examples:

- Employee → Department
- Customer → Orders
- Product → Category
- Student → Course
- Order → Payment

Without joins, relational databases would lose much of their power.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand why joins are needed.
- Understand primary and foreign keys.
- Identify relationships between tables.
- Recognize different join types.
- Prepare for INNER JOIN.

---

# Why Do We Need Joins?

Imagine a company stores employee and department information.

Instead of storing department names repeatedly for every employee, the database separates the data.

### Employees Table

| employee_id | first_name | department_id |
|-------------|------------|---------------|
|1|Rahul|1|
|2|Priya|2|
|3|Amit|1|
|4|Neha|3|

### Departments Table

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|
|3|Finance|

If you want this report:

| Employee | Department |
|-----------|------------|
|Rahul|IT|
|Priya|HR|
|Amit|IT|
|Neha|Finance|

One table is not enough.

You must combine both tables using a JOIN.

---

# Database Relationships

A relational database stores information using relationships.

### One-to-One

Example:

```
Person
↓

Passport
```

One person has one passport.

---

### One-to-Many

Example:

```
Customer

↓

Orders
```

One customer can place many orders.

This is the most common relationship.

---

### Many-to-Many

Example:

```
Students

↓

Enrollments

↓

Courses
```

One student takes many courses.

One course has many students.

A bridge (junction) table connects them.

---

# Primary Key

A **Primary Key (PK)** uniquely identifies each row.

Example

Employees

| employee_id | first_name |
|-------------|------------|
|1|Rahul|
|2|Priya|

Here,

```text
employee_id
```

is the Primary Key.

Properties:

- Unique
- Cannot be NULL
- One primary key per table

---

# Foreign Key

A **Foreign Key (FK)** references the primary key of another table.

Employees

| employee_id | department_id |
|-------------|---------------|
|1|1|
|2|2|
|3|1|

Departments

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|

Here,

```text
department_id
```

inside the Employees table is a Foreign Key.

It connects Employees to Departments.

---

# Visual Relationship

```text
Employees

employee_id
first_name
department_id
      │
      │
      ▼
Departments

department_id
department_name
```

---

# What Does a JOIN Do?

Without JOIN

```text
Employees

Rahul     1
Priya     2
```

Departments

```text
1  IT
2  HR
```

JOIN combines them.

```text
Rahul     IT

Priya     HR
```

---

# Types of SQL Joins

| Join | Description |
|------|-------------|
| INNER JOIN | Matching rows only |
| LEFT JOIN | All rows from the left table + matching rows |
| RIGHT JOIN | All rows from the right table + matching rows |
| FULL OUTER JOIN | All rows from both tables |
| CROSS JOIN | Every possible combination |
| SELF JOIN | A table joined with itself |
| NATURAL JOIN | Automatically joins matching column names (rarely recommended) |

---

# Join Diagram

```text
               SQL JOINS

                  JOIN
                    │
      ┌─────────────┼─────────────┐
      │             │             │
 INNER JOIN     OUTER JOIN     CROSS JOIN
                    │
        ┌───────────┼───────────┐
        │           │           │
     LEFT        RIGHT      FULL OUTER
```

---

# Sample Database

We'll use these tables throughout the joins module.

### Employees

| employee_id | first_name | department_id |
|-------------|------------|---------------|
|1|Rahul|1|
|2|Priya|2|
|3|Amit|1|
|4|Neha|NULL|
|5|Rohan|4|

---

### Departments

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|
|3|Finance|

Notice:

- Employee Neha has no department.
- Department Finance has no employees.
- Employee Rohan references department 4, which doesn't exist.

These situations help demonstrate how each join behaves.

---

# Common Business Scenarios

## Human Resources

- Employees and Departments
- Employees and Managers
- Employees and Salaries

---

## Sales

- Customers and Orders
- Orders and Products
- Orders and Payments

---

## Inventory

- Products and Categories
- Products and Suppliers

---

# Best Practices

- Always identify the relationship first.
- Know which table contains the foreign key.
- Use meaningful table aliases.
- Join only the tables you need.
- Always specify the join condition explicitly.

---

# Common Mistakes

### Forgetting the JOIN condition

```sql
SELECT *
FROM employees
JOIN departments;
```

This creates a Cartesian product (every employee paired with every department).

---

### Joining the wrong columns

```sql
ON employee_id = department_id
```

Incorrect.

The relationship should be:

```sql
ON employees.department_id = departments.department_id
```

---

### Assuming every foreign key has a matching primary key

Real-world data may contain orphaned records, especially when constraints are missing or data has been imported incorrectly.

---

# Interview Questions

### What is a JOIN?

A JOIN combines rows from two or more related tables.

---

### Why are joins needed?

Because normalized databases store related information across multiple tables.

---

### What is the difference between a Primary Key and a Foreign Key?

A Primary Key uniquely identifies rows in its own table.

A Foreign Key references a Primary Key in another table to create a relationship.

---

### Which join returns only matching rows?

`INNER JOIN`

---

# Cheat Sheet

| Concept | Meaning |
|----------|---------|
| Primary Key | Unique identifier |
| Foreign Key | References another table |
| JOIN | Combines tables |
| Relationship | Connection between tables |

---

# Practice Exercises

## 🟢 Beginner

1. Identify the primary key in the Employees table.
2. Identify the foreign key in the Employees table.
3. Explain why departments are stored separately.

---

## 🟡 Intermediate

1. Draw a one-to-many relationship between Customers and Orders.
2. Explain why joins reduce data duplication.
3. List three real-world examples where joins are required.

---

## 🔴 Advanced

Given the sample tables:

1. Predict which employees will appear in an INNER JOIN.
2. Predict which employees will appear in a LEFT JOIN.
3. Predict what happens when an employee references a department that does not exist.

(Don't worry if you're unsure—we'll answer these in the next chapters.)

---

# Summary

Joins are the mechanism that connects related tables in a relational database. They rely on primary and foreign keys to combine information stored across multiple tables. Understanding relationships is essential before learning the different join types.

---

# Related Topics

**Previous**

- `../04_SQL_Queries/16_ORDER_OF_EXECUTION.md`

**Next**

- `02_INNER_JOIN.md`

**Upcoming**

- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN
- CROSS JOIN
