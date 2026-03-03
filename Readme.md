# Webform Projects Collection

A comprehensive collection of ASP.NET WebForm projects demonstrating various features and functionality.

---

## 📁 Projects Overview

### 1. **Book** - E-Commerce Bookstore Application
An ASP.NET WebForm application for managing and purchasing books online.

**Location:** `Book/`

**Key Features:**
- User Authentication (Login & Registration)
- Book Catalog & Browsing
- Shopping Cart Management
- Order Processing & Checkout
- Order History & Details
- User Profile Management
- Wishlist Functionality

**Files:**
- `Books.aspx` - Product catalog page
- `Cart.aspx` - Shopping cart page
- `Checkout.aspx` - Checkout and payment processing
- `Default.aspx` - Home page
- `Login.aspx` - User login
- `Register.aspx` - User registration
- `OrderConfirmation.aspx` - Order confirmation page
- `OrderDetails.aspx` - View order details
- `OrderHistory.aspx` - User's order history
- `Profile.aspx` - User profile management
- `Wishlist.aspx` - Saved items/wishlist
- `Master.Master` - Master page template

**Folders:**
- `BLL/` - Business Logic Layer
- `DAL/` - Data Access Layer
- `Database/` - Database scripts and schemas
- `Properties/` - Project properties
- `bin/` - Compiled binaries
- `obj/` - Object files

**Documentation:**
- `README.md` - Project-specific documentation
- `SETUP_GUIDE.md` - Setup instructions
- `FEATURES.md` - Feature documentation

---

### 2. **GridDemo** - Data Grid Demo Application
A demonstration application showcasing data grid functionality with authentication.

**Location:** `GridDemo/`

**Key Features:**
- Login & Signup functionality
- Data grid display and management
- Styling with CSS

**Files:**
- `WebForm1.aspx` - Main grid view
- `Login.aspx` - User authentication
- `Signup.aspx` - User registration
- `StyleSheet1.css` - Application styles

**Folders:**
- `App_Data/` - Application data
- `Properties/` - Project properties
- `bin/` - Compiled binaries
- `obj/` - Object files

---

### 3. **MyApp** - Custom Web Application
A general-purpose ASP.NET WebForm application.

**Location:** `MyApp/`

**Key Features:**
- WebForm pages for various functionality
- Web configuration management

**Files:**
- `Default.aspx` - Home page
- `WebForm1.aspx` - Sample form
- `Web.config` - Application configuration

**Folders:**
- `Properties/` - Project properties
- `bin/` - Compiled binaries
- `obj/` - Object files

---

### 4. **WebFormReview** - SQL Review Application
A utility application for SQL query management and review.

**Location:** `WebFormReview/`

**Key Files:**
- `SQLQuery.sql` - SQL scripts
- `SQLQuery1.sql` - Additional SQL queries

---

### 5. **WebApplication1** - Base Web Application
A basic ASP.NET WebForm application template.

**Location:** `WebApplication1/`

---

## 🛠️ Technology Stack

- **Framework:** ASP.NET WebForms
- **Language:** C# (.NET Framework)
- **Database:** SQL Server (for Book project)
- **Package Manager:** NuGet

**Main Dependencies:**
- Microsoft.CodeDom.Providers.DotNetCompilerPlatform 2.0.1
- Portable.BouncyCastle 1.9.0 (GridDemo)

---

## 📋 Common Structure

All projects follow a standard ASP.NET WebForm structure:

```
[ProjectName]/
├── [ProjectName].csproj          # Project file
├── [ProjectName].csproj.user     # User-specific project settings
├── Web.config                     # Configuration file
├── Web.Debug.config              # Debug configuration
├── Web.Release.config            # Release configuration
├── packages.config               # NuGet packages
├── *.aspx                         # Web forms
├── *.aspx.cs                      # Code-behind files
├── *.aspx.designer.cs            # Designer files
├── *.Master                       # Master pages
├── Properties/                    # Project properties
├── bin/                           # Compiled assemblies
└── obj/                           # Intermediate build files
```

---

## 🚀 Getting Started

### Prerequisites
- Visual Studio 2015 or later
- .NET Framework 4.5+
- SQL Server (for Book project)
- IIS Express or IIS

### Setup Instructions

1. **Clone or Extract** the workspace to your local machine
2. **Open Solution** in Visual Studio:
   - Double-click the `.slnx` file for the desired project
3. **Restore NuGet Packages**:
   - Right-click project → "Restore NuGet Packages"
4. **Update Database** (for Book project):
   - Run database scripts from `Database/` folder
5. **Build Solution**:
   - Build → Build Solution (or Ctrl+Shift+B)
6. **Run Application**:
   - Press F5 or click Start button

For detailed setup guides, refer to individual project `SETUP_GUIDE.md` files.

---

## 📚 Project Documentation

- **Book Project:** See [Book/README.md](Book/README.md) and [Book/SETUP_GUIDE.md](Book/SETUP_GUIDE.md)


---

## 📝 Notes

- Each project is independently configurable
- Solutions use `.slnx` format (Visual Studio solution file)
- Packages are managed through NuGet via `packages.config`
- All projects follow standard ASP.NET WebForm conventions

---

## 📖 Additional Resources

- [ASP.NET WebForms Documentation](https://docs.microsoft.com/en-us/aspnet/web-forms/)
- [Microsoft .NET Framework Documentation](https://docs.microsoft.com/en-us/dotnet/framework/)

---

## 📝 Version History

- **v1.0** (2026-03-03) - Initial project collection documentation

---

**Last Updated:** March 3, 2026
