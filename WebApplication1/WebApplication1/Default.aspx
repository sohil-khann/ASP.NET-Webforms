<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- CSS file -->
    <link href="CSS/StyleSheet1.css" rel="stylesheet" />
</head>
<body>
<asp:RequiredFieldValidator  runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1"/>
<asp:TextBox ID="TextBox1" runat="server" AutoPostBack="true"
             OnTextChanged="TextBox1_TextChanged" Width="200px" Height="30px" BorderWidth="2px" BorderStyle="Dotted">
</asp:TextBox>


 


<br />

    <div class="img">
<img src="Assets/A.jpg" class="img1"/>

    </div>
    <br />

<asp:Panel ID="Panel1" runat="server">

    <h1>Hello, world!</h1>
    <br />
        <a href="Validate.aspx" >Validate</a>

    <a href="Contact.aspx" class="contactlink">Contact us</a>
  

</asp:Panel>
    <!-- JavaScript file -->
<%--    <script src="script.js"></script>--%>
</body>
</html>

</asp:Content>
