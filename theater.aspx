<%@ Page Title="Theaters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="theater.aspx.cs" Inherits="Movie_Booking_System.theater" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Theaters Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Theaters Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create Theater
        </button>
    </div>

    <!-- Add Form (Hidden by default) -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New Theater</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="THEATER_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Theater ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="THEATER_IDTextBox" runat="server" Text='<%# Bind("THEATER_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="THEATER_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTheaterGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Theater Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="THEATER_NAMETextBox" runat="server" Text='<%# Bind("THEATER_NAME") %>' CssClass="form-control" placeholder="Enter Name" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="THEATER_NAMETextBox" ErrorMessage="Name is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTheaterGroup" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">City <span class="text-danger">*</span></label>
                                <asp:TextBox ID="THEATER_CITYTextBox" runat="server" Text='<%# Bind("THEATER_CITY") %>' CssClass="form-control" placeholder="Enter City" />
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="THEATER_CITYTextBox" ErrorMessage="City is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTheaterGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Address <span class="text-danger">*</span></label>
                                <asp:TextBox ID="THEATER_ADDRESSTextBox" runat="server" Text='<%# Bind("THEATER_ADDRESS") %>' CssClass="form-control" placeholder="Enter Address" />
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="THEATER_ADDRESSTextBox" ErrorMessage="Address is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateTheaterGroup" />
                            </div>
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Theater" CssClass="btn btn-success" ValidationGroup="CreateTheaterGroup" />
                            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateTheaterGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
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
            <h6 class="m-0 font-weight-bold text-primary">Theater List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="THEATER_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="THEATER_ID" HeaderText="ID" ReadOnly="True" SortExpression="THEATER_ID" />
                        <asp:TemplateField HeaderText="Name" SortExpression="THEATER_NAME">
                            <ItemTemplate><%# Eval("THEATER_NAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("THEATER_NAME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTheaterGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City" SortExpression="THEATER_CITY">
                            <ItemTemplate><%# Eval("THEATER_CITY") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCity" runat="server" Text='<%# Bind("THEATER_CITY") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditCity" runat="server" ControlToValidate="txtEditCity" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTheaterGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" SortExpression="THEATER_ADDRESS">
                            <ItemTemplate><%# Eval("THEATER_ADDRESS") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditAddress" runat="server" Text='<%# Bind("THEATER_ADDRESS") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditAddress" runat="server" ControlToValidate="txtEditAddress" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditTheaterGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditTheaterGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;THEATER&quot; WHERE &quot;THEATER_ID&quot; = :THEATER_ID" 
        InsertCommand="INSERT INTO &quot;THEATER&quot; (&quot;THEATER_ID&quot;, &quot;THEATER_NAME&quot;, &quot;THEATER_CITY&quot;, &quot;THEATER_ADDRESS&quot;) VALUES (:THEATER_ID, :THEATER_NAME, :THEATER_CITY, :THEATER_ADDRESS)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;THEATER_ID&quot;, &quot;THEATER_NAME&quot;, &quot;THEATER_CITY&quot;, &quot;THEATER_ADDRESS&quot; FROM &quot;THEATER&quot;" 
        UpdateCommand="UPDATE &quot;THEATER&quot; SET &quot;THEATER_NAME&quot; = :THEATER_NAME, &quot;THEATER_CITY&quot; = :THEATER_CITY, &quot;THEATER_ADDRESS&quot; = :THEATER_ADDRESS WHERE &quot;THEATER_ID&quot; = :THEATER_ID"
        OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="THEATER_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="THEATER_ID" Type="String" />
            <asp:Parameter Name="THEATER_NAME" Type="String" />
            <asp:Parameter Name="THEATER_CITY" Type="String" />
            <asp:Parameter Name="THEATER_ADDRESS" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="THEATER_NAME" Type="String" />
            <asp:Parameter Name="THEATER_CITY" Type="String" />
            <asp:Parameter Name="THEATER_ADDRESS" Type="String" />
            <asp:Parameter Name="THEATER_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
