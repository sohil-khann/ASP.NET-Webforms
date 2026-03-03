    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="WebFormReview.Product" MasterPageFile="/Master.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-page {
            padding: 20px;
        }

        .page-title {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }

        .products-grid {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .products-grid thead {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .products-grid th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border: 1px solid #0056b3;
        }

        .products-grid td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        .products-grid tbody tr {
            transition: all 0.3s ease;
        }

        .products-grid tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .products-grid tbody tr:hover {
            background-color: #f0f0f0;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
        }

        .product-name {
            color: #007bff;
            font-weight: 600;
        }

        .price {
            color: #28a745;
            font-weight: 700;
            font-size: 16px;
        }

        .expiry-date {
            color: #666;
            font-size: 14px;
        }

        .btn-cart {
            background-color: #28a745;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .btn-cart:hover {
            background-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
        }

        .btn-cart:active {
            transform: translateY(0);
        }

        .no-products {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }

        .btn-wishlist {
            background-color: #e91e63;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 14px;
            margin-left: 5px;
        }

        .btn-wishlist:hover {
            background-color: #c2185b;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .products-grid {
                font-size: 14px;
            }

            .products-grid th,
            .products-grid td {
                padding: 8px 10px;
            }

            .btn-cart, .btn-wishlist {
                padding: 6px 12px;
                font-size: 12px;
            }

            .page-title {
                font-size: 22px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="product-page">
        <h1 class="page-title">🏥 Available Medicines</h1>

        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
            OnRowCommand="gvProducts_RowCommand" CssClass="products-grid" DataKeyNames="ProductID">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="ID" ItemStyle-Width="60px" />
                <asp:BoundField DataField="Name" HeaderText="Medicine Name" ItemStyle-CssClass="product-name" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" ItemStyle-CssClass="price" ItemStyle-Width="100px" />
                <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-Width="80px" />
                <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="expiry-date" ItemStyle-Width="100px" />
                <asp:CheckBoxField DataField="RequiresPrescription" HeaderText="Rx" ItemStyle-Width="50px" />
                <asp:ButtonField ButtonType="Button" CommandName="AddCart" Text="🛒 Add to Cart" ControlStyle-CssClass="btn-cart" ItemStyle-Width="130px" />
                <asp:ButtonField ButtonType="Button" CommandName="AddWishlist" Text="❤️ Wishlist" ControlStyle-CssClass="btn-wishlist" ItemStyle-Width="100px" />
            </Columns>
            <EmptyDataTemplate>
                <div class="no-products">No products available at the moment.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>
