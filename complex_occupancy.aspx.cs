using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Movie_Booking_System
{
    public partial class complex_occupancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAnalyse_Click(object sender, EventArgs e)
        {
            pnlResults.Visible = true;
            
            // Bind the repeater for the visual cards
            DataView dv = (DataView)dsOccupancy.Select(DataSourceSelectArguments.Empty);
            rptPerformers.DataSource = dv;
            rptPerformers.DataBind();

            // GridView is automatically bound via DataSourceID
            gvOccupancy.DataBind();
        }
    }
}
