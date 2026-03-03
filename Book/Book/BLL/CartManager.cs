using System;
using System.Data;
using System.Data.SqlClient;
using Bookstore.DAL;

namespace Bookstore.BLL
{
    public class CartManager
    {
        // Get cart items for user
        public static DataTable GetCartItems(int userID)
        {
            try
            {
                string query = @"SELECT c.CartID, c.BookID, b.Title, b.Author, b.Price, 
                               c.Quantity, (b.Price * c.Quantity) AS TotalPrice, b.ImageURL 
                               FROM Cart c 
                               INNER JOIN Books b ON c.BookID = b.BookID 
                               WHERE c.UserID = @UserID 
                               ORDER BY c.AddedDate DESC";
                
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving cart items: " + ex.Message);
            }
        }

        // Add item to cart
        public static bool AddToCart(int userID, int bookID, int quantity)
        {
            try
            {
                // Check if item already exists in cart
                string checkQuery = "SELECT CartID, Quantity FROM Cart WHERE UserID = @UserID AND BookID = @BookID";
                SqlParameter[] checkParams = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                DataTable dt = DatabaseHelper.ExecuteQuery(checkQuery, checkParams);
                
                if (dt.Rows.Count > 0)
                {
                    // Update quantity
                    int existingQuantity = (int)dt.Rows[0]["Quantity"];
                    return UpdateCartItem(userID, bookID, existingQuantity + quantity);
                }
                else
                {
                    // Insert new item
                    string insertQuery = @"INSERT INTO Cart (UserID, BookID, Quantity) 
                                          VALUES (@UserID, @BookID, @Quantity)";
                    
                    SqlParameter[] insertParams = {
                        new SqlParameter("@UserID", userID),
                        new SqlParameter("@BookID", bookID),
                        new SqlParameter("@Quantity", quantity)
                    };
                    
                    DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error adding to cart: " + ex.Message);
            }
        }

        // Update cart item quantity
        public static bool UpdateCartItem(int userID, int bookID, int quantity)
        {
            try
            {
                if (quantity <= 0)
                {
                    return RemoveFromCart(userID, bookID);
                }

                string query = @"UPDATE Cart SET Quantity = @Quantity 
                               WHERE UserID = @UserID AND BookID = @BookID";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID),
                    new SqlParameter("@Quantity", quantity)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating cart item: " + ex.Message);
            }
        }

        // Remove item from cart
        public static bool RemoveFromCart(int userID, int bookID)
        {
            try
            {
                string query = "DELETE FROM Cart WHERE UserID = @UserID AND BookID = @BookID";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error removing from cart: " + ex.Message);
            }
        }

        // Clear entire cart
        public static bool ClearCart(int userID)
        {
            try
            {
                string query = "DELETE FROM Cart WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error clearing cart: " + ex.Message);
            }
        }

        // Get cart total
        public static decimal GetCartTotal(int userID)
        {
            try
            {
                string query = @"SELECT SUM(b.Price * c.Quantity) AS Total 
                               FROM Cart c 
                               INNER JOIN Books b ON c.BookID = b.BookID 
                               WHERE c.UserID = @UserID";
                
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null || result is DBNull)
                    return 0;

                return Convert.ToDecimal(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error calculating cart total: " + ex.Message);
            }
        }

        // Get cart item count
        public static int GetCartItemCount(int userID)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Cart WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null || result is DBNull)
                    return 0;

                return (int)result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error getting cart item count: " + ex.Message);
            }
        }
    }
}
