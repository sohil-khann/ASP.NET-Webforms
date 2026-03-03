using System;
using System.Web.Security;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    // If user is already logged in, redirect to home
                    if (Session["UserID"] != null)
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error or show message
                System.Diagnostics.Debug.WriteLine("Login Page_Load error: " + ex.Message);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Validate username and password
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    ShowError("Please enter username and password");
                    return;
                }

                // Attempt login
                int userID = UserManager.LoginUser(username, password);

                if (userID > 0)
                {
                    // Set session variables
                    Session["UserID"] = userID;
                    Session["Username"] = username;

                    // Create forms authentication ticket
                    FormsAuthentication.SetAuthCookie(username, false);

                    // Redirect to home page
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ShowError("Invalid username or password");
                    txtPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                ShowError("An error occurred: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
        }
        
        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("Register.aspx");
            }
            catch (Exception ex)
            {
                ShowError("Error redirecting to register page: " + ex.Message);
            }
        }
     
    }
}
