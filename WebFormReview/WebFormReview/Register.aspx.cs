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
    public partial class Register : System.Web.UI.Page
    {

        private static string CS = System.Configuration.ConfigurationManager.ConnectionStrings["PharmacyDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string name = NameTextBox.Text.Trim();
                string mobile = MobTextBox.Text.Trim();
                string email = EmailTextBox.Text.Trim();
                string password = PassTextBox.Text.Trim();
                string address = AddTextBox.Text.Trim();

                // Validation
                if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(password) ||
                    string.IsNullOrWhiteSpace(mobile) || string.IsNullOrWhiteSpace(email) ||
                    string.IsNullOrWhiteSpace(address))
                {
                    Response.Write("<script>alert('Please fill all required fields');</script>");
                    return;
                }

                Session["UserName"] = name;
                Session["Password"] = password;

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "INSERT INTO Users (Name, Password, Mobile, Email, Address) VALUES (@name, @Password, @Mobile, @Email, @Address)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Address", address);

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    if (result > 0)
                    {
                        Response.Write("<script>alert('Registration successful! Please login.'); window.location='Login.aspx';</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Registration failed. Please try again.');</script>");
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                Response.Write("<script>alert('Database error: " + sqlEx.Message + "');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error during registration: " + ex.Message + "');</script>");
            }
        }
    }
}