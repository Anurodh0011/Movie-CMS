<%@ Page Title="Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="movie.aspx.cs" Inherits="Movie_Booking_System.movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Movies Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Movies Management</h1>
        <button type="button" class="btn btn-primary shadow-sm" onclick="toggleForm()">
            <i class="bi bi-plus-circle me-1"></i> Create Movie
        </button>
    </div>

    <!-- Add Form (Hidden by default) -->
    <div class="form-container">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Add New Movie</h6>
            </div>
            <div class="card-body">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="MOVIE_ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" RenderOuterTable="false">
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Movie ID <span class="text-danger">*</span></label>
                                <asp:TextBox ID="MOVIE_IDTextBox" runat="server" Text='<%# Bind("MOVIE_ID") %>' CssClass="form-control" placeholder="Enter ID" />
                                <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="MOVIE_IDTextBox" ErrorMessage="ID is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Movie Title <span class="text-danger">*</span></label>
                                <asp:TextBox ID="MOVIE_TITLETextBox" runat="server" Text='<%# Bind("MOVIE_TITLE") %>' CssClass="form-control" placeholder="Enter Title" />
                                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="MOVIE_TITLETextBox" ErrorMessage="Title is required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Duration <span class="text-danger">*</span></label>
                                <asp:TextBox ID="MOVIE_DURATIONTextBox" runat="server" Text='<%# Bind("MOVIE_DURATION") %>' CssClass="form-control" placeholder="e.g. 120" />
                                <asp:RequiredFieldValidator ID="rfvDuration" runat="server" ControlToValidate="MOVIE_DURATIONTextBox" ErrorMessage="Required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" />
                                <asp:RegularExpressionValidator ID="revDuration" runat="server" ControlToValidate="MOVIE_DURATIONTextBox" ErrorMessage="Digits only" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" ValidationExpression="^\d+$" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Genre <span class="text-danger">*</span></label>
                                <asp:TextBox ID="GENRETextBox" runat="server" Text='<%# Bind("GENRE") %>' CssClass="form-control" placeholder="e.g. Action" />
                                <asp:RequiredFieldValidator ID="rfvGenre" runat="server" ControlToValidate="GENRETextBox" ErrorMessage="Required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Release Date <span class="text-danger">*</span></label>
                                <asp:TextBox ID="RELEASE_DATETextBox" runat="server" Text='<%# Bind("RELEASE_DATE") %>' CssClass="form-control" placeholder="YYYY-MM-DD" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="RELEASE_DATETextBox" ErrorMessage="Required" Display="Dynamic" CssClass="text-danger small" ValidationGroup="CreateMovieGroup" />
                            </div>
                        </div>
                        <div class="mt-3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Save Movie" CssClass="btn btn-success" ValidationGroup="CreateMovieGroup" />
                            <button type="button" class="btn btn-primary" onclick="toggleForm()">Cancel</button>
                        </div>
                        <asp:ValidationSummary ID="vsCreate" runat="server" ValidationGroup="CreateMovieGroup" CssClass="alert alert-danger mt-3 small" HeaderText="Please correct the following:" />
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
            <h6 class="m-0 font-weight-bold text-primary">Movie List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MOVIE_ID" DataSourceID="SqlDataSource1" 
                    CssClass="table table-bordered table-striped table-hover" GridLines="None" CellSpacing="-1">
                    <Columns>
                        <asp:BoundField DataField="MOVIE_ID" HeaderText="ID" ReadOnly="True" SortExpression="MOVIE_ID" />
                        <asp:TemplateField HeaderText="Title" SortExpression="MOVIE_TITLE">
                            <ItemTemplate><%# Eval("MOVIE_TITLE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditTitle" runat="server" Text='<%# Bind("MOVIE_TITLE") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditTitle" runat="server" ControlToValidate="txtEditTitle" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditMovieGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Duration" SortExpression="MOVIE_DURATION">
                            <ItemTemplate><%# Eval("MOVIE_DURATION") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDuration" runat="server" Text='<%# Bind("MOVIE_DURATION") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditDuration" runat="server" ControlToValidate="txtEditDuration" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditMovieGroup" />
                                <asp:RegularExpressionValidator ID="revEditDuration" runat="server" ControlToValidate="txtEditDuration" ErrorMessage="?" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditMovieGroup" ValidationExpression="^\d+$" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Genre" SortExpression="GENRE">
                            <ItemTemplate><%# Eval("GENRE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditGenre" runat="server" Text='<%# Bind("GENRE") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvEditGenre" runat="server" ControlToValidate="txtEditGenre" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditMovieGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release Date" SortExpression="RELEASE_DATE">
                            <ItemTemplate><%# Eval("RELEASE_DATE", "{0:yyyy-MM-dd}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDate" runat="server" Text='<%# Bind("RELEASE_DATE", "{0:yyyy-MM-dd}") %>' CssClass="form-control form-control-sm" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvEditDate" runat="server" ControlToValidate="txtEditDate" ErrorMessage="*" Display="Dynamic" CssClass="text-danger" ValidationGroup="EditMovieGroup" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Are you sure?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateBtn" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success" ValidationGroup="EditMovieGroup"><i class="bi bi-check-lg"></i></asp:LinkButton>
                                <asp:LinkButton ID="CancelBtn" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary"><i class="bi bi-x-lg"></i></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM &quot;MOVIE&quot; WHERE &quot;MOVIE_ID&quot; = :MOVIE_ID" 
        InsertCommand="INSERT INTO &quot;MOVIE&quot; (&quot;MOVIE_ID&quot;, &quot;MOVIE_TITLE&quot;, &quot;MOVIE_DURATION&quot;, &quot;GENRE&quot;, &quot;RELEASE_DATE&quot;) VALUES (:MOVIE_ID, :MOVIE_TITLE, :MOVIE_DURATION, :GENRE, :RELEASE_DATE)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT &quot;MOVIE_ID&quot;, &quot;MOVIE_TITLE&quot;, &quot;MOVIE_DURATION&quot;, &quot;GENRE&quot;, &quot;RELEASE_DATE&quot; FROM &quot;MOVIE&quot;" 
        UpdateCommand="UPDATE &quot;MOVIE&quot; SET &quot;MOVIE_TITLE&quot; = :MOVIE_TITLE, &quot;MOVIE_DURATION&quot; = :MOVIE_DURATION, &quot;GENRE&quot; = :GENRE, &quot;RELEASE_DATE&quot; = :RELEASE_DATE WHERE &quot;MOVIE_ID&quot; = :MOVIE_ID">
        <DeleteParameters>
            <asp:Parameter Name="MOVIE_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MOVIE_ID" Type="String" />
            <asp:Parameter Name="MOVIE_TITLE" Type="String" />
            <asp:Parameter Name="MOVIE_DURATION" Type="String" />
            <asp:Parameter Name="GENRE" Type="String" />
            <asp:Parameter Name="RELEASE_DATE" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MOVIE_TITLE" Type="String" />
            <asp:Parameter Name="MOVIE_DURATION" Type="String" />
            <asp:Parameter Name="GENRE" Type="String" />
            <asp:Parameter Name="RELEASE_DATE" Type="DateTime" />
            <asp:Parameter Name="MOVIE_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
