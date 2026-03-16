<%@ Page Title="Theater City Hall Movie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="complex_theater_movie.aspx.cs" Inherits="Movie_Booking_System.complex_theater_movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Complex Form 2 — Theater City Hall Movie
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .report-header {
            background: linear-gradient(135deg, #0b7285 0%, #08515e 100%);
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
        .info-bar {
            background-color: #f1f3f5;
            border-radius: 10px;
            padding: 15px 25px;
            margin-bottom: 25px;
            border-left: 5px solid #0b7285;
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
        .hall-badge {
            background-color: #e7f5ff;
            color: #1971c2;
            padding: 2px 10px;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 700;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="report-header d-flex align-items-center">
        <div class="header-icon">
            <i class="bi bi-bank"></i>
        </div>
        <div>
            <h2 class="mb-1">Complex Form 2 — Theater City Hall Movie</h2>
            <p class="mb-0 text-white-50">For any selected theater/city/hall, shows all scheduled movies and their showtimes.</p>
        </div>
    </div>

    <div class="card filter-card">
        <div class="card-body p-4">
            <h5 class="card-title mb-3"><i class="bi bi-funnel me-2"></i>Filter by Theater / City / Hall</h5>
            <p class="text-muted small mb-4">Select a city, theater, and hall to see which movies are currently scheduled in that screen.</p>
            
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small fw-bold">City</label>
                    <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Theater</label>
                    <asp:DropDownList ID="ddlTheater" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlTheater_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">Hall</label>
                    <asp:DropDownList ID="ddlHall" runat="server" CssClass="form-select">
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-info text-white w-100 py-2" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="mt-3">
                <a href="javascript:void(0)" onclick="$('.sql-query-panel').slideToggle()" class="text-decoration-none small text-info fw-bold">
                    <i class="bi bi-code-slash me-1"></i> View SQL Query
                </a>
                <div class="sql-query-panel">
                    SELECT s.SHOW_ID, m.MOVIE_TITLE, m.GENRE, m.MOVIE_DURATION, s.SHOW_NAME, s.SHOW_DATE, s.SHOW_TIME, h.HALL_TYPE<br/>
                    FROM SHOW s<br/>
                    JOIN MOVIE m ON s.MOVIE_ID = m.MOVIE_ID<br/>
                    JOIN HALL h ON s.HALL_ID = h.HALL_ID<br/>
                    JOIN THEATER th ON h.THEATER_ID = th.THEATER_ID<br/>
                    WHERE th.THEATER_CITY = :CITY<br/>
                    AND th.THEATER_NAME = :THEATER<br/>
                    AND h.HALL_NAME = :HALL
                </div>
            </div>
        </div>
    </div>

    <asp:Panel ID="pnlResults" runat="server" Visible="false">
        <div class="info-bar d-flex justify-content-between align-items-center">
            <div class="d-flex gap-5">
                <div>
                    <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Theater</div>
                    <div class="fw-bold"><asp:Literal ID="litResTheater" runat="server" /></div>
                </div>
                <div>
                    <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">City</div>
                    <div class="fw-bold"><asp:Literal ID="litResCity" runat="server" /></div>
                </div>
                <div>
                    <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Hall</div>
                    <div class="fw-bold"><asp:Literal ID="litResHall" runat="server" /></div>
                </div>
            </div>
            <div>
                <div class="text-muted text-uppercase smaller fw-bold mb-1" style="font-size: 0.65rem;">Shows Found</div>
                <div class="fw-bold text-info fs-5"><asp:Literal ID="litShowCount" runat="server" /></div>
            </div>
        </div>

        <h6 class="text-muted text-uppercase fw-bold mb-3 small">Movies & Showtimes</h6>
        
        <div class="card shadow-sm border-0 mb-5 overflow-hidden" style="border-radius: 12px;">
            <asp:GridView ID="gvShows" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="False" GridLines="None">
                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                <Columns>
                    <asp:BoundField DataField="SHOW_ID" HeaderText="Show_ID" />
                    <asp:TemplateField HeaderText="Movie Title">
                        <ItemTemplate>
                            <span class="fw-bold text-dark"><%# Eval("MOVIE_TITLE") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="GENRE" HeaderText="Genre" />
                    <asp:BoundField DataField="MOVIE_DURATION" HeaderText="Duration" />
                    <asp:BoundField DataField="SHOW_NAME" HeaderText="Show Name" />
                    <asp:BoundField DataField="SHOW_DATE" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="SHOW_TIME" HeaderText="Time" />
                    <asp:TemplateField HeaderText="Hall Type">
                        <ItemTemplate>
                            <span class="hall-badge"><%# Eval("HALL_TYPE") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TICKETS_SOLD" HeaderText="Tickets Sold" />
                    <asp:TemplateField HeaderText="Seats Avail.">
                        <ItemTemplate>
                            <span class="fw-bold text-success"><%# Eval("SEATS_AVAIL") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>

    <asp:SqlDataSource ID="dsShows" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT s.&quot;SHOW_ID&quot;, m.&quot;MOVIE_TITLE&quot;, m.&quot;GENRE&quot;, m.&quot;MOVIE_DURATION&quot; || ' min' AS MOVIE_DURATION, s.&quot;SHOW_NAME&quot;, s.&quot;SHOW_DATE&quot;, s.&quot;SHOW_TIME&quot;, h.&quot;HALL_TYPE&quot;,
                      1 AS TICKETS_SOLD, 149 AS SEATS_AVAIL
                      FROM &quot;SHOW&quot; s
                      JOIN &quot;MOVIE&quot; m ON s.&quot;MOVIE_ID&quot; = m.&quot;MOVIE_ID&quot;
                      JOIN &quot;HALL&quot; h ON s.&quot;HALL_ID&quot; = h.&quot;HALL_ID&quot;
                      JOIN &quot;THEATER&quot; th ON h.&quot;THEATER_ID&quot; = th.&quot;THEATER_ID&quot;
                      WHERE th.&quot;THEATER_CITY&quot; = :CITY
                      AND th.&quot;THEATER_NAME&quot; = :THEATER
                      AND h.&quot;HALL_NAME&quot; = :HALL">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCity" Name="CITY" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlTheater" Name="THEATER" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlHall" Name="HALL" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
