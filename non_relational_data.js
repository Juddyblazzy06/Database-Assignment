use('ProductManagementSystem');

// Create empty collections
db.createCollection("Roles");
db.createCollection("Users");
db.createCollection("Category");
db.createCollection("Products");
db.createCollection("Orders");
db.createCollection("OrderDetails");

// Insert records into Roles
db.Roles.insertMany([
    { Role_id: 1, Role_name: "Admin", Permission: "Full Access" },
    { Role_id: 2, Role_name: "Customer", Permission: "View Only" },
    
]);

// Insert records into Users
db.Users.insertMany([
    { User_id: 1, Full_name: "Alice Johnson", Email: "alice@example.com", Password: "password123", Role_id: 1 },
    { User_id: 2, Full_name: "Bob Smith", Email: "bob@example.com", Password: "password456", Role_id: 2 },
    { User_id: 3, Full_name: "Charlie Brown", Email: "charlie@example.com", Password: "password789", Role_id: 3 }
]);

// Insert records into Category
db.Category.insertMany([
    { Category_id: 1, Category_Name: "Electronics", Description: "Electronic items" },
    { Category_id: 2, Category_Name: "Clothing", Description: "Apparel and fashion" },
    { Category_id: 3, Category_Name: "Books", Description: "Printed and digital books" }
]);

// Insert records into Products
db.Products.insertMany([
    { Product_id: 1, Category_id: 1, Product_name: "Smartphone", Price: 699.99, Quantity: 50, Size: "6.5 inch" },
    { Product_id: 2, Category_id: 2, Product_name: "T-Shirt", Price: 19.99, Quantity: 200, Size: "Medium" },
    { Product_id: 3, Category_id: 3, Product_name: "Novel", Price: 14.99, Quantity: 100, Size: "300 pages" }
]);

// Insert records into Orders
db.Orders.insertMany([
    { Order_id: 1, User_id: 2, Order_date: new Date("2024-11-01T10:00:00") },
    { Order_id: 2, User_id: 3, Order_date: new Date("2024-11-02T12:00:00") },
    { Order_id: 3, User_id: 2, Order_date: new Date("2024-11-03T14:00:00") }
]);

// Insert records into OrderDetails
db.OrderDetails.insertMany([
    { orderdetail_id: 1, Order_id: 1, Product_id: 1, Order_quantity: 1, Status: "Pending" },
    { orderdetail_id: 2, Order_id: 2, Product_id: 2, Order_quantity: 3, Status: "Shipping" },
    { orderdetail_id: 3, Order_id: 3, Product_id: 3, Order_quantity: 2, Status: "Delivered" }
]);



db.Orders.aggregate([
    {
        $lookup: {
            from: "Users",
            localField: "User_id",
            foreignField: "User_id",
            as: "UserDetails"
        }
    }
]);

db.Products.updateOne(
    { Product_id: 1 }, // Product to update
    { $inc: { Quantity: -1 } } // Decrease quantity by 1
);

db.OrderDetails.updateOne(
    { orderdetail_id: 1 }, // Order detail to update
    { $set: { Status: "Shipping" } } // Update status
);

// Delete the order details
db.OrderDetails.deleteMany({ Order_id: 1 });

// Delete the order
db.Orders.deleteOne({ Order_id: 1 });

