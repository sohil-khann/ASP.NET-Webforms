using System;
using System.Data;
using System.Data.SqlClient;
using Bookstore.DAL;

namespace Bookstore.BLL
{
    public class BookManager
    {
        // Get all books
        public static DataTable GetAllBooks()
        {
            try
            {
                string query = @"SELECT BookID, Title, Author, Description, Price, Category, 
                               ISBN, PublishedDate, Stock, ImageURL, Rating FROM Books ORDER BY Title";
                return DatabaseHelper.ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving books: " + ex.Message);
            }
        }

        // Get book by ID
        public static DataTable GetBookByID(int bookID)
        {
            try
            {
                string query = @"SELECT BookID, Title, Author, Description, Price, Category, 
                               ISBN, PublishedDate, Stock, ImageURL, Rating FROM Books WHERE BookID = @BookID";
                SqlParameter[] parameters = { new SqlParameter("@BookID", bookID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving book: " + ex.Message);
            }
        }

        // Search books by title or author
        public static DataTable SearchBooks(string searchTerm)
        {
            try
            {
                string query = @"SELECT BookID, Title, Author, Description, Price, Category, 
                               ISBN, PublishedDate, Stock, ImageURL, Rating FROM Books 
                               WHERE Title LIKE @SearchTerm OR Author LIKE @SearchTerm 
                               ORDER BY Title";
                
                SqlParameter[] parameters = { 
                    new SqlParameter("@SearchTerm", "%" + searchTerm + "%") 
                };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error searching books: " + ex.Message);
            }
        }

        // Get books by category
        public static DataTable GetBooksByCategory(string category)
        {
            try
            {
                string query = @"SELECT BookID, Title, Author, Description, Price, Category, 
                               ISBN, PublishedDate, Stock, ImageURL, Rating FROM Books 
                               WHERE Category = @Category ORDER BY Title";
                
                SqlParameter[] parameters = { new SqlParameter("@Category", category) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving books by category: " + ex.Message);
            }
        }

        // Get all categories
        public static DataTable GetCategories()
        {
            try
            {
                string query = "SELECT DISTINCT Category FROM Books WHERE Category IS NOT NULL ORDER BY Category";
                return DatabaseHelper.ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving categories: " + ex.Message);
            }
        }

        // Add new book (Admin function)
        public static bool AddBook(string title, string author, string description, decimal price, 
            string category, string isbn, DateTime publishedDate, int stock, string imageURL)
        {
            try
            {
                string query = @"INSERT INTO Books (Title, Author, Description, Price, Category, 
                               ISBN, PublishedDate, Stock, ImageURL) 
                               VALUES (@Title, @Author, @Description, @Price, @Category, 
                               @ISBN, @PublishedDate, @Stock, @ImageURL)";

                SqlParameter[] parameters = {
                    new SqlParameter("@Title", title),
                    new SqlParameter("@Author", author),
                    new SqlParameter("@Description", description ?? ""),
                    new SqlParameter("@Price", price),
                    new SqlParameter("@Category", category ?? ""),
                    new SqlParameter("@ISBN", isbn ?? ""),
                    new SqlParameter("@PublishedDate", publishedDate),
                    new SqlParameter("@Stock", stock),
                    new SqlParameter("@ImageURL", imageURL ?? "")
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error adding book: " + ex.Message);
            }
        }

        // Update book (Admin function)
        public static bool UpdateBook(int bookID, string title, string author, string description, 
            decimal price, string category, string isbn, DateTime publishedDate, int stock, string imageURL)
        {
            try
            {
                string query = @"UPDATE Books SET Title = @Title, Author = @Author, 
                               Description = @Description, Price = @Price, Category = @Category, 
                               ISBN = @ISBN, PublishedDate = @PublishedDate, Stock = @Stock, 
                               ImageURL = @ImageURL, ModifiedDate = GETDATE() WHERE BookID = @BookID";

                SqlParameter[] parameters = {
                    new SqlParameter("@BookID", bookID),
                    new SqlParameter("@Title", title),
                    new SqlParameter("@Author", author),
                    new SqlParameter("@Description", description ?? ""),
                    new SqlParameter("@Price", price),
                    new SqlParameter("@Category", category ?? ""),
                    new SqlParameter("@ISBN", isbn ?? ""),
                    new SqlParameter("@PublishedDate", publishedDate),
                    new SqlParameter("@Stock", stock),
                    new SqlParameter("@ImageURL", imageURL ?? "")
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating book: " + ex.Message);
            }
        }

        // Delete book (Admin function)
        public static bool DeleteBook(int bookID)
        {
            try
            {
                string query = "DELETE FROM Books WHERE BookID = @BookID";
                SqlParameter[] parameters = { new SqlParameter("@BookID", bookID) };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error deleting book: " + ex.Message);
            }
        }

        // Check book availability
        public static bool IsBookAvailable(int bookID, int quantity)
        {
            try
            {
                string query = "SELECT Stock FROM Books WHERE BookID = @BookID";
                SqlParameter[] parameters = { new SqlParameter("@BookID", bookID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null)
                    return false;

                int stock = (int)result;
                return stock >= quantity;
            }
            catch (Exception ex)
            {
                throw new Exception("Error checking book availability: " + ex.Message);
            }
        }

        // Get price by book ID
        public static decimal GetBookPrice(int bookID)
        {
            try
            {
                string query = "SELECT Price FROM Books WHERE BookID = @BookID";
                SqlParameter[] parameters = { new SqlParameter("@BookID", bookID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null)
                    return 0;

                return Convert.ToDecimal(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error getting book price: " + ex.Message);
            }
        }

        // Update book stock
        public static bool UpdateBookStock(int bookID, int quantity)
        {
            try
            {
                string query = "UPDATE Books SET Stock = Stock - @Quantity WHERE BookID = @BookID AND Stock >= @Quantity";
                SqlParameter[] parameters = {
                    new SqlParameter("@BookID", bookID),
                    new SqlParameter("@Quantity", quantity)
                };
                
                int rowsAffected = DatabaseHelper.ExecuteNonQuery(query, parameters);
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating book stock: " + ex.Message);
            }
        }
    }
}
