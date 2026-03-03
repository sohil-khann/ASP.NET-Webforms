using System;
using System.Data;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class OrderConfirmation : Page
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
                    Response.Redirect("~/Default.aspx");
                    return;
                }

                LoadOrderInfo();
            }
        }

        private void LoadOrderInfo()
        {
            try
            {
                int orderID = Convert.ToInt32(Request.QueryString["OrderID"]);

                DataTable dt = OrderManager.GetOrderHeader(orderID);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    lblOrderID.Text = orderID.ToString();
                    lblOrderDate.Text = ((DateTime)row["OrderDate"]).ToString("yyyy-MM-dd HH:mm:ss");
                    lblTotal.Text = "$" + ((decimal)row["TotalAmount"]).ToString("F2");
                }
            }
            catch (Exception ex)
            {
                // Log error
            }
        }
    }
}
