<%@ Page Title="Home" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Bookstore.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 20px;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 40px;
        }

        .hero h2 {
            font-size: 36px;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .feature-card {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .feature-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .feature-card h3 {
            margin-bottom: 10px;
            color: #333;
        }

        .feature-card p {
            color: #666;
            font-size: 14px;
        }

        .popular-books {
            margin-bottom: 40px;
        }

        .popular-books h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }

        .book-card {
            background: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-image {
            width: 100%;
            height: 150px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }

        .book-info {
            padding: 10px;
        }

        .book-title {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 3px;
        }

        .book-author {
            font-size: 12px;
            color: #666;
            margin-bottom: 5px;
        }

        .book-price {
            font-size: 16px;
            color: #e74c3c;
            font-weight: bold;
        }

        .login-prompt {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            margin: 20px 0;
        }

        .login-prompt a {
            background: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 10px;
        }

        .login-prompt a:hover {
            background: #2980b9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="hero">
        <h2>Welcome to Bookstore 📚</h2>
        <p>Discover thousands of books from all genres</p>
        <a href="Books.aspx" class="btn btn-primary">Start Browsing</a>
    </div>

    <div class="features">
        <div class="feature-card">
            <div class="feature-icon">📖</div>
            <h3>Wide Selection</h3>
            <p>Browse thousands of books in various categories</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon"></div>
            <h3>Easy Shopping</h3>
            <p>Simple and secure checkout process</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">❤️</div>
            <h3>Save Favorites</h3>
            <p>Create wishlists and save your favorite books</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📦</div>
            <h3>Quick Delivery</h3>
            <p>Fast and reliable shipping to your doorstep</p>
        </div>
    </div>

    <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="false">
        <div class="login-prompt">
            <h3>Start Your Reading Journey</h3>
            <p>Create an account to enjoy personalized recommendations and track your orders</p>
            <div>
                <a href="Login.aspx">Login</a>
                <a href="Register.aspx" style="background: #27ae60; margin-left: 10px;">Register</a>
            </div>
        </div>
    </asp:Panel>

    <div class="popular-books">
        <h2>Featured Books</h2>
        <div class="books-grid">
            <asp:Repeater ID="rptBooks" runat="server">
                <ItemTemplate>
                    <div class="book-card">
                        <div class="book-image">📖</div>
                        <div class="book-info">
                            <div class="book-title"><%# Eval("Title") %></div>
                            <div class="book-author"><%# Eval("Author") %></div>
                            <div class="book-price">$<%# String.Format("{0:F2}", Eval("Price")) %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
