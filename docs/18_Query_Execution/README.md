---
title: Query Execution
module: 18
difficulty: Intermediate → Advanced
estimated_time: 12-15 Hours
prerequisites:
  - SQL Basics
  - Filtering
  - GROUP BY
  - HAVING
  - Functions
  - Subqueries
  - JOINS
last_updated: 2026-07-30
version: 1.0
---

# Query Execution

> Learn how PostgreSQL executes SQL queries internally and discover why some queries run in milliseconds while others take several seconds or even minutes.

---

# Module Overview

Most SQL courses teach **how to write queries**.

Very few teach **how PostgreSQL executes them**.

Understanding the query execution process is the difference between writing SQL that simply works and writing SQL that performs well on real-world databases.

This module explains every stage of PostgreSQL's query execution pipeline, from parsing a SQL statement to returning the final result.

---

# Learning Objectives

After completing this module, you will be able to:

- Explain how PostgreSQL processes SQL statements.
- Understand the logical order of SQL execution.
- Interpret execution plans using `EXPLAIN`.
- Analyze query performance with `EXPLAIN ANALYZE`.
- Understand how PostgreSQL chooses scan methods.
- Explain different JOIN algorithms.
- Optimize slow SQL queries.
- Understand planner cost estimation.
- Use database statistics to improve performance.
- Identify common performance bottlenecks.

---

# Why This Module Matters

Imagine two developers writing the same report.

Developer A writes:

```sql
SELECT *
FROM orders
WHERE customer_id = 100;
```

Developer B writes:

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE customer_id = 100;
```

Both queries return valid results.

However, PostgreSQL may execute them differently depending on:

- Available indexes
- Number of rows
- Statistics
- Required columns
- Planner estimates

Understanding **how PostgreSQL thinks** helps you write SQL that is both correct and efficient.

---

# What You Will Learn

This module covers the complete lifecycle of a SQL query.

```text
SQL Query

↓

Parser

↓

Analyzer

↓

Rewriter

↓

Planner

↓

Optimizer

↓

Executor

↓

Result
```

Each stage will be explained in detail throughout the module.

---

# Module Structure

| Chapter | Topic | Status |
|----------|-------|--------|
| 01 | Query Processing Order | ⏳ |
| 02 | Query Execution Pipeline | ⏳ |
| 03 | Parser | ⏳ |
| 04 | Analyzer | ⏳ |
| 05 | Rewriter | ⏳ |
| 06 | Planner | ⏳ |
| 07 | Optimizer | ⏳ |
| 08 | Executor | ⏳ |
| 09 | EXPLAIN | ⏳ |
| 10 | EXPLAIN ANALYZE | ⏳ |
| 11 | Sequential Scan | ⏳ |
| 12 | Index Scan | ⏳ |
| 13 | Bitmap Index Scan | ⏳ |
| 14 | Index Only Scan | ⏳ |
| 15 | Nested Loop Join | ⏳ |
| 16 | Hash Join | ⏳ |
| 17 | Merge Join | ⏳ |
| 18 | Query Cost | ⏳ |
| 19 | Database Statistics | ⏳ |
| 20 | Query Optimization | ⏳ |
| 21 | Common Performance Problems | ⏳ |
| 22 | Performance Case Studies | ⏳ |
| 23 | Performance Cheat Sheet | ⏳ |

---

# Prerequisites

Before starting this module, you should understand:

- SQL syntax
- Filtering (`WHERE`)
- Aggregation (`GROUP BY`)
- HAVING
- Functions
- JOINS
- Subqueries

If you have completed the previous modules in this repository, you are ready to begin.

---

# Skills You Will Gain

After completing this module, you will be able to:

- Read execution plans confidently.
- Identify expensive operations.
- Understand planner decisions.
- Optimize SQL queries.
- Improve report performance.
- Troubleshoot slow queries.
- Discuss query optimization during interviews.

---

# Real-World Applications

The concepts covered in this module are used in:

- Business Intelligence
- Data Analytics
- MIS Reporting
- Financial Systems
- Banking
- Healthcare
- Retail
- E-commerce
- ERP Systems
- Enterprise Data Warehouses

---

# Estimated Learning Path

| Chapter | Estimated Time |
|----------|---------------:|
| Query Processing Order | 60 min |
| Query Execution Pipeline | 60 min |
| Parser, Analyzer & Rewriter | 90 min |
| Planner & Optimizer | 120 min |
| EXPLAIN & EXPLAIN ANALYZE | 120 min |
| Scan Methods | 180 min |
| Join Algorithms | 180 min |
| Query Optimization | 180 min |
| Case Studies | 120 min |
| Cheat Sheet & Revision | 60 min |

**Total:** ~12–15 hours

---

# Recommended Study Workflow

For each chapter:

1. Read the documentation.
2. Study the diagrams.
3. Run the SQL examples.
4. Complete the practice exercises.
5. Answer the quiz.
6. Review the cheat sheet.
7. Revisit the chapter after a few days.

---

# Repository File Structure

```text
18_Query_Execution/

README.md

01_Query_Processing_Order.md
01_Query_Processing_Order.sql
01_Practice.sql
01_Quiz.md
01_Cheat_Sheet.md

02_Query_Execution_Pipeline.md
...

23_Performance_Cheat_Sheet.md
```

---

# Best Practices

Throughout this module:

- Execute every SQL example yourself.
- Use `EXPLAIN` before optimizing.
- Compare execution plans before and after changes.
- Focus on understanding *why* PostgreSQL chooses a plan.
- Avoid memorizing execution plans—learn how to interpret them.

---

# Expected Outcome

By the end of this module, you will understand:

- How PostgreSQL processes SQL queries.
- Why query performance differs.
- How to diagnose slow queries.
- How to optimize queries using execution plans and indexes.
- How to explain query optimization concepts confidently in interviews.

---

# Next Chapter

➡ **01_Query_Processing_Order.md**

In the next chapter, you will learn:

- SQL writing order vs. logical execution order.
- Why PostgreSQL processes clauses in a different sequence than you write them.
- How this affects query results and performance.

---

# Related Modules

- JOINS
- Window Functions
- Indexes
- Transactions
- Query Optimization
- PostgreSQL Administration
