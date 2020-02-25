using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Team6Workshop5.Models
{
    public class CustomerLogin


    {   
        

        [Display(Name="User ID")]
        [Required(ErrorMessage ="Email is Required")]
        public string UserName { get; set; }

        [Display(Name="User Password")]
        [Required(ErrorMessage ="Password Is Requried")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}