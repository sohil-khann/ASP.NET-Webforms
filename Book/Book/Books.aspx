<%@ Page Title="Books" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="Bookstore.Books" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-section {
            background: white;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .search-row {
            display: grid;
            grid-template-columns: 1fr 1fr 100px;
            gap: 10px;
        }

        .books-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .book-card {
            background: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .book-image {
            width: 100%;
            height: 200px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
        }

        .book-info {
            padding: 15px;
        }

        .book-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .book-author {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }

        .book-price {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .book-rating {
            font-size: 12px;
            color: #f39c12;
            margin-bottom: 10px;
        }

        .book-actions {
            display: flex;
            gap: 5px;
        }

        .btn-small {
            flex: 1;
            padding: 8px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
            transition: background-color 0.3s;
        }

        .btn-cart {
            background-color: #3498db;
            color: white;
        }

        .btn-cart:hover {
            background-color: #2980b9;
        }

        .btn-wishlist {
            background-color: #e74c3c;
            color: white;
        }

        .btn-wishlist:hover {
            background-color: #c0392b;
        }

        .no-stock {
            background-color: #95a5a6;
            color: white;
            cursor: not-allowed;
        }

        .no-stock:hover {
            background-color: #95a5a6;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>📚 Our Books Collection</h1>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success"></asp:Label>
    </asp:Panel>

    <div class="search-section">
        <div class="search-row">
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search books by title or author..."></asp:TextBox>
            <asp:DropDownList ID="ddlCategory" runat="server">
                <asp:ListItem Value="">All Categories</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary" />
        </div>
    </div>

    <div class="books-container">
        <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
            <ItemTemplate>
                <div class="book-card">
                    <div class="book-image">📖</div>
                    <div class="book-info">
                        <div class="book-title"><%# Eval("Title") %></div>
                        <div class="book-author">by <%# Eval("Author") %></div>
                        <div class="book-price">$<%# String.Format("{0:F2}", Eval("Price")) %></div>
                        <div class="book-rating">Rating: <%# Eval("Rating") %> ⭐</div>
                        <div class="book-actions">
                            <% if ((int)Eval("Stock") > 0) { %>
                                <asp:LinkButton ID="lnkAddToCart" runat="server" CommandName="AddCart" 
                                    CommandArgument='<%# Eval("BookID") %>' CssClass="btn-small btn-cart">🛒 Add Cart</asp:LinkButton>
                                <asp:LinkButton ID="lnkWishlist" runat="server" CommandName="Wishlist" 
                                    CommandArgument='<%# Eval("BookID") %>' CssClass="btn-small btn-wishlist">❤️ Wishlist</asp:LinkButton>
                            <% } else { %>
                                <button class="btn-small no-stock" disabled>Out of Stock</button>
                            <% } %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <script>
        function showMessage(message, type) {
            var messagePanel = document.getElementById('<%= pnlMessage.ClientID %>');
            var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
            messageLabel.textContent = message;
            messageLabel.className = 'alert alert-' + type;
            messagePanel.style.display = 'block';
            setTimeout(function() {
                messagePanel.style.display = 'none';
            }, 3000);
        }
    </script>
</asp:Content>
