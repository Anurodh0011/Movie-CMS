<%@ Page Title="Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ticket.aspx.cs" Inherits="Movie_Booking_System.ticket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Tickets Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Tickets Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create Ticket
        </button>
    </div>

    <!-- Add Form (Hidden by default) -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New Ticket</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="TICKET_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ticket ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="TICKET_IDTextBox" runat="server" Text='<%# Bind("TICKET_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="TICKET_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTicketGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ticket Time <span class="text-danger">*</span></label>
                                <asp:TextBox ID="TICKET_TIMETextBox" runat="server" Text='<%# Bind("TICKET_TIME") %>' CssClass="form-control" placeholder="HH:MM" />
                                <asp:RequiredFieldValidator ID="rfvTime" runat="server" ControlToValidate="TICKET_TIMETextBox" ErrorMessage="Time is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTicketGroup" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Seat Number <span class="text-danger">*</span></label>
                                <asp:TextBox ID="SEAT_NOTextBox" runat="server" Text='<%# Bind("SEAT_NO") %>' CssClass="form-control" placeholder="e.g. A1, B12" />
                                <asp:RequiredFieldValidator ID="rfvSeat" runat="server" ControlToValidate="SEAT_NOTextBox" ErrorMessage="Seat is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTicketGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Price <span class="text-danger">*</span></label>
                                <asp:TextBox ID="PRICETextBox" runat="server" Text='<%# Bind("PRICE") %>' CssClass="form-control" placeholder="Enter Price" />
                                <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="PRICETextBox" ErrorMessage="Price is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTicketGroup" />
                                <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="PRICETextBox" ErrorMessage="Numeric only" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTicketGroup" ValidationExpression="^\d+(\.\d{1,2})?$" />
                            </div>
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Ticket" CssClass="btn btn-success" ValidationGroup="CreateTicketGroup" />
                            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateTicketGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
                        <script type="text/javascript">
                            if (typeof Page_IsValid !== 'undefined' && !Page_IsValid) {
                                document.querySelector('.form-container').style.display = 'block';
                            }
                        </script>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>

    <!-- List Table -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Ticket List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TICKET_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="TICKET_ID" HeaderText="ID" ReadOnly="True" SortExpression="TICKET_ID" />
                        <asp:TemplateField HeaderText="Time" SortExpression="TICKET_TIME">
                            <ItemTemplate><%# Eval("TICKET_TIME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditTime" runat="server" Text='<%# Bind("TICKET_TIME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditTime" runat="server" ControlToValidate="txtEditTime" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTicketGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Seat No" SortExpression="SEAT_NO">
                            <ItemTemplate><%# Eval("SEAT_NO") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditSeat" runat="server" Text='<%# Bind("SEAT_NO") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditSeat" runat="server" ControlToValidate="txtEditSeat" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTicketGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price" SortExpression="PRICE">
                            <ItemTemplate><%# Eval("PRICE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("PRICE") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditPrice" runat="server" ControlToValidate="txtEditPrice" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTicketGroup" />
                                <asp:RegularExpressionValidator ID="revEditPrice" runat="server" ControlToValidate="txtEditPrice" ErrorMessage="?" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTicketGroup" ValidationExpression="^\d+(\.\d{1,2})?$" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditTicketGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;TICKET&quot; WHERE &quot;TICKET_ID&quot; = :TICKET_ID" 
        InsertCommand="INSERT INTO &quot;TICKET&quot; (&quot;TICKET_ID&quot;, &quot;TICKET_TIME&quot;, &quot;SEAT_NO&quot;, &quot;PRICE&quot;) VALUES (:TICKET_ID, :TICKET_TIME, :SEAT_NO, :PRICE)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;TICKET_ID&quot;, &quot;TICKET_TIME&quot;, &quot;SEAT_NO&quot;, &quot;PRICE&quot; FROM &quot;TICKET&quot;" 
        UpdateCommand="UPDATE &quot;TICKET&quot; SET &quot;TICKET_TIME&quot; = :TICKET_TIME, &quot;SEAT_NO&quot; = :SEAT_NO, &quot;PRICE&quot; = :PRICE WHERE &quot;TICKET_ID&quot; = :TICKET_ID"
        OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="TICKET_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TICKET_ID" Type="String" />
            <asp:Parameter Name="TICKET_TIME" Type="DateTime" />
            <asp:Parameter Name="SEAT_NO" Type="String" />
            <asp:Parameter Name="PRICE" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TICKET_TIME" Type="DateTime" />
            <asp:Parameter Name="SEAT_NO" Type="String" />
            <asp:Parameter Name="PRICE" Type="String" />
            <asp:Parameter Name="TICKET_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
