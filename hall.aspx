<%@ Page Title="Halls" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hall.aspx.cs" Inherits="Movie_Booking_System.hall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Halls Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Halls Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create Hall
        </button>
    </div>

    <!-- Add Form (Hidden by default) -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New Hall</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="HALL_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Hall ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="HALL_IDTextBox" runat="server" Text='<%# Bind("HALL_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="HALL_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateHallGroup" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Hall Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="HALL_NAMETextBox" runat="server" Text='<%# Bind("HALL_NAME") %>' CssClass="form-control" placeholder="Enter Name" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="HALL_NAMETextBox" ErrorMessage="Name is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateHallGroup" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Hall Type <span class="text-danger">*</span></label>
                                <asp:TextBox ID="HALL_TYPETextBox" runat="server" Text='<%# Bind("HALL_TYPE") %>' CssClass="form-control" placeholder="e.g. IMAX, 3D" />
                                <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="HALL_TYPETextBox" ErrorMessage="Type is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateHallGroup" />
                            </div>
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Hall" CssClass="btn btn-success" ValidationGroup="CreateHallGroup" />
                            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateHallGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
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
            <h6 class="m-0 font-weight-bold text-primary">Hall List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="HALL_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="HALL_ID" HeaderText="ID" ReadOnly="True" SortExpression="HALL_ID" />
                        <asp:TemplateField HeaderText="Hall Name" SortExpression="HALL_NAME">
                            <ItemTemplate><%# Eval("HALL_NAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("HALL_NAME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditHallGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type" SortExpression="HALL_TYPE">
                            <ItemTemplate><%# Eval("HALL_TYPE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditType" runat="server" Text='<%# Bind("HALL_TYPE") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditType" runat="server" ControlToValidate="txtEditType" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditHallGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditHallGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;HALL&quot; WHERE &quot;HALL_ID&quot; = :HALL_ID" 
        InsertCommand="INSERT INTO &quot;HALL&quot; (&quot;HALL_ID&quot;, &quot;HALL_NAME&quot;, &quot;HALL_TYPE&quot;) VALUES (:HALL_ID, :HALL_NAME, :HALL_TYPE)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;HALL_ID&quot;, &quot;HALL_NAME&quot;, &quot;HALL_TYPE&quot; FROM &quot;HALL&quot;" 
        UpdateCommand="UPDATE &quot;HALL&quot; SET &quot;HALL_NAME&quot; = :HALL_NAME, &quot;HALL_TYPE&quot; = :HALL_TYPE WHERE &quot;HALL_ID&quot; = :HALL_ID"
        OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="HALL_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="HALL_ID" Type="String" />
            <asp:Parameter Name="HALL_NAME" Type="String" />
            <asp:Parameter Name="HALL_TYPE" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="HALL_NAME" Type="String" />
            <asp:Parameter Name="HALL_TYPE" Type="String" />
            <asp:Parameter Name="HALL_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
