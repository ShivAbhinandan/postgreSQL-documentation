---
title: psql (PostgreSQL Interactive Terminal)
difficulty: Beginner
reading_time: 20 minutes
practice_time: 30 minutes
estimated_total_time: 50 minutes
prerequisites:
  - Installing PostgreSQL
  - pgAdmin
last_updated: 2026-07-30
---

# psql (PostgreSQL Interactive Terminal)

## Overview

`psql` is the official command-line client for PostgreSQL. It allows you to connect to a PostgreSQL server, execute SQL commands, manage databases, and perform administrative tasks directly from the terminal.

Although graphical tools such as pgAdmin are convenient, many database administrators and developers prefer `psql` because it is lightweight, fast, and ideal for automation.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand what `psql` is.
- Start the PostgreSQL interactive terminal.
- Connect to a PostgreSQL server.
- Execute SQL commands.
- Use common `psql` meta-commands.
- Exit the terminal safely.

---

# What is psql?

`psql` is the official command-line interface (CLI) for PostgreSQL.

Using `psql`, you can:

- Create databases
- Create tables
- Execute SQL queries
- Import SQL files
- Export data
- Manage users
- View database objects
- Run administrative commands

---

# Why Learn psql?

Even if you primarily use pgAdmin, learning `psql` is valuable because:

- It is available on almost every PostgreSQL installation.
- It is widely used on Linux servers.
- It is essential for scripting and automation.
- It is often used in production environments.
- It helps you understand PostgreSQL more deeply.

---

# How psql Fits into PostgreSQL

```mermaid
flowchart LR

User --> psql

psql --> PostgreSQL_Server

PostgreSQL_Server --> Database
```

`psql` communicates with the PostgreSQL server. It does not store any data itself.

---

# Starting psql

Open:

```text
SQL Shell (psql)
```

You will be prompted for several values.

```text
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password:
```

Press **Enter** to accept the default values unless you have changed them.

Enter your PostgreSQL password when prompted.

If the connection succeeds, you will see:

```text
postgres=#
```

This is the `psql` prompt, indicating that you are connected and ready to execute commands.

---

# Your First SQL Query

Run:

```sql
SELECT version();
```

Example output:

```text
PostgreSQL 17.x
```

---

# Another Example

```sql
SELECT CURRENT_DATE;
```

Example output:

```text
 current_date
--------------
2026-07-30
```

---

# Understanding the Prompt

Example:

```text
postgres=#
```

Meaning:

- `postgres` → Current database
- `#` → Connected as a superuser

A normal user often sees:

```text
company_db=>
```

---

# SQL Commands vs Meta-Commands

There are two types of commands in `psql`.

## SQL Commands

These are standard SQL statements.

Example:

```sql
SELECT * FROM employees;
```

---

## Meta-Commands

Meta-commands begin with a backslash (`\`) and are interpreted by `psql` itself.

Example:

```text
\l
```

---

# Common Meta-Commands

## List Databases

```text
\l
```

---

## Connect to a Database

```text
\c company_db
```

---

## List Schemas

```text
\dn
```

---

## List Tables

```text
\dt
```

---

## Describe a Table

```text
\d employees
```

---

## List Views

```text
\dv
```

---

## Display Help

```text
\?
```

---

## SQL Help

```text
\h
```

---

## Clear the Screen

```text
\! cls
```

On Linux/macOS:

```text
\! clear
```

---

## Quit psql

```text
\q
```

---

# Importing an SQL File

Execute a SQL script:

```text
\i C:/SQL/setup_database.sql
```

This is useful when running large SQL scripts.

---

# Editing Multi-line Queries

Example:

```sql
SELECT
    employee_name,
    salary
FROM employees
WHERE salary > 60000
ORDER BY salary DESC;
```

Press **Enter** after each line.

The query is executed only after the semicolon (`;`).

---

# Common Errors

## Forgot the Semicolon

Incorrect:

```sql
SELECT * FROM employees
```

The query waits for additional input.

Correct:

```sql
SELECT * FROM employees;
```

---

## Connected to the Wrong Database

Use:

```text
\c company_db
```

to switch databases.

---

## Typing Meta-Commands Incorrectly

Incorrect:

```text
l
```

Correct:

```text
\l
```

---

# psql vs pgAdmin

| Feature | psql | pgAdmin |
|---------|-------|----------|
| Interface | Command Line | Graphical |
| Automation | Excellent | Limited |
| Resource Usage | Low | Higher |
| Learning SQL | Excellent | Excellent |
| Administration | Excellent | Excellent |

---

# Best Practices

- Learn the most common meta-commands.
- Always end SQL statements with a semicolon.
- Verify which database you are connected to before making changes.
- Use SQL scripts for repeatable tasks.
- Practice using both `psql` and pgAdmin.

---

# Common Mistakes

❌ Forgetting the semicolon.

❌ Confusing SQL commands with meta-commands.

❌ Running commands in the wrong database.

❌ Closing the terminal without finishing transactions.

---

# Interview Questions

### What is `psql`?

`psql` is the official command-line client for PostgreSQL.

---

### What is the difference between SQL commands and meta-commands?

SQL commands are executed by the PostgreSQL server.

Meta-commands (beginning with `\`) are interpreted by `psql`.

---

### Which command lists all databases?

```text
\l
```

---

### Which command exits `psql`?

```text
\q
```

---

### Which command connects to another database?

```text
\c database_name
```

---

# Key Takeaways

- `psql` is PostgreSQL's official command-line interface.
- SQL commands are sent to the PostgreSQL server.
- Meta-commands are handled locally by `psql`.
- `\l`, `\dt`, `\d`, `\c`, and `\q` are among the most frequently used commands.
- Learning `psql` is valuable even if you primarily use pgAdmin.

---

# Practice Exercises

## 🟢 Beginner

1. Open `psql`.
2. Connect to PostgreSQL.
3. Run `SELECT version();`.
4. Run `SELECT CURRENT_DATE;`.
5. Exit using `\q`.

---

## 🟡 Intermediate

1. List all databases.
2. Connect to a different database.
3. List all tables.
4. Describe a table.

---

## 🔴 Advanced

Create a SQL script containing multiple SQL statements and execute it using the `\i` meta-command.

---

# Summary

In this chapter, you learned how to use `psql`, the official PostgreSQL command-line client. You practiced connecting to a server, executing SQL queries, using meta-commands, and running SQL scripts.

---

# Related Topics

**Previous**

- `08_pgAdmin.md`

**Next**

- `10_First_Database.md`

**Related**

- `02_SQL_Basics/01_Data_Types.md`
