<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="Bookstore.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .confirmation-container {
            background: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }

        .success-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .confirmation-container h2 {
            color: #27ae60;
            margin-bottom: 10px;
        }

        .confirmation-container p {
            color: #666;
            margin-bottom: 20px;
            font-size: 16px;
        }

        .order-info {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }

        .info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-label {
            font-weight: bold;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .btn-primary {
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .btn-success {
            padding: 12px 30px;
            background: #27ae60;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-success:hover {
            background: #229954;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="confirmation-container">
        <div class="success-icon">✅</div>
        <h2>Order Placed Successfully!</h2>
        <p>Thank you for your order. Your order has been placed and will be processed shortly.</p>

        <div class="order-info">
            <div class="info-row">
                <span class="info-label">Order ID:</span>
                <span class="info-value"><asp:Label ID="lblOrderID" runat="server"></asp:Label></span>
            </div>
            <div class="info-row">
                <span class="info-label">Order Date:</span>
                <span class="info-value"><asp:Label ID="lblOrderDate" runat="server"></asp:Label></span>
            </div>
            <div class="info-row">
                <span class="info-label">Total Amount:</span>
                <span class="info-value" style="color: #e74c3c; font-weight: bold;"><asp:Label ID="lblTotal" runat="server"></asp:Label></span>
            </div>
            <div class="info-row">
                <span class="info-label">Status:</span>
                <span class="info-value">
                    <span style="background: #f39c12; color: white; padding: 5px 10px; border-radius: 3px;">
                        Pending
                    </span>
                </span>
            </div>
        </div>

        <p>
            A confirmation email has been sent to your registered email address.<br />
            You can track your order from your order history.
        </p>

        <div class="action-buttons">
            <a href="OrderHistory.aspx" class="btn-primary">View Order History</a>
            <a href="Books.aspx" class="btn-success">Continue Shopping</a>
        </div>
    </div>
</asp:Content>
