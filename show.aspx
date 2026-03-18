<%@ Page Title="Shows" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="show.aspx.cs" Inherits="Movie_Booking_System.show" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Shows Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Shows Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create Show
        </button>
    </div>

    <!-- Add Form (Hidden by default) -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New Show</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="SHOW_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Show ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="SHOW_IDTextBox" runat="server" Text='<%# Bind("SHOW_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="SHOW_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateShowGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Show Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="SHOW_NAMETextBox" runat="server" Text='<%# Bind("SHOW_NAME") %>' CssClass="form-control" placeholder="Enter Name" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="SHOW_NAMETextBox" ErrorMessage="Name is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateShowGroup" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Show Time <span class="text-danger">*</span></label>
                                <asp:TextBox ID="SHOW_TIMETextBox" runat="server" Text='<%# Bind("SHOW_TIME") %>' CssClass="form-control" placeholder="HH:MM" />
                                <asp:RequiredFieldValidator ID="rfvTime" runat="server" ControlToValidate="SHOW_TIMETextBox" ErrorMessage="Time is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateShowGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Show Date <span class="text-danger">*</span></label>
                                <asp:TextBox ID="SHOW_DATETextBox" runat="server" Text='<%# Bind("SHOW_DATE") %>' CssClass="form-control" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="SHOW_DATETextBox" ErrorMessage="Date is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateShowGroup" />
                            </div>
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Show" CssClass="btn btn-success" ValidationGroup="CreateShowGroup" />
                            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateShowGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
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
            <h6 class="m-0 font-weight-bold text-primary">Show List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SHOW_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="SHOW_ID" HeaderText="ID" ReadOnly="True" SortExpression="SHOW_ID" />
                        <asp:TemplateField HeaderText="Show Name" SortExpression="SHOW_NAME">
                            <ItemTemplate><%# Eval("SHOW_NAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("SHOW_NAME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditShowGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Time" SortExpression="SHOW_TIME">
                            <ItemTemplate><%# Eval("SHOW_TIME", "{0:HH:mm}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditTime" runat="server" Text='<%# Bind("SHOW_TIME", "{0:HH:mm}") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditTime" runat="server" ControlToValidate="txtEditTime" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditShowGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date" SortExpression="SHOW_DATE">
                            <ItemTemplate><%# Eval("SHOW_DATE", "{0:yyyy-MM-dd}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDate" runat="server" Text='<%# Bind("SHOW_DATE", "{0:yyyy-MM-dd}") %>' CssClass="form-control form-control-sm" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvEditDate" runat="server" ControlToValidate="txtEditDate" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditShowGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditShowGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;SHOW&quot; WHERE &quot;SHOW_ID&quot; = :SHOW_ID" 
        InsertCommand="INSERT INTO &quot;SHOW&quot; (&quot;SHOW_NAME&quot;, &quot;SHOW_ID&quot;, &quot;SHOW_TIME&quot;, &quot;SHOW_DATE&quot;) VALUES (:SHOW_NAME, :SHOW_ID, :SHOW_TIME, :SHOW_DATE)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;SHOW_NAME&quot;, &quot;SHOW_ID&quot;, &quot;SHOW_TIME&quot;, &quot;SHOW_DATE&quot; FROM &quot;SHOW&quot;" 
        UpdateCommand="UPDATE &quot;SHOW&quot; SET &quot;SHOW_NAME&quot; = :SHOW_NAME, &quot;SHOW_TIME&quot; = :SHOW_TIME, &quot;SHOW_DATE&quot; = :SHOW_DATE WHERE &quot;SHOW_ID&quot; = :SHOW_ID"
        OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="SHOW_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="SHOW_NAME" Type="String" />
            <asp:Parameter Name="SHOW_ID" Type="String" />
            <asp:Parameter Name="SHOW_TIME" Type="DateTime" />
            <asp:Parameter Name="SHOW_DATE" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SHOW_NAME" Type="String" />
            <asp:Parameter Name="SHOW_TIME" Type="DateTime" />
            <asp:Parameter Name="SHOW_DATE" Type="DateTime" />
            <asp:Parameter Name="SHOW_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
