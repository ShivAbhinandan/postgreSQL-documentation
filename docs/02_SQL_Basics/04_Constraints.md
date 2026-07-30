---
title: Constraints
difficulty: Beginner
reading_time: 40 minutes
practice_time: 90 minutes
estimated_total_time: 130 minutes
prerequisites:
  - PostgreSQL Data Types
  - CREATE SCHEMA
  - CREATE TABLE
last_updated: 2026-07-30
---

# Constraints

## Overview

Constraints are rules applied to table columns that ensure the accuracy, consistency, and integrity of data.

Without constraints, users could insert invalid or duplicate information into the database, leading to unreliable reports and application errors.

Every production database should use appropriate constraints.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Explain what constraints are.
- Understand why constraints are important.
- Apply different types of constraints.
- Design tables with proper data validation.
- Interpret common constraint errors.

---

# What are Constraints?

A constraint is a rule that PostgreSQL enforces whenever data is inserted, updated, or deleted.

For example:

- Every employee should have a unique ID.
- Salary cannot be negative.
- Email addresses should not be duplicated.
- Every employee must belong to an existing department.

Constraints ensure that invalid data never enters the database.

---

# Why Are Constraints Important?

Without constraints:

| Employee ID | Email | Salary |
|-------------|----------------------|---------|
| 101 | alice@company.com | 65000 |
| 101 | alice@company.com | -5000 |
| NULL | NULL | 10000 |

Problems:

- Duplicate employee IDs
- Duplicate email addresses
- Negative salary
- Missing employee ID

With constraints, PostgreSQL rejects invalid data automatically.

---

# Types of Constraints

| Constraint | Purpose |
|------------|---------|
| NOT NULL | Prevents NULL values |
| UNIQUE | Prevents duplicate values |
| PRIMARY KEY | Uniquely identifies each row |
| FOREIGN KEY | Maintains relationships between tables |
| CHECK | Validates data using a condition |
| DEFAULT | Provides a default value |

---

# NOT NULL

A NOT NULL constraint requires a value.

```sql
CREATE TABLE hr.departments (

    department_id INTEGER,

    department_name VARCHAR(100) NOT NULL

);
```

Valid:

```text
Sales
```

Invalid:

```text
NULL
```

---

# UNIQUE

Ensures values are unique.

```sql
email VARCHAR(255) UNIQUE
```

Valid:

```text
alice@company.com
bob@company.com
```

Invalid:

```text
alice@company.com
alice@company.com
```

---

# PRIMARY KEY

A Primary Key uniquely identifies every row.

Rules:

- Unique
- Cannot be NULL
- One primary key per table

Example:

```sql
employee_id INTEGER PRIMARY KEY
```

Example table:

| employee_id | employee_name |
|--------------|---------------|
| 1 | Alice |
| 2 | Bob |
| 3 | Charlie |

---

# FOREIGN KEY

A Foreign Key creates a relationship between two tables.

Example:

```text
Departments

department_id
1
2
3
```

Employees

```text
employee_id

department_id

101

1
```

Relationship:

```
Employees.department_id

↓

Departments.department_id
```

SQL:

```sql
department_id INTEGER
REFERENCES hr.departments(department_id)
```

---

# CHECK

CHECK validates data.

Example:

```sql
salary NUMERIC(10,2)
CHECK (salary > 0)
```

Allowed:

```text
50000
```

Rejected:

```text
-5000
```

---

# DEFAULT

DEFAULT automatically inserts a value if none is provided.

```sql
is_active BOOLEAN DEFAULT TRUE
```

Insert:

```sql
INSERT INTO hr.employees (
    employee_id,
    employee_name
)
VALUES (
    1,
    'Alice'
);
```

Stored value:

```text
TRUE
```

---

# Building Our Production Table

Let's redesign the `employees` table using proper constraints.

```sql
CREATE TABLE hr.employees (

    employee_id INTEGER PRIMARY KEY,

    employee_name VARCHAR(100) NOT NULL,

    email VARCHAR(255) UNIQUE NOT NULL,

    phone_number VARCHAR(20),

    salary NUMERIC(10,2)
        CHECK (salary >= 0),

    hire_date DATE NOT NULL,

    is_active BOOLEAN
        DEFAULT TRUE

);
```

