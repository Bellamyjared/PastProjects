using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class Customer
    {
        [Required]
        [Key]
        [Display(Name = "Customer ID")]
        public int CustomerId { get; set; }
        [Required]
        [StringLength(25)]
        [Display(Name = "First Name")]
        public string CustFirstName { get; set; }
        [Required]
        [StringLength(25)]
        [Display(Name = "Last Name")]
        public string CustLastName { get; set; }
        [Required]
        [StringLength(75)]
        [Display(Name = "Address")]
        public string CustAddress { get; set; }
        [Required]
        [StringLength(50)]
        [Display(Name = "City")]
        public string CustCity { get; set; }
        [Required]
        [StringLength(2)]
        [Display(Name = "Province")]
        public string CustProv { get; set; }
        [Required]
        [RegularExpression(@"^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$",
         ErrorMessage = "Must be valid postal code")]
        [StringLength(7)]
        [Display(Name = "Postal Code")]
        public string CustPostal { get; set; }
        [StringLength(25)]
        [Display(Name = "Country")]
        public string CustCountry { get; set; }
        [StringLength(20)]
        [Display(Name = "Home Phone")]
        public string CustHomePhone { get; set; }
        [StringLength(20)]
        [Display(Name = "Business Phone")]
        public string CustBusPhone { get; set; }
        [StringLength(50)]
        [Display(Name = "Email")]
        public string CustEmail { get; set; }
        [Required]
        [StringLength(25)]
        public string UserName { get; set; }
        [Required]
        [StringLength(50)]
        public string Password { get; set; }
        [Required]
        [StringLength(50)]
        [Display(Name = "Confirm Password")]
        [Compare("Password",ErrorMessage ="Pasword Does Not Match")]
        public string ConfirmPassword { get; set; }


    }
}