using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class TravelExpertsDB
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["TravelExpertsConnection"].ConnectionString;
        }
    }
}