<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Bookstore.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .details-container {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 20px;
        }

        .order-info {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .order-info h2 {
            margin-top: 0;
            margin-bottom: 15px;
        }

        .info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: bold;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        .order-items {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            grid-column: 1 / -1;
            margin-top: 20px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background-color: #34495e;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .grid td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .grid tr:hover {
            background-color: #f9f9f9;
        }

        .order-summary {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            height: fit-content;
        }

        .summary-title {
            font-weight: bold;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .summary-row.total {
            border-bottom: 2px solid #333;
            font-weight: bold;
            font-size: 18px;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 3px;
            color: white;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .status-pending {
            background-color: #f39c12;
        }

        .status-processing {
            background-color: #3498db;
        }

        .status-shipped {
            background-color: #9b59b6;
        }

        .status-delivered {
            background-color: #27ae60;
        }

        .status-cancelled {
            background-color: #e74c3c;
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
            .details-container {
                grid-template-columns: 1fr;
            }

            .info-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>📋 Order Details</h1>

    <div class="details-container">
        <div>
            <div class="order-info">
                <h2>Order Information</h2>
                <div class="status-badge" id="statusBadge" runat="server"></div>
                
                <div class="info-row">
                    <span class="info-label">Order ID:</span>
                    <span class="info-value"><asp:Label ID="lblOrderID" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Order Date:</span>
                    <span class="info-value"><asp:Label ID="lblOrderDate" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Status:</span>
                    <span class="info-value"><asp:Label ID="lblStatus" runat="server"></asp:Label></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Delivery Date:</span>
                    <span class="info-value"><asp:Label ID="lblDeliveryDate" runat="server"></asp:Label></span>
                </div>
            </div>

            <div class="order-info">
                <h2>Shipping Address</h2>
                <div class="info-row" style="border-bottom: none;">
                    <span class="info-value" style="grid-column: 1 / -1;">
                        <asp:Label ID="lblAddress" runat="server"></asp:Label><br />
                        <asp:Label ID="lblCity" runat="server"></asp:Label>, 
                        <asp:Label ID="lblState" runat="server"></asp:Label> 
                        <asp:Label ID="lblZipCode" runat="server"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="order-items">
                <h2>Order Items</h2>
                <asp:GridView ID="gvOrderItems" runat="server" CssClass="grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Book Title" />
                        <asp:BoundField DataField="Author" HeaderText="Author" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" DataFormatString="${0:F2}" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="${0:F2}" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div class="order-summary">
            <div class="summary-title">Order Summary</div>
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
            <a href="OrderHistory.aspx" class="btn-back">Back to Orders</a>
        </div>
    </div>
</asp:Content>
