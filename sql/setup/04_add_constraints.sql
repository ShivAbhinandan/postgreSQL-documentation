/*
============================================================
 PostgreSQL Complete Mastery Course
 Company Database
 File: 04_add_constraints.sql
============================================================
*/

-- ==========================================================
-- HR SCHEMA
-- ==========================================================

ALTER TABLE hr.departments
ADD CONSTRAINT uq_department_name
UNIQUE (department_name);

ALTER TABLE hr.jobs
ADD CONSTRAINT chk_salary_range
CHECK (min_salary <= max_salary);

ALTER TABLE hr.employees

ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES hr.departments(department_id);

ALTER TABLE hr.employees

ADD CONSTRAINT fk_employee_job
FOREIGN KEY (job_id)
REFERENCES hr.jobs(job_id);

ALTER TABLE hr.employees

ADD CONSTRAINT chk_employee_salary
CHECK (salary >= 0);

-- ==========================================================
-- INVENTORY SCHEMA
-- ==========================================================

ALTER TABLE inventory.categories

ADD CONSTRAINT uq_category_name
UNIQUE (category_name);

ALTER TABLE inventory.suppliers

ADD CONSTRAINT uq_supplier_email
UNIQUE (email);

ALTER TABLE inventory.products

ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id)
REFERENCES inventory.categories(category_id);

ALTER TABLE inventory.products

ADD CONSTRAINT fk_product_supplier
FOREIGN KEY (supplier_id)
REFERENCES inventory.suppliers(supplier_id);

ALTER TABLE inventory.products

ADD CONSTRAINT chk_unit_price
CHECK (unit_price >= 0);

ALTER TABLE inventory.products

ADD CONSTRAINT chk_stock
CHECK (units_in_stock >= 0);

-- ==========================================================
-- SALES SCHEMA
-- ==========================================================

ALTER TABLE sales.customers

ADD CONSTRAINT uq_customer_email
UNIQUE (email);

ALTER TABLE sales.orders

ADD CONSTRAINT fk_order_customer
FOREIGN KEY (customer_id)
REFERENCES sales.customers(customer_id);

ALTER TABLE sales.order_items

ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES sales.orders(order_id);

ALTER TABLE sales.order_items

ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id)
REFERENCES inventory.products(product_id);

ALTER TABLE sales.order_items

ADD CONSTRAINT chk_quantity
CHECK (quantity > 0);

ALTER TABLE sales.order_items

ADD CONSTRAINT chk_order_price
CHECK (unit_price >= 0);

-- ==========================================================
-- FINANCE SCHEMA
-- ==========================================================

ALTER TABLE finance.invoices

ADD CONSTRAINT fk_invoice_order
FOREIGN KEY (order_id)
REFERENCES sales.orders(order_id);

ALTER TABLE finance.payments

ADD CONSTRAINT fk_payment_invoice
FOREIGN KEY (invoice_id)
REFERENCES finance.invoices(invoice_id);

ALTER TABLE finance.payments

ADD CONSTRAINT chk_payment_amount
CHECK (amount >= 0);
