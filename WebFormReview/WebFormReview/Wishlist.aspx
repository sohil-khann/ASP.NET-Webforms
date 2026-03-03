<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="WebFormReview.Wishlist" MasterPageFile="~/Master.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .wishlist-page {
            padding: 20px;
            width: 100%;
        }

        .page-title {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }

        .wishlist-grid {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .wishlist-grid th {
            background: linear-gradient(135deg, #e91e63 0%, #c2185b 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .wishlist-grid td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        .wishlist-grid tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .wishlist-grid tbody tr:hover {
            background-color: #f0f0f0;
        }

        .product-name {
            color: #e91e63;
            font-weight: 600;
        }

        .price {
            color: #28a745;
            font-weight: 700;
        }

        .btn {
            padding: 8px 16px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-cart {
            background-color: #28a745;
            color: white;
        }

        .btn-cart:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .btn-remove {
            background-color: #dc3545;
            color: white;
        }

        .btn-remove:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .no-items {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wishlist-page">
        <h1 class="page-title">❤️ My Wishlist</h1>

        <asp:GridView ID="gvWishlist" runat="server" AutoGenerateColumns="False" 
            OnRowCommand="gvWishlist_RowCommand" CssClass="wishlist-grid" DataKeyNames="WishlistID">
            <Columns>
                <asp:BoundField DataField="WishlistID" HeaderText="ID" ItemStyle-Width="50px" />
                <asp:BoundField DataField="ProductID" HeaderText="Product ID" ItemStyle-Width="80px" />
                <asp:BoundField DataField="Name" HeaderText="Product Name" ItemStyle-CssClass="product-name" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" ItemStyle-CssClass="price" />
                <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:ButtonField ButtonType="Button" CommandName="AddToCart" Text="Add to Cart" ControlStyle-CssClass="btn btn-cart" />
                <asp:ButtonField ButtonType="Button" CommandName="RemoveWishlist" Text="Remove" ControlStyle-CssClass="btn btn-remove" />
            </Columns>
            <EmptyDataTemplate>
                <div class="no-items">
                    Your wishlist is empty. <a href="Product.aspx" style="color: #e91e63; text-decoration: none; font-weight: 600;">Browse Products</a>
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>
