using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Movie_Booking_System
{
    public partial class complex_user_tickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Default dates: last 6 months to today
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFromDate.Text = DateTime.Now.AddMonths(-6).ToString("yyyy-MM-dd");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlResults.Visible = true;
            
            // Re-bind the ticket grid with the filters
            gvTickets.DataSourceID = "dsTickets";
            gvTickets.DataBind();

            // Set period text
            litPeriod.Text = txtFromDate.Text + " — " + txtToDate.Text;

            // Simple count logic (can be improved by using the DB count but for demo purposes)
            DataView dv = (DataView)dsTickets.Select(DataSourceSelectArguments.Empty);
            int count = (dv != null) ? dv.Count : 0;
            litTicketCount.Text = count.ToString();
            litTotal.Text = count.ToString();
            litBooked.Text = count.ToString();

            decimal totalPaid = 0;
            if (dv != null)
            {
                foreach (DataRowView row in dv)
                {
                    totalPaid += Convert.ToDecimal(row["PRICE"]);
                }
            }
            litTotalPaid.Text = string.Format("{0:N0}", totalPaid);
        }
    }
}
