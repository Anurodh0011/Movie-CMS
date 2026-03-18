<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="complex_user_tickets.aspx.cs" Inherits="Movie_Booking_System.complex_user_tickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    User Ticket Report
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .report-header {
            background: linear-gradient(135deg, #2d5ae5 0%, #1a368b 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
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
        .details-card {
            background-color: #f0f4ff;
            border: 1px solid #d0daff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
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
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-booked { background-color: #e6fcf5; color: #0ca678; }
        .summary-box {
            background-color: #fff;
            border: 1px solid #e3e6f0;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mb-4">
        <h1 class="h3 mb-1 text-gray-800">User Ticket Report</h1>
        <p class="text-muted">Generate a detailed report of tickets purchased by a specific user over a six-month period.</p>
    </div>

    <!-- Search/Filter Card -->
    <div class="card filter-card">
        <div class="card-body p-4">
            <h5 class="card-title mb-3"><i class="bi bi-search me-2"></i>Search Parameters</h5>
            <p class="text-muted small mb-4">Select a user to view their complete ticket booking history within the past 6 months.</p>
            
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Select User</label>
                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="form-select" DataSourceID="dsUserList" DataTextField="UserInfo" DataValueField="USER_ID" AutoPostBack="true"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 py-2 shadow-sm" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="mt-3">
                <!-- SQL Query Panel Removed as per request -->
            </div>
        </div>
    </div>

    <asp:Panel ID="pnlResults" runat="server" Visible="false">
        <!-- User Details Card -->
        <div class="details-card">
            <div class="row text-uppercase small fw-bold text-primary mb-2">
                <div class="col-md-2">User ID</div>
                <div class="col-md-3">Full Name</div>
                <div class="col-md-3">Email</div>
                <div class="col-md-2">Phone</div>
                <div class="col-md-2">Address</div>
            </div>
            <asp:FormView ID="fvUserDetails" runat="server" DataSourceID="dsUserDetails" RenderOuterTable="false">
                <ItemTemplate>
                    <div class="row fw-bold text-dark">
                        <div class="col-md-2"><%# Eval("USER_ID") %></div>
                        <div class="col-md-3"><%# Eval("USER_NAME") %></div>
                        <div class="col-md-3"><%# Eval("USER_EMAIL") %></div>
                        <div class="col-md-2"><%# Eval("USER_PHONE") %></div>
                        <div class="col-md-2"><%# Eval("USER_ADDRESS") %></div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </div>

        <!-- Period Banner -->
        <div class="d-inline-block bg-white border rounded-pill px-3 py-2 mb-4 shadow-sm">
            <i class="bi bi-calendar3 text-primary me-2"></i>
            <span class="small fw-bold text-muted">
                Period: <asp:Literal ID="litPeriod" runat="server" /> | 
                <asp:Literal ID="litTicketCount" runat="server" /> ticket(s) found
            </span>
        </div>

        <h6 class="text-muted text-uppercase fw-bold mb-3 small">Ticket History</h6>
        
        <!-- Ticket Grid -->
        <div class="card shadow-sm border-0 mb-4 overflow-hidden" style="border-radius: 12px;">
            <asp:GridView ID="gvTickets" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="False" GridLines="None">
                <HeaderStyle CssClass="bg-light text-muted small text-uppercase" />
                <Columns>
                    <asp:BoundField DataField="TICKET_ID" HeaderText="Ticket_ID" />
                    <asp:TemplateField HeaderText="Movie">
                        <ItemTemplate>
                            <span class="fw-bold"><%# Eval("MOVIE_TITLE") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SHOW_DATE" HeaderText="Show Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="SHOW_TIME" HeaderText="Time" />
                    <asp:BoundField DataField="THEATER_NAME" HeaderText="Theater" />
                    <asp:BoundField DataField="HALL_NAME" HeaderText="Hall" />
                    <asp:BoundField DataField="SEAT_NO" HeaderText="Seat" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="status-badge status-booked">Booked</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price (NPR)">
                        <ItemTemplate>
                            <span class="fw-bold text-secondary">NPR <%# Eval("PRICE") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Summary Footer -->
        <div class="card shadow-sm border-0 mb-5" style="border-radius: 12px; background-color: #f8f9fc;">
            <div class="card-body d-flex justify-content-between align-items-center py-3">
                <div class="d-flex gap-4 small text-muted">
                    <span>Total Tickets: <strong class="text-dark"><asp:Literal ID="litTotal" runat="server" /></strong></span>
                    <span>Booked: <strong class="text-success"><asp:Literal ID="litBooked" runat="server" /></strong></span>
                    <span>Cancelled: <strong class="text-danger">0</strong></span>
                </div>
                <div class="fw-bold">
                    Total Paid: <span class="text-primary fs-5">NPR <asp:Literal ID="litTotalPaid" runat="server" /></span>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Data Sources -->
    <asp:SqlDataSource ID="dsUserList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT &quot;USER_ID&quot;, &quot;USER_ID&quot; || ' - ' || &quot;USER_NAME&quot; AS UserInfo FROM &quot;USERS&quot;"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUserDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM &quot;USERS&quot; WHERE &quot;USER_ID&quot; = :USER_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUsers" Name="USER_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTickets" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
        SelectCommand="SELECT t.&quot;TICKET_ID&quot;, m.&quot;MOVIE_TITLE&quot;, s.&quot;SHOW_DATE&quot;, s.&quot;SHOW_TIME&quot;, th.&quot;THEATER_NAME&quot;, h.&quot;HALL_NAME&quot;, t.&quot;SEAT_NO&quot;, t.&quot;PRICE&quot;
                      FROM &quot;TICKET&quot; t
                      JOIN &quot;SHOW_TICKET&quot; st ON t.&quot;TICKET_ID&quot; = st.&quot;TICKET_ID&quot;
                      JOIN &quot;SHOW&quot; s ON st.&quot;SHOW_ID&quot; = s.&quot;SHOW_ID&quot;
                      JOIN &quot;MOVIE&quot; m ON st.&quot;MOVIE_ID&quot; = m.&quot;MOVIE_ID&quot;
                      JOIN &quot;HALL&quot; h ON st.&quot;HALL_ID&quot; = h.&quot;HALL_ID&quot;
                      JOIN &quot;THEATER&quot; th ON st.&quot;THEATER_ID&quot; = th.&quot;THEATER_ID&quot;
                      WHERE st.&quot;USER_ID&quot; = :USER_ID
                      AND s.&quot;SHOW_DATE&quot; BETWEEN TO_DATE(:FROM_DATE, 'YYYY-MM-DD') AND TO_DATE(:TO_DATE, 'YYYY-MM-DD')">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUsers" Name="USER_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtFromDate" Name="FROM_DATE" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtToDate" Name="TO_DATE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
