using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormReview
{
    public partial class Cart : System.Web.UI.Page
    {
        private static string CS = System.Configuration.ConfigurationManager.ConnectionStrings["PharmacyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = @"SELECT c.CartID, p.ProductID, p.Name, p.Price, c.Quantity, (p.Price * c.Quantity) AS Total
                               FROM Cart c
                               INNER JOIN Products p ON c.ProductID = p.ProductID
                               WHERE c.UserID = @UserID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserID", Session["UserID"]);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCart.DataSource = dt;
                gvCart.DataBind();
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (e.CommandName == "RemoveCart")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int cartId = Convert.ToInt32(gvCart.DataKeys[rowIndex].Value);

                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "DELETE FROM Cart WHERE CartID = @CartID AND UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadCart();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item removed from cart');", true);
            }
            else if (e.CommandName == "UpdateQuantity")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int cartId = Convert.ToInt32(gvCart.DataKeys[rowIndex].Value);
                GridViewRow row = gvCart.Rows[rowIndex];
                TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");

                if (int.TryParse(txtQuantity.Text, out int quantity) && quantity > 0)
                {
                    using (SqlConnection con = new SqlConnection(CS))
                    {
                        string query = "UPDATE Cart SET Quantity = @Quantity WHERE CartID = @CartID AND UserID = @UserID";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@CartID", cartId);
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadCart();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Quantity updated');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please enter a valid quantity');", true);
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Checkout.aspx");
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Product.aspx");
        }
    }
}