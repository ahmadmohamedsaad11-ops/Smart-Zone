USE smart_zone;


# نسخه احتياطيه
CREATE TABLE sales_raw AS
SELECT *
FROM sales;


SELECT COUNT(*) AS total_rows
FROM sales;

DESCRIBE sales;


SELECT
    SUM(sale_id IS NULL) AS null_sale_id,
    SUM(sale_date IS NULL) AS null_sale_date,
    SUM(payment_method IS NULL OR TRIM(payment_method) = '') AS bad_payment_method,
    SUM(order_status IS NULL OR TRIM(order_status) = '') AS bad_order_status,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(store_id IS NULL) AS null_store_id,
    SUM(employee_id IS NULL) AS null_employee_id
FROM sales;


SELECT sale_id, COUNT(*) AS cnt
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1;



SELECT DISTINCT payment_method
FROM sales;

SELECT DISTINCT order_status
FROM sales;



SELECT s.*
FROM sales s
LEFT JOIN customers c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT s.*
FROM sales s
LEFT JOIN stores st
    ON s.store_id = st.store_id
WHERE st.store_id IS NULL;

SELECT s.*
FROM sales s
LEFT JOIN employees e
    ON s.employee_id = e.employee_id
WHERE e.employee_id IS NULL;



#PAYMENT METHOD CLEANING
SELECT
    payment_method AS old_value,
    CASE
        WHEN LOWER(TRIM(payment_method)) LIKE 'credit card%' THEN 'Credit Card'
        WHEN LOWER(TRIM(payment_method)) LIKE 'debit card%' THEN 'Debit Card'
        WHEN LOWER(TRIM(payment_method)) LIKE 'cash%' THEN 'Cash'
        WHEN LOWER(TRIM(payment_method)) LIKE 'mobile wallet%' THEN 'Mobile Wallet'
        WHEN LOWER(TRIM(payment_method)) LIKE 'installment%' THEN 'Installment'
        WHEN payment_method IS NULL
             OR TRIM(payment_method) = '' THEN 'Unknown'
        ELSE 'Unknown'
    END AS new_value
FROM sales
GROUP BY payment_method;


UPDATE sales
SET payment_method =
    CASE
        WHEN LOWER(TRIM(payment_method)) LIKE 'credit card%' THEN 'Credit Card'
        WHEN LOWER(TRIM(payment_method)) LIKE 'debit card%' THEN 'Debit Card'
        WHEN LOWER(TRIM(payment_method)) LIKE 'cash%' THEN 'Cash'
        WHEN LOWER(TRIM(payment_method)) LIKE 'mobile wallet%' THEN 'Mobile Wallet'
        WHEN LOWER(TRIM(payment_method)) LIKE 'installment%' THEN 'Installment'
        WHEN payment_method IS NULL
             OR TRIM(payment_method) = '' THEN 'Unknown'
        ELSE 'Unknown'
    END;

SELECT DISTINCT payment_method
FROM sales;












#ORDER STATUS CLEANING
SELECT
    order_status AS old_value,
    CASE
        WHEN LOWER(TRIM(order_status)) LIKE 'complete%' THEN 'Completed'
        WHEN LOWER(TRIM(order_status)) LIKE 'cancel%' THEN 'Cancelled'
        WHEN LOWER(TRIM(order_status)) LIKE 'return%' THEN 'Returned'
        WHEN LOWER(TRIM(order_status)) LIKE 'pending%' THEN 'Pending'
        WHEN order_status IS NULL
             OR TRIM(order_status) = '' THEN 'Unknown'
        ELSE 'Unknown'
    END AS new_value
FROM sales
GROUP BY order_status;


UPDATE sales
SET order_status =
    CASE
        WHEN LOWER(TRIM(order_status)) LIKE 'complete%' THEN 'Completed'
        WHEN LOWER(TRIM(order_status)) LIKE 'cancel%' THEN 'Cancelled'
        WHEN LOWER(TRIM(order_status)) LIKE 'return%' THEN 'Returned'
        WHEN LOWER(TRIM(order_status)) LIKE 'pending%' THEN 'Pending'
        WHEN order_status IS NULL
             OR TRIM(order_status) = '' THEN 'Unknown'
        ELSE 'Unknown'
    END;
    
SELECT DISTINCT order_status
FROM sales;


#------------
SELECT COUNT(*) AS total_rows
FROM sales;



SELECT
    SUM(sale_id IS NULL) AS null_sale_id,
    SUM(sale_date IS NULL) AS null_sale_date,
    SUM(payment_method IS NULL OR TRIM(payment_method) = '') AS bad_payment_method,
    SUM(order_status IS NULL OR TRIM(order_status) = '') AS bad_order_status,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(store_id IS NULL) AS null_store_id,
    SUM(employee_id IS NULL) AS null_employee_id
FROM sales;


#-----------------

SELECT DISTINCT payment_method
FROM sales;

SELECT DISTINCT order_status
FROM sales;












#----------------------------------------TABLE STORE

SELECT * FROM stores;

CREATE TABLE stores_raw AS
SELECT *
FROM stores;



DESCRIBE stores;

SELECT COUNT(*) AS total_rows
FROM stores;



SELECT
    SUM(store_id IS NULL) AS null_store_id,
    SUM(store_name IS NULL OR TRIM(store_name) = '') AS bad_store_name,
    SUM(city IS NULL OR TRIM(city) = '') AS bad_city,
    SUM(opening_date IS NULL) AS null_opening_date
FROM stores;

SELECT store_id, COUNT(*) AS cnt
FROM stores
GROUP BY store_id
HAVING COUNT(*) > 1;

SELECT DISTINCT city
FROM stores;


SELECT e.*
FROM employees e
LEFT JOIN stores s
    ON e.store_id = s.store_id
WHERE s.store_id IS NULL;


#----------------------------------------------------


SELECT * FROM customers;

SELECT * FROM employees;

SELECT * FROM products;

SELECT * FROM stores;

SELECT * FROM sales;

SELECT * FROM sale_details;
