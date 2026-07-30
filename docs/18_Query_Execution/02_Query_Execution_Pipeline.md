# Parser, Analyzer & Rewriter

## Introduction

When PostgreSQL receives a SQL statement, it cannot execute it immediately. It first passes through the **Parser**, **Analyzer**, and **Rewriter**.

```text
SQL Text
 ↓
Parser
 ↓
Analyzer
 ↓
Rewriter
```

# 1. Parser

The Parser converts SQL text into a **Parse Tree** and validates SQL syntax.

Example:

```sql
SELECT employee_name
FROM employees;
```

It checks:
- SQL grammar
- Keyword order
- Parentheses
- Commas
- Overall syntax

Example syntax error:

```sql
SELECT FROM employees;
```

Output:

```text
ERROR: syntax error at or near "FROM"
```

> The Parser checks syntax only. It does not verify whether tables or columns exist.

# 2. Analyzer

The Analyzer validates:

- Tables
- Columns
- Data types
- Functions
- Permissions

Example:

```sql
SELECT employee_name
FROM employees;
```

Missing table:

```sql
SELECT salary
FROM employee_data;
```

Output:

```text
ERROR: relation "employee_data" does not exist
```

Missing column:

```sql
SELECT monthly_salary
FROM employees;
```

Output:

```text
ERROR: column "monthly_salary" does not exist
```

# Parser vs Analyzer

| Parser | Analyzer |
|---------|----------|
| Checks syntax | Checks database objects |
| Creates Parse Tree | Creates Query Tree |
| Finds grammar errors | Finds semantic errors |

# 3. Rewriter

The Rewriter expands views and applies rewrite rules before planning.

Example:

```sql
CREATE VIEW active_employees AS
SELECT *
FROM employees
WHERE status='Active';
```

Query:

```sql
SELECT *
FROM active_employees;
```

Internally becomes:

```sql
SELECT *
FROM employees
WHERE status='Active';
```

# Complete Flow

```text
SQL Text
 ↓
Parser
 ↓
Parse Tree
 ↓
Analyzer
 ↓
Query Tree
 ↓
Rewriter
 ↓
Rewritten Query
 ↓
Planner
```

# Business Example

Queries against views are rewritten into the underlying SQL before planning.

# Interview Questions

1. What is the Parser?
2. What is a Parse Tree?
3. Difference between syntax and semantic errors?
4. What does the Analyzer validate?
5. How does the Rewriter handle views?

# Summary

The Parser validates syntax, the Analyzer validates database objects and semantics, and the Rewriter transforms queries before they reach the Planner.
