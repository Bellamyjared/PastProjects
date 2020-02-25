using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class CustomerBookingsDB
    {

        public static List<CustomerBookings> GetPackBookings(int custId) // custID = userID which is passed by the controller
        {
            //make an empty list
            List<CustomerBookings> accPackBookingsList = new List<CustomerBookings>();

            string sql1 = "Select C.CustFirstName, P.ProdName,BD.BasePrice, Pack.PkgName,Pack.PkgBasePrice,B.BookingId from "
                            + "Customers as C join Bookings as B "
                            + "on C.CustomerId= B.CustomerId "
                            + "join Packages as Pack on "
                            + "B.PackageId = Pack.PackageId "
                            + "join BookingDetails as BD "
                            + "on B.BookingId = BD.BookingId "
                            + "join  Products_Suppliers as PS "
                            + "on BD.ProductSupplierId= PS.ProductSupplierId "
                            + "join Products as P "
                            + "on Ps.ProductId=P.ProductId "
                            + "where C.CustomerId = @CustomerId "; 

            string sql2 = "Select C.CustFirstName, P.ProdName, BD.BasePrice, B.BookingId from "
                            + "Customers as C join Bookings as B "
                            + "on C.CustomerId= B.CustomerId "
                            + "join BookingDetails as BD "
                            + "on B.BookingId = BD.BookingId "
                            + "join  Products_Suppliers as PS "
                            + "on BD.ProductSupplierId= PS.ProductSupplierId "
                            + "join Products as P "
                            + "on Ps.ProductId=P.ProductId "
                            + "where C.CustomerId = @CustomerId ";


            using (SqlConnection con = new SqlConnection(TravelExpertsDB.GetConnectionString()))
            {
                //used in PACKAGES after PRODUCTS
                CustomerBookings packbooking;
                packbooking = new CustomerBookings();

                

                //PRODUCTS
                using (SqlCommand cmd = new SqlCommand(sql2, con))
                {
                    //put userID into sql
                    cmd.Parameters.AddWithValue("@CustomerId", custId);

                    //open connectoin
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader(); //variable to capture all the data that is gathered by sql query
                    CustomerBookings prodbooking; // creating object based off of customerBookings model

                    decimal? total = 0; // empty var for use later

                    while (dr.Read()) //for each set of data that is sent by the sql query
                    {
                        if (dr["ProdName"] != null) // if there is relevant data
                        {
                            //put data into object earlier made object
                            prodbooking = new CustomerBookings();
                            prodbooking.PRODCustFirstName = dr["CustFirstName"].ToString();
                            prodbooking.PRODProdName = dr["ProdName"].ToString();
                            prodbooking.PRODBasePrice = Convert.ToDecimal(dr["BasePrice"]);
                            prodbooking.PRODBookingId = Convert.ToInt32(dr["BookingId"]);

                            //add price to the total for each set of data
                            total += prodbooking.PRODBasePrice;

                            //sending the prod information to the list
                            accPackBookingsList.Add(prodbooking);
                        }
                    }
                    //close the reader
                    dr.Close();

                    //make another object
                    CustomerBookings prodbookingtest = new CustomerBookings();
                    //put data into object
                    prodbookingtest.PRODTotal = total;
                    //send object to the list
                    accPackBookingsList.Add(prodbookingtest);

                    //close connection
                    con.Close();
                }

                //PACKAGES
                //follow same principals as prods, please refer to PRODUCTS for comments
                using (SqlCommand cmd = new SqlCommand(sql1, con))
                {
                    cmd.Parameters.AddWithValue("@CustomerId", custId);


                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    decimal? total = 0;


                    while (dr.Read())
                    {
                        if (dr["PkgName"] != null)
                        {
                            packbooking.PACKCustFirstName = dr["CustFirstName"].ToString();
                            packbooking.PACKProdName = dr["ProdName"].ToString();
                            packbooking.PACKBasePrice = Convert.ToDecimal(dr["BasePrice"]);
                            packbooking.PACKPkgName = dr["PkgName"].ToString();
                            packbooking.PACKPkgBasePrice = Convert.ToDecimal(dr["PkgBasePrice"]);
                            packbooking.PACKBookingId = Convert.ToInt32(dr["BookingId"]);

                            total += packbooking.PACKPkgBasePrice;

                            //sending the packes information to the list
                            accPackBookingsList.Add(packbooking);

                        }
                    }
                    dr.Close();

                    CustomerBookings packbookingtest = new CustomerBookings();
                    packbookingtest.PACKTotal = total;
                    accPackBookingsList.Add(packbookingtest);

                }
            }
            //return the list to whatever calls the method
            return accPackBookingsList;
        }
    }
}