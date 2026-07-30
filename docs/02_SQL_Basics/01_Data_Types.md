---
title: PostgreSQL Data Types
difficulty: Beginner
reading_time: 25 minutes
practice_time: 40 minutes
estimated_total_time: 65 minutes
prerequisites:
  - Creating Your First Database
last_updated: 2026-07-30
---

# PostgreSQL Data Types

## Overview

Every value stored in PostgreSQL has a **data type**.

A data type defines:

- What kind of data can be stored.
- How much storage is required.
- Which operations can be performed.
- The valid range of values.

Choosing the correct data type improves:

- Data integrity
- Performance
- Storage efficiency
- Query optimization

---

# Learning Objectives

After completing this chapter, you will be able to:

- Explain what a data type is.
- Choose appropriate data types for different scenarios.
- Differentiate between common PostgreSQL data types.
- Understand best practices for selecting data types.

---

# What is a Data Type?

A data type specifies the kind of value a column can store.

Example:

```text
Employee Name → Text

Salary → Number

Joining Date → Date

Is Active → True/False
```

Every column in a table must have exactly one data type.

---

# Categories of Data Types

PostgreSQL supports many data types, which can be grouped into the following categories.

| Category | Examples |
|----------|----------|
| Numeric | SMALLINT, INTEGER, BIGINT, NUMERIC, REAL, DOUBLE PRECISION |
| Character | CHAR, VARCHAR, TEXT |
| Boolean | BOOLEAN |
| Date & Time | DATE, TIME, TIMESTAMP, INTERVAL |
| Binary | BYTEA |
| UUID | UUID |
| JSON | JSON, JSONB |
| Array | INTEGER[], TEXT[] |
| Network | INET, CIDR, MACADDR |
| Geometric | POINT, LINE, CIRCLE |

---

# Numeric Data Types

Used for storing numbers.

| Data Type | Description | Example |
|-----------|-------------|---------|
| SMALLINT | Small whole numbers | 125 |
| INTEGER | Standard whole numbers | 1000 |
| BIGINT | Very large whole numbers | 9000000000 |
| NUMERIC(p,s) | Exact decimal values | 12345.67 |
| REAL | Single precision decimal | 25.4 |
| DOUBLE PRECISION | Double precision decimal | 25.456789 |

Example:

```sql
salary NUMERIC(10,2)
```

Stores values like:

```text
85000.50
1200.00
99999999.99
```

---

# Character Data Types

Used for storing text.

| Data Type | Description |
|-----------|-------------|
| CHAR(n) | Fixed-length text |
| VARCHAR(n) | Variable-length text with a maximum length |
| TEXT | Unlimited length text |

Example:

```sql
employee_name VARCHAR(100)
```

---

# Boolean

Stores only two values.

```text
TRUE
FALSE
```

Example:

```sql
is_active BOOLEAN
```

---

# Date and Time

| Data Type | Stores |
|-----------|--------|
| DATE | Calendar date |
| TIME | Time only |
| TIMESTAMP | Date and time |
| INTERVAL | Time duration |

Example:

```sql
hire_date DATE
```

---

# UUID

A UUID is a globally unique identifier.

Example:

```text
550e8400-e29b-41d4-a716-446655440000
```

Useful in distributed applications where unique IDs are required.

---

# JSON and JSONB

Store structured JSON data.

Example:

```json
{
  "name": "Alice",
  "department": "HR"
}
```

`JSONB` stores data in a binary format and supports indexing, making it the preferred choice for most applications.

---

# Arrays

A single column can store multiple values.

Example:

```text
skills

Python
SQL
Power BI
```

Data type:

```sql
TEXT[]
```

Arrays are useful but should be used carefully. In many cases, a separate table provides a more flexible design.

---

# Choosing the Right Data Type

| Requirement | Recommended Type |
|------------|------------------|
| Employee ID | INTEGER |
| Employee Name | VARCHAR(100) |
| Salary | NUMERIC(10,2) |
| Joining Date | DATE |
| Active Status | BOOLEAN |
| Product Description | TEXT |

---

# Best Practices

- Choose the smallest data type that satisfies your requirements.
- Use `NUMERIC` for financial values to avoid rounding errors.
- Use `VARCHAR` when a sensible maximum length exists.
- Use `TEXT` for long descriptions.
- Use `BOOLEAN` for true/false values.
- Avoid storing numbers in text columns.

---

# Common Mistakes

❌ Storing dates as text.

❌ Using `TEXT` for every column without considering limits.

❌ Using `REAL` or `DOUBLE PRECISION` for financial values.

❌ Storing phone numbers as numeric values (they may contain leading zeros or symbols).

---

# Real-World Example

An `employees` table might contain:

| Column | Data Type |
|--------|-----------|
| employee_id | INTEGER |
| employee_name | VARCHAR(100) |
| email | VARCHAR(255) |
| phone_number | VARCHAR(20) |
| salary | NUMERIC(10,2) |
| hire_date | DATE |
| is_active | BOOLEAN |

Choosing appropriate data types improves consistency, validation, and performance.

---

# Interview Questions

### What is a data type?

A data type defines the kind of values that can be stored in a column.

---

### Why is `NUMERIC` preferred for financial data?

Because it stores exact decimal values without floating-point rounding errors.

---

### What is the difference between `CHAR` and `VARCHAR`?

`CHAR` stores fixed-length strings, while `VARCHAR` stores variable-length strings up to a specified maximum.

---

### When should you use `TEXT`?

When the maximum length is unknown or unrestricted.

---

# Cheat Sheet

| Data Type | Common Use |
|-----------|------------|
| SMALLINT | Small integers |
| INTEGER | IDs, counts |
| BIGINT | Very large integers |
| NUMERIC | Prices, salaries |
| VARCHAR | Names, emails |
| TEXT | Descriptions |
| BOOLEAN | True/False |
| DATE | Dates |
| TIMESTAMP | Date and time |
| UUID | Unique identifiers |
| JSONB | Structured JSON |
| TEXT[] | Arrays of text |

---

# Practice Exercises

## 🟢 Beginner

1. Identify the correct data type for:
   - Customer Name
   - Product Price
   - Order Date
   - Is Delivered

2. Explain the difference between `VARCHAR` and `TEXT`.

---

## 🟡 Intermediate

Design the data types for an `employees` table containing:

- Employee ID
- Name
- Email
- Salary
- Hire Date
- Active Status

---

## 🔴 Advanced

Research PostgreSQL's `JSONB` data type and explain two advantages it has over `JSON`.

---

# Summary

In this chapter, you learned that data types define the kind of data PostgreSQL can store. Selecting appropriate data types is a key part of designing efficient, reliable databases. In the next chapter, you'll learn about database objects and how PostgreSQL organizes them.

---

# Related Topics

**Previous**

- `../01_Introduction/10_First_Database.md`

**Next**

- `02_Database_Objects.md`

**Related**

- `05_CREATE_TABLE.md`
- `06_Constraints.md`
