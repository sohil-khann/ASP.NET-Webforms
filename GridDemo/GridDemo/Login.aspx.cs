using Org.BouncyCastle.Crypto.Generators;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GridDemo
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtLoginUsername.Text.Trim();
            string password = txtLoginPassword.Text.Trim();
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT PasswordHash FROM Users WHERE Username=@Username";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read()) // reader.Read() returns bool; do NOT index into it
                        {
                            var storedPasswordHash = reader["PasswordHash"]?.ToString();
                            if (storedPasswordHash != null && storedPasswordHash == password)
                            {
                                Session["Username"] = username;
                                Response.Redirect("Webform1.aspx");
                            }
                            else
                            {
                                lblLoginMessage.Text = "Invalid username or password.";
                            }
                        }
                        else
                        {
                            lblLoginMessage.Text = "Invalid username or password.";
                        }
                    }
                }
            }
        }

    }
}