<%@ Page Title="Home" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormReview.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="home-container">
        <h1>Welcome to Pharmacy Store</h1>
        <p>Your trusted online pharmacy for quality medicines and healthcare products.</p>

        <div class="action-buttons">
            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Sign In" OnClick="btnLogin_Click" />

            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-secondary" Text="Create Account" OnClick="btnRegister_Click" />
        </div>

        
    </div>
</asp:Content>
