<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Invoice | Admin</title>

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

    <h4 class="mb-3">Edit Invoice</h4>

    <div class="card shadow-sm">
        <div class="card-body">

            <form onsubmit="saveInvoice(event)">

                <div class="mb-3">
                    <label class="form-label">Invoice No</label>
                    <input type="text" class="form-control" value="INV-1001" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Patient Name</label>
                    <input type="text" class="form-control" value="Nur Aisyah">
                </div>

                <div class="mb-3">
                    <label class="form-label">Service</label>
                    <input type="text" class="form-control" value="Doctor Consultation">
                </div>

                <div class="mb-3">
                    <label class="form-label">Amount (RM)</label>
                    <input type="number" class="form-control" value="120">
                </div>

                <div class="mb-3">
                    <label class="form-label">Payment Status</label>
                    <select class="form-select">
                        <option selected>PAID</option>
                        <option>UNPAID</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Remarks</label>
                    <textarea class="form-control" rows="3">Payment completed.</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-success">Save</button>
                    <a href="admin-dashboard.html" class="btn btn-secondary">Cancel</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script>
function saveInvoice(e) {
    e.preventDefault();
    alert("Invoice updated successfully");
    window.location.href = "admin-dashboard.html";
}
</script>

</body>
</html>
