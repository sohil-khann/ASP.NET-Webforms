using System;
using System.Data;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = UserManager.GetUserByID(userID);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    lblUsername.Text = row["Username"].ToString();
                    lblJoinDate.Text = ((DateTime)row["CreatedDate"]).ToString("MMMM yyyy");
                    
                    txtEmail.Text = row["Email"].ToString();
                    txtFirstName.Text = row["FirstName"].ToString();
                    txtLastName.Text = row["LastName"].ToString();
                    txtPhone.Text = row["PhoneNumber"].ToString();
                    txtAddress.Text = row["Address"].ToString();
                    txtCity.Text = row["City"].ToString();
                    txtState.Text = row["State"].ToString();
                    txtZipCode.Text = row["ZipCode"].ToString();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading profile: " + ex.Message, "danger");
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];

                string firstName = txtFirstName.Text.Trim();
                string lastName = txtLastName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string address = txtAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string state = txtState.Text.Trim();
                string zipCode = txtZipCode.Text.Trim();

                if (UserManager.UpdateUserProfile(userID, firstName, lastName, phone, address, city, state, zipCode))
                {
                    ShowMessage("Profile updated successfully!", "success");
                }
                else
                {
                    ShowMessage("Failed to update profile. Please try again.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating profile: " + ex.Message, "danger");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];

                string oldPassword = txtOldPassword.Text.Trim();
                string newPassword = txtNewPassword.Text.Trim();

                if (string.IsNullOrEmpty(oldPassword) || string.IsNullOrEmpty(newPassword))
                {
                    ShowMessage("Please enter both current and new password", "danger");
                    return;
                }

                if (UserManager.ChangePassword(userID, oldPassword, newPassword))
                {
                    ShowMessage("Password changed successfully!", "success");
                    txtOldPassword.Text = "";
                    txtNewPassword.Text = "";
                    txtConfirmNewPassword.Text = "";
                }
                else
                {
                    ShowMessage("Current password is incorrect. Please try again.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error changing password: " + ex.Message, "danger");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-" + type;
            pnlMessage.Visible = true;
        }
    }
}
