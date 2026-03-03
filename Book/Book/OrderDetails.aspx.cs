using System;
using System.Data;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class OrderDetails : Page
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
                if (Request.QueryString["OrderID"] == null)
                {
                    Response.Redirect("~/OrderHistory.aspx");
                    return;
                }

                LoadOrderDetails();
            }
        }

        private void LoadOrderDetails()
        {
            try
            {
                int orderID = Convert.ToInt32(Request.QueryString["OrderID"]);

                // Load order header
                DataTable headerDT = OrderManager.GetOrderHeader(orderID);
                if (headerDT.Rows.Count == 0)
                {
                    Response.Redirect("~/OrderHistory.aspx");
                    return;
                }

                DataRow headerRow = headerDT.Rows[0];
                
                lblOrderID.Text = orderID.ToString();
                lblOrderDate.Text = ((DateTime)headerRow["OrderDate"]).ToString("yyyy-MM-dd");
                lblStatus.Text = headerRow["Status"].ToString();
                lblAddress.Text = headerRow["ShippingAddress"].ToString();
                lblCity.Text = headerRow["ShippingCity"].ToString();
                lblState.Text = headerRow["ShippingState"].ToString();
                lblZipCode.Text = headerRow["ShippingZipCode"].ToString();

                // Set status badge
                string status = headerRow["Status"].ToString();
                statusBadge.Attributes["class"] = "status-badge status-" + status.ToLower();
                statusBadge.InnerText = status;

                if (headerRow["DeliveryDate"] != null && !(headerRow["DeliveryDate"] is DBNull))
                {
                    lblDeliveryDate.Text = ((DateTime)headerRow["DeliveryDate"]).ToString("yyyy-MM-dd");
                }
                else
                {
                    lblDeliveryDate.Text = "Not yet delivered";
                }

                // Load order items
                DataTable itemsDT = OrderManager.GetOrderDetails(orderID);
                gvOrderItems.DataSource = itemsDT;
                gvOrderItems.DataBind();

                // Calculate totals
                decimal subtotal = 0;
                foreach (DataRow row in itemsDT.Rows)
                {
                    subtotal += Convert.ToDecimal(row["TotalPrice"]);
                }

                decimal tax = subtotal * 0.10m;
                decimal total = subtotal + tax;

                lblSubtotal.Text = "$" + subtotal.ToString("F2");
                lblTax.Text = "$" + tax.ToString("F2");
                lblTotal.Text = "$" + total.ToString("F2");
            }
            catch (Exception ex)
            {
                // Log error
                Response.Redirect("~/OrderHistory.aspx");
            }
        }
    }
}
