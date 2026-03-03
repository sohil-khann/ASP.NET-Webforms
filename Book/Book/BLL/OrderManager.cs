using System;
using System.Data;
using System.Data.SqlClient;
using Bookstore.DAL;

namespace Bookstore.BLL
{
    public class OrderManager
    {
        // Get all orders for user
        public static DataTable GetUserOrders(int userID)
        {
            try
            {
                string query = @"SELECT OrderID, OrderDate, TotalAmount, Status, 
                               ShippingCity, ShippingState, DeliveryDate 
                               FROM Orders 
                               WHERE UserID = @UserID 
                               ORDER BY OrderDate DESC";
                
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving orders: " + ex.Message);
            }
        }

        // Get order details
        public static DataTable GetOrderDetails(int orderID)
        {
            try
            {
                string query = @"SELECT od.OrderDetailID, od.BookID, b.Title, b.Author, 
                               od.Quantity, od.UnitPrice, od.TotalPrice 
                               FROM OrderDetails od 
                               INNER JOIN Books b ON od.BookID = b.BookID 
                               WHERE od.OrderID = @OrderID";
                
                SqlParameter[] parameters = { new SqlParameter("@OrderID", orderID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving order details: " + ex.Message);
            }
        }

        // Get order header information
        public static DataTable GetOrderHeader(int orderID)
        {
            try
            {
                string query = @"SELECT OrderID, UserID, OrderDate, TotalAmount, Status, 
                               ShippingAddress, ShippingCity, ShippingState, ShippingZipCode, 
                               DeliveryDate FROM Orders WHERE OrderID = @OrderID";
                
                SqlParameter[] parameters = { new SqlParameter("@OrderID", orderID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving order header: " + ex.Message);
            }
        }

        // Place order from cart
        public static int PlaceOrder(int userID, string shippingAddress, string shippingCity, 
            string shippingState, string shippingZipCode)
        {
            SqlConnection connection = null;
            SqlTransaction transaction = null;

            try
            {
                connection = DatabaseHelper.GetConnection();
                connection.Open();
                transaction = connection.BeginTransaction();

                // Get cart items
                DataTable cartItems = CartManager.GetCartItems(userID);
                if (cartItems.Rows.Count == 0)
                {
                    throw new Exception("Cart is empty");
                }

                // Calculate total
                decimal totalAmount = 0;
                foreach (DataRow row in cartItems.Rows)
                {
                    totalAmount += Convert.ToDecimal(row["TotalPrice"]);
                }

                // Insert order header
                string orderQuery = @"INSERT INTO Orders (UserID, TotalAmount, Status, 
                                    ShippingAddress, ShippingCity, ShippingState, ShippingZipCode) 
                                    VALUES (@UserID, @TotalAmount, 'Pending', @ShippingAddress, 
                                    @ShippingCity, @ShippingState, @ShippingZipCode); 
                                    SELECT SCOPE_IDENTITY();";

                SqlCommand orderCommand = new SqlCommand(orderQuery, connection, transaction);
                orderCommand.Parameters.AddWithValue("@UserID", userID);
                orderCommand.Parameters.AddWithValue("@TotalAmount", totalAmount);
                orderCommand.Parameters.AddWithValue("@ShippingAddress", shippingAddress ?? "");
                orderCommand.Parameters.AddWithValue("@ShippingCity", shippingCity ?? "");
                orderCommand.Parameters.AddWithValue("@ShippingState", shippingState ?? "");
                orderCommand.Parameters.AddWithValue("@ShippingZipCode", shippingZipCode ?? "");

                int orderID = Convert.ToInt32(orderCommand.ExecuteScalar());

                // Insert order details and update stock
                foreach (DataRow row in cartItems.Rows)
                {
                    int bookID = (int)row["BookID"];
                    int quantity = (int)row["Quantity"];
                    decimal unitPrice = Convert.ToDecimal(row["Price"]);
                    decimal totalPrice = Convert.ToDecimal(row["TotalPrice"]);

                    // Insert order detail
                    string detailQuery = @"INSERT INTO OrderDetails (OrderID, BookID, Quantity, 
                                          UnitPrice, TotalPrice) 
                                          VALUES (@OrderID, @BookID, @Quantity, @UnitPrice, @TotalPrice)";

                    SqlCommand detailCommand = new SqlCommand(detailQuery, connection, transaction);
                    detailCommand.Parameters.AddWithValue("@OrderID", orderID);
                    detailCommand.Parameters.AddWithValue("@BookID", bookID);
                    detailCommand.Parameters.AddWithValue("@Quantity", quantity);
                    detailCommand.Parameters.AddWithValue("@UnitPrice", unitPrice);
                    detailCommand.Parameters.AddWithValue("@TotalPrice", totalPrice);

                    detailCommand.ExecuteNonQuery();

                    // Update book stock
                    string updateStockQuery = "UPDATE Books SET Stock = Stock - @Quantity WHERE BookID = @BookID";
                    SqlCommand updateStockCommand = new SqlCommand(updateStockQuery, connection, transaction);
                    updateStockCommand.Parameters.AddWithValue("@BookID", bookID);
                    updateStockCommand.Parameters.AddWithValue("@Quantity", quantity);

                    updateStockCommand.ExecuteNonQuery();
                }

                // Clear cart
                string clearCartQuery = "DELETE FROM Cart WHERE UserID = @UserID";
                SqlCommand clearCartCommand = new SqlCommand(clearCartQuery, connection, transaction);
                clearCartCommand.Parameters.AddWithValue("@UserID", userID);
                clearCartCommand.ExecuteNonQuery();

                transaction.Commit();
                return orderID;
            }
            catch (Exception ex)
            {
                if (transaction != null)
                    transaction.Rollback();
                throw new Exception("Error placing order: " + ex.Message);
            }
            finally
            {
                if (connection != null && connection.State == ConnectionState.Open)
                    connection.Close();
            }
        }

        // Update order status
        public static bool UpdateOrderStatus(int orderID, string status)
        {
            try
            {
                string query = "UPDATE Orders SET Status = @Status, ModifiedDate = GETDATE() WHERE OrderID = @OrderID";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@OrderID", orderID),
                    new SqlParameter("@Status", status)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating order status: " + ex.Message);
            }
        }

        // Update delivery date
        public static bool UpdateDeliveryDate(int orderID, DateTime deliveryDate)
        {
            try
            {
                string query = "UPDATE Orders SET DeliveryDate = @DeliveryDate, ModifiedDate = GETDATE() WHERE OrderID = @OrderID";
                
                SqlParameter[] parameters = {
                    new SqlParameter("@OrderID", orderID),
                    new SqlParameter("@DeliveryDate", deliveryDate)
                };
                
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating delivery date: " + ex.Message);
            }
        }

        // Cancel order
        public static bool CancelOrder(int orderID)
        {
            SqlConnection connection = null;
            SqlTransaction transaction = null;

            try
            {
                connection = DatabaseHelper.GetConnection();
                connection.Open();
                transaction = connection.BeginTransaction();

                // Check order status
                string statusQuery = "SELECT Status FROM Orders WHERE OrderID = @OrderID";
                SqlCommand statusCommand = new SqlCommand(statusQuery, connection, transaction);
                statusCommand.Parameters.AddWithValue("@OrderID", orderID);
                
                object statusResult = statusCommand.ExecuteScalar();
                if (statusResult == null)
                    throw new Exception("Order not found");

                string currentStatus = statusResult.ToString();
                if (currentStatus != "Pending")
                    throw new Exception("Only pending orders can be cancelled");

                // Get order details to restore stock
                string detailsQuery = @"SELECT BookID, Quantity FROM OrderDetails WHERE OrderID = @OrderID";
                SqlCommand detailsCommand = new SqlCommand(detailsQuery, connection, transaction);
                detailsCommand.Parameters.AddWithValue("@OrderID", orderID);
                
                SqlDataAdapter adapter = new SqlDataAdapter(detailsCommand);
                DataTable details = new DataTable();
                adapter.Fill(details);

                // Restore stock
                foreach (DataRow row in details.Rows)
                {
                    int bookID = (int)row["BookID"];
                    int quantity = (int)row["Quantity"];

                    string restoreQuery = "UPDATE Books SET Stock = Stock + @Quantity WHERE BookID = @BookID";
                    SqlCommand restoreCommand = new SqlCommand(restoreQuery, connection, transaction);
                    restoreCommand.Parameters.AddWithValue("@BookID", bookID);
                    restoreCommand.Parameters.AddWithValue("@Quantity", quantity);
                    restoreCommand.ExecuteNonQuery();
                }

                // Update order status
                string updateQuery = "UPDATE Orders SET Status = 'Cancelled', ModifiedDate = GETDATE() WHERE OrderID = @OrderID";
                SqlCommand updateCommand = new SqlCommand(updateQuery, connection, transaction);
                updateCommand.Parameters.AddWithValue("@OrderID", orderID);
                updateCommand.ExecuteNonQuery();

                transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                if (transaction != null)
                    transaction.Rollback();
                throw new Exception("Error cancelling order: " + ex.Message);
            }
            finally
            {
                if (connection != null && connection.State == ConnectionState.Open)
                    connection.Close();
            }
        }

        // Get total orders count
        public static int GetUserOrderCount(int userID)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Orders WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                if (result == null || result is DBNull)
                    return 0;

                return (int)result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error getting order count: " + ex.Message);
            }
        }
    }
}
