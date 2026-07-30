---
title: RIGHT JOIN
difficulty: Intermediate
reading_time: 60 minutes
practice_time: 90 minutes
estimated_total_time: 150 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
last_updated: 2026-07-30
---

# RIGHT JOIN

## Overview

A `RIGHT JOIN` returns:

- Every row from the **right table**
- Matching rows from the **left table**
- `NULL` values for left-table columns when no matching row exists

It is the opposite of a `LEFT JOIN`.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand how RIGHT JOIN works.
- Compare RIGHT JOIN with LEFT JOIN.
- Find unmatched rows in the left table.
- Decide when RIGHT JOIN is appropriate.
- Write equivalent LEFT JOIN queries.

---

# Syntax

```sql
SELECT column_list
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;
```

The table written after `RIGHT JOIN` is preserved.

---

# Sample Tables

## Employees

| employee_id | first_name | department_id |
|-------------|------------|---------------|
|1|Rahul|1|
|2|Priya|2|
|3|Amit|1|
|4|Neha|NULL|
|5|Rohan|4|

---

## Departments

| department_id | department_name |
|---------------|-----------------|
|1|IT|
|2|HR|
|3|Finance|

---

# Visual Representation

```text
Employees                     Departments

Rahul -------- IT

Priya -------- HR

Amit --------- IT

Neha --------- NULL

Rohan -------- Department 4 (Missing)

RIGHT JOIN Result

Rahul      IT

Priya      HR

Amit       IT

NULL       Finance
```

Finance appears because every row from the **right table** is preserved.

Neha and Rohan do not appear because they belong only to the left table.

---

# First RIGHT JOIN

```sql
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

Output

| employee_id | first_name | department_name |
|--------------|------------|----------------|
|1|Rahul|IT|
|3|Amit|IT|
|2|Priya|HR|
|NULL|NULL|Finance|

---

# Step-by-Step Execution

```text
Read Departments

↓

For each department

↓

Find matching employee

↓

Match Found?

YES → Return employee + department

NO → Return NULL + department
```

---

# RIGHT JOIN vs LEFT JOIN

```text
LEFT JOIN

Keep LEFT table

↓

Employees
```

```text
RIGHT JOIN

Keep RIGHT table

↓

Departments
```

Both can produce equivalent results by reversing the table order.

---

# Equivalent LEFT JOIN

These queries return the same result.

RIGHT JOIN

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

Equivalent LEFT JOIN

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.departments AS d
LEFT JOIN hr.employees AS e
    ON d.department_id = e.department_id;
```

Many teams prefer the second version because LEFT JOIN is more commonly used.

---

# Finding Departments Without Employees

```sql
SELECT
    d.department_name
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;
```

Output

| department_name |
|-----------------|
|Finance|

---

# RIGHT JOIN with Aggregate Functions

```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;
```

Output

| Department | Employees |
|-------------|----------:|
|IT|2|
|HR|1|
|Finance|0|

---

# RIGHT JOIN with WHERE

Departments beginning with "H".

```sql
SELECT
    d.department_name,
    e.first_name
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE d.department_name LIKE 'H%';
```

Output

| Department | Employee |
|-------------|----------|
|HR|Priya|

---

# Business Scenarios

## Departments Without Employees

```sql
SELECT
    d.department_name
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;
```

---

## Categories Without Products

```sql
SELECT
    c.category_name
FROM inventory.products AS p
RIGHT JOIN inventory.categories AS c
    ON p.category_id = c.category_id
WHERE p.product_id IS NULL;
```

---

## Suppliers Without Products

```sql
SELECT
    s.supplier_name
FROM inventory.products AS p
RIGHT JOIN inventory.suppliers AS s
    ON p.supplier_id = s.supplier_id
WHERE p.product_id IS NULL;
```

---

# Common Mistakes

## Forgetting Which Table Is Preserved

RIGHT JOIN always preserves the table on the right.

---

## Confusing RIGHT JOIN with LEFT JOIN

Remember:

```text
LEFT JOIN

Keep LEFT table
```

```text
RIGHT JOIN

Keep RIGHT table
```

---

## Filtering Preserved Rows Incorrectly

Filtering the preserved table in the `WHERE` clause is usually fine.

Filtering the non-preserved table can unintentionally remove unmatched rows.

Be mindful of where conditions belong.

---

# Performance Tips

- Index join columns.
- Prefer LEFT JOIN when possible for readability.
- Use table aliases.
- Select only required columns.
- Filter rows as early as practical.

---

# Best Practices

- Learn RIGHT JOIN for interviews.
- Prefer LEFT JOIN in new code unless RIGHT JOIN clearly improves readability.
- Always qualify column names with aliases.
- Use `COUNT(column)` when counting matches.

---

# Interview Questions

### What does RIGHT JOIN return?

All rows from the right table and matching rows from the left table.

---

### Can RIGHT JOIN be rewritten?

Yes.

Swap the table order and use a LEFT JOIN.

---

### Which join is more common?

LEFT JOIN.

---

### What happens when no matching row exists?

The left-table columns are returned as `NULL`.

---

# Cheat Sheet

| Join | Keeps |
|------|-------|
| INNER JOIN | Matching rows |
| LEFT JOIN | Left table |
| RIGHT JOIN | Right table |

---

# Production Example

## Department Staffing Report

```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM hr.employees AS e
RIGHT JOIN hr.departments AS d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;
```

Departments with no employees still appear with a count of `0`.

---

# Practice Exercises

## 🟢 Beginner

1. Display all departments with employee names.
2. Find departments with no employees.
3. Rewrite a RIGHT JOIN as a LEFT JOIN.

---

## 🟡 Intermediate

1. Display all product categories, including empty categories.
2. Display all suppliers, including those without products.
3. Count employees in every department.

---

## 🔴 Advanced

1. Find regions with no sales.
2. Display every warehouse, including warehouses without inventory.
3. Rewrite three RIGHT JOIN queries using LEFT JOIN.

---

# Summary

A `RIGHT JOIN` preserves every row from the right table and includes matching rows from the left table. Although it is fully supported in PostgreSQL, many development teams prefer writing equivalent `LEFT JOIN` queries because they are generally easier to read and maintain.

---

# Related Topics

**Previous**

- `03_LEFT_JOIN.md`

**Next**

- `05_FULL_OUTER_JOIN.md`

**Related**

- `02_INNER_JOIN.md`
- `03_LEFT_JOIN.md`
