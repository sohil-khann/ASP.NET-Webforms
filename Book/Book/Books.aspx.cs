using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bookstore
{
    using BLL;

    public partial class Books : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadBooks();
            }
        }

        private void LoadCategories()
        {
            try
            {
                DataTable dt = BookManager.GetCategories();
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Category";
                ddlCategory.DataValueField = "Category";
                ddlCategory.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
            }
        }

        private void LoadBooks()
        {
            try
            {
                DataTable dt = BookManager.GetAllBooks();
                rptBooks.DataSource = dt;
                rptBooks.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading books: " + ex.Message, "danger");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchTerm = txtSearch.Text.Trim();
                string category = ddlCategory.SelectedValue;

                DataTable dt = null;

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    dt = BookManager.SearchBooks(searchTerm);
                }
                else if (!string.IsNullOrEmpty(category))
                {
                    dt = BookManager.GetBooksByCategory(category);
                }
                else
                {
                    dt = BookManager.GetAllBooks();
                }

                rptBooks.DataSource = dt;
                rptBooks.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error searching books: " + ex.Message, "danger");
            }
        }

        protected void rptBooks_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int userID = (int)Session["UserID"];
                int bookID = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "AddCart")
                {
                    CartManager.AddToCart(userID, bookID, 1);
                    ShowMessage("Book added to cart successfully!", "success");
                }
                else if (e.CommandName == "Wishlist")
                {
                    if (WishlistManager.AddToWishlist(userID, bookID))
                    {
                        ShowMessage("Book added to wishlist successfully!", "success");
                    }
                    else
                    {
                        ShowMessage("Book is already in your wishlist", "danger");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
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