This is much closer to what you would see in a real application.

---

# Constraint Violations

## Duplicate Primary Key

```sql
INSERT INTO hr.employees
VALUES (
    1,
    'Alice',
    'alice@company.com',
    '9876543210',
    65000,
    '2025-01-15',
    TRUE
);
```

Running the same insert again results in:

```text
ERROR:
duplicate key value violates unique constraint
```

---

## NULL in NOT NULL Column

```sql
INSERT INTO hr.employees (

    employee_id,
    employee_name

)

VALUES (

    2,
    NULL

);
```

Result:

```text
ERROR:
null value in column "employee_name"
violates not-null constraint
```

---

## CHECK Constraint Failure

```sql
INSERT INTO hr.employees (

    employee_id,
    employee_name,
    email,
    salary,
    hire_date

)

VALUES (

    3,
    'Bob',
    'bob@company.com',
    -1000,
    '2025-02-01'

);
```

Result:

```text
ERROR:
new row violates check constraint
```

---

# Best Practices

- Every table should have a PRIMARY KEY.
- Use NOT NULL for mandatory information.
- Use UNIQUE for emails and usernames.
- Use CHECK to validate business rules.
- Use DEFAULT for common values.
- Keep constraints simple and meaningful.

---

# Common Mistakes

❌ Creating tables without a primary key.

❌ Allowing NULL values in required columns.

❌ Storing duplicate email addresses.

❌ Forgetting to validate numeric values.

---

# Real-World Example

An HR system might enforce these rules:

| Column | Constraint |
|---------|------------|
| employee_id | PRIMARY KEY |
| employee_name | NOT NULL |
| email | UNIQUE, NOT NULL |
| salary | CHECK (salary >= 0) |
| hire_date | NOT NULL |
| is_active | DEFAULT TRUE |

These rules help maintain clean and reliable employee data.

---

# Interview Questions

### What is a constraint?

A constraint is a rule that PostgreSQL enforces to maintain data integrity.

---

### What is the difference between PRIMARY KEY and UNIQUE?

A PRIMARY KEY uniquely identifies each row and cannot contain NULL values.

A UNIQUE constraint also prevents duplicates but can allow NULL values (subject to PostgreSQL's handling of NULLs).

---

### Can a table have multiple PRIMARY KEY constraints?

No.

A table can have only one PRIMARY KEY, although it may consist of multiple columns (a composite primary key).

---

### Why use CHECK constraints?

To enforce business rules, such as ensuring salaries are not negative or ages fall within an acceptable range.

---

# Cheat Sheet

| Constraint | Example |
|------------|---------|
| NOT NULL | `employee_name VARCHAR(100) NOT NULL` |
| UNIQUE | `email VARCHAR(255) UNIQUE` |
| PRIMARY KEY | `employee_id INTEGER PRIMARY KEY` |
| FOREIGN KEY | `REFERENCES hr.departments(department_id)` |
| CHECK | `CHECK (salary >= 0)` |
| DEFAULT | `DEFAULT TRUE` |

---

# Practice Exercises

## 🟢 Beginner

1. Create a table named `projects` with:
   - `project_id` as the PRIMARY KEY.
   - `project_name` as NOT NULL.
   - `budget` with a CHECK constraint ensuring it is greater than or equal to 0.

2. Insert valid rows and observe the results.

---

## 🟡 Intermediate

Create a `customers` table with:

- `customer_id` as PRIMARY KEY
- `email` as UNIQUE
- `customer_name` as NOT NULL
- `is_active` with a DEFAULT value of TRUE

Test each constraint by attempting invalid inserts.

---

## 🔴 Advanced

Design the constraints for the following tables:

- departments
- products
- orders

Explain why you chose each constraint.

---

# Summary

Constraints protect the integrity of your data by preventing invalid, duplicate, or inconsistent values. Proper use of constraints is a fundamental part of professional database design and helps ensure that applications operate on reliable data.

---

# Related Topics

**Previous**

- `03_CREATE_TABLE.md`

**Next**

- `05_INSERT.md`

**Related**

- `06_SELECT.md`
- `03_CREATE_TABLE.md`
