<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="MyApp.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="Button1_Click" />
<asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
        </div>
    </form>
</body>  
</html>
