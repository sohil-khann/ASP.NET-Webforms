<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GridDemo.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <asp:TextBox ID="txtLoginUsername" runat="server" CssClass="input"></asp:TextBox>
<asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
<asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
<asp:Label ID="lblLoginMessage" runat="server" CssClass="message"></asp:Label>
    </form>
</body>
</html>
