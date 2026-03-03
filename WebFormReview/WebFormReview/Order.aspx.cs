using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebFormReview
{
    public partial class Order : System.Web.UI.Page
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
                LoadOrders();
        }

        void LoadOrders()
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT OrderID, OrderDate, TotalAmount FROM Orders WHERE UserID=@UserID ORDER BY OrderDate DESC", con);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }
    }
}