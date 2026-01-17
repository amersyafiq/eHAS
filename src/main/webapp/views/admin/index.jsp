<%-- 
    Document   : index
    Created on : Jan 2026
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Dashboard" />

    <%-- Admin Summary Query --%>
    <sql:query var="summary" dataSource="${myDatasource}">
        SELECT
            (SELECT COUNT(*) FROM appointment) AS total_appointments,
            (SELECT COUNT(*) FROM appointment WHERE status = 'PENDING') AS pending_appointments,
            (SELECT COUNT(*) FROM appointment WHERE billstatus = 'UNPAID') AS unpaid_bills,
            (SELECT COALESCE(SUM(totalamount), 0) 
            FROM appointment WHERE billstatus = 'PAID') AS total_revenue
    </sql:query>

    <sql:query var="revenueTrend" dataSource="${myDatasource}">
        SELECT 
            createdat, 
            SUM(totalamount) as daily_total
        FROM APPOINTMENT
        WHERE createdat >= CURRENT_DATE - INTERVAL '30 days'
        AND billstatus = 'PAID'
        GROUP BY createdat
        ORDER BY createdat ASC;
    </sql:query>

    <sql:query var="dailyAppts" dataSource="${myDatasource}">
        SELECT 
            createdat,
            COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END) as completed_count,
            COUNT(CASE WHEN status != 'COMPLETED' THEN 1 END) as other_count
        FROM APPOINTMENT
        WHERE createdat >= CURRENT_DATE - INTERVAL '10 days'
        GROUP BY createdat
        ORDER BY createdat ASC;
    </sql:query>

    <body class="uikit">

        <!-- Loader -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
            </div>
        </div>

        <%-- Navigation Sidebar (ADMIN) --%>
        <%@ include file="/WEB-INF/jspf/nav.jspf" %>

        <main class="main-content">
            <div class="position-relative iq-banner">

                <%-- Header --%>
                <%@ include file="/WEB-INF/jspf/header.jspf" %>

                <div class="container-fluid content-inner p-3">

                    <div class="row">
                        <!-- Welcome Banner -->
                        <div class="col-12">
                            <div class="card border-0 mb-3" style="background: linear-gradient(90deg, #111827 0%, #1f2937 100%);">
                                <div class="card-body py-4 px-4">
                                    <h3 class="text-white fw-bold mb-1">Welcome, ${sessionScope.loggedUser.fullName}.</h3>
                                    <p class="text-white fs-6 mb-0 opacity-75">Administrator Dashboard</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Statistics Cards Row -->
                        <div class="col-12 mb-3">
                            <div class="row g-3">
    
                                    <!-- Total Appointments -->
                                    <div class="col-12 col-md-3">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <p class="mb-0 text-muted small">Total Appointments</p>
                                                <h2 class="fw-bold text-primary counter">${summary.rows[0].total_appointments}</h2>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Pending Appointments -->
                                    <div class="col-12 col-md-3">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <p class="mb-0 text-muted small">Pending Appointments</p>
                                                <h2 class="fw-bold text-warning counter">${summary.rows[0].pending_appointments}</h2>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Unpaid Bills -->
                                    <div class="col-12 col-md-3">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <p class="mb-0 text-muted small">Unpaid Bills</p>
                                                <h2 class="fw-bold text-danger counter">${summary.rows[0].unpaid_bills}</h2>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Total Revenue -->
                                    <div class="col-12 col-md-3">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <p class="mb-0 text-muted small">Total Revenue</p>
                                                <h2 class="fw-bold text-success"><fmt:formatNumber value="${summary.rows[0].total_revenue}" type="currency" currencyCode="MYR"/></h2>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- Graph --%>
                                    <div class="col-12 col-md-6">
                                        <div class="card m-0" data-aos="fade-up" data-aos-delay="800">
                                            <div class="flex-wrap card-header d-flex justify-content-between align-items-center">
                                                <div class="header-title">
                                                    <h4 class="card-title"><fmt:formatNumber value="${summary.rows[0].total_revenue}" type="currency" currencyCode="MYR"/></h4>
                                                    <p class="mb-0">Total Revenue</p>          
                                                </div>
                                                <div class="d-flex align-items-center align-self-center">
                                                    <div class="d-flex align-items-center text-primary">
                                                        <svg class="icon-12" xmlns="http://www.w3.org/2000/svg" width="12" viewBox="0 0 24 24" fill="currentColor">
                                                            <g> <circle cx="12" cy="12" r="8" fill="currentColor"></circle> </g>
                                                        </svg>
                                                        <div class="ms-2">
                                                            <span class="text-gray">Revenue</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="dropdown">
                                                    <a href="#" class="text-gray dropdown-toggle" id="dropdownMenuButton22" data-bs-toggle="dropdown" aria-expanded="false"> This Week </a>
                                                    <ul class="dropdown-menu dropdown-menu-end custom-dropdown-menu-end" aria-labelledby="dropdownMenuButton22">
                                                        <li><a class="dropdown-item" href="#">This Week</a></li>
                                                        <li><a class="dropdown-item" href="#">This Month</a></li>
                                                        <li><a class="dropdown-item" href="#">This Year</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div id="revenue_graph" class="d-main"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="card m-0 h-100" data-aos="fade-up" data-aos-delay="1000">
                                            <div class="flex-wrap card-header d-flex justify-content-between">
                                                <div class="header-title">
                                                    <h4 class="card-title">Daily Appointments</h4>            
                                                </div>
                                                <div class="dropdown">
                                                    <a href="#" class="text-gray dropdown-toggle" id="dropdownMenuButton3" data-bs-toggle="dropdown" aria-expanded="false">
                                                        This Week
                                                    </a>
                                                    <ul class="dropdown-menu dropdown-menu-end custom-dropdown-menu-end" aria-labelledby="dropdownMenuButton3">
                                                        <li><a class="dropdown-item" href="#">This Week</a></li>
                                                        <li><a class="dropdown-item" href="#">This Month</a></li>
                                                        <li><a class="dropdown-item" href="#">This Year</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div id="daily_appointment" class="d-activity h-100"></div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                

                            </div>
                        </div>
                    </div>



                </div>
            </div>

            <%-- Footer --%>
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
        </main>
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function() {

                function loadRevenueGraph() {
                    const options = {
                        series: [{
                            name: 'Total Revenue',
                            // Loop through the SQL result to get the sum of totals
                            data: [
                                <c:forEach var="row" items="${revenueTrend.rows}" varStatus="status">
                                    ${row.daily_total}${!status.last ? ',' : ''}
                                </c:forEach>
                            ]
                        }],
                        chart: {
                            fontFamily: '"Inter", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"',
                            height: 245,
                            type: 'area',
                            toolbar: { show: false },
                            sparkline: { enabled: false },
                        },
                        xaxis: {
                            // Loop through the SQL result to get the dates
                            categories: [
                                <c:forEach var="row" items="${revenueTrend.rows}" varStatus="status">
                                    "${row.createdat}"${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            labels: {
                                minHeight: 22,
                                maxHeight: 22,
                                show: true,
                                style: { colors: "#8A92A6" },
                            }
                        },
                        // ... (rest of your configuration remains the same)
                        colors: ["#3a57e8"],
                        stroke: { curve: 'smooth', width: 3 },
                        grid: { show: false },
                        fill: {
                            type: 'gradient',
                            gradient: {
                                shade: 'dark',
                                type: "vertical",
                                opacityFrom: .4,
                                opacityTo: .1,
                                stops: [0, 50, 80]
                            }
                        },
                        tooltip: { enabled: true }
                    };

                    const chart = new ApexCharts(document.querySelector("#revenue_graph"), options);
                    chart.render();
                    document.addEventListener('ColorChange', (e) => {
                        console.log(e)
                        const newOpt = {
                        colors: [e.detail.detail1, e.detail.detail2],
                        fill: {
                            type: 'gradient',
                            gradient: {
                                shade: 'dark',
                                type: "vertical",
                                shadeIntensity: 0,
                                gradientToColors: [e.detail.detail1, e.detail.detail2], // optional, if not defined - uses the shades of same color in series
                                inverseColors: true,
                                opacityFrom: .4,
                                opacityTo: .1,
                                stops: [0, 50, 60],
                                colors: [e.detail.detail1, e.detail.detail2],
                            }
                        },
                    }
                        chart.updateOptions(newOpt)
                    })
                }

                function loadDailyApptGraph() {
                    const options = {
                        series: [{
                            name: 'Completed',
                            data: [
                                <c:forEach var="row" items="${dailyAppts.rows}" varStatus="status">
                                    ${row.completed_count}${!status.last ? ',' : ''}
                                </c:forEach>
                            ]
                        }, {
                            name: 'Pending/Other',
                            data: [
                                <c:forEach var="row" items="${dailyAppts.rows}" varStatus="status">
                                    ${row.other_count}${!status.last ? ',' : ''}
                                </c:forEach>
                            ]
                        }],
                        chart: {
                            type: 'bar',
                            height: 255,
                            stacked: true, // This keeps the bars on top of each other
                            toolbar: { show: false }
                        },
                        colors: ["#3a57e8", "#4bc7d2"],
                        plotOptions: {
                            bar: {
                            horizontal: false,
                            columnWidth: '28%',
                            borderRadius: 5,
                            },
                        },
                        legend: { show: true, position: 'top' },
                        dataLabels: { enabled: false },
                        xaxis: {
                            // Formats the date to a simple day initial or short date
                            categories: [
                                <c:forEach var="row" items="${dailyAppts.rows}" varStatus="status">
                                    "${row.createdat}"${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            labels: {
                            style: { colors: "#8A92A6" },
                            }
                        },
                        yaxis: {
                            labels: {
                                style: { colors: "#8A92A6" },
                            }
                        },
                        fill: { opacity: 1 },
                        tooltip: {
                            y: {
                            formatter: function (val) {
                                return val + " Appointments"
                            }
                            }
                        }
                    };
                    
                    const chart = new ApexCharts(document.querySelector("#daily_appointment"), options);
                    chart.render();

                    document.addEventListener('ColorChange', (e) => {
                        chart.updateOptions({ colors: [e.detail.detail1, e.detail.detail2] });
                    });
                }

                loadRevenueGraph();
                loadDailyApptGraph();
            });
        </script>

    </body>
</html>
