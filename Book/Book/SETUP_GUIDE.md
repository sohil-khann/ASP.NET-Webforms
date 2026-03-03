# Bookstore Application - Setup & Deployment Guide

## 🚀 Quick Start

### Prerequisites
- Visual Studio 2019 or later
- SQL Server 2012 or later
- .NET Framework 4.8

### Installation Steps

#### 1. Database Setup
1. Open SQL Server Management Studio
2. Open the file `Database/BookstoreDB.sql`
3. Execute the script to create the database with all tables and sample data

#### 2. Update Connection String
1. Open `Web.config`
2. Update the connection string if needed:
```xml
<add key="ConnectionString" value="Server=.; Database=BookstoreDB; Integrated Security=true;" />
```

#### 3. Build the Project
1. Open the solution in Visual Studio
2. Build the solution (Ctrl + Shift + B)
3. Resolve any NuGet dependencies if needed

#### 4. Run the Application
1. Set the project as the startup project
2. Press F5 or click Start
3. The application will open in your default browser

## 📋 Default Sample Data

The database comes with 5 sample books:
- **The Great Gatsby** by F. Scott Fitzgerald - $12.99
- **To Kill a Mockingbird** by Harper Lee - $14.99
- **1984** by George Orwell - $13.99
- **Pride and Prejudice** by Jane Austen - $11.99
- **The Catcher in the Rye** by J.D. Salinger - $10.99

## 🔐 User Authentication

- Users must register before placing orders
- Passwords are securely hashed using SHA256
- Session-based authentication with Forms Authentication
- Auto-login after registration

## 📱 Application Features

### User Management
- Register with email validation
- Secure login with hashed passwords
- Profile management (update address, contact info)
- Change password functionality

### Shopping Features
- Browse books with categories
- Search by title or author
- Add to cart with quantity management
- Wishlist for saving favorite books
- Real-time cart and wishlist counters

### Ordering
- Shopping cart with tax calculation (10%)
- Checkout with shipping address
- Order confirmation with order ID
- Order history in GridView
- View order details
- Cancel pending orders

## 🗄️ Database Structure

### Tables
- **Users** - User account information
- **Books** - Book catalog
- **Cart** - Shopping cart items (per user)
- **Wishlist** - Wishlist items (per user)
- **Orders** - Order header information
- **OrderDetails** - Order line items

## 🔧 Configuration

### Web.config Settings
```xml
<appSettings>
    <add key="ConnectionString" value="Server=.; Database=BookstoreDB; Integrated Security=true;" />
</appSettings>
```

### Authentication
- Mode: Forms
- Login URL: ~/Login.aspx
- Requires login for cart, wishlist, and checkout

## 📊 Admin Features (Future)

Currently, all books are loaded from the database. To add admin functionality:
1. Add an `isAdmin` field to Users table
2. Create admin pages for managing books
3. Implement inventory management

## 🐛 Troubleshooting

### Connection String Issues
- Verify SQL Server is running
- Check database name matches `BookstoreDB`
- Ensure integrated security or use SQL authentication

### Page Not Found Errors
- Ensure all .aspx files are in the root directory
- Check Master.Master path in @Page directives

### Cart Not Working
- Verify UserID is in session
- Check CartManager queries in SQL Server

## 📈 Performance Optimization

The application includes:
- Index on UserID in Cart, Wishlist, Orders
- Index on Category in Books
- Parameterized queries to prevent SQL injection
- Transaction support for order processing

## 🔒 Security Features

1. **Password Security**
   - SHA256 hashing for all passwords
   - No plaintext passwords stored

2. **SQL Injection Prevention**
   - All queries use SqlParameter objects
   - No concatenated SQL strings

3. **Session Management**
   - Forms authentication
   - Session-based user tracking

4. **Validation**
   - Client-side and server-side validation
   - Required field validators
   - Email format validation

## 📞 Support

For issues or questions:
1. Check the README.md in the project root
2. Review the code comments in BLL classes
3. Verify database structure in SQL Server

## 🚢 Deployment

### To Azure App Service:
1. Right-click project > Publish
2. Choose Azure App Service
3. Create new service or select existing
4. Update connection string in Azure Application Settings
5. Publish

### To IIS:
1. Publish using Web Deploy
2. Ensure .NET Framework 4.8 is installed on server
3. Create SQL Server database on target server
4. Update web.config connection string
5. Set application pool to Classic mode (recommended for WebForms)

## 📝 License

This is a demonstration project for learning ASP.NET WebForms with SQL Server.

---

**Last Updated**: 2024
**Framework**: ASP.NET WebForms (.NET Framework 4.8)
**Database**: SQL Server
