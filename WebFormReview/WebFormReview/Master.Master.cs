using System;
using System.Web.UI;

namespace WebFormReview
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                UpdateUserDisplay();
            }
        }

        private void UpdateUserDisplay()
        {
            if (Session["UserName"] != null)
            {
                lblUserName.Text = "👤 " + Session["UserName"].ToString();
                btnLogout.Visible = true;
                btnLogin.Visible = false;
            }
            else
            {
                lblUserName.Text = "";
                btnLogout.Visible = false;
                btnLogin.Visible = true;
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        protected void btnProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Product.aspx");
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Wishlist.aspx");
        }

        protected void btnOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Order.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}