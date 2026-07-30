---
title: CREATE SCHEMA
difficulty: Beginner
reading_time: 20 minutes
practice_time: 30 minutes
estimated_total_time: 50 minutes
prerequisites:
  - PostgreSQL Data Types
  - Creating Your First Database
last_updated: 2026-07-30
---

# CREATE SCHEMA

## Overview

A **schema** is a logical container used to organize database objects such as tables, views, functions, and sequences.

Think of a database as a filing cabinet and a schema as a folder inside that cabinet.

Using schemas helps organize large databases, improves security, and prevents naming conflicts.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand what a schema is.
- Create schemas.
- View existing schemas.
- Switch between schemas.
- Delete schemas.
- Explain why schemas are used.

---

# What is a Schema?

A schema is a namespace within a PostgreSQL database.

Example:

```text
company_db
│
├── hr
│   ├── employees
│   └── departments
│
├── sales
│   ├── customers
│   ├── orders
│   └── order_items
│
└── finance
    ├── invoices
    └── payments
```

Schemas help organize related database objects.

---

# Why Use Schemas?

Without schemas:

```text
employees
customers
orders
payments
products
departments
```

Everything exists in one place.

With schemas:

```text
hr.employees
sales.orders
finance.payments
```

Organization becomes much clearer.

---

# Default Schema

Every PostgreSQL database contains a default schema called:

```text
public
```

When you create a table without specifying a schema, PostgreSQL places it in the `public` schema.

Example:

```sql
CREATE TABLE employees (
    employee_id INTEGER
);
```

Equivalent to:

```sql
CREATE TABLE public.employees (
    employee_id INTEGER
);
```

---

# CREATE SCHEMA Syntax

```sql
CREATE SCHEMA schema_name;
```

---

# Example

Create an HR schema:

```sql
CREATE SCHEMA hr;
```

Create a Sales schema:

```sql
CREATE SCHEMA sales;
```

Create a Finance schema:

```sql
CREATE SCHEMA finance;
```

---

# View Existing Schemas

In `psql`:

```text
\dn
```

Typical output:

```text
public
hr
sales
finance
```

In pgAdmin:

```text
Databases
└── company_db
    └── Schemas
```

Expand the **Schemas** node to view all schemas.

---

# Creating Tables Inside a Schema

```sql
CREATE TABLE hr.employees (
    employee_id INTEGER,
    employee_name VARCHAR(100)
);
```

Notice the table name is prefixed with the schema name.

---

# Setting the Search Path

Instead of writing:

```sql
SELECT *
FROM hr.employees;
```

You can change the search path:

```sql
SET search_path TO hr;
```

Now you can simply write:

```sql
SELECT *
FROM employees;
```

PostgreSQL automatically searches the `hr` schema first.

---

# Delete a Schema

```sql
DROP SCHEMA hr;
```

If the schema contains objects:

```sql
DROP SCHEMA hr CASCADE;
```

> ⚠️ `CASCADE` deletes the schema **and all objects inside it**. Use it with caution.

---

# Common Errors

## Schema Already Exists

```text
ERROR: schema "hr" already exists
```

Solution:

```sql
CREATE SCHEMA IF NOT EXISTS hr;
```

---

## Schema Does Not Exist

```text
ERROR: schema "finance" does not exist
```

Check the schema name or create it before using it.

---

# Best Practices

- Use schemas to organize applications by business domain.
- Use lowercase names with underscores.
- Keep related tables together.
- Avoid putting every table in the `public` schema.
- Use meaningful schema names.

---

# Real-World Example

An e-commerce company might organize its database like this:

```text
company_db
│
├── hr
├── sales
├── inventory
├── finance
├── analytics
└── security
```

Each team owns and manages its own schema while sharing the same database.

---

# Interview Questions

### What is a schema?

A schema is a logical namespace inside a database that organizes database objects.

---

### What is the default schema in PostgreSQL?

`public`

---

### Can two schemas contain tables with the same name?

Yes.

Example:

```text
hr.employees

sales.employees
```

These are two different tables because they belong to different schemas.

---

### Why are schemas useful?

They improve organization, security, and object management while preventing naming conflicts.

---

# Cheat Sheet

| Command | Description |
|----------|-------------|
| `CREATE SCHEMA hr;` | Create a schema |
| `\dn` | List schemas (`psql`) |
| `SET search_path TO hr;` | Change the default schema |
| `DROP SCHEMA hr;` | Delete an empty schema |
| `DROP SCHEMA hr CASCADE;` | Delete a schema and all its objects |

---

# Practice Exercises

## 🟢 Beginner

1. Create a schema named `hr`.
2. Create another schema named `sales`.
3. List all schemas.

---

## 🟡 Intermediate

1. Create a table named `employees` inside the `hr` schema.
2. Change the search path to `hr`.
3. Query the table.

---

## 🔴 Advanced

Design a schema structure for a hospital management system. Include at least five schemas and explain the purpose of each.

---

# Summary

Schemas provide a logical way to organize database objects within a database. By grouping related tables and other objects into schemas, databases become easier to manage, secure, and scale.

In the next chapter, you'll create your first table inside the `company_db` database using the data types you've already learned.

---

# Related Topics

**Previous**

- `01_Data_Types.md`

**Next**

- `03_CREATE_TABLE.md`

**Related**

- `04_Constraints.md`
- `05_INSERT.md`
