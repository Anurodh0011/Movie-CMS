using System;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;
using System.Xml;
using System.IO;

class Program {
    static void Main() {
        string configFile = "Web.config";
        string connStr = "";
        
        try {XmlDocument doc = new XmlDocument(); doc.Load(configFile);
            XmlNode node = doc.SelectSingleNode("//connectionStrings/add[@name='ConnectionString']");
            if (node != null) connStr = node.Attributes["connectionString"].Value;
        } catch { return; }

        using (OracleConnection conn = new OracleConnection(connStr)) {
            conn.Open();
            DataTable dt = conn.GetSchema("Tables");
            StreamWriter sw = new StreamWriter("full_schema.txt");
            foreach (DataRow row in dt.Rows) {
                string tableName = row["TABLE_NAME"].ToString();
                string owner = row["OWNER"].ToString();
                // Filter out system schemas except maybe the current one
                if (owner == "SYSTEM" || owner == "XDB" || owner == "SYS") continue;
                
                sw.WriteLine("Table: " + tableName + " (Owner: " + owner + ")");
                try {
                    DataTable cols = conn.GetSchema("Columns", new string[] { owner, tableName });
                    foreach(DataRow col in cols.Rows) {
                        sw.WriteLine("  " + col["COLUMN_NAME"]);
                    }
                } catch {}
            }
            sw.Close();
        }
    }
}
