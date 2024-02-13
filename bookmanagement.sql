CREATE DATABASE IF NOT EXISTS bookstoremanagement;
USE bookstoremanagement;
-- DIFFERENT TABLES CREATED AS PER THE ASSIGNMENT 
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(500) NOT NULL
);
CREATE TABLE IF NOT EXISTS  Books (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(500) NOT NULL,
author_id INT,
genre VARCHAR(200),
price DECIMAL(10, 2),
quantity_available INT,
FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);
CREATE TABLE IF NOT EXISTS  Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE  IF NOT EXISTS Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity_ordered INT,
    -- LINKING
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
INSERT INTO  Authors
(author_name) 
VALUES
('Author A'),
('Author B'),
('Author C');
INSERT INTO Books 
(title, author_id, genre, price, quantity_available)
 VALUES
('Book 1',1,'Fiction',20.00,100),
('Book 2',2,'Non-Fiction',25.50,150),
('Book 3',3,'Science Fiction',18.75,120);
INSERT INTO Customers 
(customer_name, email, phone_number) 
VALUES
('Debajyoti', 'deba9862@gmail.com', '1234555678'),
('Debarjita', 'debarjita455@gmail.com', '2234557789');
-- Insert Sample Orders
INSERT INTO Orders 
(customer_id, order_date, total_price) 
VALUES
(1,'2023-01-15',45.50),
(2,'2023-02-20',35.25);
-- Insert Sample Order Items
INSERT INTO Order_Items
(order_id, book_id, quantity_ordered) 
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 3);
-- Top-Selling Books
SELECT b.title, a.author_name, SUM(oi.quantity_ordered) AS total_sold
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Order_Items oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC
LIMIT 10;
-- Calculate Total Sales Revenue for a Given Period
SELECT SUM(o.total_price) AS total_revenue
FROM Orders o
WHERE o.order_date >= '2023-01-01' AND o.order_date <= '2023-03-31';