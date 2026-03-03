-- Bookstore Database Schema

-- Create Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BookstoreDB')
BEGIN
    CREATE DATABASE BookstoreDB;
END
GO

USE BookstoreDB;
GO

-- Create Users Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        UserID INT PRIMARY KEY IDENTITY(1,1),
        Username NVARCHAR(50) UNIQUE NOT NULL,
        Email NVARCHAR(100) UNIQUE NOT NULL,
        Password NVARCHAR(MAX) NOT NULL,
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        PhoneNumber NVARCHAR(15),
        Address NVARCHAR(200),
        City NVARCHAR(50),
        State NVARCHAR(50),
        ZipCode NVARCHAR(10),
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create Books Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Books')
BEGIN
    CREATE TABLE Books (
        BookID INT PRIMARY KEY IDENTITY(1,1),
        Title NVARCHAR(200) NOT NULL,
        Author NVARCHAR(100) NOT NULL,
        Description NVARCHAR(MAX),
        Price DECIMAL(10,2) NOT NULL,
        Category NVARCHAR(50),
        ISBN NVARCHAR(20) UNIQUE,
        PublishedDate DATETIME,
        Stock INT DEFAULT 0,
        ImageURL NVARCHAR(500),
        Rating DECIMAL(3,2) DEFAULT 0,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create Cart Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Cart')
BEGIN
    CREATE TABLE Cart (
        CartID INT PRIMARY KEY IDENTITY(1,1),
        UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
        BookID INT NOT NULL FOREIGN KEY REFERENCES Books(BookID),
        Quantity INT DEFAULT 1,
        AddedDate DATETIME DEFAULT GETDATE(),
        UNIQUE(UserID, BookID)
    );
END
GO

-- Create Wishlist Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Wishlist')
BEGIN
    CREATE TABLE Wishlist (
        WishlistID INT PRIMARY KEY IDENTITY(1,1),
        UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
        BookID INT NOT NULL FOREIGN KEY REFERENCES Books(BookID),
        AddedDate DATETIME DEFAULT GETDATE(),
        UNIQUE(UserID, BookID)
    );
END
GO

-- Create Orders Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders')
BEGIN
    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY IDENTITY(1,1),
        UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
        OrderDate DATETIME DEFAULT GETDATE(),
        TotalAmount DECIMAL(10,2) NOT NULL,
        Status NVARCHAR(20) DEFAULT 'Pending',
        ShippingAddress NVARCHAR(200),
        ShippingCity NVARCHAR(50),
        ShippingState NVARCHAR(50),
        ShippingZipCode NVARCHAR(10),
        DeliveryDate DATETIME,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create OrderDetails Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'OrderDetails')
BEGIN
    CREATE TABLE OrderDetails (
        OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
        OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
        BookID INT NOT NULL FOREIGN KEY REFERENCES Books(BookID),
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(10,2) NOT NULL,
        TotalPrice DECIMAL(10,2) NOT NULL
    );
END
GO

-- Insert Sample Books
INSERT INTO Books (Title, Author, Description, Price, Category, ISBN, PublishedDate, Stock, Rating)
VALUES 
    ('The Great Gatsby', 'F. Scott Fitzgerald', 'A classic American novel', 12.99, 'Fiction', '978-0-7432-7356-5', '1925-04-10', 50, 4.5),
    ('To Kill a Mockingbird', 'Harper Lee', 'A gripping tale of racial injustice', 14.99, 'Fiction', '978-0-06-112008-4', '1960-07-11', 40, 4.7),
    ('1984', 'George Orwell', 'A dystopian social science fiction novel', 13.99, 'Science Fiction', '978-0-451-52494-2', '1949-06-08', 35, 4.6),
    ('Pride and Prejudice', 'Jane Austen', 'A romantic novel of manners', 11.99, 'Romance', '978-0-14-143951-8', '1813-01-28', 45, 4.8),
    ('The Catcher in the Rye', 'J.D. Salinger', 'A story of teenage rebellion', 10.99, 'Fiction', '978-0-316-76948-0', '1951-07-16', 30, 4.2);
GO

-- Create Indexes for better performance
CREATE INDEX IDX_Cart_UserID ON Cart(UserID);
CREATE INDEX IDX_Wishlist_UserID ON Wishlist(UserID);
CREATE INDEX IDX_Orders_UserID ON Orders(UserID);
CREATE INDEX IDX_OrderDetails_OrderID ON OrderDetails(OrderID);
CREATE INDEX IDX_Books_Category ON Books(Category);
 