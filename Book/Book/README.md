# Bookstore WebForms Application

A full-stack e-commerce bookstore application built with ASP.NET WebForms and .NET Framework 4.8.

## Features

### User Management
- **User Registration**: Create new account with validation
- **User Login**: Secure login with password hashing
- **User Profile**: View and update user information
- **Password Management**: Change password functionality

### Product Management
- **Browse Books**: View all available books with search and filter options
- **Book Details**: View detailed information about each book
- **Category Filtering**: Filter books by category
- **Search Functionality**: Search books by title or author

### Shopping Features
- **Shopping Cart**: Add/remove items, update quantities
- **Cart Management**: View cart total with tax calculation
- **Wishlist**: Save favorite books for later
- **Move to Cart**: Move items from wishlist to cart

### Order Management
- **Place Order**: Checkout process with shipping information
- **Order Confirmation**: Order confirmation page with order details
- **Order History**: View all past orders in GridView
- **Order Details**: View individual order details with items
- **Order Cancellation**: Cancel pending orders

## Database Setup

### Connection String
Update the connection string in `Web.config`:
```xml
<appSettings>
    <add key="ConnectionString" value="Server=.; Database=BookstoreDB; Integrated Security=true;" />
</appSettings>
```

### Create Database
Run the SQL script in `Database/BookstoreDB.sql` to create:
- Users table
- Books table
- Cart table
- Wishlist table
- Orders table
- OrderDetails table

The script also includes sample book data.

## Project Structure

```
Book/
├── DAL/
│   └── DatabaseHelper.cs          # Database connectivity
├── BLL/
│   ├── UserManager.cs             # User operations
│   ├── BookManager.cs             # Book operations
│   ├── CartManager.cs             # Cart management
│   ├── WishlistManager.cs         # Wishlist management
│   └── OrderManager.cs            # Order processing
├── Master.Master                  # Master page layout
├── Login.aspx                     # Login page
├── Register.aspx                  # Registration page
├── Default.aspx                   # Home page
├── Books.aspx                     # Books listing and search
├── Cart.aspx                      # Shopping cart
├── Wishlist.aspx                  # Wishlist management
├── Checkout.aspx                  # Order checkout
├── OrderHistory.aspx              # Order history with GridView
├── OrderDetails.aspx              # Order details view
├── OrderConfirmation.aspx         # Order confirmation
├── Web.config                     # Configuration file
└── Database/
    └── BookstoreDB.sql            # Database schema and sample data
```

## Key Pages

### Authentication
- **Login.aspx**: User login with credential validation
- **Register.aspx**: New user registration with form validation

### Shopping
- **Books.aspx**: Browse and search books, add to cart/wishlist
- **Cart.aspx**: Manage shopping cart items and totals
- **Wishlist.aspx**: Manage wishlist items
- **Checkout.aspx**: Enter shipping details and place order

### Orders
- **OrderHistory.aspx**: Display all user orders in a GridView with sorting
- **OrderDetails.aspx**: View detailed information about a specific order
- **OrderConfirmation.aspx**: Show confirmation after order placement

## Business Logic Features

### User Management (UserManager)
- User registration with duplicate username/email check
- Secure password hashing using SHA256
- Login with password verification
- Profile update functionality
- Password change with old password verification

### Product Management (BookManager)
- Get all books with sorting
- Search books by title or author
- Filter books by category
- Get available categories
- Check book availability
- Update stock after purchase

### Cart Management (CartManager)
- Add items to cart (with quantity updates)
- Remove items from cart
- Update item quantities
- Clear entire cart
- Calculate cart total
- Get cart item count

### Wishlist Management (WishlistManager)
- Add items to wishlist
- Remove items from wishlist
- Check if item is in wishlist
- Move items from wishlist to cart
- Get wishlist item count

### Order Processing (OrderManager)
- Place order with transaction support
- Get user orders with sorting
- Get order details
- Update order status
- Cancel orders with stock restoration
- Get order count

## Security Features

- Password hashing using SHA256
- SQL parameterized queries to prevent SQL injection
- Forms authentication for session management
- Transaction support for order processing
- Validation controls on forms

## Database Schema

### Users
- UserID (PK)
- Username, Email (Unique)
- Password (Hashed)
- FirstName, LastName
- Contact and address information
- Timestamps

### Books
- BookID (PK)
- Title, Author
- Price, Category
- Stock, Rating
- Description, ISBN
- PublishedDate, ImageURL

### Cart
- CartID (PK)
- UserID (FK), BookID (FK)
- Quantity
- AddedDate
- Unique constraint on (UserID, BookID)

### Wishlist
- WishlistID (PK)
- UserID (FK), BookID (FK)
- AddedDate
- Unique constraint on (UserID, BookID)

### Orders
- OrderID (PK)
- UserID (FK)
- OrderDate, TotalAmount
- Status, ShippingAddress
- DeliveryDate

### OrderDetails
- OrderDetailID (PK)
- OrderID (FK), BookID (FK)
- Quantity, UnitPrice, TotalPrice

## Sample Data

The database script includes 5 sample books:
1. The Great Gatsby - F. Scott Fitzgerald - $12.99
2. To Kill a Mockingbird - Harper Lee - $14.99
3. 1984 - George Orwell - $13.99
4. Pride and Prejudice - Jane Austen - $11.99
5. The Catcher in the Rye - J.D. Salinger - $10.99

## UI Features

- **Responsive Design**: Works on desktop and mobile devices
- **Modern Styling**: Clean and professional UI with gradients
- **Navigation**: Consistent header with shopping cart and wishlist badges
- **GridView**: Used for displaying order history with sorting and filtering
- **Form Validation**: Client-side and server-side validation
- **Status Badges**: Color-coded order status indicators
- **Alert Messages**: Success and error notifications

## Getting Started

1. Create the SQL Server database using the provided script
2. Update the connection string in Web.config
3. Build and run the application
4. Navigate to the application URL
5. Register a new account or login
6. Start shopping!

## Future Enhancements

- Payment gateway integration (PayPal, Stripe)
- Email notifications for order status
- Admin panel for book management
- Product reviews and ratings
- User recommendation system
- Inventory management
- Multiple shipping options
- Order tracking with real-time updates

## Technical Stack

- **Framework**: ASP.NET WebForms (.NET Framework 4.8)
- **Language**: C#
- **Database**: SQL Server
- **Frontend**: HTML5, CSS3, JavaScript
- **Styling**: Custom CSS with modern gradients and responsive design

## Notes

- All passwords are hashed using SHA256
- Cart items are stored per user session in database
- Orders are processed with transaction support
- Stock is automatically updated upon order placement
- Cancelled orders restore stock quantities
- Only pending orders can be cancelled
