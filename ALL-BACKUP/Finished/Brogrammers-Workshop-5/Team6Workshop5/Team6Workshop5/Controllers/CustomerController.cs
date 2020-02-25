using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Team6Workshop5.Models;

namespace Team6Workshop5.Controllers
{
    public class CustomerController : Controller
    {
        Customer customer; //customer reference
        // GET: Customer
       
        public ActionResult Index()
        {
            //check for nulls and redirect if necessary
            if (Session["UserID"] == null)
            {
               return RedirectToAction("Login");
            }
            //return customer details
            else
            {
                int id = Convert.ToInt32(Session["UserID"]);

                customer = CustomerDB.GetCustomerDetails(id);
                return View(customer);
            }

        }


        //GET: CustomerBookings
        public ActionResult CustomerBookings()
        {
            //if user is not logged in
            if (Session["UserID"] == null)
            {
                return RedirectToAction("Login");
            }
            //if user is logged in
            else
            {
                //makes new list from the model
                List<CustomerBookings> accPackBookingsList = new List<CustomerBookings>();
                //grabs userID from the currect session for SQL statement
                int id = Convert.ToInt32(Session["UserID"]);

                //populates the list based off of sql command
                accPackBookingsList = CustomerBookingsDB.GetPackBookings(id);

                //sends list to the view
                return View(accPackBookingsList);
            }
        }

        // GET: Customer/Details/5
        public ActionResult Details(int id)
        {
           
           return View();
        }

        
        // GET: Customer/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Customer/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Customer customer)
        {
            try
            {
                var custInfo = CustomerDB.GetCustomerInfo(customer.UserName);

                // check to see if the username already exists
                if(custInfo != null)
                {
                    ViewBag.usertaken = "User ID Already Exist";
                    return View();
                }

                else
                {
                    if (customer.CustEmail == null)
                    {
                        customer.CustEmail = "";
                    }
                    if (customer.CustBusPhone == null)
                    {
                        customer.CustBusPhone = "";
                    }
                    customer.Password = Crypto.Hash(customer.Password);
                    CustomerDB.CustomerRegister(customer);

                    return RedirectToAction("Login");
                }
            }
            catch
            {
                return View();
            }
        }
        
        // GET: Customer/Edit/5
        public ActionResult Edit()
        {
            //check to see if user is logged in else redirect to login
            if (Session["UserID"] == null)
            {
                return RedirectToAction("Login");
            }
            else
            {
                int id = Convert.ToInt32(Session["UserID"]);
                Customer currentCust = CustomerDB.GetCustomerDetails(id);
                return View(currentCust);
            }
        }

        // POST: Customer/Edit/5
        [HttpPost]
        public ActionResult Edit(Customer newCustomer)
        {
            try
            {
                var custInfo = CustomerDB.GetCustomerInfo(newCustomer.UserName);
                int id = Convert.ToInt32(Session["UserID"]);
                Customer currentCust = CustomerDB.GetCustomerDetails(id);
                newCustomer.Password = Crypto.Hash(newCustomer.Password);
                // check to see if username has been taken
                if (custInfo != null && currentCust.UserName != custInfo.UserName)
                {
                    ViewBag.usertaken = "User ID Already Exist";
                    return View();
                }
                if (newCustomer.CustEmail == null)
                {
                    newCustomer.CustEmail = "";
                }
                if(newCustomer.CustBusPhone == null)
                {
                    newCustomer.CustBusPhone = "";
                }
               
                int count = CustomerDB.UpdateCustomer(currentCust, newCustomer);
                if (count == 0)// no update due to concurrency issue
                    TempData["errorMessage"] = "Update aborted. " +
                        "Another user changed or deleted this row";

                else
                    TempData["errorMessage"] = "";
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        // GET: Customer/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Customer/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // Controller for Login
        public ActionResult Login()
        {
            CustomerLogin loginInfo = new CustomerLogin();

            return View(loginInfo);
        }

        // Controller for Login
        [HttpPost]

        public ActionResult Login(CustomerLogin login)
        {
            Customer databaseUser = new Customer();
            databaseUser = CustomerDB.CustomerLogin(login.UserName);

            if (ModelState.IsValid)
            {
                if (databaseUser is null)
                {
                    //ModelState.AddModelError("Error", "User Name is Registered");
                    ViewBag.invalid = "Invalid User";
                    return View();
                }
                
                else
                {
                    var databasePassword = databaseUser.Password;
                    //if(databaseUser.Password != Crypto.Hash(login.Password))

                    int results = (string.Compare(Crypto.Hash(login.Password), databasePassword));
                    if (results != 0)
              
                    {
                        ViewBag.Password = "Invalid Password";
                        return View();
                    }

                    else
                    {
                        Session["UserID"] = databaseUser.CustomerId;
                        Session["CustFirstName"] = databaseUser.CustFirstName;
                    }
                    
                }
            }
           
            return RedirectToAction("Index","Customer");
        }

        public ActionResult Logout()
        {

            Session.Abandon();
            return RedirectToAction("Login");
        }
    }
}
