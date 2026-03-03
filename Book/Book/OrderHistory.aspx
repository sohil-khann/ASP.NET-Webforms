<%@ Page Title="Order History" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="Bookstore.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .orders-container {
            background: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background-color: #34495e;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: bold;
        }

        .grid td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        .grid tr:hover {
            background-color: #f9f9f9;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-pending {
            background-color: #f39c12;
            color: white;
        }

        .status-processing {
            background-color: #3498db;
            color: white;
        }

        .status-shipped {
            background-color: #9b59b6;
            color: white;
        }

        .status-delivered {
            background-color: #27ae60;
            color: white;
        }

        .status-cancelled {
            background-color: #e74c3c;
            color: white;
        }

        .action-links {
            display: flex;
            gap: 5px;
        }

        .action-links a {
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            font-size: 12px;
        }

        .action-links a:hover {
            background-color: #2980b9;
        }

        .action-links a.danger {
            background-color: #e74c3c;
        }

        .action-links a.danger:hover {
            background-color: #c0392b;
        }

        .empty-orders {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-orders p {
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

        .pager {
            text-align: center;
            padding: 15px;
            background: #f9f9f9;
        }

        .pager a {
            padding: 5px 10px;
            margin: 0 5px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }

        .pager a:hover {
            background: #2980b9;
        }

        .pager span {
            padding: 5px 10px;
            margin: 0 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>📦 Order History</h1>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success"></asp:Label>
    </asp:Panel>

    <asp:Panel ID="pnlEmptyOrders" runat="server" Visible="false">
        <div class="orders-container">
            <div class="empty-orders">
                <p>You have no orders yet</p>
                <a href="Books.aspx" class="btn btn-primary">Start Shopping</a>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlOrders" runat="server" Visible="false">
        <div class="orders-container">
            <asp:GridView ID="gvOrders" runat="server" CssClass="grid" AutoGenerateColumns="False" 
                DataKeyNames="OrderID" OnRowCommand="gvOrders_RowCommand" OnRowDataBound="gvOrders_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="${0:F2}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="status status-<%# Eval("Status").ToString().ToLower() %>">
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DeliveryDate" HeaderText="Delivery Date" DataFormatString="{0:yyyy-MM-dd}" NullDisplayText="N/A" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-links">
                                <asp:LinkButton ID="lnkView" runat="server" CommandName="View" 
                                    CommandArgument='<%# Eval("OrderID") %>' Text="View Details"></asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" 
                                    CommandArgument='<%# Eval("OrderID") %>' CssClass="danger" Text="Cancel" 
                                    OnClientClick="return confirm('Are you sure you want to cancel this order?');"></asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>
</asp:Content>
