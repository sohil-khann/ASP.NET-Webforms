using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormReview
{
    public partial class Wishlist : System.Web.UI.Page
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
                LoadWishlist();
        }

        private void LoadWishlist()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                string query = @"SELECT w.WishlistID, p.ProductID, p.Name, p.Price, p.ExpiryDate
                               FROM Wishlist w
                               INNER JOIN Products p ON w.ProductID = p.ProductID
                               WHERE w.UserID = @UserID
                               ORDER BY p.Name";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserID", Session["UserID"]);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvWishlist.DataSource = dt;
                gvWishlist.DataBind();
            }
        }

        protected void gvWishlist_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int wishlistId = Convert.ToInt32(gvWishlist.DataKeys[rowIndex].Value);
            int productId = Convert.ToInt32(gvWishlist.Rows[rowIndex].Cells[1].Text);

            if (e.CommandName == "AddToCart")
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "INSERT INTO Cart(UserID, ProductID, Quantity) VALUES(@UserID, @ProductID, 1)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    cmd.Parameters.AddWithValue("@ProductID", productId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Added to Cart');", true);
            }
            else if (e.CommandName == "RemoveWishlist")
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    string query = "DELETE FROM Wishlist WHERE WishlistID = @WishlistID AND UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@WishlistID", wishlistId);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadWishlist();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Removed from Wishlist');", true);
            }
        }
    }
}
