<%@ Page Title="Occupancy Performer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="complex_occupancy.aspx.cs" Inherits="Movie_Booking_System.complex_occupancy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Complex Form 3 — Movie Occupancy Performer
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .report-header {
            background: linear-gradient(135deg, #c08d0a 0%, #9e7408 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }
        .header-icon {
            font-size: 2.5rem;
            margin-right: 20px;
            background: rgba(255,255,255,0.2);
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }
        .filter-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .movie-info-bar {
            background-color: #f1f3ff;
            border-radius: 10px;
            padding: 15px 25px;
            margin-bottom: 25px;
            border-bottom: 3px solid #dee2e6;
        }
        .sql-query-panel {
            display: none;
            background-color: #1e1e1e;
            color: #d4d4d4;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Consolas', monospace;
            font-size: 0.85rem;
            margin-top: 15px;
        }
        .rank-badge {
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: #ffd43b;
            color: #8a6d00;
            font-weight: 800;
            margin-right: 15px;
        }
        .progress {
            height: 8px;
            border-radius: 10px;
            margin: 10px 0;
            background-color: #e9ecef;
        }
        .progress-bar {
            background-color: #dee2e6;
        }
        .performer-card {
            border-radius: 15px;
            border: 1px solid #e9ecef;
            padding: 20px;
            margin-bottom: 15px;
            position: relative;
        }
        .winner-star {
            position: absolute;
            top: 20px;
            right: 20px;
            color: #ffd43b;
            font-size: 1.5rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="report-header d-flex align-items-center">
        <div class="header-icon">
            <i class="bi bi-trophy"></i>
        </div>
        <div>
            <h2 class="mb-1">Complex Form 3 — Movie Occupancy Performer</h2>
            <p class="mb-0 text-white-50">For any selected movie, shows the top 3 theater/city/halls by seat occupancy percentage (paid tickets only)</p>
        </div>
    </div>

    <div class="card filter-card">
        <div class="card-body p-4">
            <h5 class="card-title mb-3"><i class="bi bi-bullseye me-2"></i>Select Movie to Analyse</h5>
            <p class="text-muted small mb-4">Select a movie to rank the top 3 theaters/halls by seat occupancy. Only paid (Booked) tickets count towards occupancy.</p>
            
            <div class="row g-3">
                <div class="col-md-10">
                    <label class="form-label small fw-bold text-muted">Movie</label>
                    <asp:DropDownList ID="ddlMovies" runat="server" CssClass="form-select" DataSourceID="dsMovieList" DataTextField="MovieInfo" DataValueField="MOVIE_ID">
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <asp:Button ID="btnAnalyse" runat="server" Text="Analyse" CssClass="btn btn-warning text-white w-100 py-2 fw-bold" OnClick="btnAnalyse_Click" />
                </div>
            </div>

            <div class="mt-3">
                <!-- SQL Query Panel Removed as per request -->
            </div>
        </div>
    </div>

    <asp:Panel ID="pnlResults" runat="server" Visible="false">
        <div class="movie-info-bar">
            <asp:FormView ID="fvMovieDetail" runat="server" DataSourceID="dsMovieDetail" RenderOuterTable="false">
                <ItemTemplate>
                    <div class="row g-4">
                        <div class="col-md-3">
                            <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Movie</div>
                            <div class="fw-bold fs-6"><%# Eval("MOVIE_TITLE") %></div>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Genre</div>
                            <div class="fw-bold"><%# Eval("GENRE") %></div>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Duration</div>
                            <div class="fw-bold"><%# Eval("MOVIE_DURATION") %> min</div>
                        </div>
                        <div class="col-md-3">
                            <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Release</div>
                            <div class="fw-bold"><%# Eval("RELEASE_DATE", "{0:yyyy-MM-dd}") %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </div>

        <h6 class="text-muted text-uppercase fw-bold mb-3 small">Top 3 Theater / Hall Performers</h6>
        
        <asp:Repeater ID="rptPerformers" runat="server">
            <ItemTemplate>
                <div class="performer-card bg-white shadow-sm mb-3">
                    <div class="d-flex align-items-center">
                        <div class="rank-badge"><%# Container.ItemIndex + 1 %></div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <h6 class="mb-1 fw-bold"><%# Eval("THEATER_NAME") %> — <%# Eval("HALL_NAME") %></h6>
                                <span class="fw-bold text-dark"><%# Eval("OCCUPANCY_PERCENT") %>%</span>
                            </div>
                            <div class="small text-muted mb-2">
                                <i class="bi bi-geo-alt-fill me-1"></i> <%# Eval("THEATER_CITY") %> | <%# Eval("HALL_TYPE") %>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style='<%# "width: " + Eval("OCCUPANCY_PERCENT") + "%;" %>' aria-valuenow='<%# Eval("OCCUPANCY_PERCENT") %>' aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between smaller text-muted" style="font-size: 0.75rem;">
                                <span><i class="bi bi-award me-1"></i> <%# (Container.ItemIndex == 0 ? "1st Place" : (Container.ItemIndex == 1 ? "2nd Place" : "3rd Place")) %></span>
                                <span><%# Eval("PAID_TICKETS") %> paid tickets / <%# Eval("CAPACITY") %> seats</span>
                            </div>
                        </div>
                    </div>
                    <%# Container.ItemIndex == 0 ? "<i class='bi bi-star-fill winner-star'></i>" : "" %>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="card shadow-sm border-0 mb-5 overflow-hidden mt-4" style="border-radius: 12px;">
            <asp:GridView ID="gvOccupancy" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="False" GridLines="None" DataSourceID="dsOccupancy">
                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                <Columns>
                    <asp:TemplateField HeaderText="Rank">
                        <ItemTemplate>
                            <span class="fw-bold">
                                <%# (Container.DataItemIndex == 0 ? "🏆 #1" : (Container.DataItemIndex == 1 ? "🥈 #2" : "🥉 #3")) %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="THEATER_NAME" HeaderText="Theater" />
                    <asp:BoundField DataField="THEATER_CITY" HeaderText="City" />
                    <asp:BoundField DataField="HALL_NAME" HeaderText="Hall" />
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <span class="badge bg-light text-primary border border-primary-subtle rounded-pill small" style="font-size: 0.7rem;"><%# Eval("HALL_TYPE") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CAPACITY" HeaderText="Capacity" />
                    <asp:BoundField DataField="PAID_TICKETS" HeaderText="Paid Tickets" />
                    <asp:TemplateField HeaderText="Occupancy %">
                        <ItemTemplate>
                            <span class="fw-bold text-primary"><%# Eval("OCCUPANCY_PERCENT") %>%</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>

    <asp:SqlDataSource ID="dsMovieList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT &quot;MOVIE_ID&quot;, &quot;MOVIE_ID&quot; || ' - ' || &quot;MOVIE_TITLE&quot; AS MovieInfo FROM &quot;MOVIE&quot;"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsMovieDetail" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM &quot;MOVIE&quot; WHERE &quot;MOVIE_ID&quot; = :MOVIE_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMovies" Name="MOVIE_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsOccupancy" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM (
                        SELECT th.&quot;THEATER_NAME&quot;, th.&quot;THEATER_CITY&quot;, h.&quot;HALL_NAME&quot;, h.&quot;HALL_TYPE&quot;, 
                               200 AS CAPACITY,
                               COUNT(t.&quot;TICKET_ID&quot;) AS PAID_TICKETS,
                               ROUND((COUNT(t.&quot;TICKET_ID&quot;) / 200.0) * 100, 2) AS OCCUPANCY_PERCENT
                        FROM &quot;TICKET&quot; t
                        JOIN &quot;SHOW_TICKET&quot; st ON t.&quot;TICKET_ID&quot; = st.&quot;TICKET_ID&quot;
                        JOIN &quot;HALL&quot; h ON st.&quot;HALL_ID&quot; = h.&quot;HALL_ID&quot;
                        JOIN &quot;THEATER&quot; th ON st.&quot;THEATER_ID&quot; = th.&quot;THEATER_ID&quot;
                        WHERE st.&quot;MOVIE_ID&quot; = :MOVIE_ID
                        GROUP BY th.&quot;THEATER_NAME&quot;, th.&quot;THEATER_CITY&quot;, h.&quot;HALL_NAME&quot;, h.&quot;HALL_TYPE&quot;
                        ORDER BY OCCUPANCY_PERCENT DESC
                    ) WHERE ROWNUM <= 3">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMovies" Name="MOVIE_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
