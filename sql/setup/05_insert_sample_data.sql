/*
============================================================
 PostgreSQL Complete Mastery Course
 Company Database
 File: 05_insert_sample_data.sql
============================================================
*/

-- ==========================================================
-- HR SCHEMA
-- ==========================================================

-- Departments

INSERT INTO hr.departments (department_name, location)
VALUES
('Human Resources', 'New Delhi'),
('Finance', 'Mumbai'),
('Sales', 'Bengaluru'),
('IT', 'Hyderabad'),
('Marketing', 'Pune');

------------------------------------------------------------

-- Jobs

INSERT INTO hr.jobs (job_title, min_salary, max_salary)
VALUES
('MIS Executive', 30000, 60000),
('Data Analyst', 50000, 90000),
('HR Manager', 60000, 100000),
('Software Engineer', 70000, 150000),
('Sales Executive', 25000, 70000);

------------------------------------------------------------

-- Employees

INSERT INTO hr.employees
(
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    salary,
    department_id,
    job_id
)
VALUES
('Rahul','Sharma','rahul.sharma@company.com','9876543210','2022-01-15',55000,4,4),

('Priya','Verma','priya.verma@company.com','9876543211','2021-06-10',72000,2,2),

('Amit','Kumar','amit.kumar@company.com','9876543212','2023-03-20',42000,1,1),

('Neha','Singh','neha.singh@company.com','9876543213','2020-09-12',68000,3,5),

('Rohit','Gupta','rohit.gupta@company.com','9876543214','2019-11-18',95000,4,4);

-- ==========================================================
-- INVENTORY SCHEMA
-- ==========================================================

INSERT INTO inventory.categories (category_name)
VALUES
('Laptops'),
('Accessories'),
('Monitors'),
('Networking'),
('Storage');

------------------------------------------------------------

INSERT INTO inventory.suppliers
(
supplier_name,
contact_name,
email,
phone
)
VALUES
('Dell India','Amit Mehra','amit@dell.com','9811111111'),
('HP India','Riya Sharma','riya@hp.com','9822222222'),
('Lenovo India','Karan Gupta','karan@lenovo.com','9833333333');

------------------------------------------------------------

INSERT INTO inventory.products
(
product_name,
category_id,
supplier_id,
unit_price,
units_in_stock
)
VALUES
('Dell Latitude 5450',1,1,85000,45),

('HP EliteBook 840',1,2,92000,30),

('Lenovo ThinkPad E14',1,3,76000,52),

('Dell 24 Monitor',3,1,12000,80),

('Wireless Mouse',2,2,800,200),

('Keyboard',2,2,1200,180);

-- ==========================================================
-- SALES SCHEMA
-- ==========================================================

INSERT INTO sales.customers
(
first_name,
last_name,
email,
phone,
city,
country
)
VALUES
('Arjun','Kapoor','arjun@gmail.com','9991111111','Delhi','India'),

('Sneha','Mehta','sneha@gmail.com','9992222222','Mumbai','India'),

('Karan','Patel','karan@gmail.com','9993333333','Ahmedabad','India'),

('Pooja','Shah','pooja@gmail.com','9994444444','Pune','India');

------------------------------------------------------------

INSERT INTO sales.orders
(
customer_id,
order_date,
order_status
)
VALUES
(1,'2025-01-05','Completed'),

(2,'2025-01-10','Completed'),

(1,'2025-02-02','Pending'),

(3,'2025-02-18','Completed');

------------------------------------------------------------

INSERT INTO sales.order_items
(
order_id,
product_id,
quantity,
unit_price
)
VALUES
(1,1,1,85000),

(1,5,2,800),

(2,2,1,92000),

(3,6,3,1200),

(4,4,2,12000);

-- ==========================================================
-- FINANCE SCHEMA
-- ==========================================================

INSERT INTO finance.invoices
(
order_id,
invoice_date,
total_amount
)
VALUES
(1,'2025-01-05',86600),

(2,'2025-01-10',92000),

(4,'2025-02-18',24000);

------------------------------------------------------------

INSERT INTO finance.payments
(
invoice_id,
payment_date,
payment_method,
amount
)
VALUES
(1,'2025-01-06','UPI',86600),

(2,'2025-01-11','Credit Card',92000),

(3,'2025-02-19','Bank Transfer',24000);
