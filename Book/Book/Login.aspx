<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Bookstore.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Bookstore</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
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
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }

        .btn-login {
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

        .btn-login:hover {
            transform: translateY(-2px);
        }

        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .signup-link a:hover {
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

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .error-message {
            color: #721c24;
            font-size: 14px;
            margin-top: 5px;
        }

        .register-link {
            color: #667eea;
            text-decoration: none;
            background: none;
            border: none;
            cursor: pointer;
            font-size: inherit;
            padding: 0;
        }

        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="logo">📚</div>
            <h1>Bookstore Login</h1>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger show">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" Placeholder="Enter your username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Enter your password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

            <div class="signup-link">
                Don't have an account? <asp:LinkButton ID="lnkRegister" runat="server" Text="Register here" CssClass="register-link" OnClick="lnkRegister_Click" />
            </div>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
             console.log('Login page loaded');
             console.log('Current URL:', window.location.href);
             
             // Find the register link button (it will have a different ID due to ASP.NET)
             var registerLink = document.getElementById('<%= lnkRegister.ClientID %>');
             if (registerLink) {
                 console.log('Register link button found:', registerLink);
                 console.log('Register link will redirect to: Register.aspx');
                 
                 // The LinkButton will handle the click server-side, so we just log it
                 registerLink.addEventListener('click', function(e) {
                     console.log('Register link button clicked');
                     // The server-side click handler will handle the redirect
                 });
                 console.log('Register link button event listener attached');
             } else {
                 console.error('Register link button not found!');
                 // Fallback to looking for the signup link
                 var fallbackLink = document.querySelector('.signup-link a');
                 if (fallbackLink) {
                     console.log('Found fallback register link:', fallbackLink);
                     fallbackLink.addEventListener('click', function(e) {
                         console.log('Fallback register link clicked');
                         console.log('Link href:', this.href);
                     });
                 }
             }
         });
    </script>
</body>
</html>
