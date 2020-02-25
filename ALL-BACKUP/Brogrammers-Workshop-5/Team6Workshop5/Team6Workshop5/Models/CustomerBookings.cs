using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class CustomerBookings
    {

        //PACKAGES

        [Display(Name = "")]
        public string PACKCustFirstName { get; set; }

        [Display(Name = "Product Name")]
        public string PACKProdName { get; set; }

        [Display(Name = "Price")]
        [DataType(DataType.Currency)]
        public decimal? PACKBasePrice { get; set; }

        [Display(Name = "Package Name")]
        public string PACKPkgName { get; set; }

        [Display(Name = "Price")]
        [DataType(DataType.Currency)]
        public decimal? PACKPkgBasePrice { get; set; }

        [Display(Name = "Booking ID")]
        public int? PACKBookingId { get; set; }

        [Display(Name = "Total")]
        [DataType(DataType.Currency)]
        public decimal? PACKTotal { get; set; }

        //PRODUCTS
        public string PRODCustFirstName { get; set; }

        [Display(Name = "Product Name")]
        public string PRODProdName { get; set; }

        [Display(Name = "Price")]
        [DataType(DataType.Currency)]
        public decimal? PRODBasePrice { get; set; }

        [Display(Name = "Booking ID")]
        public int? PRODBookingId { get; set; }

        [Display(Name = "Total")]
        [DataType(DataType.Currency)]
        public decimal? PRODTotal { get; set; }
    }
}