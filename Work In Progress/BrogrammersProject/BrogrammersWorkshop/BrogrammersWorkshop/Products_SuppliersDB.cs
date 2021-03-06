﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrogrammersWorkshop
{
    public class Products_SuppliersDB
    {
        //retrieve a list of packages products and suppliers for the table
        public static List<Products_Suppliers> GetProductsSuppliers()
        {
            List<Products_Suppliers> ProdSup = new List<Products_Suppliers>(); //empty list
            Products_Suppliers prodSup; // aux for reading

            using (SqlConnection connection = TravelExpertsDB.GetConnection())
            {
                string query = "SELECT * " +
                               "FROM Products_Suppliers " +
                               "ORDER BY ProductSupplierId";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (reader.Read())
                    {
                        prodSup = new Products_Suppliers();
                        prodSup.ProductSupplierId = (int)reader["ProductSupplierId"];
                        prodSup.ProductId = (int)reader["ProductId"];
                        prodSup.SupplierId = (int)reader["SupplierId"];
                        ProdSup.Add(prodSup);
                    }
                }
            }
            return ProdSup;
        }
        // retrieve a single package product and supplier data
        public static Products_Suppliers GetProdSup(int ProductSupplierId)
        {
            //creating the object to store the orders information
            Products_Suppliers prodSup = null;
            //opening a connection to SQL and inputting a query to access the specific orderIDs information
            using (SqlConnection connection = TravelExpertsDB.GetConnection())
            {
                string query = "SELECT * " +
                                "FROM Products_Suppliers " +
                                "WHERE ProductSupplierId = @ProductSupplierId";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@PackageID", ProductSupplierId);
                    connection.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                    {
                        //store values into the order object
                        if (reader.Read())
                        {
                            prodSup = new Products_Suppliers();
                            prodSup.ProductSupplierId = (int)reader["ProductSupplierId"];
                            prodSup.ProductId = (int)reader["ProductId"];
                            prodSup.SupplierId = (int)reader["SupplierId"];      
                        }
                    }
                }
            }
            return prodSup;
        }// Get Packages and suppliers method completed
    }
}