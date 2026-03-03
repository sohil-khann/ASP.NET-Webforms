using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bookstore
{
    using BLL;

    public partial class Cart : Page
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
                LoadCart();
            }
        }

        private void LoadCart()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = CartManager.GetCartItems(userID);

                if (dt.Rows.Count == 0)
                {
                    pnlEmptyCart.Visible = true;
                    pnlCart.Visible = false;
                }
                else
                {
                    pnlEmptyCart.Visible = false;
                    pnlCart.Visible = true;
                    rptCart.DataSource = dt;
                    rptCart.DataBind();
                    UpdateCartTotals();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading cart: " + ex.Message, "danger");
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];

                if (e.CommandName == "Remove")
                {
                    int bookID = Convert.ToInt32(e.CommandArgument);
                    CartManager.RemoveFromCart(userID, bookID);
                    LoadCart();
                    ShowMessage("Item removed from cart", "success");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }

        protected void rptCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Quantity update can be handled here if needed
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];
                int cartItemCount = CartManager.GetCartItemCount(userID);

                if (cartItemCount == 0)
                {
                    ShowMessage("Your cart is empty", "danger");
                    return;
                }

                Response.Redirect("~/Checkout.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }

        private void UpdateCartTotals()
        {
            try
            {
                int userID = (int)Session["UserID"];
                decimal subtotal = CartManager.GetCartTotal(userID);
                decimal tax = subtotal * 0.10m;
                decimal total = subtotal + tax;

                lblSubtotal.Text = "$" + subtotal.ToString("F2");
                lblTax.Text = "$" + tax.ToString("F2");
                lblTotal.Text = "$" + total.ToString("F2");
            }
            catch (Exception ex)
            {
                ShowMessage("Error calculating totals: " + ex.Message, "danger");
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
