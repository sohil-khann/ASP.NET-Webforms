<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyApp.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     

        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox> userName
<%--          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Display="Dynamic"></asp:RequiredFieldValidator>--%>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p>

    

            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
            password</p>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Width="73px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Restore" Width="84px" />

        
    &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/WebForm1.aspx">go to page 1</asp:LinkButton>

        
    </form>
</body>
</html>
