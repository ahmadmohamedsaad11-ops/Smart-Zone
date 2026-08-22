use smart_zone
-------------------------------------------------------------------------
-- Base Sales Dataset: Products, Sale Details & Sales
SELECT
p.product_id,
p.product_name,
p.brand,
p.category,

sd.sale_id,
sd.quantity,
sd.discount,
sd.unit_price,
sd.unit_cost,

s.sale_date,
s.payment_method,
s.order_status,
s.customer_id,
s.store_id,
s.employee_id

FROM Products AS p
JOIN SaleDetails AS sd
ON p.product_id = sd.product_id
JOIN Sales AS s
ON s.sale_id = sd.sale_id;

----------------------------
-- Product Performance: Total Quantity, Revenue, Cost & Profit

SELECT
p.product_id,
p.product_name,

SUM( sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount) ) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Products AS p

JOIN SaleDetails AS sd
ON p.product_id = sd.product_id

GROUP BY
p.product_id,
p.product_name

ORDER BY total_profit DESC;

---------------------------------------
-- Category Performance: Total Quantity, Revenue, Cost & Profit

SELECT
p.category,

SUM(sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount)) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Products AS p
JOIN SaleDetails AS sd
ON p.product_id = sd.product_id

GROUP BY p.category
ORDER BY total_profit DESC;

------------------------------------------
-- Brand Performance: Total Quantity, Revenue, Cost & Profit

SELECT
p.brand,
SUM(sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount)) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Products AS p
JOIN SaleDetails AS sd
ON p.product_id = sd.product_id
GROUP BY p.brand
ORDER BY total_profit DESC;

--------------------------------------------------
-- Store Performance: Total Orders, Quantity, Revenue, Cost & Profit

SELECT
st.store_id,
st.store_name,
st.city,
COUNT(DISTINCT s.sale_id) AS total_orders,
SUM(sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount)) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Stores AS st
JOIN Sales AS s
ON st.store_id = s.store_id
JOIN SaleDetails AS sd
ON s.sale_id = sd.sale_id
GROUP BY st.store_id , st.store_name , st.city
ORDER BY total_profit DESC;

------------------------------------------------
-- Employee Performance: Total Orders, Quantity, Revenue, Cost & Profit

SELECT
e.employee_id,
e.name,

COUNT(DISTINCT s.sale_id) AS total_orders,
SUM(sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount)) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Employees AS e
JOIN Sales AS s
ON e.employee_id = s.employee_id
JOIN SaleDetails AS sd
ON s.sale_id = sd.sale_id
GROUP BY
e.employee_id,
e.name
ORDER BY total_profit DESC;

------------------------------------------
-- Customer Performance: Total Orders, Quantity, Revenue, Cost & Profit

SELECT
c.customer_id,
c.name,
c.gender,
c.age,
c.city,

COUNT(DISTINCT s.sale_id) AS total_orders,
SUM(
sd.quantity) AS total_quantity,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount)) AS total_revenue,
SUM(sd.quantity * sd.unit_cost) AS total_cost,
SUM(sd.quantity * sd.unit_price * (1 - sd.discount))
    -
SUM(sd.quantity * sd.unit_cost) AS total_profit
FROM Customers AS c
JOIN Sales AS s
ON c.customer_id = s.customer_id
JOIN SaleDetails AS sd
ON s.sale_id = sd.sale_id

GROUP BY
c.customer_id,
c.name,
c.gender,
c.age,
c.city

ORDER BY total_profit DESC;
----------------------------------
-- Products Above Average Quantity
SELECT
p.product_id,
p.product_name,
SUM(sd.quantity) AS total_quantity
FROM Products AS p
JOIN SaleDetails AS sd
ON p.product_id = sd.product_id

GROUP BY
p.product_id,
p.product_name

HAVING
SUM(sd.quantity) >
(SELECT AVG(sd2.quantity)
FROM SaleDetails AS sd2)

ORDER BY total_quantity DESC;
    -----------------------------------------