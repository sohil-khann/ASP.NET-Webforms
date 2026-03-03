<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebFormReview.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Pharmacy - Login</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="loginbox">
        <h2>Login</h2>

        <asp:TextBox ID="txtName" runat="server" placeholder="Username" CssClass="form-control" />
        <asp:RequiredFieldValidator ControlToValidate="txtName" ErrorMessage="Username is required" ForeColor="Red" runat="server"/>

        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" CssClass="form-control" />
        <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" runat="server"/>

        <div class="button-group">
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-primary"/>
            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-secondary"/>
        </div>
    </div>
</asp:Content>
