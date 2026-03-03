<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebFormReview.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Pharmacy - Register</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="loginbox">
        <h2>Register</h2>

        <asp:TextBox ID="NameTextBox" runat="server" placeholder="Full Name" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" ErrorMessage="Full Name is required" ForeColor="Red" />

        <asp:TextBox ID="PassTextBox" runat="server" TextMode="Password" placeholder="Password" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="PassTextBox" ErrorMessage="Password is required" ForeColor="Red" />

        <asp:TextBox ID="MobTextBox" runat="server" placeholder="Mobile Number" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="MobTextBox" ErrorMessage="Mobile is required" ForeColor="Red" />
        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="MobTextBox" ErrorMessage="Invalid mobile length" ForeColor="Red" MaximumValue="13" MinimumValue="10" />

        <asp:TextBox ID="EmailTextBox" runat="server" placeholder="Email" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="Email is required" ForeColor="Red" />

        <asp:TextBox ID="AddTextBox" runat="server" placeholder="Address" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="AddTextBox" ErrorMessage="Address is required" ForeColor="Red" />

        <div class="button-group">
            <asp:Button ID="Button1" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="Button1_Click" />
        </div>
    </div>
</asp:Content>

