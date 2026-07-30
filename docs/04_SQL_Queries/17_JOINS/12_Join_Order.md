---
title: Join Order
difficulty: Advanced
reading_time: 75 minutes
practice_time: 120 minutes
estimated_total_time: 195 minutes
prerequisites:
  - Multiple Table Joins
  - EXPLAIN
last_updated: 2026-07-30
---

# Join Order

## Overview

When writing SQL queries involving multiple tables, many developers assume PostgreSQL processes joins exactly in the order they appear.

In reality, PostgreSQL uses a **cost-based query optimizer** that determines the most efficient execution plan.

Understanding join order helps you:

- Read execution plans.
- Optimize slow queries.
- Write maintainable SQL.
- Understand how PostgreSQL executes joins.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand logical vs physical join order.
- Learn how PostgreSQL chooses execution plans.
- Read basic `EXPLAIN` output.
- Improve query performance.
- Write optimizer-friendly SQL.

---

# Logical Join Order

Consider the following query.

```sql
SELECT
    c.customer_name,
    p.product_name
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
JOIN inventory.products AS p
    ON oi.product_id = p.product_id;
```

Logically, the joins appear as:

```text
Customers

↓

Orders

↓

Order Items

↓

Products
```

This is the order written by the developer.

---

# Physical Join Order

The PostgreSQL optimizer may choose:

```text
Products

↓

Order Items

↓

Orders

↓

Customers
```

or another order entirely.

The optimizer chooses the plan with the lowest estimated cost.

---

# Why Does PostgreSQL Change Join Order?

PostgreSQL considers factors such as:

- Table size.
- Available indexes.
- Column statistics.
- Estimated row counts.
- Filter conditions.
- Join algorithms.

The goal is to reduce work while returning the same result.

---

# Example

Query

```sql
SELECT
    c.customer_name,
    p.product_name
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
JOIN inventory.products AS p
    ON oi.product_id = p.product_id
WHERE
    p.category_id = 5;
```

Even though `products` appears last, PostgreSQL may access it first because the `WHERE` clause greatly reduces the number of rows.

---

# Visual Comparison

Developer's Query

```text
Customers

↓

Orders

↓

Order Items

↓

Products
```

Optimizer's Plan

```text
Products (Filtered)

↓

Order Items

↓

Orders

↓

Customers
```

Both return the same result.

---

# Join Algorithms

PostgreSQL chooses a join algorithm based on the estimated cost.

## Nested Loop Join

Best for:

- Small tables.
- Indexed lookups.

```text
For each customer

↓

Find matching order
```

---

## Hash Join

Best for:

- Large tables.
- Equality joins.

```text
Build Hash Table

↓

Probe Hash Table
```

---

## Merge Join

Best for:

- Sorted data.
- Large datasets.

```text
Sort

↓

Merge
```

---

# Using EXPLAIN

View the execution plan.

```sql
EXPLAIN
SELECT
    c.customer_name,
    p.product_name
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
JOIN inventory.products AS p
    ON oi.product_id = p.product_id;
```

The output shows:

- Join order.
- Join algorithms.
- Estimated rows.
- Estimated cost.

---

# Using EXPLAIN ANALYZE

```sql
EXPLAIN ANALYZE
SELECT ...
```

Unlike `EXPLAIN`, this executes the query and reports:

- Actual execution time.
- Actual row counts.
- Estimated vs actual rows.

Use it when investigating performance.

---

# Reading a Simple Plan

Example

```text
Hash Join

↓

Seq Scan orders

↓

Hash

↓

Seq Scan customers
```

Interpretation

- PostgreSQL scans both tables.
- Builds a hash table.
- Uses a Hash Join.

---

# Business Scenario

## Sales Dashboard

A report joins:

- Customers
- Orders
- Products
- Categories
- Sales Representatives

Instead of joining all rows first, PostgreSQL may start with:

```text
Products

↓

WHERE category = 'Electronics'
```

to reduce the dataset before performing additional joins.

---

# Common Mistakes

## Assuming SQL Executes Top to Bottom

The optimizer determines the physical execution plan.

---

## Ignoring EXPLAIN

Never guess why a query is slow.

Use:

```sql
EXPLAIN
```

or

```sql
EXPLAIN ANALYZE
```

---

## Missing Indexes

Joining large tables without indexes can significantly increase execution time.

---

## Selecting Unnecessary Columns

Avoid:

```sql
SELECT *
```

Return only the columns you need.

---

# Performance Tips

- Index join columns.
- Filter early when possible.
- Keep table statistics up to date using `ANALYZE`.
- Review execution plans regularly.
- Avoid unnecessary joins.

---

# Best Practices

- Write joins in logical relationship order for readability.
- Let PostgreSQL choose the physical execution order.
- Verify assumptions with `EXPLAIN ANALYZE`.
- Use descriptive aliases.

---

> **✅ Production Recommendation**
>
> Focus on writing clear SQL with proper indexes and accurate statistics. PostgreSQL's optimizer is usually better at choosing join order than manually trying to force it.

---

# Interview Questions

### Does PostgreSQL always execute joins in the written order?

No.

The optimizer can reorder joins.

---

### What determines join order?

Estimated execution cost.

---

### Which command shows the execution plan?

```sql
EXPLAIN
```

---

### Which command measures actual execution?

```sql
EXPLAIN ANALYZE
```

---

### Name three join algorithms.

- Nested Loop Join
- Hash Join
- Merge Join

---

# Cheat Sheet

| Concept | Description |
|----------|-------------|
|Logical Order|Order written in SQL|
|Physical Order|Order chosen by PostgreSQL|
|EXPLAIN|Estimated execution plan|
|EXPLAIN ANALYZE|Actual execution statistics|
|Optimizer|Chooses lowest-cost plan|

---

# Production Example

```sql
EXPLAIN ANALYZE
SELECT
    c.customer_name,
    p.product_name,
    oi.quantity
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
JOIN inventory.products AS p
    ON oi.product_id = p.product_id
WHERE
    p.category_id = 5;
```

Analyze:

- Join order
- Join algorithms
- Cost estimates
- Actual execution time

---

# Practice Exercises

## 🟢 Beginner

1. Run `EXPLAIN` on a query joining two tables.
2. Identify the join algorithm.
3. Compare estimated row counts.

---

## 🟡 Intermediate

1. Add a `WHERE` filter and compare the execution plan.
2. Create an index on the join column and rerun `EXPLAIN ANALYZE`.
3. Observe any changes.

---

## 🔴 Advanced

1. Join five tables and analyze the execution plan.
2. Compare plans before and after indexing.
3. Document why PostgreSQL changed the join order.

---

# Complexity & Performance

| Join Algorithm | Best Use Case |
|----------------|---------------|
|Nested Loop|Small datasets with indexes|
|Hash Join|Large equality joins|
|Merge Join|Large sorted datasets|

Performance Checklist

- Create indexes on join keys.
- Keep statistics current.
- Avoid unnecessary joins.
- Use `EXPLAIN ANALYZE` for performance tuning.

---

# Summary

Join order in SQL and join execution order in PostgreSQL are not always the same. PostgreSQL's optimizer selects the most efficient execution plan based on statistics, indexes, filters, and estimated costs. Understanding execution plans is essential for writing high-performance SQL.

---

# Related Topics

**Previous**

- `11_Multiple_Joins.md`

**Next**

- `13_Join_vs_Subquery.md`

**Related**

- `EXPLAIN.md` *(future chapter)*
- `Indexes.md` *(future chapter)*
- `Query_Optimization.md` *(future chapter)*
