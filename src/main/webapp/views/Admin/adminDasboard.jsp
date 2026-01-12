<!doctype html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="utf-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="../assets/css/core/libs.min.css">
    <link rel="stylesheet" href="../assets/css/hope-ui.min.css">
    <link rel="stylesheet" href="../assets/css/custom.min.css">
</head>

<body>

<!-- ===== Sidebar ===== -->
<aside class="sidebar sidebar-default sidebar-white">
    <div class="sidebar-header d-flex align-items-center">
        <a href="dashboard.html" class="navbar-brand">
            <h4 class="logo-title">Admin Panel</h4>
        </a>
    </div>

    <div class="sidebar-body">
        <ul class="navbar-nav iq-main-menu">

            <li class="nav-item">
                <a class="nav-link active" href="dashboard.html">
                    <span class="item-name">Dashboard</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="report.html">
                    <span class="item-name">Report</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="invoice.html">
                    <span class="item-name">Invoice</span>
                </a>
            </li>

        </ul>
    </div>
</aside>

<!-- ===== Main Content ===== -->
<main class="main-content">
    <div class="container-fluid p-4">

        <h2>Dashboard</h2>
        <p>Welcome to Admin Dashboard (Static Version)</p>

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5>Total Reports</h5>
                        <h3>12</h3>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5>Total Invoices</h5>
                        <h3>8</h3>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<!-- JS -->
<script src="../assets/js/core/libs.min.js"></script>
<script src="../assets/js/hope-ui.js"></script>

</body>
</html>
