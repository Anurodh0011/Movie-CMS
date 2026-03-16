<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Movie_Booking_System.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Dashboard | Movie System
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .stat-card {
            border-left: 4px solid;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card.primary { border-left-color: #4e73df; }
        .stat-card.success { border-left-color: #1cc88a; }
        .stat-card.info { border-left-color: #36b9cc; }
        .stat-card.warning { border-left-color: #f6c23e; }
        .stat-card.danger { border-left-color: #e74a3b; }
        .stat-card.dark { border-left-color: #5a5c69; }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #5a5c69;
        }
        .stat-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05rem;
        }
        .stat-icon {
            font-size: 2rem;
            color: #dddfeb;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">System Dashboard</h1>
    </div>

    <asp:SqlDataSource ID="dsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;USERS&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMovies" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;MOVIE&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsTheaters" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;THEATER&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsHalls" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;HALL&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsShows" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;SHOW&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsTickets" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;TICKET&quot;"></asp:SqlDataSource>

    <div class="row">
        <!-- Users -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card primary shadow h-100 py-2" onclick="location.href='users.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-primary mb-1">Total Users</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvUsers" runat="server" DataSourceID="dsUsers">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="users.aspx" class="btn btn-sm btn-outline-primary w-100">View all Users</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Movies -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card success shadow h-100 py-2" onclick="location.href='movie.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-success mb-1">Total Movies</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvMovies" runat="server" DataSourceID="dsMovies">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-camera-reels stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="movie.aspx" class="btn btn-sm btn-outline-success w-100">View all Movies</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Theaters -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card info shadow h-100 py-2" onclick="location.href='theater.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-info mb-1">Total Theaters</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvTheaters" runat="server" DataSourceID="dsTheaters">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-building stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="theater.aspx" class="btn btn-sm btn-outline-info w-100">View all Theaters</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Halls -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card warning shadow h-100 py-2" onclick="location.href='hall.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-warning mb-1">Total Halls</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvHalls" runat="server" DataSourceID="dsHalls">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-door-open stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="hall.aspx" class="btn btn-sm btn-outline-warning w-100">View all Halls</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Shows -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card danger shadow h-100 py-2" onclick="location.href='show.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-danger mb-1">Total Shows</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvShows" runat="server" DataSourceID="dsShows">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-calendar-event stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="show.aspx" class="btn btn-sm btn-outline-danger w-100">View all Shows</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tickets -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card stat-card dark shadow h-100 py-2" onclick="location.href='ticket.aspx'">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col me-2">
                            <div class="stat-label text-dark mb-1">Total Tickets</div>
                            <div class="stat-value">
                                <asp:FormView ID="fvTickets" runat="server" DataSourceID="dsTickets">
                                    <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-ticket-perforated stat-icon"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="ticket.aspx" class="btn btn-sm btn-outline-dark w-100">View all Tickets</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
