using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormReview
{
    public partial class Product : System.Web.UI.Page
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
                LoadProducts();
        }

        private void LoadProducts()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT ProductID, Name, Price, Stock, ExpiryDate, RequiresPrescription FROM Products WHERE ExpiryDate > GETDATE() AND Stock > 0 ORDER BY Name", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int productId = Convert.ToInt32(gvProducts.DataKeys[rowIndex].Value);

            if (e.CommandName == "AddCart")
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    // Check if item already in cart
                    string checkQuery = "SELECT CartID FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    checkCmd.Parameters.AddWithValue("@ProductID", productId);

                    con.Open();
                    object existing = checkCmd.ExecuteScalar();

                    if (existing != null)
                    {
                        // Update quantity
                        string updateQuery = "UPDATE Cart SET Quantity = Quantity + 1 WHERE CartID = @CartID";
                        SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                        updateCmd.Parameters.AddWithValue("@CartID", existing);
                        updateCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        // Insert new item
                        string insertQuery = "INSERT INTO Cart(UserID, ProductID, Quantity) VALUES(@UserID, @ProductID, 1)";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                        insertCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                        insertCmd.Parameters.AddWithValue("@ProductID", productId);
                        insertCmd.ExecuteNonQuery();
                    }
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('✓ Added to Cart');", true);
            }
            else if (e.CommandName == "AddWishlist")
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    // Check if already in wishlist
                    string checkQuery = "SELECT WishlistID FROM Wishlist WHERE UserID = @UserID AND ProductID = @ProductID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    checkCmd.Parameters.AddWithValue("@ProductID", productId);

                    con.Open();
                    object existing = checkCmd.ExecuteScalar();

                    if (existing != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item already in Wishlist');", true);
                    }
                    else
                    {
                        string insertQuery = "INSERT INTO Wishlist(UserID, ProductID) VALUES(@UserID, @ProductID)";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                        insertCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                        insertCmd.Parameters.AddWithValue("@ProductID", productId);
                        insertCmd.ExecuteNonQuery();

                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('❤️ Added to Wishlist');", true);
                    }
                }
            }
        }
    }
}