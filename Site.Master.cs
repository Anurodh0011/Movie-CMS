using System;
using System.Linq;
using System.Web.UI;

namespace Movie_Booking_System
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ltMessage.Text = ""; // Clear message on each load
        }

        public void ShowMessage(string message, string type = "success")
        {
            string icon = type == "success" ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill";
            ltMessage.Text = $@"
                <div class='alert alert-{type} alert-dismissible fade show shadow-sm border-0 mb-4' role='alert' style='border-radius: 12px; animation: slideInDown 0.4s ease-out;'>
                    <div class='d-flex align-items-center'>
                        <i class='bi {icon} me-3 fs-4'></i>
                        <div>
                            <strong class='d-block'>{(type == "success" ? "Success!" : "Action Required")}</strong>
                            {message}
                        </div>
                    </div>
                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                </div>
                <style>
                    @keyframes slideInDown {{
                        from {{ transform: translateY(-30px); opacity: 0; }}
                        to {{ transform: translateY(0); opacity: 1; }}
                    }}
                </style>";
        }

        public void HandleSqlError(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e, string entityName)
        {
            if (e.Exception != null)
            {
                string msg = e.Exception.Message;
                if (msg.Contains("ORA-00001"))
                {
                    if (msg.ToUpper().Contains("EMAIL"))
                    {
                        ShowMessage("<strong>Duplicate Email!</strong> This email address is already registered. Please use a different one.", "danger");
                    }
                    else if (msg.ToUpper().Contains("PHONE") || msg.ToUpper().Contains("MOBILE"))
                    {
                        ShowMessage("<strong>Duplicate Mobile!</strong> This phone number is already registered. Please use a different one.", "danger");
                    }
                    else if (msg.ToUpper().Contains("_PK") || msg.ToUpper().Contains("PRIMARY"))
                    {
                        ShowMessage($"<strong>Duplicate ID!</strong> A {entityName} with this ID already exists. Please use a unique ID.", "danger");
                    }
                    else
                    {
                        // Extract constraint name from message if possible (usually in parentheses)
                        string constraint = "";
                        int start = msg.IndexOf('(');
                        int end = msg.IndexOf(')');
                        if (start >= 0 && end > start) constraint = msg.Substring(start + 1, end - start - 1);
                        
                        // Try to humanize the constraint name (e.g., MOVIE_TITLE_UQ -> Movie Title)
                        string fieldHint = "";
                        if (!string.IsNullOrEmpty(constraint))
                        {
                            string raw = constraint.Split('.').Last() // Remove owner
                                           .Replace("_UQ", "").Replace("_UK", "").Replace("_UNIQUE", "");
                            fieldHint = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(raw.Replace("_", " ").ToLower());
                        }

                        string details = !string.IsNullOrEmpty(fieldHint) ? $"the <strong>{fieldHint}</strong> field" : "some fields";
                        ShowMessage($"<strong>Constraint Violated!</strong> A {entityName} with this <strong>{fieldHint}</strong> already exists. (Database Constraint: {constraint}). " +
                                  "Only ID, Email, and Mobile should be unique in this system.", "danger");
                    }
                }
                else
                {
                    ShowMessage($"<strong>Database error:</strong> {msg}", "danger");
                }
                e.ExceptionHandled = true;
            }
            else
            {
                string action = "processed";
                if (e.Command.CommandText.TrimStart().StartsWith("INSERT", StringComparison.OrdinalIgnoreCase)) action = "added";
                else if (e.Command.CommandText.TrimStart().StartsWith("UPDATE", StringComparison.OrdinalIgnoreCase)) action = "updated";
                else if (e.Command.CommandText.TrimStart().StartsWith("DELETE", StringComparison.OrdinalIgnoreCase)) action = "deleted";

                ShowMessage($"Success! The <strong>{entityName}</strong> has been {action} successfully.", "success");
            }
        }
    }
}
