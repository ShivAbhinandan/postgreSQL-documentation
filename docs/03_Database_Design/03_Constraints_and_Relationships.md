# Constraints and Relationships

## Overview

Creating tables defines the structure of a database, but constraints define the rules that protect the quality and consistency of the data.

In this chapter, we connect all tables in the `company_db` database and enforce business rules using PostgreSQL constraints.

---

# Types of Constraints Used

| Constraint | Purpose |
|------------|---------|
| PRIMARY KEY | Uniquely identifies each row |
| FOREIGN KEY | Creates relationships between tables |
| UNIQUE | Prevents duplicate values |
| CHECK | Validates business rules |
| NOT NULL | Requires a value |
| DEFAULT | Assigns a default value when none is provided |

---

# Entity Relationships

## HR Module

```text
departments
      │
      │ 1
      │
      │
      ▼
employees
      ▲
      │
      │ N
      │
jobs
```

One department can have many employees.

One job role can be assigned to many employees.

---

## Inventory Module

```text
categories
      │
      │
      ▼
products
      ▲
      │
suppliers
```

Each product belongs to one category and one supplier.

---

## Sales Module

```text
customers
      │
      ▼
orders
      │
      ▼
order_items
      │
      ▼
products
```

A customer can place many orders.

An order contains multiple products.

---

## Finance Module

```text
orders
   │
   ▼
invoices
   │
   ▼
payments
```

Each invoice belongs to an order.

Each payment is linked to an invoice.

---

# Business Rules

The database enforces the following rules:

- Department names must be unique.
- Product categories must be unique.
- Employee salaries cannot be negative.
- Product prices cannot be negative.
- Stock cannot be negative.
- Quantity must be greater than zero.
- Payment amounts cannot be negative.
- Employees must belong to existing departments.
- Orders must belong to existing customers.

---

# Why Use Foreign Keys?

Foreign keys ensure that relationships remain valid.

For example:

```text
Employee
Department ID = 5
```

Department **5** must already exist in the `departments` table.

If it does not, PostgreSQL rejects the insert.

This prevents orphan records and maintains referential integrity.

---

# Summary

Constraints are essential for building reliable databases. They enforce business rules, protect data integrity, and connect related tables so that SQL queries can retrieve meaningful information across the entire system.
