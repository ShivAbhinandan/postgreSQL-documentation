# What is SQL?

## Definition

SQL (Structured Query Language) is the standard language used to communicate with relational databases.

It allows users to:

- Store data
- Retrieve data
- Modify data
- Delete data
- Manage database structures

SQL is used by database systems such as:

- PostgreSQL
- MySQL
- SQL Server
- Oracle
- SQLite

---

## Why Do We Need SQL?

Modern applications generate large amounts of data.

Examples:

| Application | Data Stored |
|------------|------------|
| E-commerce | Orders, Customers, Products |
| Banking | Accounts, Transactions |
| Hospital | Patients, Doctors |
| HR System | Employees, Salaries |

SQL provides an efficient way to manage and analyze this data.

---

## What Can SQL Do?

### Create Database Objects

```sql
CREATE TABLE employees (
    employee_id INT,
    employee_name VARCHAR(100)
);
```

### Insert Data

```sql
INSERT INTO employees
VALUES (1, 'John');
```

### Retrieve Data

```sql
SELECT *
FROM employees;
```

### Update Data

```sql
UPDATE employees
SET employee_name = 'David'
WHERE employee_id = 1;
```

### Delete Data

```sql
DELETE FROM employees
WHERE employee_id = 1;
```

---

## SQL Categories

### DDL (Data Definition Language)

Used to define database structures.

Commands:

- CREATE
- ALTER
- DROP
- TRUNCATE

### DML (Data Manipulation Language)

Used to manipulate data.

Commands:

- INSERT
- UPDATE
- DELETE

### DQL (Data Query Language)

Used to retrieve data.

Commands:

- SELECT

### DCL (Data Control Language)

Used for permissions.

Commands:

- GRANT
- REVOKE

### TCL (Transaction Control Language)

Used for transactions.

Commands:

- COMMIT
- ROLLBACK
- SAVEPOINT

---

## Real-World Example

A company wants to see all employees working in the Sales department.

```sql
SELECT employee_name
FROM employees
WHERE department = 'Sales';
```

SQL makes such queries simple and efficient.

---

## Common Interview Questions

### What does SQL stand for?

Structured Query Language.

### Is SQL a programming language?

SQL is generally considered a declarative language because it describes what data is needed rather than how to retrieve it.

### What are the main categories of SQL commands?

- DDL
- DML
- DQL
- DCL
- TCL

---

## Summary

- SQL is the standard language for relational databases.
- SQL is used to create, read, update, and delete data.
- SQL works with databases such as PostgreSQL, MySQL, Oracle, and SQL Server.
- SQL commands are categorized into DDL, DML, DQL, DCL, and TCL.
