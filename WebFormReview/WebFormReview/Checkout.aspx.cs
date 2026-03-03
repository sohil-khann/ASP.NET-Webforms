using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebFormReview
{
    public partial class Checkout : System.Web.UI.Page
    {
        private static string CS = System.Configuration.ConfigurationManager.ConnectionStrings["PharmacyDB"].ConnectionString;
        private decimal subtotal = 0;
        private decimal tax = 0;
        private decimal grandTotal = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
                LoadUserInfo();
            }
        }

        private void LoadCartItems()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = @"SELECT p.Name, p.Price, c.Quantity, (p.Price * c.Quantity) AS Total
                               FROM Cart c
                               INNER JOIN Products p ON c.ProductID = p.ProductID
                               WHERE c.UserID = @UserID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserID", Session["UserID"]);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlCheckout.Visible = false;
                    pnlEmptyCart.Visible = true;
                    return;
                }

                gvOrderItems.DataSource = dt;
                gvOrderItems.DataBind();

                foreach (DataRow row in dt.Rows)
                {
                    subtotal += Convert.ToDecimal(row["Total"]);
                }

                tax = subtotal * 0.10m;
                grandTotal = subtotal + tax;

                lblSubtotal.Text = subtotal.ToString("C");
                lblTax.Text = tax.ToString("C");
                lblGrandTotal.Text = grandTotal.ToString("C");
            }
        }

        private void LoadUserInfo()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = "SELECT Name, Mobile, Address FROM Users WHERE Id = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFullName.Text = reader["Name"].ToString();
                    txtPhone.Text = reader["Mobile"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtFullName.Text) || string.IsNullOrWhiteSpace(txtPhone.Text) ||
                    string.IsNullOrWhiteSpace(txtAddress.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please fill all delivery details');", true);
                    return;
                }

                decimal orderTotal = CalculateTotal();

                using (SqlConnection con = new SqlConnection(CS))
                {
                    con.Open();

                    // Create order
                    string orderQuery = "INSERT INTO Orders (UserID, TotalAmount) VALUES (@UserID, @TotalAmount); SELECT SCOPE_IDENTITY();";
                    SqlCommand orderCmd = new SqlCommand(orderQuery, con);
                    orderCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    orderCmd.Parameters.AddWithValue("@TotalAmount", orderTotal);

                    int orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                    // Clear cart after successful order
                    string clearCartQuery = "DELETE FROM Cart WHERE UserID = @UserID";
                    SqlCommand clearCartCmd = new SqlCommand(clearCartQuery, con);
                    clearCartCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    clearCartCmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "alert", 
                    "alert('Order placed successfully! Thank you for your purchase.'); window.location='Order.aspx';", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error placing order: " + ex.Message + "');", true);
            }
        }

        private decimal CalculateTotal()
        {
            decimal total = 0;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = @"SELECT SUM(p.Price * c.Quantity) AS Total
                               FROM Cart c
                               INNER JOIN Products p ON c.ProductID = p.ProductID
                               WHERE c.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != DBNull.Value)
                {
                    total = Convert.ToDecimal(result);
                    total += total * 0.10m; // Add tax
                }
            }
            return total;
        }

        protected void btnBackToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }

        protected void btnShop_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Product.aspx");
        }
    }
}
