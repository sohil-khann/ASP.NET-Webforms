using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using Bookstore.DAL;

namespace Bookstore.BLL
{
    public class UserManager
    {
        // Hash password using SHA256
        private static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        // Verify password
        public static bool VerifyPassword(string password, string hash)
        {
            string hashOfInput = HashPassword(password);
            return hashOfInput.Equals(hash);
        }

        // Register new user
        public static bool RegisterUser(string username, string email, string password, 
            string firstName, string lastName, string phone, string address, 
            string city, string state, string zipCode)
        {
            try
            {
                // Check if username already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email";
                SqlParameter[] checkParams = {
                    new SqlParameter("@Username", username),
                    new SqlParameter("@Email", email)
                };
                
                object result = DatabaseHelper.ExecuteScalar(checkQuery, checkParams);
                if ((int)result > 0)
                    return false;

                string hashedPassword = HashPassword(password);
                
                string query = @"INSERT INTO Users (Username, Email, Password, FirstName, LastName, 
                               PhoneNumber, Address, City, State, ZipCode) 
                               VALUES (@Username, @Email, @Password, @FirstName, @LastName, 
                               @Phone, @Address, @City, @State, @ZipCode)";

                SqlParameter[] parameters = {
                    new SqlParameter("@Username", username),
                    new SqlParameter("@Email", email),
                    new SqlParameter("@Password", hashedPassword),
                    new SqlParameter("@FirstName", firstName ?? ""),
                    new SqlParameter("@LastName", lastName ?? ""),
                    new SqlParameter("@Phone", phone ?? ""),
                    new SqlParameter("@Address", address ?? ""),
                    new SqlParameter("@City", city ?? ""),
                    new SqlParameter("@State", state ?? ""),
                    new SqlParameter("@ZipCode", zipCode ?? "")
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error registering user: " + ex.Message);
            }
        }

        // Login user
        public static int LoginUser(string username, string password)
        {
            try
            {
                string query = "SELECT UserID, Password FROM Users WHERE Username = @Username";
                SqlParameter[] parameters = { new SqlParameter("@Username", username) };
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                
                if (dt.Rows.Count > 0)
                {
                    string storedHash = dt.Rows[0]["Password"].ToString();
                    if (VerifyPassword(password, storedHash))
                    {
                        return (int)dt.Rows[0]["UserID"];
                    }
                }
                return -1; // Login failed
            }
            catch (Exception ex)
            {
                throw new Exception("Error during login: " + ex.Message);
            }
        }

        // Get user by ID
        public static DataTable GetUserByID(int userID)
        {
            try
            {
                string query = "SELECT UserID, Username, Email, FirstName, LastName, PhoneNumber, " +
                              "Address, City, State, ZipCode, CreatedDate FROM Users WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userID) };
                
                return DatabaseHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving user: " + ex.Message);
            }
        }

        // Update user profile
        public static bool UpdateUserProfile(int userID, string firstName, string lastName, 
            string phone, string address, string city, string state, string zipCode)
        {
            try
            {
                string query = @"UPDATE Users SET FirstName = @FirstName, LastName = @LastName, 
                               PhoneNumber = @Phone, Address = @Address, City = @City, 
                               State = @State, ZipCode = @ZipCode, ModifiedDate = GETDATE() 
                               WHERE UserID = @UserID";

                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@FirstName", firstName ?? ""),
                    new SqlParameter("@LastName", lastName ?? ""),
                    new SqlParameter("@Phone", phone ?? ""),
                    new SqlParameter("@Address", address ?? ""),
                    new SqlParameter("@City", city ?? ""),
                    new SqlParameter("@State", state ?? ""),
                    new SqlParameter("@ZipCode", zipCode ?? "")
                };

                DatabaseHelper.ExecuteNonQuery(query, parameters);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating profile: " + ex.Message);
            }
        }

        // Change password
        public static bool ChangePassword(int userID, string oldPassword, string newPassword)
        {
            try
            {
                string query = "SELECT Password FROM Users WHERE UserID = @UserID";
                SqlParameter[] selectParams = { new SqlParameter("@UserID", userID) };
                
                DataTable dt = DatabaseHelper.ExecuteQuery(query, selectParams);
                if (dt.Rows.Count == 0)
                    return false;

                string storedHash = dt.Rows[0]["Password"].ToString();
                if (!VerifyPassword(oldPassword, storedHash))
                    return false;

                string newHash = HashPassword(newPassword);
                string updateQuery = "UPDATE Users SET Password = @Password WHERE UserID = @UserID";
                SqlParameter[] updateParams = {
                    new SqlParameter("@UserID", userID),
                    new SqlParameter("@Password", newHash)
                };

                DatabaseHelper.ExecuteNonQuery(updateQuery, updateParams);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Error changing password: " + ex.Message);
            }
        }

        // Check if username exists
        public static bool UsernameExists(string username)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                SqlParameter[] parameters = { new SqlParameter("@Username", username) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                return (int)result > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error checking username: " + ex.Message);
            }
        }

        // Check if email exists
        public static bool EmailExists(string email)
        {
            try
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlParameter[] parameters = { new SqlParameter("@Email", email) };
                
                object result = DatabaseHelper.ExecuteScalar(query, parameters);
                return (int)result > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error checking email: " + ex.Message);
            }
        }
    }
}
