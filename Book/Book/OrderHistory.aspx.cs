using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bookstore
{
    using BLL;

    public partial class OrderHistory : Page
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
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            try
            {
                int userID = (int)Session["UserID"];
                DataTable dt = OrderManager.GetUserOrders(userID);

                if (dt.Rows.Count == 0)
                {
                    pnlEmptyOrders.Visible = true;
                    pnlOrders.Visible = false;
                }
                else
                {
                    pnlEmptyOrders.Visible = false;
                    pnlOrders.Visible = true;
                    gvOrders.DataSource = dt;
                    gvOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading orders: " + ex.Message, "danger");
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int orderID = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "View")
                {
                    Response.Redirect("~/OrderDetails.aspx?OrderID=" + orderID);
                }
                else if (e.CommandName == "Cancel")
                {
                    if (OrderManager.CancelOrder(orderID))
                    {
                        ShowMessage("Order cancelled successfully", "success");
                        LoadOrders();
                    }
                    else
                    {
                        ShowMessage("Failed to cancel order", "danger");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }

        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // You can add custom formatting here if needed
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();
                
                // Disable cancel button for non-pending orders
                if (status != "Pending")
                {
                    LinkButton lnkCancel = (LinkButton)e.Row.FindControl("lnkCancel");
                    if (lnkCancel != null)
                    {
                        lnkCancel.Enabled = false;
                        lnkCancel.Style["opacity"] = "0.5";
                    }
                }
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
