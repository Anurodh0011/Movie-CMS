<%@ Page Title="Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="Movie_Booking_System.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Users Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Users Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create User
        </button>
    </div>

    <!-- Add Form -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New User</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="USER_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">User ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="USER_IDTextBox" runat="server" Text='<%# Bind("USER_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="USER_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="USER_NAMETextBox" runat="server" Text='<%# Bind("USER_NAME") %>' CssClass="form-control" placeholder="Enter Name" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="USER_NAMETextBox" ErrorMessage="Name is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email Address <span class="text-danger">*</span></label>
                                <asp:TextBox ID="USER_EMAILTextBox" runat="server" Text='<%# Bind("USER_EMAIL") %>' CssClass="form-control" placeholder="name@example.com" />
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="USER_EMAILTextBox" ErrorMessage="Email is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="USER_EMAILTextBox" ErrorMessage="Invalid email format" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                <asp:TextBox ID="USER_PHONETextBox" runat="server" Text='<%# Bind("USER_PHONE") %>' CssClass="form-control" placeholder="Enter Phone" />
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="USER_PHONETextBox" ErrorMessage="Phone is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" />
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address <span class="text-danger">*</span></label>
                            <asp:TextBox ID="USER_ADDRESSTextBox" runat="server" Text='<%# Bind("USER_ADDRESS") %>' CssClass="form-control" TextMode="MultiLine" Rows="2" />
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="USER_ADDRESSTextBox" ErrorMessage="Address is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateUserGroup" />
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save User" CssClass="btn btn-success" ValidationGroup="CreateUserGroup" />
                            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateUserGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
                        <script type="text/javascript">
                            // Keep form visible if there was a postback with errors
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
            <h6 class="m-0 font-weight-bold text-primary">User List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="USER_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="USER_ID" HeaderText="ID" ReadOnly="True" SortExpression="USER_ID" />
                        <asp:TemplateField HeaderText="Name" SortExpression="USER_NAME">
                            <ItemTemplate><%# Eval("USER_NAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("USER_NAME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditUserGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email" SortExpression="USER_EMAIL">
                            <ItemTemplate><%# Eval("USER_EMAIL") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("USER_EMAIL") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditEmail" runat="server" ControlToValidate="txtEditEmail" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditUserGroup" />
                                <asp:RegularExpressionValidator ID="revEditEmail" runat="server" ControlToValidate="txtEditEmail" ErrorMessage="!" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditUserGroup" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone" SortExpression="USER_PHONE">
                            <ItemTemplate><%# Eval("USER_PHONE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPhone" runat="server" Text='<%# Bind("USER_PHONE") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditPhone" runat="server" ControlToValidate="txtEditPhone" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditUserGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" SortExpression="USER_ADDRESS">
                            <ItemTemplate><%# Eval("USER_ADDRESS") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditAddress" runat="server" Text='<%# Bind("USER_ADDRESS") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditAddress" runat="server" ControlToValidate="txtEditAddress" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditUserGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditUserGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;USERS&quot; WHERE &quot;USER_ID&quot; = :USER_ID" 
        InsertCommand="INSERT INTO &quot;USERS&quot; (&quot;USER_ID&quot;, &quot;USER_NAME&quot;, &quot;USER_EMAIL&quot;, &quot;USER_PHONE&quot;, &quot;USER_ADDRESS&quot;) VALUES (:USER_ID, :USER_NAME, :USER_EMAIL, :USER_PHONE, :USER_ADDRESS)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;USER_ID&quot;, &quot;USER_NAME&quot;, &quot;USER_EMAIL&quot;, &quot;USER_PHONE&quot;, &quot;USER_ADDRESS&quot; FROM &quot;USERS&quot;" 
        UpdateCommand="UPDATE &quot;USERS&quot; SET &quot;USER_NAME&quot; = :USER_NAME, &quot;USER_EMAIL&quot; = :USER_EMAIL, &quot;USER_PHONE&quot; = :USER_PHONE, &quot;USER_ADDRESS&quot; = :USER_ADDRESS WHERE &quot;USER_ID&quot; = :USER_ID"
        OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="USER_ID" Type="String" /> 
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="USER_ID" Type="String" />
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="USER_EMAIL" Type="String" />
            <asp:Parameter Name="USER_PHONE" Type="String" />
            <asp:Parameter Name="USER_ADDRESS" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="USER_EMAIL" Type="String" />
            <asp:Parameter Name="USER_PHONE" Type="String" />
            <asp:Parameter Name="USER_ADDRESS" Type="String" />
            <asp:Parameter Name="USER_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
