<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Bookstore.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 20px;
        }

        .checkout-form {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .checkout-form h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .order-summary {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .summary-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .summary-items {
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ddd;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .summary-row.total {
            border-top: 2px solid #ddd;
            padding-top: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #e74c3c;
        }

        .place-order-btn {
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

        .place-order-btn:hover {
            background: #229954;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background: #95a5a6;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
        }

        .btn-back:hover {
            background: #7f8c8d;
        }

        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }

            .order-summary {
                position: static;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>💳 Checkout</h1>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger"></asp:Label>
    </asp:Panel>

    <div class="checkout-container">
        <div class="checkout-form">
            <h2>Shipping Information</h2>
            
            <div class="form-row full">
                <div class="form-group">
                    <label for="txtAddress">Address <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" Placeholder="Street address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" 
                        ErrorMessage="Address is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtCity">City <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" Placeholder="City"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" 
                        ErrorMessage="City is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtState">State <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtState" runat="server" Placeholder="State"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" 
                        ErrorMessage="State is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtZipCode">Zip Code <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtZipCode" runat="server" Placeholder="Zip code"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvZipCode" runat="server" ControlToValidate="txtZipCode" 
                        ErrorMessage="Zip code is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="place-order-btn" OnClick="btnPlaceOrder_Click" />
            <a href="Cart.aspx" class="btn-back">Back to Cart</a>
        </div>

        <div class="order-summary">
            <div class="summary-title">Order Summary</div>
            
            <div class="summary-items">
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <ItemTemplate>
                        <div class="summary-item">
                            <span><%# Eval("Title") %> (x<%# Eval("Quantity") %>)</span>
                            <span>$<%# String.Format("{0:F2}", Eval("TotalPrice")) %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

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
        </div>
    </div>
</asp:Content>
