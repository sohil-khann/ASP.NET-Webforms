using System;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Register : Page
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
                ShowError("Page load error: " + ex.Message);
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Set hidden field to track form submission
                hdnFormSubmitted.Value = "true";

                // Clear any previous messages
                pnlError.Visible = false;
                pnlSuccess.Visible = false;

                // Check if page is valid (all validators passed)
                if (!Page.IsValid)
                {
                    return;
                }

                // Validate inputs
                string username = txtUsername.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string firstName = txtFirstName.Text.Trim();
                string lastName = txtLastName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string address = txtAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string state = txtState.Text.Trim();
                string zipCode = txtZipCode.Text.Trim();

                // Basic validation
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                {
                    ShowError("Username, email, and password are required");
                    return;
                }

                // Check if username exists
                try
                {
                    if (UserManager.UsernameExists(username))
                    {
                        ShowError("Username already exists. Please choose a different username.");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ShowError("Error checking username: " + ex.Message);
                    return;
                }

                // Check if email exists
                try
                {
                    if (UserManager.EmailExists(email))
                    {
                        ShowError("Email already registered. Please use a different email.");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ShowError("Error checking email: " + ex.Message);
                    return;
                }

                // Register user
                try
                {
                    if (UserManager.RegisterUser(username, email, password, firstName, lastName, phone, address, city, state, zipCode))
                    {
                        ShowSuccess("Account created successfully! Redirecting to login...");
                        Response.Redirect("~/Login.aspx");
                    }
                    else
                    {
                        ShowError("Registration failed. Please try again.");
                    }
                }
                catch (Exception ex)
                {
                    ShowError("Error registering user: " + ex.Message);
                    return;
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
            pnlSuccess.Visible = false;
        }

        private void ShowSuccess(string message)
        {
            lblSuccess.Text = message;
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
        }
    }
}
