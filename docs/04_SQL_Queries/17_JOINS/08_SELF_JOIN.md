---
title: SELF JOIN
difficulty: Intermediate
reading_time: 75 minutes
practice_time: 120 minutes
estimated_total_time: 195 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
  - Table Aliases
last_updated: 2026-07-30
---

# SELF JOIN

## Overview

A **SELF JOIN** joins a table to itself.

Instead of joining two different tables, SQL treats the same table as two separate tables by using aliases.

There is **no dedicated SELF JOIN keyword**.

A SELF JOIN is created using:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN (rare)
- FULL OUTER JOIN (rare)

along with table aliases.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand what a SELF JOIN is.
- Join a table with itself.
- Build employee-manager relationships.
- Work with hierarchical data.
- Write production-quality SELF JOIN queries.

---

# Why SELF JOIN?

Consider an employee table.

Each employee has a manager.

The manager is also an employee.

Instead of creating another table, both employees and managers are stored in the same table.

Example:

| employee_id | employee_name | manager_id |
|--------------|---------------|-----------|
|1|John|NULL|
|2|Alice|1|
|3|Bob|1|
|4|David|2|
|5|Emma|2|

Notice:

Manager IDs reference another employee in the same table.

---

# Visual Representation

```text
Employees

1 John

2 Alice

3 Bob

4 David

5 Emma

Manager Relationships

John
│
├── Alice
│     ├── David
│     └── Emma
│
└── Bob
```

This hierarchy is retrieved using a SELF JOIN.

---

# Syntax

```sql
SELECT
    e.employee_name,
    m.employee_name AS manager_name
FROM hr.employees AS e
JOIN hr.employees AS m
ON e.manager_id = m.employee_id;
```

Notice:

Both aliases refer to the same table.

---

# Why Aliases Are Required

Without aliases:

```sql
FROM employees
JOIN employees
```

SQL cannot distinguish which instance of the table each column belongs to.

Correct:

```sql
FROM employees AS e
JOIN employees AS m
```

Now:

- `e` → Employee
- `m` → Manager

---

# First SELF JOIN

```sql
SELECT
    e.employee_name,
    m.employee_name AS manager
FROM hr.employees AS e
INNER JOIN hr.employees AS m
ON e.manager_id = m.employee_id;
```

Output

| Employee | Manager |
|-----------|---------|
|Alice|John|
|Bob|John|
|David|Alice|
|Emma|Alice|

---

# Step-by-Step Execution

```text
Employee Table

↓

Take Alice

↓

manager_id = 1

↓

Find employee_id = 1

↓

John Found

↓

Return

Alice → John
```

Repeat for every employee.

---

# Using LEFT JOIN

The CEO has no manager.

To include everyone:

```sql
SELECT
    e.employee_name,
    m.employee_name AS manager
FROM hr.employees AS e
LEFT JOIN hr.employees AS m
ON e.manager_id = m.employee_id;
```

Output

| Employee | Manager |
|-----------|---------|
|John|NULL|
|Alice|John|
|Bob|John|
|David|Alice|
|Emma|Alice|

This is more common than an INNER SELF JOIN because it includes top-level employees.

---

# Multiple SELF JOINs

Retrieve employee, manager, and director.

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    d.employee_name AS director
FROM hr.employees AS e
LEFT JOIN hr.employees AS m
    ON e.manager_id = m.employee_id
LEFT JOIN hr.employees AS d
    ON m.manager_id = d.employee_id;
```

Output

| Employee | Manager | Director |
|-----------|---------|----------|
|David|Alice|John|
|Emma|Alice|John|

---

# Business Scenarios

## Employee → Manager

```sql
SELECT
    e.employee_name,
    m.employee_name AS manager
FROM hr.employees AS e
LEFT JOIN hr.employees AS m
ON e.manager_id = m.employee_id;
```

---

## Category Hierarchy

Example:

```text
Electronics

↓

Laptop

↓

