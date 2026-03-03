using System;
using System.Data;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Checkout : Page
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
                LoadOrderSummary();
                LoadUserInfo();
            }
        }

        private void LoadOrderSummary()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = CartManager.GetCartItems(userID);

                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("~/Cart.aspx");
                    return;
                }

                rptOrderItems.DataSource = dt;
                rptOrderItems.DataBind();

                decimal subtotal = CartManager.GetCartTotal(userID);
                decimal tax = subtotal * 0.10m;
                decimal total = subtotal + tax;

                lblSubtotal.Text = "$" + subtotal.ToString("F2");
                lblTax.Text = "$" + tax.ToString("F2");
                lblTotal.Text = "$" + total.ToString("F2");
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading order summary: " + ex.Message);
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = UserManager.GetUserByID(userID);

                if (dt.Rows.Count > 0)
                {
                    txtAddress.Text = dt.Rows[0]["Address"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
                    txtState.Text = dt.Rows[0]["State"].ToString();
                    txtZipCode.Text = dt.Rows[0]["ZipCode"].ToString();
                }
            }
            catch (Exception ex)
            {
                // Log error
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = (int)Session["UserID"];

                string address = txtAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string state = txtState.Text.Trim();
                string zipCode = txtZipCode.Text.Trim();

                if (string.IsNullOrEmpty(address) || string.IsNullOrEmpty(city) || 
                    string.IsNullOrEmpty(state) || string.IsNullOrEmpty(zipCode))
                {
                    ShowMessage("Please fill all required fields");
                    return;
                }

                int orderID = OrderManager.PlaceOrder(userID, address, city, state, zipCode);

                if (orderID > 0)
                {
                    Response.Redirect("~/OrderConfirmation.aspx?OrderID=" + orderID);
                }
                else
                {
                    ShowMessage("Failed to place order. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error placing order: " + ex.Message);
            }
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
        }
    }
}
