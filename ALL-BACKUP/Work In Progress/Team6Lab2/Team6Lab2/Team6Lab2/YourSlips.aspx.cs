using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team6Lab2
{
    public partial class YourSlips : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //checks to see if the user is logged in, if not will redirect to login page
            bool loggedIn = System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            if (!loggedIn)
                Response.Redirect("Account/Login.aspx");
            else
            {
                //stores the customer ID as a reference for the fieldview
                string currentUser = Context.User.Identity.GetUserName();

                lblCustomerID.Text = CurrentUser(currentUser).ToString() ;
            }
        }
        public void Show_Lease(int ID)
        {

        }
        protected void gvCustomerLeases_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        public int CurrentUser(string currentUser)
        {
            //find the customer ID
            int result = -1;

            string connectionString = @"Data Source=localhost\sqlexpress;Initial Catalog=Marina;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string insertStatement =
                    "SELECT ID " +
                    "FROM Customer " +
                    "WHERE FirstName = @CurrentUser";
                using (SqlCommand cmd = new SqlCommand(insertStatement, connection))
                {
                    cmd.Parameters.AddWithValue("@CurrentUser", currentUser);
                    connection.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                    {
                        if (reader.Read()) // if there is data
                        {
                            result = Convert.ToInt32(reader["ID"]);
                        }
                    }
                }
                return result;
            }
        }
    }
}