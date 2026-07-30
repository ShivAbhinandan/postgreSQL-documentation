/*
============================================================
 PostgreSQL Complete Mastery Course
 Company Database
 File: 03_create_tables.sql
============================================================
*/

-- ==========================================================
-- HR SCHEMA
-- ==========================================================

CREATE TABLE hr.departments
(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE hr.jobs
(
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    min_salary NUMERIC(10,2),
    max_salary NUMERIC(10,2)
);

CREATE TABLE hr.employees
(
    employee_id SERIAL PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    email VARCHAR(150) UNIQUE NOT NULL,

    phone_number VARCHAR(20),

    hire_date DATE NOT NULL,

    salary NUMERIC(10,2) NOT NULL,

    department_id INTEGER,

    job_id INTEGER
);

-- ==========================================================
-- INVENTORY SCHEMA
-- ==========================================================

CREATE TABLE inventory.categories
(
    category_id SERIAL PRIMARY KEY,

    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE inventory.suppliers
(
    supplier_id SERIAL PRIMARY KEY,

    supplier_name VARCHAR(150) NOT NULL,

    contact_name VARCHAR(100),

    email VARCHAR(150),

    phone VARCHAR(20)
);

CREATE TABLE inventory.products
(
    product_id SERIAL PRIMARY KEY,

    product_name VARCHAR(200) NOT NULL,

    category_id INTEGER,

    supplier_id INTEGER,

    unit_price NUMERIC(10,2),

    units_in_stock INTEGER
);

-- ==========================================================
-- SALES SCHEMA
-- ==========================================================

CREATE TABLE sales.customers
(
    customer_id SERIAL PRIMARY KEY,

    first_name VARCHAR(50),

    last_name VARCHAR(50),

    email VARCHAR(150),

    phone VARCHAR(20),

    city VARCHAR(100),

    country VARCHAR(100)
);

CREATE TABLE sales.orders
(
    order_id SERIAL PRIMARY KEY,

    customer_id INTEGER,

    order_date DATE,

    order_status VARCHAR(30)
);

CREATE TABLE sales.order_items
(
    order_item_id SERIAL PRIMARY KEY,

    order_id INTEGER,

    product_id INTEGER,

    quantity INTEGER,

    unit_price NUMERIC(10,2)
);

-- ==========================================================
-- FINANCE SCHEMA
-- ==========================================================

CREATE TABLE finance.invoices
(
    invoice_id SERIAL PRIMARY KEY,

    order_id INTEGER,

    invoice_date DATE,

    total_amount NUMERIC(12,2)
);

CREATE TABLE finance.payments
(
    payment_id SERIAL PRIMARY KEY,

    invoice_id INTEGER,

    payment_date DATE,

    payment_method VARCHAR(50),

    amount NUMERIC(12,2)
);
