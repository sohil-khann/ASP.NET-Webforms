<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Bookstore.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container {
            background: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }

        .profile-avatar {
            font-size: 64px;
            margin-right: 20px;
        }

        .profile-name {
            flex: 1;
        }

        .profile-name h2 {
            margin: 0 0 5px 0;
        }

        .profile-name p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #eee;
        }

        .tab-button {
            padding: 10px 20px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-size: 16px;
            color: #666;
            transition: all 0.3s;
        }

        .tab-button.active {
            color: #3498db;
            border-bottom-color: #3498db;
        }

        .tab-button:hover {
            color: #3498db;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-save {
            background: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-save:hover {
            background: #229954;
        }

        .btn-cancel {
            background: #95a5a6;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background: #7f8c8d;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
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

        .read-only {
            background: #f9f9f9;
            color: #666;
            cursor: not-allowed;
        }

        .validation-error {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>

    <script>
        function switchTab(tabName) {
            // Hide all tabs
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }

            // Deactivate all buttons
            var buttons = document.getElementsByClassName('tab-button');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }

            // Show selected tab
            document.getElementById(tabName).classList.add('active');
            event.target.classList.add('active');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <div class="profile-name">
                <h2><asp:Label ID="lblUsername" runat="server"></asp:Label></h2>
                <p>Member since <asp:Label ID="lblJoinDate" runat="server"></asp:Label></p>
            </div>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success"></asp:Label>
        </asp:Panel>

        <div class="tabs">
            <button class="tab-button active" onclick="switchTab('profileTab')">Profile Information</button>
            <button class="tab-button" onclick="switchTab('passwordTab')">Change Password</button>
        </div>

        <!-- Profile Information Tab -->
        <div id="profileTab" class="tab-content active">
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

            <div class="form-group">
                <label for="txtEmail">Email (Read-only)</label>
                <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="read-only"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPhone">Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" Placeholder="Phone number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAddress">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" Placeholder="Street address"></asp:TextBox>
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

            <div class="form-group">
                <label for="txtZipCode">Zip Code</label>
                <asp:TextBox ID="txtZipCode" runat="server" Placeholder="Zip code"></asp:TextBox>
            </div>

            <div class="button-group">
                <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnSaveProfile_Click" />
            </div>
        </div>

        <!-- Change Password Tab -->
        <div id="passwordTab" class="tab-content">
            <div class="form-group">
                <label for="txtOldPassword">Current Password</label>
                <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" Placeholder="Enter current password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ControlToValidate="txtOldPassword" 
                    ErrorMessage="Current password is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtNewPassword">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" 
                    ErrorMessage="New password is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtConfirmNewPassword">Confirm New Password</label>
                <asp:TextBox ID="txtConfirmNewPassword" runat="server" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmNewPassword" runat="server" ControlToValidate="txtConfirmNewPassword" 
                    ErrorMessage="Please confirm new password" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvNewPassword" runat="server" ControlToValidate="txtConfirmNewPassword" 
                    ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" CssClass="validation-error" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="button-group">
                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn-save" OnClick="btnChangePassword_Click" />
            </div>
        </div>
    </div>
</asp:Content>
