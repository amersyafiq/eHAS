<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Report | Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- ADMIN HEADER -->
<nav class="navbar navbar-dark bg-dark px-4">
    <span class="navbar-brand mb-0 h4">Admin Dashboard</span>
    <a href="admin-dashboard.html" class="btn btn-outline-light btn-sm">Back</a>
</nav>

<!-- PAGE CONTENT -->
<div class="container mt-4">

    <h4 class="mb-3">Edit Report</h4>

    <div class="card shadow-sm">
        <div class="card-body">

            <form onsubmit="saveReport(event)">

                <div class="mb-3">
                    <label class="form-label">Report ID</label>
                    <input type="text" class="form-control" value="RPT-001" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Patient Name</label>
                    <input type="text" class="form-control" value="Ali Ahmad">
                </div>

                <div class="mb-3">
                    <label class="form-label">Doctor Name</label>
                    <input type="text" class="form-control" value="Dr. Sarah">
                </div>

                <div class="mb-3">
                    <label class="form-label">Report Date</label>
                    <input type="date" class="form-control" value="2026-01-12">
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select class="form-select">
                        <option>PENDING</option>
                        <option selected>CONFIRMED</option>
                        <option>COMPLETED</option>
                        <option>CANCELLED</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Remarks</label>
                    <textarea class="form-control" rows="3">Patient attended consultation.</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-primary">Save</button>
                    <a href="admin-dashboard.html" class="btn btn-secondary">Cancel</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script>
function saveReport(e) {
    e.preventDefault();
    alert("Report updated successfully");
    window.location.href = "admin-dashboard.html";
}
</script>

</body>
</html>
csdcdcdvffdaff