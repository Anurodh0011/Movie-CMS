using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.OracleClient;

#pragma warning disable 618
namespace Movie_Booking_System
{
    public partial class complex_theater_movie : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCities();
            }
        }

        private void LoadCities()
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                string sql = "SELECT DISTINCT THEATER_CITY FROM THEATER ORDER BY THEATER_CITY";
                OracleCommand cmd = new OracleCommand(sql, conn);
                conn.Open();
                ddlCity.DataSource = cmd.ExecuteReader();
                ddlCity.DataTextField = "THEATER_CITY";
                ddlCity.DataValueField = "THEATER_CITY";
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem("-- Select City --", ""));
            }
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCity.SelectedValue)) return;
            
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                // Join via HALL_SHOW to find theaters in this city
                string sql = "SELECT DISTINCT th.THEATER_NAME FROM THEATER th JOIN HALL_SHOW hs ON th.THEATER_ID = hs.THEATER_ID WHERE th.THEATER_CITY = :city ORDER BY th.THEATER_NAME";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.AddWithValue("city", ddlCity.SelectedValue);
                conn.Open();
                ddlTheater.DataSource = cmd.ExecuteReader();
                ddlTheater.DataTextField = "THEATER_NAME";
                ddlTheater.DataValueField = "THEATER_NAME";
                ddlTheater.DataBind();
                ddlTheater.Items.Insert(0, new ListItem("-- Select Theater --", ""));
            }
            ddlHall.Items.Clear();
        }

        protected void ddlTheater_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlTheater.SelectedValue)) return;

            using (OracleConnection conn = new OracleConnection(connStr))
            {
                // Join via HALL_SHOW to find halls in this theater
                string sql = "SELECT DISTINCT h.HALL_NAME FROM HALL h JOIN HALL_SHOW hs ON h.HALL_ID = hs.HALL_ID JOIN THEATER th ON hs.THEATER_ID = th.THEATER_ID WHERE th.THEATER_NAME = :theater ORDER BY h.HALL_NAME";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.AddWithValue("theater", ddlTheater.SelectedValue);
                conn.Open();
                ddlHall.DataSource = cmd.ExecuteReader();
                ddlHall.DataTextField = "HALL_NAME";
                ddlHall.DataValueField = "HALL_NAME";
                ddlHall.DataBind();
                ddlHall.Items.Insert(0, new ListItem("-- Select Hall --", ""));
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlResults.Visible = true;
            litResCity.Text = ddlCity.SelectedValue;
            litResTheater.Text = ddlTheater.SelectedValue;
            litResHall.Text = ddlHall.SelectedValue;

            gvShows.DataSourceID = "dsShows";
            gvShows.DataBind();

            DataView dv = (DataView)dsShows.Select(DataSourceSelectArguments.Empty);
            litShowCount.Text = (dv != null) ? dv.Count.ToString() : "0";
        }
    }
}
