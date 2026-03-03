using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
namespace MyApp
{
    public partial class Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["demodb"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;


        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //if (ViewState["user"] != null && ViewState["password"]!=null)
            //TextBox1.Text = ViewState["user"].ToString();
            //TextBox2.Text = ViewState["password"].ToString();
            if (Session["user"] != null && Session["pass"]!=null)
            {
                TextBox1.Text=Session["user"].ToString();
                TextBox2.Text=Session["pass"].ToString();
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    // Changed from 'Login' table to 'SignUp' table to match registration
                    string query = "select * from SignUp where FullName=@user and Password=@pass";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@user", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@pass", TextBox2.Text);
                    
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    
                    if (dr.HasRows)
                    {
                        Session["user"] = TextBox1.Text;
                        Session["pass"] = TextBox2.Text;
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login successful'); window.location='WebForm2.aspx';", true);
                        
                        TextBox1.Text = string.Empty;
                        TextBox2.Text = string.Empty;
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login failed');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }
    }
}