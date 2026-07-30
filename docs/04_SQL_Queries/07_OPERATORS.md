---
title: SQL Operators
difficulty: Beginner
reading_time: 50 minutes
practice_time: 90 minutes
estimated_total_time: 140 minutes
prerequisites:
  - WHERE Clause
last_updated: 2026-07-30
---

# SQL Operators

## Overview

SQL operators allow you to compare values, perform calculations, combine conditions, and manipulate query results.

Operators are used in almost every SQL query.

Examples:

- Salary greater than 60000
- Quantity multiplied by price
- Customers from Delhi AND Mumbai
- Employees NOT in HR

---

# Learning Objectives

After completing this chapter, you will be able to:

- Use comparison operators.
- Perform arithmetic calculations.
- Combine logical conditions.
- Understand operator precedence.
- Write cleaner SQL queries.

---

# Types of SQL Operators

| Category | Operators |
|----------|-----------|
| Arithmetic | + - * / % |
| Comparison | = <> > < >= <= |
| Logical | AND OR NOT |
| String | \|\| |

---

# Arithmetic Operators

## Addition (+)

```sql
SELECT
    salary,
    salary + 5000 AS revised_salary
FROM hr.employees;
```

---

## Subtraction (-)

```sql
SELECT
    salary,
    salary - 2000 AS deduction
FROM hr.employees;
```

---

## Multiplication (*)

Calculate annual salary.

```sql
SELECT
    first_name,
    salary,
    salary * 12 AS annual_salary
FROM hr.employees;
```

---

## Division (/)

Monthly salary divided by 30.

```sql
SELECT
    first_name,
    salary / 30 AS daily_salary
FROM hr.employees;
```

---

## Modulus (%)

Find even employee IDs.

```sql
SELECT
    employee_id,
    first_name
FROM hr.employees
WHERE employee_id % 2 = 0;
```

---

# Comparison Operators

## Equal (=)

```sql
WHERE city = 'Delhi'
```

---

## Not Equal (<>)

```sql
WHERE city <> 'Delhi'
```

---

## Greater Than (>)

```sql
WHERE salary > 60000
```

---

## Less Than (<)

```sql
WHERE salary < 50000
```

---

## Greater Than or Equal (>=)

```sql
WHERE salary >= 70000
```

---

## Less Than or Equal (<=)

```sql
WHERE salary <= 40000
```

---

# Logical Operators

## AND

Both conditions must be true.

```sql
SELECT *
FROM hr.employees
WHERE salary > 50000
AND department_id = 4;
```

---

## OR

At least one condition must be true.

```sql
SELECT *
FROM sales.customers
WHERE city = 'Delhi'
OR city = 'Mumbai';
```

---

## NOT

Reverse a condition.

```sql
SELECT *
FROM hr.employees
WHERE NOT department_id = 1;
```

---

# String Concatenation

PostgreSQL uses `||`.

```sql
SELECT
    first_name || ' ' || last_name AS full_name
FROM hr.employees;
```

---

# Operator Precedence

SQL evaluates operators in this order:

1. Parentheses
2. Arithmetic
3. Comparison
4. NOT
5. AND
6. OR

Example:

```sql
SELECT *
FROM hr.employees
WHERE
(
    department_id = 2
    OR department_id = 4
)
AND salary > 60000;
```

Always use parentheses to make complex logic clear.

---

# Business Scenarios

## HR

Employees earning more than 70,000.

```sql
SELECT
    first_name,
    salary
FROM hr.employees
WHERE salary > 70000;
```

---

## Sales

Customers from Delhi or Pune.

```sql
SELECT
    first_name,
    city
FROM sales.customers
WHERE city = 'Delhi'
OR city = 'Pune';
```

---

## Inventory

Products with stock below 50.

```sql
SELECT
    product_name,
    units_in_stock
FROM inventory.products
WHERE units_in_stock < 50;
```

---

# Best Practices

- Use parentheses in complex conditions.
- Keep expressions simple.
- Format logical conditions on separate lines.
- Avoid unnecessary calculations in the WHERE clause.

---

# Common Mistakes

## Confusing = with ==

❌ Wrong

```sql
WHERE salary == 50000;
```

✅ Correct

```sql
WHERE salary = 50000;
```

---

## Missing Parentheses

❌

```sql
WHERE department_id = 1
OR department_id = 2
AND salary > 50000;
```

✅

```sql
WHERE
(
    department_id = 1
    OR department_id = 2
)
AND salary > 50000;
```

---

# Interview Questions

### What is the difference between AND and OR?

`AND` requires all conditions to be true.

`OR` requires at least one condition to be true.

---

### Which operator checks inequality?

```sql
<>
```

---

### Which operator concatenates strings in PostgreSQL?

```sql
||
```

---

### What is operator precedence?

It determines the order in which SQL evaluates expressions.

---

# Cheat Sheet

| Operator | Purpose |
|----------|---------|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |
| = | Equal |
| <> | Not Equal |
| > | Greater Than |
| < | Less Than |
| >= | Greater Than or Equal |
| <= | Less Than or Equal |
| AND | Both conditions |
| OR | Either condition |
| NOT | Reverse condition |
| \|\| | String concatenation |

---

# Practice Exercises

## 🟢 Beginner

1. Show employees with salary greater than 50000.
2. Calculate annual salary.
3. Show products with stock less than 100.

---

## 🟡 Intermediate

1. Show employees in departments 2 or 4.
2. Display customer full names.
3. Find employees with even employee IDs.

---

## 🔴 Advanced

1. Display employees earning between 50000 and 80000 using operators only.
2. Display products where stock × price is greater than 500000.
3. Display employees not working in the HR department.

---

# Performance Tip

Whenever possible, avoid calculations directly on indexed columns inside the `WHERE` clause.

Less efficient:

```sql
WHERE salary * 12 > 800000;
```

More efficient:

```sql
WHERE salary > 800000 / 12;
```

This gives PostgreSQL a better opportunity to use an index on `salary`.

---

# Summary

SQL operators are the building blocks of filtering, calculations, and logical expressions. Understanding how they work—and how they interact through operator precedence—is essential for writing accurate and efficient SQL queries.

---

# Related Topics

**Previous**

- `06_DISTINCT.md`

**Next**

- `08_BETWEEN.md`

**Related**

- `03_WHERE.md`
- `09_IN.md`
