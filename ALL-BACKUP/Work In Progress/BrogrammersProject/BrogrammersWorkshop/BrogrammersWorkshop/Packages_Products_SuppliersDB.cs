using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrogrammersWorkshop
{
    public class Packages_Products_SuppliersDB
    {
        //retrieve a list of packages products and suppliers for the table
        public static List<Packages_Products_Suppliers> GetPackProductsSuppliers()
        {
            List<Packages_Products_Suppliers> packProdSup = new List<Packages_Products_Suppliers>(); //empty list
            Packages_Products_Suppliers pkgProdSup; // aux for reading

            using (SqlConnection connection = TravelExpertsDB.GetConnection())
            {
                string query = "SELECT * " +
                               "FROM Packages_Products_Suppliers " +
                               "ORDER BY PackageId";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (reader.Read())
                    {
                        pkgProdSup = new Packages_Products_Suppliers();
                        pkgProdSup.PackageId = (int)reader["PackageId"];
                        pkgProdSup.ProductSupplierId = (int)reader["ProductSupplierId"];
                        packProdSup.Add(pkgProdSup);
                    }
                }
            }
            return packProdSup;
        }
        // retrieve a single package product and supplier data
        public static Packages_Products_Suppliers GetPackProdSup(int PackageID)
        {
            //creating the object to store the orders information
            Packages_Products_Suppliers pkgProdSup = null;
            //opening a connection to SQL and inputting a query to access the specific orderIDs information
            using (SqlConnection connection = TravelExpertsDB.GetConnection())
            {
                string query = "SELECT * " +
                                "FROM Packages " +
                                "WHERE PackageID = @PackageID";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@PackageID", PackageID);
                    connection.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                    {
                        //store values into the order object
                        if (reader.Read())
                        {
                            pkgProdSup = new Packages_Products_Suppliers();
                            pkgProdSup.PackageId = (int)reader["PackageId"];
                            pkgProdSup.ProductSupplierId = (int)reader["ProductSupplierId"];
                        }
                    }
                }
            }
            return pkgProdSup;
        }// Get Packages and suppliers method completed
    }
}