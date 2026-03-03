<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="MyApp.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" title="Register">
        <div>
        

        <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox> &nbsp; Full Name
<%--          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Display="Dynamic"></asp:RequiredFieldValidator>--%>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" Display="Dynamic" ErrorMessage="Required" ForeColor="Red">*</asp:RequiredFieldValidator>
            &nbsp;<p>

    

            <asp:TextBox ID="PassTextBox" runat="server"></asp:TextBox>
            &nbsp;
            password&nbsp;&nbsp;&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PassTextBox" Display="Dynamic" ErrorMessage="Required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </p>

    
            &nbsp;<asp:TextBox ID="ConfirmTextBox" runat="server"></asp:TextBox>
            &nbsp;Confirm password&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ConfirmTextBox" Display="Dynamic" ErrorMessage="Required" ForeColor="Red">*</asp:RequiredFieldValidator>
            <br />
&nbsp; 
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Select</asp:ListItem>
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
                <asp:ListItem>NA</asp:ListItem>
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gender&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropDownList1" InitialValue="Select" Display="Dynamic" ErrorMessage="Required" ForeColor="Red">*</asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="EmailTextBox" runat="server"></asp:TextBox>
&nbsp;Email<br />
            <br />

        </div>
        <asp:Button ID="Button1" runat="server" Text="Register" OnClick="Button1_Click" />
        <br />
        <br />
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/WebForm2.aspx">go to page 2</asp:LinkButton>
        


    </form>
</body>
</html>
