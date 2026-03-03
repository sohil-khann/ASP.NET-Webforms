using System;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Master : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateCartAndWishlistCounts();
            }
        }

        private void UpdateCartAndWishlistCounts()
        {
            if (Session["UserID"] != null)
            {
                int userID = (int)Session["UserID"];
                try
                {
                    lblCartCount.Text = CartManager.GetCartItemCount(userID).ToString();
                    lblWishlistCount.Text = WishlistManager.GetWishlistItemCount(userID).ToString();
                }
                catch (Exception ex)
                {
                    // Log error
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
