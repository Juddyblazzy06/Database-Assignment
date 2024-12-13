# Inventory Management System

## Overview

This project involves the design and implementation of a database system for an Inventory Management System using both SQL and NoSQL (MongoDB). The system manages users, roles, categories, products, orders, and order details, ensuring data consistency and supporting CRUD operations.

## Features

- **Entities and Relationships**:
  - Users have roles and place orders.
  - Products belong to categories and are included in orders.
  - Order details track product quantities and statuses for each order.
- **SQL Implementation**:
  - Schema design with primary keys, foreign keys, and constraints.
  - Data insertion, updates, deletions, and retrieval using SQL queries.
- **MongoDB Implementation**:
  - Document-based design for flexibility.
  - Operations to insert, update, delete, and query records using aggregations and lookups.

## Technologies Used

- MySQL for relational database implementation.
- MongoDB for NoSQL database implementation.

## Files

1. **SQL Schema**:

   - Contains the `CREATE TABLE` commands for all entities.
   - Foreign key constraints are embedded directly in table definitions.
   - Includes sample SQL queries for CRUD operations and joins.

2. **MongoDB Script**:

   - Shows the structure and creation of collections.
   - Includes commands for CRUD operations and querying with `lookup` for multi-collection queries.

## SQL Commands

- **Schema Creation**: Includes tables for `Users`, `Roles`, `Category`, `Products`, `Orders`, and `Order_details`.
- **Insert Records**: Commands to populate entities with sample data.
- **Retrieve Records**: Demonstrates joins for querying related data across multiple tables.
- **Update Records**: Updates information in related tables using cascading constraints.
- **Delete Records**: Shows cascading deletes to maintain referential integrity.

## MongoDB Commands

- **Collection Creation**: JSON-style documents for each entity.
- **Insert Records**: Adds sample data to collections.
- **Retrieve Records**: Uses aggregation pipelines with `$lookup` for joining collections.
- **Update Records**: Updates multiple documents using `updateMany`.
- **Delete Records**: Removes specific documents or many documents matching a condition.

## Sample Queries

### SQL Examples

- Retrieve all products with their categories:

  ```sql
  SELECT p.Product_name, c.Category_Name
  FROM Products p
  JOIN Category c ON p.Category_id = c.Category_id;
  ```

- Retrieve orders with user details:

  ```sql
  SELECT o.Order_id, u.Full_name, o.Order_date
  FROM Orders o
  JOIN Users u ON o.User_id = u.User_id;
  ```

### MongoDB Examples

- Retrieve orders with user details:

  ```javascript code
  db.orders.aggregate([
    {
      $lookup: {
        from: 'users',
        localField: 'User_id',
        foreignField: 'User_id',
        as: 'userDetails',
      },
    },
  ])
  ```

- Retrieve products with their categories:

  ```javascript code
  db.products.aggregate([
    {
      $lookup: {
        from: 'categories',
        localField: 'Category_id',
        foreignField: 'Category_id',
        as: 'categoryDetails',
      },
    },
  ])
  ```

## How to Run

### MySQL

1. Create the database using the `CREATE DATABASE` command.
2. Execute the SQL script to create tables and populate them with sample data.
3. Run SQL queries to perform CRUD operations.

### MongoDB

1. Use the provided scripts to create collections and insert sample data.
2. Execute MongoDB commands in the shell or a GUI like MongoDB Compass to query and manipulate data.

## Conclusion

This project demonstrates a dual implementation of an Inventory Management System using SQL and NoSQL, showcasing best practices in database design, data manipulation, and querying techniques.
