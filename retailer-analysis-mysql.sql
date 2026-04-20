CREATE DATABASE retail_db;
USE retail_db;

-- Customers --
CREATE TABLE customers (
customers_id INT PRIMARY KEY,
user_name VARCHAR(50),
city VARCHAR(50)
);

-- Products --
CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
category VARCHAR(50),
price DECIMAL(10,2)
);
-- Orders --
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customers_id)
);
-- Order_Items --
CREATE TABLE order_items (
order_id INT,
product_id INT,
quantity INT,
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Insert into Customers --
INSERT INTO  customers VALUES
(1,'Abhishek','Narayanpur'),
(2,'Ayush','Bhagalpur'),
(3,'Aryan','Patna');
INSERT INTO  customers VALUES
(4,'Saurabh','Varanasi');
-- Inser into Products --
INSERT INTO products VALUES
(1,'Laptop','Electronics',5000),
(2,'Mouse','Electronics',500),
(3,'Keyboard','Electronics',5000),
(4,'T-shirt','Clothing',800),
(5,'Jeans','Clothing',2000),
(6,'Notebook','Stationery',100),
(7,'pen','Stationery',20),
(8,'Book-Java','Books',600),
(9,'Book-SQL','Books',700);

-- Inserting orders --
INSERT INTO orders VALUES
(101,1,'2026-01-01'),
(102,2,'2026-02-01'),
(103,1,'2026-03-01'),
(104,3,'2026-03-10');

-- Inserting order_Items --
INSERT INTO order_items VALUES
(101,1,1),
(101,4,2),
(101,6,5),
(102,2,3),
(102,8,2),
(103,3,1),
(103,9,1),
(104,5,1),
(104,8,1);
-- check data
SELECT*FROM customers;
SELECT*FROM products;
SELECT*FROM orders;
SELECT*FROM order_items;

-- 1.Top Selling Products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM  order_items AS oi
INNER JOIN products AS p 
ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Most Valuable Customer
SELECT  c.user_name, SUM(p.price* oi.quantity) AS total_spent
FROM  customers AS c
JOIN orders AS o ON c.customer_id=o.customer_id
JOIN order_items AS oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
GROUP BY c.user_name
ORDER BY total_spent DESC;

-- Monthly revenue calculation
SELECT MONTHNAME(o.order_date) AS order_month,SUM(p.price*oi.quantity) as revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id=oi.order_id
JOIN products AS p ON oi.product_id =p.product_id
GROUP BY  order_month;
 
 -- Category_wise sales analysis
 SELECT p.category ,SUM(oi.quantity) AS total_sold_items
 FROM  order_items AS oi
 JOIN products AS p ON oi.product_id=p.product_id
 GROUP BY p.category;
 
 -- Inactive Customers
 SELECT c.user_name
 FROM customers AS c
 LEFT JOIN orders AS o 
 ON c.customer_id =o.customer_id
 where o.order_id IS NULL;