Gaming Laptop
```

```sql
SELECT
    c.category_name,
    p.category_name AS parent_category
FROM inventory.categories AS c
LEFT JOIN inventory.categories AS p
ON c.parent_category_id = p.category_id;
```

---

## Family Tree

```sql
SELECT
    child.name,
    parent.name
FROM family.people AS child
LEFT JOIN family.people AS parent
ON child.parent_id = parent.person_id;
```

---

## Bill of Materials (BOM)

```sql
SELECT
    child.part_name,
    parent.part_name
FROM manufacturing.parts AS child
LEFT JOIN manufacturing.parts AS parent
ON child.parent_part_id = parent.part_id;
```

---

# Common Mistakes

## Forgetting Aliases

❌

```sql
SELECT *
FROM employees
JOIN employees
ON manager_id = employee_id;
```

---

✅

```sql
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id;
```

---

## Using INNER JOIN Accidentally

An INNER JOIN excludes employees without managers.

If you need the full hierarchy:

Use

```sql
LEFT JOIN
```

---

## Confusing Employee and Manager Columns

Always prefix columns.

```sql
e.employee_name

m.employee_name
```

---

# Performance Tips

- Index the foreign key (`manager_id`).
- Select only required columns.
- Use aliases consistently.
- For very deep hierarchies, consider recursive CTEs.

---

# Best Practices

- Use meaningful aliases (`e`, `m`, `p`, `child`, `parent`).
- Prefer LEFT JOIN for organizational charts.
- Clearly alias output columns.

Example:

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
```

---

# Interview Questions

### What is a SELF JOIN?

A join where a table is joined to itself.

---

### Does SQL have a SELF JOIN keyword?

No.

SELF JOIN is implemented using regular joins and table aliases.

---

### Why are aliases required?

To distinguish different logical roles of the same table.

---

### What is the most common SELF JOIN example?

Employee → Manager.

---

### Can SELF JOIN use LEFT JOIN?

Yes.

It is commonly used to include employees who do not have managers.

---

# Cheat Sheet

| Feature | SELF JOIN |
|----------|-----------|
|Special SQL keyword|❌|
|Uses aliases|✅|
|Joins same table|✅|
|Supports INNER JOIN|✅|
|Supports LEFT JOIN|✅|

---

# Production Example

## Organizational Chart

```sql
SELECT
    e.employee_name AS employee,
    e.job_title,
    m.employee_name AS manager
FROM hr.employees AS e
LEFT JOIN hr.employees AS m
ON e.manager_id = m.employee_id
ORDER BY manager, employee;
```

---

# Practice Exercises

## 🟢 Beginner

1. Display every employee with their manager.
2. Include employees without managers.
3. Display only employees managed by John.

---

## 🟡 Intermediate

1. Display employee, manager, and director.
2. Display parent and child categories.
3. Display parent and child products.

---

## 🔴 Advanced

1. Build a three-level organizational hierarchy.
2. Find employees who manage more than five employees.
3. Display all employees with the number of direct reports.

---

# Complexity & Performance

| Operation | Impact |
|-----------|--------|
|SELF JOIN on indexed key|Fast|
|Multiple SELF JOINs|Moderate|
|Deep hierarchies|Consider recursive CTEs|

Performance Checklist

- Index `manager_id`.
- Use LEFT JOIN when preserving the full hierarchy.
- Avoid `SELECT *`.
- Use `EXPLAIN ANALYZE` for complex hierarchical queries.

---

# Summary

A **SELF JOIN** joins a table with itself using aliases. It is essential for working with hierarchical data such as employees and managers, product categories, family trees, and organizational structures. Mastering SELF JOIN is a key step toward learning recursive CTEs.

---

# Related Topics

**Previous**

- `07_CROSS_JOIN.md`

**Next**

- `09_NATURAL_JOIN.md`

**Related**

- `10_USING_vs_ON.md`
- `18_CTEs/01_Introduction.md` *(coming later)*
