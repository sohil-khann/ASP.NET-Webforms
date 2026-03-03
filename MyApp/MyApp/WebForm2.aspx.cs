using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyApp
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                lblMessage.Text = "Session " + Session["user"].ToString() + " Welcome into page 2";
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Session.Abandon();
                Response.Redirect("Default.aspx?message=Logout+successfully!");
            }
        }
    }
}