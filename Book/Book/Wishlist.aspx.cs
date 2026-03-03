using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bookstore
{
    using BLL;

    public partial class Wishlist : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadWishlist();
            }
        }

        private void LoadWishlist()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = WishlistManager.GetWishlistItems(userID);

                if (dt.Rows.Count == 0)
                {
                    pnlEmptyWishlist.Visible = true;
                    pnlWishlist.Visible = false;
                }
                else
                {
                    pnlEmptyWishlist.Visible = false;
                    pnlWishlist.Visible = true;
                    rptWishlist.DataSource = dt;
                    rptWishlist.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading wishlist: " + ex.Message, "danger");
            }
        }

        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];
                int bookID = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "AddCart")
                {
                    WishlistManager.MoveToCart(userID, bookID, 1);
                    ShowMessage("Item moved to cart", "success");
                    LoadWishlist();
                }
                else if (e.CommandName == "Remove")
                {
                    WishlistManager.RemoveFromWishlist(userID, bookID);
                    ShowMessage("Item removed from wishlist", "success");
                    LoadWishlist();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-" + type;
            pnlMessage.Visible = true;
        }
    }
}
