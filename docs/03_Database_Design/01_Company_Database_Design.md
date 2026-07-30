---
title: Company Database Design
difficulty: Beginner
reading_time: 35 minutes
practice_time: 20 minutes
estimated_total_time: 55 minutes
last_updated: 2026-07-30
---

# Company Database Design

## Overview

Throughout this documentation, we will use a single database named **company_db**.

Rather than creating isolated example tables for each SQL concept, we will build and maintain a realistic database that models the operations of a medium-sized company.

This approach provides a consistent learning experience and reflects how databases are designed and maintained in professional environments.

---

# Learning Objectives

After completing this chapter, you will be able to:

- Understand the overall structure of the company database.
- Identify the purpose of each schema.
- Recognize relationships between business domains.
- Prepare for the SQL examples used in later chapters.

---

# Database Structure

```text
company_db
│
├── hr
├── sales
├── inventory
└── finance
```

Each schema groups related database objects.

---

# HR Schema

Responsible for employee management.

Tables:

```text
departments

jobs

employees
```

### departments

Stores department information.

Example:

| department_id | department_name |
|--------------|-----------------|
| 1 | Human Resources |
| 2 | Finance |
| 3 | Sales |

---

### jobs

Stores job roles.

| job_id | job_title |
|---------|------------|
| 1 | Data Analyst |
| 2 | MIS Executive |
| 3 | HR Manager |

---

### employees

Stores employee information.

| Column |
|----------|
| employee_id |
| first_name |
| last_name |
| email |
| phone_number |
| hire_date |
| salary |
| department_id |
| job_id |

---

# Inventory Schema

Responsible for product management.

Tables:

```text
categories

suppliers

products
```

---

### categories

Stores product categories.

Example:

Electronics

Furniture

Office Supplies

---

### suppliers

Stores supplier information.

---

### products

Stores product details.

Relationships:

```
Product

↓

Category

↓

Supplier
```

---

# Sales Schema

Responsible for customer orders.

Tables:

```text
customers

orders

order_items
```

Relationships:

```
Customer

↓

Orders

↓

Order Items

↓

Products
```

---

# Finance Schema

Responsible for billing and payments.

Tables:

```text
payments

invoices
```

---

# High-Level Relationships

```text
departments
      │
      │
employees
      │
      │
jobs


customers
     │
orders
     │
order_items
     │
products
     │
categories
     │
suppliers


orders
   │
payments

orders
   │
invoices
```

---

# Database Design Principles

The database follows these principles:

- One table stores one type of information.
- Tables are connected using foreign keys.
- Duplicate data is minimized.
- Data integrity is enforced through constraints.
- Schemas separate different business domains.

---

# Naming Conventions

Schemas:

```text
hr

sales

inventory

finance
```

Tables:

```text
employees

departments

customers

orders

products
```

Columns:

```text
employee_id

department_id

product_name

order_date
```

---

# Why We Use One Database

Using one consistent database provides several advantages:

- Examples build on previous chapters.
- Relationships remain consistent.
- Joins become more meaningful.
- Queries resemble real business scenarios.
- Readers can follow a complete project from start to finish.

---

# Future Chapters

The next chapters will progressively build this database.

Order:

1. Create schemas
2. Create tables
3. Add constraints
4. Insert sample data
5. Query data
6. Build reports
7. Optimize performance

---

# Summary

The `company_db` database will serve as the foundation for every SQL lesson in this repository. By working with a realistic database design, you will gain experience that closely matches real-world SQL development.
