using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormReview
{
    public partial class AdminProducts : System.Web.UI.Page
    {
        private static string CS = System.Configuration.ConfigurationManager.ConnectionStrings["PharmacyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadAdmin();
        }

        void LoadAdmin()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT ProductID, Name, Price, Stock, ExpiryDate, RequiresPrescription FROM Products ORDER BY Name", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAdmin.DataSource = dt;
                gvAdmin.DataBind();
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtPrice.Text) ||
                    string.IsNullOrWhiteSpace(txtStock.Text) || string.IsNullOrWhiteSpace(txtExpiryDate.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please fill all fields');", true);
                    return;
                }

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "INSERT INTO Products (Name, Price, Stock, ExpiryDate, RequiresPrescription) VALUES (@Name, @Price, @Stock, @ExpiryDate, @RequiresPrescription)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@Stock", Convert.ToInt32(txtStock.Text));
                    cmd.Parameters.AddWithValue("@ExpiryDate", Convert.ToDateTime(txtExpiryDate.Text));
                    cmd.Parameters.AddWithValue("@RequiresPrescription", Convert.ToInt32(ddlPrescription.SelectedValue));

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                txtName.Text = "";
                txtPrice.Text = "";
                txtStock.Text = "";
                txtExpiryDate.Text = "";
                ddlPrescription.SelectedIndex = 0;

                LoadAdmin();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Product added successfully');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void gvAdmin_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAdmin.EditIndex = e.NewEditIndex;
            LoadAdmin();
        }

        protected void gvAdmin_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAdmin.EditIndex = -1;
            LoadAdmin();
        }

        protected void gvAdmin_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvAdmin.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvAdmin.Rows[e.RowIndex];

                string name = ((TextBox)row.Cells[1].Controls[0]).Text;
                decimal price = Convert.ToDecimal(((TextBox)row.Cells[2].Controls[0]).Text.Replace("$", "").Replace(",", ""));
                int stock = Convert.ToInt32(((TextBox)row.Cells[3].Controls[0]).Text);

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "UPDATE Products SET Name=@Name, Price=@Price, Stock=@Stock WHERE ProductID=@ProductID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@Stock", stock);
                    cmd.Parameters.AddWithValue("@ProductID", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                gvAdmin.EditIndex = -1;
                LoadAdmin();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Product updated successfully');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void gvAdmin_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvAdmin.DataKeys[e.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "DELETE FROM Products WHERE ProductID=@ProductID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ProductID", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadAdmin();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Product deleted successfully');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }
    }
}