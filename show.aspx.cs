using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Booking_System
{
    public partial class show : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e) => ((Site)Master).HandleSqlError(sender, e, "Show");
        protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e) => ((Site)Master).HandleSqlError(sender, e, "Show");
        protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e) => ((Site)Master).HandleSqlError(sender, e, "Show");
    }
}