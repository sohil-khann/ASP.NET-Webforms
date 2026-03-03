

CREATE TABLE Products(
    ProductID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    ExpiryDate DATE,
    RequiresPrescription BIT
)

CREATE TABLE Cart(
    CartID INT PRIMARY KEY IDENTITY,
    UserID INT,
    ProductID INT,
    Quantity INT
)

CREATE TABLE Orders(
    OrderID INT PRIMARY KEY IDENTITY,
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2)
)