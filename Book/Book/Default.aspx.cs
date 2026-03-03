using System;
using System.Data;
using System.Web.UI;

namespace Bookstore
{
    using BLL;

    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Show login prompt if not logged in
                pnlNotLoggedIn.Visible = (Session["UserID"] == null);

                // Load featured books
                LoadFeaturedBooks();
            }
        }

        private void LoadFeaturedBooks()
        {
            try
            {
                DataTable dt = BookManager.GetAllBooks();
                
                // Limit to first 6 books
                if (dt.Rows.Count > 6)
                {
                    dt.DefaultView.RowFilter = null;
                    DataTable limitedDt = dt.Clone();
                    for (int i = 0; i < 6; i++)
                    {
                        limitedDt.ImportRow(dt.Rows[i]);
                    }
                    rptBooks.DataSource = limitedDt;
                }
                else
                {
                    rptBooks.DataSource = dt;
                }

                rptBooks.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
            }
        }
    }
}
