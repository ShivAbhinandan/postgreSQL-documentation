---
title: FULL OUTER JOIN
difficulty: Intermediate
reading_time: 75 minutes
practice_time: 120 minutes
estimated_total_time: 195 minutes
prerequisites:
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN
last_updated: 2026-07-30
---

# FULL OUTER JOIN

## Overview

A `FULL OUTER JOIN` returns:

- Every matching row from both tables
- Every unmatched row from the left table
- Every unmatched row from the right table

When no match exists, columns from the missing side are returned as `NULL`.

Think of it as:

```text
LEFT JOIN
      +
RIGHT JOIN
      =
FULL OUTER JOIN
```

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand FULL OUTER JOIN.
- Compare it with INNER, LEFT, and RIGHT JOIN.
- Find unmatched records in either table.
- Perform data reconciliation.
- Write auditing queries.

---

# Syntax

```sql
SELECT column_list
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;
```

`FULL JOIN` is accepted by PostgreSQL as a shorthand for `FULL OUTER JOIN`.

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

Finance ------- No Employees

FULL OUTER JOIN Result

Rahul      IT

Priya      HR

Amit       IT

Neha       NULL

Rohan      NULL

NULL       Finance
```

Everything from both tables appears.

---

# First FULL OUTER JOIN

```sql
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM hr.employees AS e
FULL OUTER JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

Output

| employee_id | first_name | department_name |
|-------------|------------|-----------------|
|1|Rahul|IT|
|2|Priya|HR|
|3|Amit|IT|
|4|Neha|NULL|
|5|Rohan|NULL|
|NULL|NULL|Finance|

---

# Step-by-Step Execution

```text
Read Employees

↓

Read Departments

↓

Find matching rows

↓

Return matches

↓

Return unmatched employees

↓

Return unmatched departments
```

---

# Comparing Join Types

| Join Type | Matching Rows | Unmatched Left | Unmatched Right |
|------------|:-------------:|:--------------:|:---------------:|
| INNER JOIN | ✅ | ❌ | ❌ |
| LEFT JOIN | ✅ | ✅ | ❌ |
| RIGHT JOIN | ✅ | ❌ | ✅ |
| FULL OUTER JOIN | ✅ | ✅ | ✅ |

---

# Finding Employees Without Departments

```sql
SELECT
    e.employee_id,
    e.first_name
FROM hr.employees AS e
FULL OUTER JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
```

Output

| employee_id | first_name |
|-------------|------------|
|4|Neha|
|5|Rohan|

---

# Finding Departments Without Employees

```sql
SELECT
    d.department_name
FROM hr.employees AS e
FULL OUTER JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;
```

Output

| department_name |
|-----------------|
|Finance|

---

# Finding All Unmatched Records

```sql
SELECT
    e.first_name,
    d.department_name
FROM hr.employees AS e
FULL OUTER JOIN hr.departments AS d
    ON e.department_id = d.department_id
WHERE
    e.employee_id IS NULL
    OR d.department_id IS NULL;
```

Output

| Employee | Department |
|----------|------------|
|Neha|NULL|
|Rohan|NULL|
|NULL|Finance|

This is a common pattern for identifying data inconsistencies.

---

# FULL OUTER JOIN with Aggregate Functions

```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM hr.departments AS d
FULL OUTER JOIN hr.employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;
```

---

# Business Scenarios

## Data Migration Validation

Compare old and new customer tables.

```sql
SELECT
    o.customer_id AS old_customer,
    n.customer_id AS new_customer
FROM old_customers AS o
FULL OUTER JOIN new_customers AS n
    ON o.customer_id = n.customer_id
WHERE
    o.customer_id IS NULL
    OR n.customer_id IS NULL;
```

---

## Inventory Audit

Find products missing from either inventory system.

```sql
SELECT
    a.product_id AS warehouse_a,
    b.product_id AS warehouse_b
FROM inventory_a AS a
FULL OUTER JOIN inventory_b AS b
    ON a.product_id = b.product_id
WHERE
    a.product_id IS NULL
    OR b.product_id IS NULL;
```

---

## Customer Reconciliation

Compare CRM and billing systems.

```sql
SELECT
    crm.customer_id,
    billing.customer_id
FROM crm.customers AS crm
FULL OUTER JOIN billing.customers AS billing
    ON crm.customer_id = billing.customer_id;
```

---

# Common Mistakes

## Assuming It Behaves Like LEFT JOIN

`FULL OUTER JOIN` returns unmatched rows from **both** tables.

---

## Forgetting NULL Checks

To identify unmatched rows:

```sql
WHERE
    left_table.id IS NULL
    OR right_table.id IS NULL;
```

---

## Using FULL OUTER JOIN Unnecessarily

If only one table must be preserved, use `LEFT JOIN` or `RIGHT JOIN`.

---

# Performance Tips

- FULL OUTER JOIN is generally more expensive than INNER or LEFT JOIN.
- Index join columns.
- Filter data before joining where possible.
- Use only when both unmatched sides are required.

---

# Best Practices

- Use aliases consistently.
- Select only required columns.
- Use `COALESCE()` when displaying values from either table.

Example:

```sql
SELECT
    COALESCE(e.first_name, 'No Employee') AS employee,
    COALESCE(d.department_name, 'No Department') AS department
FROM hr.employees AS e
FULL OUTER JOIN hr.departments AS d
    ON e.department_id = d.department_id;
```

---

# Interview Questions

### What does FULL OUTER JOIN return?

All matching rows plus every unmatched row from both tables.

---

### When should FULL OUTER JOIN be used?

When you need complete visibility into both datasets, including unmatched records.

---

### How do you find unmatched rows?

```sql
WHERE
    left_table.id IS NULL
    OR right_table.id IS NULL;
```

---

### Is `FULL JOIN` valid?

Yes.

In PostgreSQL:

```sql
FULL JOIN
```

is equivalent to:

```sql
FULL OUTER JOIN
```

---

# Cheat Sheet

| Join | Keeps Left | Keeps Right |
|------|:----------:|:-----------:|
| INNER | ❌ | ❌ |
| LEFT | ✅ | ❌ |
| RIGHT | ❌ | ✅ |
| FULL OUTER | ✅ | ✅ |

---

# Production Example

## Customer Synchronization Report

```sql
SELECT
    old.customer_id AS old_system,
    new.customer_id AS new_system
FROM old_customers AS old
FULL OUTER JOIN new_customers AS new
    ON old.customer_id = new.customer_id
WHERE
    old.customer_id IS NULL
    OR new.customer_id IS NULL;
```

This query identifies records that exist in only one system.

---

# Practice Exercises

## 🟢 Beginner

1. Perform a FULL OUTER JOIN between employees and departments.
2. List employees without departments.
3. List departments without employees.

---

## 🟡 Intermediate

1. Find unmatched products across two inventory tables.
2. Compare old and new employee databases.
3. Display all customers and all orders, including unmatched records.

---

## 🔴 Advanced

1. Reconcile two sales systems using FULL OUTER JOIN.
2. Identify missing suppliers across two databases.
3. Build an audit report showing unmatched records from both sides.

---

# Summary

`FULL OUTER JOIN` combines the behavior of `LEFT JOIN` and `RIGHT JOIN`, returning every matching and unmatched row from both tables. It is particularly useful for auditing, reconciliation, ETL validation, and comparing datasets.

---

# Related Topics

**Previous**

- `04_RIGHT_JOIN.md`

**Next**

- `06_JOIN_COMPARISON.md`

**Related**

- `02_INNER_JOIN.md`
- `03_LEFT_JOIN.md`
- `04_RIGHT_JOIN.md`
