<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="WebFormReview.Order" MasterPageFile="~/Master.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .order-page {
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

        .orders-grid {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .orders-grid th {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .orders-grid td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        .orders-grid tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .orders-grid tbody tr:hover {
            background-color: #f0f0f0;
        }

        .no-orders {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="order-page">
        <h1 class="page-title">📦 Order History</h1>

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="orders-grid">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="{0:C}" />
            </Columns>
            <EmptyDataTemplate>
                <div class="no-orders">You have no orders yet. <a href="Product.aspx" style="color: #007bff;">Start Shopping</a></div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>
