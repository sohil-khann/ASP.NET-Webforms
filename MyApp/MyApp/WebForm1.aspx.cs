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
    public partial class WebForm1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["demodb"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;


        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    string query = "insert into SignUp(FullName,Password,Confirm,Gender,Email) values(@fname,@pass,@confirm,@gender,@email)";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@fname", NameTextBox.Text);
                    cmd.Parameters.AddWithValue("@pass", PassTextBox.Text);
                    cmd.Parameters.AddWithValue("@confirm", ConfirmTextBox.Text);
                    cmd.Parameters.AddWithValue("@gender", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@email", EmailTextBox.Text);
                    
                    conn.Open();
                    int a = cmd.ExecuteNonQuery();

                    if (a > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Signup successful.... '); window.location='Default.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Signup failed. Please try again.');", true);
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