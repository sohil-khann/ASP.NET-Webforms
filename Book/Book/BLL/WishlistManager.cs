using System;
using System.Data;
using System.Data.SqlClient;
using Bookstore.DAL;

namespace Bookstore.BLL
{
    public class WishlistManager
    {
        // Get wishlist items for user
        public static DataTable GetWishlistItems(int userID)
        {
            try
            {
                string query = @"SELECT w.WishlistID, w.BookID, b.Title, b.Author, b.Price, 
                               b.Rating, b.ImageURL, w.AddedDate 
                               FROM Wishlist w 
                               INNER JOIN Books b ON w.BookID = b.BookID 
                               WHERE w.UserID = @UserID 
                               ORDER BY w.AddedDate DESC";
                
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving wishlist items: " + ex.Message);
            }
        }

        // Add item to wishlist
        public static bool AddToWishlist(int userID, int bookID)
        {
            try
            {
                // Check if item already exists
                string checkQuery = "SELECT COUNT(*) FROM Wishlist WHERE UserID = @UserID AND BookID = @BookID";
                SqlParameter[] checkParams = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                object result = DatabaseHelper.ExecuteScalar(checkQuery, checkParams);
                if ((int)result > 0)
                    return false; // Already in wishlist

                string insertQuery = @"INSERT INTO Wishlist (UserID, BookID) 
                                      VALUES (@UserID, @BookID)";
                
                SqlParameter[] insertParams = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error adding to wishlist: " + ex.Message);
            }
        }

        // Remove item from wishlist
        public static bool RemoveFromWishlist(int userID, int bookID)
        {
            try
            {
                string query = "DELETE FROM Wishlist WHERE UserID = @UserID AND BookID = @BookID";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error removing from wishlist: " + ex.Message);
            }
        }

        // Check if book is in wishlist
        public static bool IsInWishlist(int userID, int bookID)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Wishlist WHERE UserID = @UserID AND BookID = @BookID";
                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@BookID", bookID)
                };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                return (int)result > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error checking wishlist: " + ex.Message);
            }
        }

        // Clear entire wishlist
        public static bool ClearWishlist(int userID)
        {
            try
            {
                string query = "DELETE FROM Wishlist WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error clearing wishlist: " + ex.Message);
            }
        }

        // Get wishlist item count
        public static int GetWishlistItemCount(int userID)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Wishlist WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null || result is DBNull)
                    return 0;

                return (int)result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error getting wishlist item count: " + ex.Message);
            }
        }

        // Move item from wishlist to cart
        public static bool MoveToCart(int userID, int bookID, int quantity = 1)
        {
            try
            {
                // Add to cart
                CartManager.AddToCart(userID, bookID, quantity);
                
                // Remove from wishlist
                RemoveFromWishlist(userID, bookID);
                
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error moving item to cart: " + ex.Message);
            }
        }
    }
}
