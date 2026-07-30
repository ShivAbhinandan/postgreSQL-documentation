---
title: CREATE TABLE
difficulty: Beginner
reading_time: 30 minutes
practice_time: 60 minutes
estimated_total_time: 90 minutes
prerequisites:
  - PostgreSQL Data Types
  - CREATE SCHEMA
last_updated: 2026-07-30
---

# CREATE TABLE

## Overview

A table is the fundamental object used to store data in a relational database.

Every piece of information stored in PostgreSQL—such as employees, customers, products, and orders—is stored in tables.

Before data can be inserted, a table must be created.

In this chapter, you'll learn how to create tables using PostgreSQL, understand table structure, and apply best practices used in real-world database design.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Explain what a table is.
- Create tables using SQL.
- Define columns and data types.
- Understand table structure.
- Follow table naming conventions.
- Create production-ready tables.

---

# What is a Table?

A table stores related information in rows and columns.

Example:

| employee_id | employee_name | salary |
|-------------|---------------|---------|
| 101 | Alice | 65000.00 |
| 102 | Bob | 72000.00 |
| 103 | Charlie | 58000.00 |

Each row represents one record.

Each column represents one attribute.

---

# Anatomy of a Table

```text
employees
│
├── employee_id
├── employee_name
├── email
├── phone_number
├── salary
├── hire_date
└── is_active
```

Every column has a defined data type.

---

# CREATE TABLE Syntax

```sql
CREATE TABLE table_name (
    column_name data_type,
    column_name data_type,
    column_name data_type
);
```

---

# Our First Table

Before creating the table, make sure you are connected to **company_db**.

```sql
CREATE TABLE hr.employees (

    employee_id INTEGER,

    employee_name VARCHAR(100),

    email VARCHAR(255),

    phone_number VARCHAR(20),

    salary NUMERIC(10,2),

    hire_date DATE,

    is_active BOOLEAN

);
```

If successful:

```text
CREATE TABLE
```

---

# Understanding the Table

| Column | Data Type | Purpose |
|---------|-----------|---------|
| employee_id | INTEGER | Employee identifier |
| employee_name | VARCHAR(100) | Employee name |
| email | VARCHAR(255) | Email address |
| phone_number | VARCHAR(20) | Contact number |
| salary | NUMERIC(10,2) | Employee salary |
| hire_date | DATE | Joining date |
| is_active | BOOLEAN | Employment status |

---

# View the Table

In `psql`:

```text
\dt
```

If you're using schemas:

```text
\dt hr.*
```

Example output:

```text
       List of relations

 Schema |   Name    | Type  | Owner
--------+-----------+-------+---------
 hr     | employees | table | postgres
```

---

# Describe the Table

In `psql`:

```text
\d hr.employees
```

Example output:

```text
 Column         | Type
----------------+------------------
 employee_id    | integer
 employee_name  | varchar(100)
 email          | varchar(255)
 phone_number   | varchar(20)
 salary         | numeric(10,2)
 hire_date      | date
 is_active      | boolean
```

---

# Create Another Table

```sql
CREATE TABLE hr.departments (

    department_id INTEGER,

    department_name VARCHAR(100),

    location VARCHAR(100)

);
```

---

# Naming Conventions

### Tables

✅ Good

```text
employees
departments
customers
order_items
```

❌ Avoid

```text
Employee
EMPLOYEE
emp
table1
```

---

### Columns

✅ Good

```text
employee_id
employee_name
hire_date
```

❌ Avoid

```text
Name
N1
Data
Column
```

---

# Best Practices

- Use lowercase names.
- Separate multiple words with underscores.
- Use meaningful column names.
- Select the correct data type.
- Group related information in one table.
- Avoid unnecessary columns.

---

# Common Mistakes

❌ Using incorrect data types.

```sql
salary VARCHAR(100)
```

Better:

```sql
salary NUMERIC(10,2)
```

---

❌ Storing phone numbers as integers.

Wrong:

```sql
phone_number INTEGER
```

Correct:

```sql
phone_number VARCHAR(20)
```

Phone numbers are identifiers, not values used for arithmetic.

---

❌ Using spaces in table names.

Wrong:

```text
Employee Details
```

Correct:

```text
employee_details
```

---

# Real-World Example

An HR management system may include:

```text
hr

├── employees

├── departments

├── attendance

├── payroll

└── leave_requests
```

Each table stores one type of business information, making the database easier to manage and maintain.

---

# Interview Questions

### What is a table?

A table is a database object that stores related data in rows and columns.

---

### Can two tables have the same name?

Yes, if they belong to different schemas.

Example:

```text
hr.employees

sales.employees
```

---

### Why does every column require a data type?

A data type defines the kind of data that can be stored and how PostgreSQL processes it.

---

### Which SQL command creates a table?

```sql
CREATE TABLE
```

---

# Cheat Sheet

| Command | Description |
|----------|-------------|
| `CREATE TABLE table_name (...);` | Create a new table |
| `\dt` | List tables |
| `\dt hr.*` | List tables in the `hr` schema |
| `\d hr.employees` | Describe a table |

---

# Practice Exercises

## 🟢 Beginner

1. Create the `employees` table.
2. Create the `departments` table.
3. List all tables.
4. Describe the `employees` table.

---

## 🟡 Intermediate

Create a table named `customers` with the following columns:

- customer_id
- customer_name
- email
- phone_number
- city

Choose appropriate data types for each column.

---

## 🔴 Advanced

Design the table structure for an online shopping system. Include:

- products
- categories
- suppliers

Choose meaningful column names and appropriate data types.

---

# Summary

In this chapter, you learned how to create tables in PostgreSQL, define columns and data types, and follow naming conventions used in professional database design. Tables form the foundation of every relational database and will be used throughout the remainder of this course.

---

# Related Topics

**Previous**

- `02_CREATE_SCHEMA.md`

**Next**

- `04_Constraints.md`

**Related**

- `05_INSERT.md`
- `06_SELECT.md`
