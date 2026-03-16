<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OracleClient" %>
<%@ Import Namespace="System.Configuration" %>

<!DOCTYPE html>
<html>
<head>
    <title>DB Diagnostic</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Table Columns Diagnostic</h2>
            <asp:GridView ID="gvColumns" runat="server"></asp:GridView>
        </div>
    </form>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                // Query to get all columns for tables in the current user's schema
                string sql = "SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE FROM USER_TAB_COLUMNS ORDER BY TABLE_NAME, COLUMN_ID";
                OracleCommand cmd = new OracleCommand(sql, conn);
                conn.Open();
                gvColumns.DataSource = cmd.ExecuteReader();
                gvColumns.DataBind();
            }
        }
    </script>
</body>
</html>
