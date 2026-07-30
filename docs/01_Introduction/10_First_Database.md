---
title: Creating Your First Database
difficulty: Beginner
reading_time: 20 minutes
practice_time: 30 minutes
estimated_total_time: 50 minutes
prerequisites:
  - Installing PostgreSQL
  - pgAdmin
  - psql
last_updated: 2026-07-30
---

# Creating Your First Database

## Overview

Now that PostgreSQL is installed and you know how to use both **pgAdmin** and **psql**, it's time to create your first database.

A database is the top-level container where your application's data is stored. Throughout this documentation, we'll use a single database named **company_db** for all examples and exercises.

Using one consistent database makes it easier to understand how SQL concepts connect together in real-world projects.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Create a database using SQL.
- Create a database using pgAdmin.
- Connect to a database.
- Verify that a database exists.
- Delete a database.
- Understand common database naming conventions.

---

# What is a Database?

A PostgreSQL server can contain multiple databases.

Example:

```text
PostgreSQL Server
│
├── company_db
├── school_db
├── hospital_db
└── ecommerce_db
```

Each database has its own:

- Schemas
- Tables
- Views
- Functions
- Data

Databases are isolated from one another.

---

# Naming Conventions

Choose meaningful names.

Good examples:

```text
company_db
sales_db
inventory_db
hr_db
```

Avoid names like:

```text
database1
test
new_db
abc
```

---

# Creating a Database (SQL)

Open the Query Tool in pgAdmin or connect using `psql`.

Execute:

```sql
CREATE DATABASE company_db;
```

If successful, PostgreSQL returns:

```text
CREATE DATABASE
```

---

# Verify the Database

List all databases.

In `psql`:

```text
\l
```

You should see:

```text
company_db
postgres
template0
template1
```

In pgAdmin:

```text
Servers
└── PostgreSQL
    └── Databases
```

Refresh the **Databases** node if `company_db` is not immediately visible.

---

# Connecting to the Database

In `psql`:

```text
\c company_db
```

Example output:

```text
You are now connected to database "company_db".
```

---

In pgAdmin:

- Expand **Databases**
- Right-click **company_db**
- Choose **Query Tool**

All SQL executed from this window will run against `company_db`.

---

# Checking the Current Database

Execute:

```sql
SELECT current_database();
```

Example output:

| current_database |
|------------------|
| company_db |

---

# Creating a Database Using pgAdmin

1. Expand **Servers**.
2. Expand **Databases**.
3. Right-click **Databases**.
4. Select **Create → Database...**
5. Enter:

```text
Database Name:
company_db
```

6. Click **Save**.

The new database will appear under the **Databases** node.

---

# Deleting a Database

> ⚠️ Warning
>
> Deleting a database permanently removes all objects and data stored inside it.

SQL:

```sql
DROP DATABASE company_db;
```

You cannot drop a database while you are connected to it.

First connect to another database, such as `postgres`.

```text
\c postgres
```

Then execute:

```sql
DROP DATABASE company_db;
```

---

# Common Errors

## Database Already Exists

```text
ERROR:
database "company_db" already exists
```

Solution:

Choose a different name or drop the existing database if appropriate.

---

## Cannot Drop the Current Database

```text
ERROR:
cannot drop the currently open database
```

Solution:

Connect to another database before running `DROP DATABASE`.

---

## Permission Denied

Only users with the required privileges can create or drop databases.

---

# Best Practices

- Use meaningful database names.
- Keep development and production databases separate.
- Avoid deleting databases unless necessary.
- Use lowercase names with underscores.
- Back up important databases regularly.

---

# Real-World Example

A company may organize its systems like this:

```text
PostgreSQL Server
│
├── hr_db
├── payroll_db
├── inventory_db
├── crm_db
└── analytics_db
```

Each database serves a different business function.

---

# Interview Questions

### What is the purpose of a database?

A database stores related data and database objects such as tables, views, and functions.

---

### Which SQL command creates a database?

```sql
CREATE DATABASE database_name;
```

---

### Which SQL command deletes a database?

```sql
DROP DATABASE database_name;
```

---

### How do you connect to another database in `psql`?

```text
\c database_name
```

---

# Cheat Sheet

| Command | Description |
|----------|-------------|
| `CREATE DATABASE company_db;` | Create a database |
| `DROP DATABASE company_db;` | Delete a database |
| `SELECT current_database();` | Show the current database |
| `\l` | List databases (`psql`) |
| `\c company_db` | Connect to a database (`psql`) |

---

# Practice Exercises

## 🟢 Beginner

1. Create a database named `company_db`.
2. List all databases.
3. Connect to `company_db`.
4. Verify the current database.

---

## 🟡 Intermediate

1. Create another database named `sales_db`.
2. Switch between `company_db` and `sales_db`.
3. Delete `sales_db`.

---

## 🔴 Advanced

Research the difference between:

- `CREATE DATABASE`
- `CREATE SCHEMA`

Write a short explanation describing when each should be used.

---

# Summary

In this chapter, you created your first PostgreSQL database and learned how to manage databases using both SQL and pgAdmin. This database, **company_db**, will be used throughout the remainder of this documentation as the foundation for all examples, exercises, and projects.

---

# Related Topics

**Previous**

- `09_psql.md`

**Next**

- `docs/02_SQL_Basics/01_Data_Types.md`

**Related**

- `02_Create_Database.md`
- `03_Create_Schema.md`
