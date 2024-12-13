CREATE DATABASE `Product Management System`; 
USE `Product Management System`; 

CREATE TABLE `Roles` (
    `Role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Role_name` VARCHAR(100) NOT NULL, 
    `Permission` VARCHAR(255) NOT NULL
);

CREATE TABLE `Users` (
    `User_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Full_name` VARCHAR(255) NOT NULL, 
    `Email` VARCHAR(255) NOT NULL UNIQUE, 
    `Password` VARCHAR(255) NOT NULL, 
    `Role_id` INT UNSIGNED NOT NULL, 
    FOREIGN KEY (`Role_id`) REFERENCES `Roles`(`Role_id`) ON DELETE CASCADE
);

CREATE TABLE `Category` (
    `Category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Category_Name` VARCHAR(255) NOT NULL, 
    `Description` VARCHAR(255) NOT NULL
);

CREATE TABLE `Products` (
    `Product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Category_id` INT UNSIGNED NOT NULL, 
    `Product_name` VARCHAR(255) NOT NULL, 
    `Price` FLOAT(53) NOT NULL, 
    `Quantity` BIGINT NOT NULL, 
    `Size` VARCHAR(255) NOT NULL, 
    FOREIGN KEY (`Category_id`) REFERENCES `Category`(`Category_id`) ON DELETE CASCADE
);

CREATE TABLE `Orders` (
    `Order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `User_id` INT UNSIGNED NOT NULL, 
    `Order_date` DATETIME NOT NULL, 
    FOREIGN KEY (`User_id`) REFERENCES `Users`(`User_id`) ON DELETE CASCADE
);

CREATE TABLE `Order_details` (
    `orderdetail_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Order_id` INT UNSIGNED NOT NULL, 
    `Product_id` INT UNSIGNED NOT NULL, 
    `Order_quantity` INT NOT NULL, 
    `Status` ENUM(
        'Pending', 
        'Shipping', 
        'Delivered', 
        'Failed'
    ) NOT NULL DEFAULT 'Pending', 
    FOREIGN KEY (`Order_id`) REFERENCES `Orders`(`Order_id`) ON DELETE CASCADE, 
    FOREIGN KEY (`Product_id`) REFERENCES `Products`(`Product_id`) ON DELETE CASCADE
);

-- Inserting into Roles
INSERT INTO `Roles` (`Role_name`, `Permission`) 
VALUES ('Admin', 'Full Access'),  
       ('Customer', 'View Only');

-- Inserting into Users
INSERT INTO `Users` (`Full_name`, `Email`, `Password`, `Role_id`) 
VALUES ('John Dame', 'johndame@gmail.com', 'password123', 2), 
       ('Jane Smith', 'janesmth@gmail.com', 'password456', 1), 
       ('Alex Bree', 'alexbre@gmail.com', 'password789', 2);

-- Inserting into Categories
INSERT INTO `Category` (`Category_Name`, `Description`) 
VALUES ('Electronics', 'Devices and Gadgets'), 
       ('Furniture', 'Home and Office Furniture'), 
       ('Clothing', 'Apparel and Accessories');

-- Inserting into Products
INSERT INTO `Products` (`Category_id`, `Product_name`, `Price`, `Quantity`, `Size`) 
VALUES (1, 'Laptop', 13900.00, 50, '15-inch'), 
       (2, 'Office Chair', 15000.00, 100, 'Medium'), 
       (3, 'T-Shirt', 1200.00, 200, 'Large');

-- Inserting into Orders
INSERT INTO `Orders` (`User_id`, `Order_date`) 
VALUES (1, NOW()), 
       (2, NOW()), 
       (3, NOW());

-- Inserting into Order_details
INSERT INTO `Order_details` (`Order_id`, `Product_id`, `Order_quantity`, `Status`) 
VALUES (1, 1, 2, 'Pending'), 
       (2, 2, 1, 'Shipping'), 
       (3, 3, 5, 'Delivered');


-- Fetch Orders and corresponding User details
SELECT o.Order_id, o.Order_date, u.Full_name, u.Email 
FROM `Orders` o 
JOIN `Users` u ON o.User_id = u.User_id;

-- Fetch Products with their Category details
SELECT p.Product_name, p.Price, c.Category_Name, c.Description 
FROM `Products` p 
JOIN `Category` c ON p.Category_id = c.Category_id;

-- Fetch Order details with Product and User details
SELECT od.Order_id, od.Order_quantity, od.Status, p.Product_name, u.Full_name
FROM `Order_details` od
JOIN `Products` p ON od.Product_id = p.Product_id
JOIN `Orders` o ON od.Order_id = o.Order_id
JOIN `Users` u ON o.User_id = u.User_id;

-- Fetch Users with their Role details
SELECT u.Full_name, u.Email, r.Role_name, r.Permission
FROM `Users` u
JOIN `Roles` r ON u.Role_id = r.Role_id;

-- Update Product Quantity based on Category
UPDATE `Products` p
JOIN `Category` c ON p.Category_id = c.Category_id
SET p.Quantity = p.Quantity - 10
WHERE c.Category_Name = 'Electronics';

-- Update User Role
UPDATE `Users` u
JOIN `Roles` r ON u.Role_id = r.Role_id
SET r.Permission = 'Updated Access'
WHERE u.Full_name = 'Jane Smith';

-- Delete an Order and its corresponding Order Details
DELETE od, o 
FROM `Orders` o
JOIN `Order_details` od ON o.Order_id = od.Order_id
WHERE o.Order_id = 1;

-- Delete Products and their Categories if the Category is "Clothing"
DELETE p, c 
FROM `Products` p
JOIN `Category` c ON p.Category_id = c.Category_id
WHERE c.Category_Name = 'Clothing';

-- Fetch all Order details along with User and Product information
SELECT o.Order_id, u.Full_name AS User, p.Product_name AS Product, od.Order_quantity, od.Status 
FROM `Order_details` od
JOIN `Orders` o ON od.Order_id = o.Order_id
JOIN `Users` u ON o.User_id = u.User_id
JOIN `Products` p ON od.Product_id = p.Product_id;

-- Fetch all Users and their Roles
SELECT u.Full_name, u.Email, r.Role_name, r.Permission 
FROM `Users` u 
JOIN `Roles` r ON u.Role_id = r.Role_id;

-- Fetch all Products and their Categories
SELECT p.Product_name, p.Price, p.Quantity, p.Size, c.Category_Name, c.Description
FROM `Products` p
JOIN `Category` c ON p.Category_id = c.Category_id;

