---
title: INSERT Statement
difficulty: Beginner
reading_time: 30 minutes
practice_time: 60 minutes
estimated_total_time: 90 minutes
prerequisites:
  - Company Database Design
  - Constraints
last_updated: 2026-07-30
---

# INSERT Statement

## Overview

The `INSERT` statement is used to add new rows to a table.

Whenever a new employee joins a company, a customer places an order, or a new product is added to inventory, an `INSERT` statement is executed.

It is one of the four primary Data Manipulation Language (DML) commands:

- INSERT
- SELECT
- UPDATE
- DELETE

---

# Learning Objectives

After completing this chapter, you will be able to:

- Insert single rows.
- Insert multiple rows.
- Insert values into selected columns.
- Understand default values.
- Handle common INSERT errors.
- Follow best practices.

---

# INSERT Syntax

```sql
INSERT INTO table_name (
    column1,
    column2,
    column3
)
VALUES (
    value1,
    value2,
    value3
);
```

---

# Insert a Single Employee

```sql
INSERT INTO hr.employees
(
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    salary,
    department_id,
    job_id
)
VALUES
(
    'Ankit',
    'Sharma',
    'ankit.sharma@company.com',
    '9876500000',
    '2025-03-15',
    68000,
    4,
    2
);
```

---

# Verify the Insert

```sql
SELECT *
FROM hr.employees
ORDER BY employee_id DESC
LIMIT 1;
```

---

# Insert Multiple Rows

```sql
INSERT INTO hr.departments
(department_name, location)

VALUES

('Legal', 'Delhi'),

('Research', 'Bengaluru'),

('Operations', 'Mumbai');
```

---

# Insert Using Selected Columns

Suppose the `phone_number` is unknown.

```sql
INSERT INTO sales.customers
(
    first_name,
    last_name,
    email,
    city,
    country
)
VALUES
(
    'Riya',
    'Malhotra',
    'riya@example.com',
    'Delhi',
    'India'
);
```

The omitted columns receive either `NULL` or their defined `DEFAULT` value.

---

# DEFAULT Values

If a column has a default value, PostgreSQL automatically uses it when no value is provided.

Example table definition:

```sql
is_active BOOLEAN DEFAULT TRUE
```

Insert:

```sql
INSERT INTO hr.employees
(
    first_name,
    last_name,
    email,
    hire_date,
    salary
)
VALUES
(
    'Mohit',
    'Singh',
    'mohit.singh@company.com',
    CURRENT_DATE,
    55000
);
```

The `is_active` column is automatically set to `TRUE`.

---

# Using CURRENT_DATE

Instead of typing today's date manually:

```sql
'2026-07-30'
```

Use:

```sql
CURRENT_DATE
```

This always uses the current database date.

---

# Common Errors

## Duplicate Email

```text
ERROR:
duplicate key value violates unique constraint
```

Cause:

A row with the same email already exists.

---

## Invalid Foreign Key

```sql
department_id = 999
```

Result:

```text
ERROR:
insert or update on table "employees"
violates foreign key constraint
```

The referenced department must exist.

---

## NULL in Required Column

```text
ERROR:
null value violates not-null constraint
```

Every required column must receive a value.

---

# INSERT ... RETURNING

PostgreSQL supports returning inserted values immediately.

```sql
INSERT INTO hr.departments
(department_name, location)
VALUES
('Support', 'Chennai')
RETURNING department_id, department_name;
```

Example output:

| department_id | department_name |
|---------------|-----------------|
| 9 | Support |

This is useful when your application needs the newly generated ID.

---

# Best Practices

- Always specify column names.
- Use meaningful values.
- Let identity columns generate IDs automatically.
- Verify foreign key values before inserting.
- Use transactions for bulk inserts.

---

# Common Mistakes

❌ Omitting the column list.

```sql
INSERT INTO hr.departments
VALUES ('HR', 'Delhi');
```

This depends on the table's column order and is harder to maintain.

✅ Preferred:

```sql
INSERT INTO hr.departments
(department_name, location)
VALUES
('HR', 'Delhi');
```

---

# Interview Questions

### What is the purpose of the INSERT statement?

It adds one or more new rows to a table.

---

### Can INSERT add multiple rows?

Yes.

A single `INSERT` statement can insert multiple rows.

---

### Why should you specify column names?

It improves readability and prevents errors if the table structure changes.

---

### What does the RETURNING clause do?

It returns values from the inserted rows, such as generated IDs.

---

# Cheat Sheet

| Statement | Purpose |
|-----------|---------|
| `INSERT INTO ... VALUES (...)` | Insert one row |
| `INSERT INTO ... VALUES (...), (...);` | Insert multiple rows |
| `CURRENT_DATE` | Current database date |
| `RETURNING` | Return inserted values |

---

# Practice Exercises

## 🟢 Beginner

1. Insert one employee.
2. Insert one customer.
3. Insert one product.

---

## 🟡 Intermediate

1. Insert three departments in one statement.
2. Insert a customer without a phone number.
3. Use `RETURNING` to display the new customer ID.

---

## 🔴 Advanced

Create a transaction that:

- Inserts a customer.
- Inserts an order for that customer.
- Commits the transaction.

(Hint: You'll learn transactions in detail later.)

---

# Summary

The `INSERT` statement adds new records to a table. By specifying column names, validating foreign keys, and using features like `RETURNING`, you can write reliable and maintainable SQL that works well in both learning environments and production systems.

---

# Related Topics

**Previous**

- `03_Database_Design/04_Insert_Sample_Data.md`

**Next**

- `02_SELECT.md`

**Related**

- `03_WHERE.md`
- `04_ORDER_BY.md`
