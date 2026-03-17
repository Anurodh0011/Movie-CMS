<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Movie_Booking_System.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Dashboard | Movie System
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .stat-card {
            border: none;
            border-bottom: 4px solid transparent;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            overflow: hidden;
            background: #fff;
        }
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 1rem 3rem rgba(0,0,0,0.1) !important;
        }
        .stat-card.primary { border-bottom-color: #4e73df; }
        .stat-card.success { border-bottom-color: #1cc88a; }
        .stat-card.info { border-bottom-color: #36b9cc; }
        .stat-card.warning { border-bottom-color: #f6c23e; }
        .stat-card.danger { border-bottom-color: #e74a3b; }
        .stat-card.dark { border-bottom-color: #5a5c69; }
        
        .stat-value {
            font-size: 1.75rem;
            font-weight: 800;
            color: #2e3b52;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1rem;
            color: #858796;
        }
        .stat-icon-wrapper {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .bg-primary-soft { background-color: rgba(78, 115, 223, 0.1); color: #4e73df; }
        .bg-success-soft { background-color: rgba(28, 200, 138, 0.1); color: #1cc88a; }
        .bg-info-soft { background-color: rgba(54, 185, 204, 0.1); color: #36b9cc; }
        .bg-warning-soft { background-color: rgba(246, 194, 62, 0.1); color: #f6c23e; }
        .bg-danger-soft { background-color: rgba(231, 74, 59, 0.1); color: #e74a3b; }
        .bg-dark-soft { background-color: rgba(90, 92, 105, 0.1); color: #5a5c69; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow" style="border-radius: 12px; overflow: hidden; border: none;">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="h3 mb-1">System Dashboard</h1>
                        <p class="mb-0 opacity-75">Welcome back! Here's what's happening in your movie booking system today.</p>
                    </div>
                    <div class="d-none d-md-block">
                        <i class="bi bi-speedometer2" style="font-size: 3.5rem; opacity: 0.3;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="dsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;USERS&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMovies" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;MOVIE&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsTheaters" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;THEATER&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsHalls" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;HALL&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsShows" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;SHOW&quot;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsTickets" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT COUNT(*) AS TOTAL FROM &quot;TICKET&quot;"></asp:SqlDataSource>

    <%-- Chart Data Sources --%>
    <asp:SqlDataSource ID="dsMovieStats" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT M.MOVIE_TITLE, COUNT(ST.TICKET_ID) AS TICKET_COUNT FROM &quot;MOVIE&quot; M LEFT JOIN &quot;SHOW_TICKET&quot; ST ON M.MOVIE_ID = ST.MOVIE_ID GROUP BY M.MOVIE_TITLE">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsRevenueStats" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT M.MOVIE_TITLE, NVL(SUM(T.PRICE), 0) AS REVENUE FROM &quot;MOVIE&quot; M LEFT JOIN &quot;SHOW_TICKET&quot; ST ON M.MOVIE_ID = ST.MOVIE_ID LEFT JOIN &quot;TICKET&quot; T ON ST.TICKET_ID = T.TICKET_ID GROUP BY M.MOVIE_TITLE">
    </asp:SqlDataSource>

    <div class="row">
        <!-- Users -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card info shadow-sm h-100" onclick="location.href='users.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-info-soft">
                            <i class="bi bi-people"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Users</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvUsers" runat="server" DataSourceID="dsUsers">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Movies -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card primary shadow-sm h-100" onclick="location.href='movie.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-primary-soft">
                            <i class="bi bi-camera-reels"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Movies</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvMovies" runat="server" DataSourceID="dsMovies">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Theaters -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card success shadow-sm h-100" onclick="location.href='theater.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-success-soft">
                            <i class="bi bi-building"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Theaters</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvTheaters" runat="server" DataSourceID="dsTheaters">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Halls -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card warning shadow-sm h-100" onclick="location.href='hall.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-warning-soft">
                            <i class="bi bi-door-open"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Halls</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvHalls" runat="server" DataSourceID="dsHalls">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Shows -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card danger shadow-sm h-100" onclick="location.href='show.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-danger-soft">
                            <i class="bi bi-calendar-event"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Shows</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvShows" runat="server" DataSourceID="dsShows">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tickets -->
        <div class="col-xl-2 col-md-4 mb-4">
            <div class="card stat-card dark shadow-sm h-100" onclick="location.href='ticket.aspx'">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-wrapper bg-dark-soft">
                            <i class="bi bi-ticket-perforated"></i>
                        </div>
                    </div>
                    <div>
                        <div class="stat-label mb-1">Tickets</div>
                        <div class="stat-value">
                            <asp:FormView ID="fvTickets" runat="server" DataSourceID="dsTickets">
                                <ItemTemplate><%# Eval("TOTAL") %></ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row mb-5 mt-4 g-4">
        <div class="col-xl-8">
            <div class="card shadow-sm h-100">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary"><i class="bi bi-bar-chart-fill me-2"></i>Ticket Sales by Movie</h6>
                </div>
                <div class="card-body">
                    <div class="chart-area" style="position: relative; height: 350px;">
                        <canvas id="movieBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4">
            <div class="card shadow-sm h-100">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary"><i class="bi bi-pie-chart-fill me-2"></i>Revenue Contribution</h6>
                </div>
                <div class="card-body">
                    <div class="chart-pie d-flex flex-column align-items-center" style="position: relative; height: 350px;">
                        <canvas id="revenuePieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-5 mb-4">
        <h4 class="h5 mb-3 text-gray-800 fw-bold"><i class="bi bi-graph-up me-2 text-primary"></i>Analytics & Complex Reports</h4>
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm p-3 h-100" style="background: linear-gradient(to right, #ffffff, #f0f4ff); border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                            <i class="bi bi-file-earmark-person text-primary fs-4"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 fw-bold">User Ticket History</h6>
                            <p class="text-muted smaller mb-2" style="font-size: 0.75rem;">6-month report with details</p>
                            <a href="complex_user_tickets.aspx" class="btn btn-sm btn-link p-0 text-decoration-none fw-bold">Open Report</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm p-3 h-100" style="background: linear-gradient(to right, #ffffff, #f0f4ff); border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                            <i class="bi bi-building-check text-primary fs-4"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 fw-bold">Theater-Hall Schedule</h6>
                            <p class="text-muted smaller mb-2" style="font-size: 0.75rem;">Movies per specific screen</p>
                            <a href="complex_theater_movie.aspx" class="btn btn-sm btn-link p-0 text-decoration-none fw-bold text-primary">Open Report</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm p-3 h-100" style="background: linear-gradient(to right, #ffffff, #f0f4ff); border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                            <i class="bi bi-trophy text-primary fs-4"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 fw-bold">Occupancy Performers</h6>
                            <p class="text-muted smaller mb-2" style="font-size: 0.75rem;">Top 3 highest seat occupancy</p>
                            <a href="complex_occupancy.aspx" class="btn btn-sm btn-link p-0 text-decoration-none fw-bold text-primary">Open Report</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Data for Movie Bar Chart
            const movieLabels = [
                <asp:Repeater ID="rptMovieLabels" runat="server" DataSourceID="dsMovieStats">
                    <ItemTemplate>'<%# Eval("MOVIE_TITLE") %>',</ItemTemplate>
                </asp:Repeater>
            ];
            const movieData = [
                <asp:Repeater ID="rptMovieData" runat="server" DataSourceID="dsMovieStats">
                    <ItemTemplate><%# Eval("TICKET_COUNT") %>,</ItemTemplate>
                </asp:Repeater>
            ];

            // Data for Revenue Pie Chart
            const revenueLabels = [
                <asp:Repeater ID="rptRevLabels" runat="server" DataSourceID="dsRevenueStats">
                    <ItemTemplate>'<%# Eval("MOVIE_TITLE") %>',</ItemTemplate>
                </asp:Repeater>
            ];
            const revenueData = [
                <asp:Repeater ID="rptRevData" runat="server" DataSourceID="dsRevenueStats">
                    <ItemTemplate><%# Eval("REVENUE") %>,</ItemTemplate>
                </asp:Repeater>
            ];

            // Movie Bar Chart
            const ctxBar = document.getElementById('movieBarChart').getContext('2d');
            new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: movieLabels,
                    datasets: [{
                        label: 'Tickets Sold',
                        data: movieData,
                        backgroundColor: 'rgba(78, 115, 223, 0.8)',
                        borderColor: 'rgba(78, 115, 223, 1)',
                        borderWidth: 1,
                        borderRadius: 5
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: { precision: 0 }
                        }
                    },
                    plugins: {
                        legend: { display: false }
                    }
                }
            });

            // Revenue Pie Chart
            const ctxPie = document.getElementById('revenuePieChart').getContext('2d');
            new Chart(ctxPie, {
                type: 'doughnut',
                data: {
                    labels: revenueLabels,
                    datasets: [{
                        data: revenueData,
                        backgroundColor: [
                            '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#5a5c69', 
                            '#574ea1', '#fbcbc9', '#858796', '#000000'
                        ],
                        hoverOffset: 10
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { boxWidth: 12, padding: 15 }
                        }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
</asp:Content>
