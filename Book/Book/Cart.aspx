<%@ Page Title="Shopping Cart" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Bookstore.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-container {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 20px;
        }

        .cart-items {
            background: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr 100px 100px 100px 50px;
            gap: 15px;
            padding: 15px;
            border-bottom: 1px solid #eee;
            align-items: center;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 100px;
            height: 100px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            border-radius: 5px;
        }

        .item-details h3 {
            margin: 0 0 5px 0;
            font-size: 16px;
        }

        .item-details p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .quantity-input {
            width: 50px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }

        .item-price {
            font-weight: bold;
            font-size: 16px;
        }

        .item-total {
            font-weight: bold;
            font-size: 16px;
            color: #e74c3c;
        }

        .btn-remove {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }

        .btn-remove:hover {
            background: #c0392b;
        }

        .cart-summary {
            background: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .summary-row.total {
            border-top: 2px solid #ddd;
            padding-top: 15px;
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
        }

        .checkout-btn {
            width: 100%;
            padding: 12px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }

        .checkout-btn:hover {
            background: #229954;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 5px;
        }

        .empty-cart p {
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

        @media (max-width: 768px) {
            .cart-container {
                grid-template-columns: 1fr;
            }

            .cart-item {
                grid-template-columns: 80px 1fr;
            }

            .cart-summary {
                position: static;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>🛒 Shopping Cart</h1>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success"></asp:Label>
    </asp:Panel>

    <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
        <div class="empty-cart">
            <p>Your cart is empty</p>
            <a href="Books.aspx" class="btn btn-primary">Continue Shopping</a>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlCart" runat="server" Visible="false">
        <div class="cart-container">
            <div class="cart-items">
                <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand" OnItemDataBound="rptCart_ItemDataBound">
                    <ItemTemplate>
                        <div class="cart-item">
                            <div class="item-image">📖</div>
                            <div class="item-details">
                                <h3><%# Eval("Title") %></h3>
                                <p>by <%# Eval("Author") %></p>
                            </div>
                            <div class="item-price">$<%# String.Format("{0:F2}", Eval("Price")) %></div>
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-input"></asp:TextBox>
                            <div class="item-total">$<%# String.Format("{0:F2}", Eval("TotalPrice")) %></div>
                            <asp:LinkButton ID="lnkRemove" runat="server" CommandName="Remove" 
                                CommandArgument='<%# Eval("BookID") %>' CssClass="btn-remove" OnClientClick="return confirm('Remove this item?');">✕</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="cart-summary">
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <span><asp:Label ID="lblSubtotal" runat="server">$0.00</asp:Label></span>
                </div>
                <div class="summary-row">
                    <span>Tax (10%):</span>
                    <span><asp:Label ID="lblTax" runat="server">$0.00</asp:Label></span>
                </div>
                <div class="summary-row total">
                    <span>Total:</span>
                    <span><asp:Label ID="lblTotal" runat="server">$0.00</asp:Label></span>
                </div>
                <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="checkout-btn" OnClick="btnCheckout_Click" />
                <a href="Books.aspx" class="btn btn-primary" style="width: 100%; text-align: center; margin-top: 10px;">Continue Shopping</a>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
