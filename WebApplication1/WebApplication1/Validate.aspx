<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" 
    AutoEventWireup="true" CodeBehind="Validate.aspx.cs" 
    Inherits="WebApplication1.Validate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="val">
    Name:
    <asp:TextBox ID="txtName" runat="server" />
    <asp:RequiredFieldValidator 
        ControlToValidate="txtName"
        ErrorMessage="Name required"
        runat="server" ForeColor="Red"
        ValidationGroup="vg1" />
    <br />

    Email:
    <asp:TextBox ID="txtEmail" runat="server" />
    <asp:RegularExpressionValidator
        ControlToValidate="txtEmail"
        ValidationExpression="\w+@\w+\.\w+"
        ErrorMessage="Invalid email"
        runat="server" ForeColor="Red"
        ValidationGroup="vg1" />
    <br />

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="vg1" />

    <asp:ValidationSummary runat="server" ForeColor="Red" ValidationGroup="vg1" />
    </div>

</asp:Content>