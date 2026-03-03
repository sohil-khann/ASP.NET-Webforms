<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="WebFormReview.Cart" MasterPageFile="Master.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-page {
            padding: 20px;
        }

        .page-title {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }

        .cart-grid {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .cart-grid thead {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .cart-grid th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border: 1px solid #0056b3;
        }

        .cart-grid td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        .cart-grid tbody tr {
            transition: all 0.3s ease;
        }

        .cart-grid tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .cart-grid tbody tr:hover {
            background-color: #f0f0f0;
        }

        .product-name {
            color: #007bff;
            font-weight: 600;
        }

        .price {
            color: #28a745;
            font-weight: 700;
        }

        .quantity-input {
            width: 70px;
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            font-size: 14px;
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

        .btn-remove {
            background-color: #dc3545;
            color: white;
        }

        .btn-remove:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .btn-update {
            background-color: #28a745;
            color: white;
        }

        .btn-update:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .summary {
            background-color: #f9f9f9;
            padding: 25px;
            border-radius: 8px;
            border: 1px solid #ddd;
            max-width: 400px;
            margin-left: auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 16px;
            border-bottom: 1px solid #ddd;
        }

        .summary-row label {
            font-weight: 600;
            color: #333;
        }

        .summary-row.total {
            font-size: 20px;
            color: #007bff;
            border-top: 2px solid #ddd;
            border-bottom: none;
            padding-top: 15px;
            margin-top: 15px;
        }

        .summary-row.total label {
            color: #007bff;
        }

        .checkout-section {
            text-align: center;
            margin-top: 30px;
        }

        .btn-checkout {
            background-color: #007bff;
            color: white;
            padding: 12px 40px;
            font-size: 16px;
            margin: 10px;
        }

        .btn-checkout:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .btn-continue {
            background-color: #6c757d;
            color: white;
            padding: 12px 30px;
            font-size: 16px;
        }

        .btn-continue:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }

        .cart-empty {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .cart-grid {
                font-size: 13px;
            }

            .cart-grid th,
            .cart-grid td {
                padding: 8px 10px;
            }

            .quantity-input {
                width: 60px;
            }

            .btn {
                padding: 6px 12px;
                font-size: 12px;
            }

            .summary {
                max-width: 100%;
                margin-left: 0;
            }

            .checkout-section {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .btn-checkout,
            .btn-continue {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-page">
        <h1 class="page-title">🛒 Shopping Cart</h1>

        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" DataKeyNames="CartID"
            OnRowCommand="gvCart_RowCommand" CssClass="cart-grid">
            <Columns>
                <asp:BoundField DataField="CartID" HeaderText="ID" ItemStyle-Width="50px" />
                <asp:BoundField DataField="ProductID" HeaderText="Product ID" ItemStyle-Width="70px" />
                <asp:BoundField DataField="Name" HeaderText="Product Name" ItemStyle-CssClass="product-name" />
                <asp:BoundField DataField="Price" HeaderText="Unit Price" DataFormatString="{0:C}" ItemStyle-CssClass="price" ItemStyle-Width="100px" />
                <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="130px">
                    <ItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' 
                            CssClass="quantity-input" />
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="UpdateQuantity" 
            CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-update" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" ItemStyle-CssClass="price" ItemStyle-Width="100px" />
                <asp:ButtonField ButtonType="Button" CommandName="RemoveCart" Text="Remove" 
                    ControlStyle-CssClass="btn btn-remove" ItemStyle-Width="100px" />
            </Columns>
            <EmptyDataTemplate>
                <div class="cart-empty">
                    Your cart is empty. <a href="Product.aspx" style="color: #007bff; text-decoration: none; font-weight: 600;">Continue Shopping</a>
                </div>
            </EmptyDataTemplate>
        </asp:GridView>

        <div class="summary">
            <div class="summary-row">
                <label>Subtotal:</label>
                <span id="subtotal" class="price">$0.00</span>
            </div>
            <div class="summary-row">
                <label>Tax (10%):</label>
                <span id="tax" class="price">$0.00</span>
            </div>
            <div class="summary-row total">
                <label>Grand Total:</label>
                <span id="grandtotal" class="price">$0.00</span>
            </div>
        </div>

        <div class="checkout-section">
            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" 
                CssClass="btn btn-checkout" OnClick="btnCheckout_Click" />
            <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" 
                CssClass="btn btn-continue" OnClick="btnContinueShopping_Click" />
        </div>
    </div>

    <script type="text/javascript">
        function calculateTotal() {
            var table = document.getElementById('gvCart');
            var subtotal = 0;

            if (table && table.rows.length > 1) {
                for (var i = 1; i < table.rows.length; i++) {
                    var cells = table.rows[i].getElementsByTagName('td');
                    if (cells.length > 0) {
                        var totalCell = cells[cells.length - 2].innerText.trim();
                        var total = parseFloat(totalCell.replace('$', '').replace(',', ''));
                        if (!isNaN(total)) {
                            subtotal += total;
                        }
                    }
                }
            }

            var tax = subtotal * 0.10;
            var grandtotal = subtotal + tax;

            document.getElementById('subtotal').innerText = '$' + subtotal.toFixed(2);
            document.getElementById('tax').innerText = '$' + tax.toFixed(2);
            document.getElementById('grandtotal').innerText = '$' + grandtotal.toFixed(2);
        }

        calculateTotal();
    </script>
</asp:Content>
