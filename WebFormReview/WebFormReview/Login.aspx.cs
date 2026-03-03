using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;    

namespace WebFormReview
{
    public partial class Login : System.Web.UI.Page
    {
        private static string CS = System.Configuration.ConfigurationManager.ConnectionStrings["PharmacyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    Response.Write("<script>alert('Please enter username and password');</script>");
                    return;
                }

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "SELECT Id FROM Users WHERE Name=@Name AND Password=@Password";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        Session["UserID"] = result.ToString();
                        Session["UserName"] = txtName.Text;
                        Response.Redirect("Product.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Invalid Login - Username or password is incorrect');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error during login: " + ex.Message + "');</script>");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("~/Register.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error navigating to register: " + ex.Message + "');</script>");
            }
        }
    }
}