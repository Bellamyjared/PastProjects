using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class CustomerDB
    {
        // pass in customer id and return their details
        public static Customer GetCustomerDetails(int custId)
        {
            Customer cust = null;
            string query = "SELECT CustomerId, CustFirstName, CustLastName, CustAddress, CustCity, CustProv, CustPostal, CustCountry, " +
                           "CustHomePhone, CustBusPhone, CustEmail, UserName " +
                           "FROM Customers " +
                           "WHERE CustomerId = @CustomerId";

            using (SqlConnection connection = new SqlConnection(TravelExpertsDB.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@CustomerId", custId);
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (reader.Read())
                    {
                        cust = new Customer();
                        cust.CustomerId = Convert.ToInt32(reader["CustomerId"]);
                        cust.CustFirstName = reader["CustFirstName"].ToString();
                        cust.CustLastName = reader["CustLastName"].ToString();
                        cust.CustAddress = reader["CustAddress"].ToString();
                        cust.CustCity = reader["CustCity"].ToString();
                        cust.CustProv = reader["CustProv"].ToString();
                        cust.CustPostal = reader["CustPostal"].ToString();
                        cust.CustCountry = reader["CustCountry"].ToString();
                        cust.CustHomePhone = reader["CustHomePhone"].ToString();
                        cust.CustBusPhone = reader["CustBusPhone"].ToString();
                        cust.CustEmail = reader["CustEmail"].ToString();
                        cust.UserName = reader["UserName"].ToString();

                    }
                }
            }
            return cust;
        }
        // register customers information
        public static void CustomerRegister(Customer customer)
        {
            string sql = "INSERT INTO Customers "
                + "(CustFirstName, CustLastName, CustAddress, CustCity, CustProv, CustPostal, CustCountry, CustHomePhone, CustBusPhone, CustEmail, UserName, Password) "
                + "VALUES (@CustFirstName, @CustLastName, @CustAddress, @CustCity, @CustProv, @CustPostal, @CustCountry, @CustHomePhone, @CustBusPhone, @CustEmail, @UserName, @Password)";
            using (SqlConnection con = new SqlConnection(TravelExpertsDB.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("CustFirstName", customer.CustFirstName);
                    cmd.Parameters.AddWithValue("CustLastName", customer.CustLastName);
                    cmd.Parameters.AddWithValue("CustAddress", customer.CustAddress);
                    cmd.Parameters.AddWithValue("CustCity", customer.CustCity);
                    cmd.Parameters.AddWithValue("CustProv", customer.CustProv);
                    cmd.Parameters.AddWithValue("CustPostal", customer.CustPostal);
                    cmd.Parameters.AddWithValue("CustCountry", customer.CustCountry);
                    cmd.Parameters.AddWithValue("CustHomePhone", customer.CustHomePhone);
                    cmd.Parameters.AddWithValue("CustBusPhone", customer.CustBusPhone);
                    cmd.Parameters.AddWithValue("CustEmail", customer.CustEmail);
                    cmd.Parameters.AddWithValue("UserName", customer.UserName);
                    cmd.Parameters.AddWithValue("Password", customer.Password);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // edit customers information
        public static int UpdateCustomer(Customer original_Customer,
    Customer new_Customer)
        {
            int updateCount = 0;
            
                string sql = "UPDATE Customers SET "
                    + "CustFirstName = @CustFirstName, "
                    + "CustLastName = @CustLastName, "
                    + "CustAddress = @CustAddress, "
                    + "CustCity = @CustCity, "
                    + "CustProv = @CustProv, "
                    + "CustPostal = @CustPostal, "
                    + "CustCountry = @CustCountry, "
                    + "CustHomePhone = @CustHomePhone, "
                    + "CustBusPhone = @CustBusPhone, "
                    + "CustEmail = @CustEmail, "
                    + "UserName = @UserName, "
                    + "Password = @Password "
                    + "WHERE CustomerId = @original_CustomerId";

                using (SqlConnection con = new SqlConnection(TravelExpertsDB.GetConnectionString()))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("CustFirstName", new_Customer.CustFirstName);
                        cmd.Parameters.AddWithValue("CustLastName", new_Customer.CustLastName);
                        cmd.Parameters.AddWithValue("CustAddress", new_Customer.CustAddress);
                        cmd.Parameters.AddWithValue("CustCity", new_Customer.CustCity);
                        cmd.Parameters.AddWithValue("CustProv", new_Customer.CustProv);
                        cmd.Parameters.AddWithValue("CustPostal", new_Customer.CustPostal);
                        cmd.Parameters.AddWithValue("CustCountry", new_Customer.CustCountry);
                        cmd.Parameters.AddWithValue("CustHomePhone", new_Customer.CustHomePhone);
                        cmd.Parameters.AddWithValue("CustBusPhone", new_Customer.CustBusPhone);
                        cmd.Parameters.AddWithValue("CustEmail", new_Customer.CustEmail);
                        cmd.Parameters.AddWithValue("UserName", new_Customer.UserName);
                        cmd.Parameters.AddWithValue("Password", new_Customer.Password);
                        cmd.Parameters.AddWithValue("original_CustomerId", original_Customer.CustomerId);
                        con.Open();
                        updateCount = cmd.ExecuteNonQuery();
                    }
                }
            return updateCount;
        }
        //check login credentials
        public static Customer CustomerLogin(string custUserName)
        {
            Customer cust = null;
            string query = "SELECT CustomerId, UserName, Password, CustFirstName " +
                           "FROM Customers " +
                           "WHERE UserName = @UserName";

            using (SqlConnection connection = new SqlConnection(TravelExpertsDB.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@UserName", custUserName);
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (reader.Read())
                    {
                        cust = new Customer();
                        cust.CustomerId = Convert.ToInt32(reader["CustomerId"]);
                        cust.UserName = reader["UserName"].ToString();
                        cust.Password = reader["Password"].ToString();
                        cust.CustFirstName = reader["CustFirstName"].ToString();
                    }
                }
            }
            return cust;
        }
        // get the customers information for checking with database
        public static Customer GetCustomerInfo(string userName)
        {
            Customer cust = null;
            string query = "SELECT CustomerId, CustFirstName, CustLastName, CustAddress, CustCity, CustProv, CustPostal, CustCountry, " +
                           "CustHomePhone, CustBusPhone, CustEmail, UserName " +
                           "FROM Customers " +
                           "WHERE UserName = @UserName";

            using (SqlConnection connection = new SqlConnection(TravelExpertsDB.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (reader.Read())
                    {
                        cust = new Customer();
                        cust.CustomerId = Convert.ToInt32(reader["CustomerId"]);
                        cust.CustFirstName = reader["CustFirstName"].ToString();
                        cust.CustLastName = reader["CustLastName"].ToString();
                        cust.CustAddress = reader["CustAddress"].ToString();
                        cust.CustCity = reader["CustCity"].ToString();
                        cust.CustProv = reader["CustProv"].ToString();
                        cust.CustPostal = reader["CustPostal"].ToString();
                        cust.CustCountry = reader["CustCountry"].ToString();
                        cust.CustHomePhone = reader["CustHomePhone"].ToString();
                        cust.CustBusPhone = reader["CustBusPhone"].ToString();
                        cust.CustEmail = reader["CustEmail"].ToString();
                        cust.UserName = reader["UserName"].ToString();

                    }
                }
            }
            return cust;
        }


    }
}