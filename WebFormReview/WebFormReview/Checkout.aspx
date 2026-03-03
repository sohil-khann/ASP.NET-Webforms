<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="WebFormReview.Checkout" MasterPageFile="~/Master.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-page {
            padding: 20px;
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        .page-title {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }

        .checkout-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .checkout-section h3 {
            color: #007bff;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .order-items {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .order-items th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #ddd;
        }

        .order-items td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 16px;
        }

        .summary-row.total {
            font-size: 20px;
            font-weight: bold;
            color: #007bff;
            border-top: 2px solid #ddd;
            padding-top: 15px;
            margin-top: 10px;
        }

        .price {
            color: #28a745;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #333;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn-place-order {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .btn-place-order:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-back {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-back:hover {
            background: #5a6268;
        }

        .empty-cart {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-page">
        <h1 class="page-title">✅ Checkout</h1>

        <asp:Panel ID="pnlCheckout" runat="server">
            <div class="checkout-section">
                <h3>📦 Order Summary</h3>
                <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="False" CssClass="order-items">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Product" />
                        <asp:BoundField DataField="Price" HeaderText="Unit Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" ItemStyle-CssClass="price" />
                    </Columns>
                </asp:GridView>

                <div class="summary-row">
                    <span>Subtotal:</span>
                    <asp:Label ID="lblSubtotal" runat="server" CssClass="price" />
                </div>
                <div class="summary-row">
                    <span>Tax (10%):</span>
                    <asp:Label ID="lblTax" runat="server" CssClass="price" />
                </div>
                <div class="summary-row total">
                    <span>Grand Total:</span>
                    <asp:Label ID="lblGrandTotal" runat="server" />
                </div>
            </div>

            <div class="checkout-section">
                <h3>📍 Delivery Address</h3>
                <div class="form-group">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" />
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" />
                </div>
                <div class="form-group">
                    <label>Delivery Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" />
                </div>
            </div>

            <asp:Button ID="btnPlaceOrder" runat="server" Text="🛒 Place Order" CssClass="btn-place-order" OnClick="btnPlaceOrder_Click" />
            <asp:Button ID="btnBackToCart" runat="server" Text="← Back to Cart" CssClass="btn-back" OnClick="btnBackToCart_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
            <div class="checkout-section empty-cart">
                <h3>Your cart is empty</h3>
                <p>Please add items to your cart before checking out.</p>
                <asp:Button ID="btnShop" runat="server" Text="Browse Products" CssClass="btn-place-order" OnClick="btnShop_Click" />
            </div>
        </asp:Panel>
    </div>
</asp:Content>
