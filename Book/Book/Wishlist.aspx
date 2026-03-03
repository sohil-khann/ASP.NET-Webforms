<%@ Page Title="Wishlist" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="Bookstore.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .wishlist-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .wishlist-item {
            background: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .wishlist-item:hover {
            transform: translateY(-5px);
        }

        .item-image {
            width: 100%;
            height: 200px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
        }

        .item-info {
            padding: 15px;
        }

        .item-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .item-author {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }

        .item-price {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .item-actions {
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
        }

        .btn-add {
            background-color: #27ae60;
            color: white;
        }

        .btn-add:hover {
            background-color: #229954;
        }

        .btn-remove {
            background-color: #e74c3c;
            color: white;
        }

        .btn-remove:hover {
            background-color: #c0392b;
        }

        .empty-wishlist {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 5px;
        }

        .empty-wishlist p {
            font-size: 18px;
            color: #666;
            margin-bottom: 20px;
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
    <h1>❤️ My Wishlist</h1>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success"></asp:Label>
    </asp:Panel>

    <asp:Panel ID="pnlEmptyWishlist" runat="server" Visible="false">
        <div class="empty-wishlist">
            <p>Your wishlist is empty</p>
            <a href="Books.aspx" class="btn btn-primary">Browse Books</a>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlWishlist" runat="server" Visible="false">
        <div class="wishlist-container">
            <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                <ItemTemplate>
                    <div class="wishlist-item">
                        <div class="item-image">📖</div>
                        <div class="item-info">
                            <div class="item-title"><%# Eval("Title") %></div>
                            <div class="item-author">by <%# Eval("Author") %></div>
                            <div class="item-price">$<%# String.Format("{0:F2}", Eval("Price")) %></div>
                            <div class="item-actions">
                                <asp:LinkButton ID="lnkAddCart" runat="server" CommandName="AddCart" 
                                    CommandArgument='<%# Eval("BookID") %>' CssClass="btn-small btn-add">🛒 Add to Cart</asp:LinkButton>
                                <asp:LinkButton ID="lnkRemove" runat="server" CommandName="Remove" 
                                    CommandArgument='<%# Eval("BookID") %>' CssClass="btn-small btn-remove">Remove</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Panel>
</asp:Content>
