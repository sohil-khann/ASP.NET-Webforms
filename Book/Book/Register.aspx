<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Bookstore.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - Bookstore</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .register-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }

        .logo {
            text-align: center;
            font-size: 32px;
            margin-bottom: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            display: none;
        }

        .alert.show {
            display: block;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .error-message {
            color: #721c24;
            font-size: 12px;
            margin-top: 3px;
        }

        .validation-summary {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <div class="logo">📚</div>
            <h1>Create Account</h1>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger show">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success show">
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <asp:HiddenField ID="hdnFormSubmitted" runat="server" Value="false" />

            <div class="form-row full">
                <div class="form-group">
                    <label for="txtUsername">Username <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Choose a username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                        ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-row full">
                <div class="form-group">
                    <label for="txtEmail">Email <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="Enter your email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                        ErrorMessage="Email is required" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                   <%-- <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                        ErrorMessage="Please enter a valid email" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RegularExpressionValidator>--%>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtPassword">Password <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                        ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password <span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Placeholder="Confirm password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ErrorMessage="Please confirm password" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" CssClass="error-message" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:CompareValidator>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtFirstName">First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" Placeholder="First name"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtLastName">Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" Placeholder="Last name"></asp:TextBox>
                </div>
            </div>

            <div class="form-row full">
                <div class="form-group">
                    <label for="txtPhone">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" Placeholder="Phone number"></asp:TextBox>
                </div>
            </div>

            <div class="form-row full">
                <div class="form-group">
                    <label for="txtAddress">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" Placeholder="Street address"></asp:TextBox>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtCity">City</label>
                    <asp:TextBox ID="txtCity" runat="server" Placeholder="City"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtState">State</label>
                    <asp:TextBox ID="txtState" runat="server" Placeholder="State"></asp:TextBox>
                </div>
            </div>

            <div class="form-row full">
                <div class="form-group">
                    <label for="txtZipCode">Zip Code</label>
                    <asp:TextBox ID="txtZipCode" runat="server" Placeholder="Zip code"></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register" OnClick="btnRegister_Click" ValidationGroup="RegisterGroup" CausesValidation="true" />

            <div class="login-link">
                Already have an account? <a href="Login.aspx">Login here</a>
            </div>
        </div>
    </form>

    <script>
        // Client-side debugging
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Register page loaded');
            
            var registerButton = document.getElementById('<%= btnRegister.ClientID %>');
            if (registerButton) {
                registerButton.addEventListener('click', function(e) {
                    console.log('Register button clicked');
                    console.log('Username:', document.getElementById('<%= txtUsername.ClientID %>').value);
                    console.log('Email:', document.getElementById('<%= txtEmail.ClientID %>').value);
                    console.log('Password:', document.getElementById('<%= txtPassword.ClientID %>').value ? '[ENTERED]' : '[EMPTY]');
                    console.log('Confirm Password:', document.getElementById('<%= txtConfirmPassword.ClientID %>').value ? '[ENTERED]' : '[EMPTY]');
                    
                    // Check if passwords match
                    var password = document.getElementById('<%= txtPassword.ClientID %>').value;
                    var confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
                    if (password !== confirmPassword) {
                        alert('Passwords do not match!');
                        e.preventDefault();
                        return false;
                    }
                    
                    // Check required fields
                    if (!document.getElementById('<%= txtUsername.ClientID %>').value.trim()) {
                        alert('Username is required!');
                        e.preventDefault();
                        return false;
                    }
                    
                    if (!document.getElementById('<%= txtEmail.ClientID %>').value.trim()) {
                        alert('Email is required!');
                        e.preventDefault();
                        return false;
                    }
                    
                    if (!password) {
                        alert('Password is required!');
                        e.preventDefault();
                        return false;
                    }
                    
                    console.log('Form validation passed, submitting...');
                });
            } else {
                console.error('Register button not found!');
            }
        });
    </script>
</body>
</html>
