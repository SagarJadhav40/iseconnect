<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.iseConnect.model.NptelCertification" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NPTEL Certifications</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --blue-dark: #0f2d4f;
            --blue-bright: #00a8ef;
            --beige: #d9cec3;
            --gray-light: #f3f1ee;
            --black: #000000;
        }

        body {
            background-color: var(--gray-light);
            margin: 0;
        }

        .header {
            background-color: var(--blue-dark);
            padding: 15px 30px;
            color: white;
        }

        .header .nav-link {
            color: white !important;
        }

        .footer {
            background-color: var(--blue-dark);
            color: white;
            text-align: center;
            padding: 15px 0;
            margin-top: auto;
        }

        .section-block {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        .table-responsive {
            overflow-x: auto;
        }

        .navbar-toggler {
            border: none;
        }

        .navbar-toggler-icon {
            background-color: white;
            border-radius: 5px;
        }
    </style>
</head>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setHeader("Expires", "0"); // Proxies

if (session.getAttribute("name") == "Admin") {
    response.sendRedirect("AdminPanelLoginPage.jsp");
}

%>
<body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg" style="background-color: var(--blue-dark);">
        <div class="container-fluid">
            <a class="navbar-brand text-white fw-bold me-3" href="#">ISE CONNECT</a>
            <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            Profile
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#">Edit Profile</a></li>
                            <li><a class="dropdown-item" href="Logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <div class="section-block">
            <form action="ViewNptel" method="post"  onsubmit="return validateForm()">
                <div class="mb-3">
                    <label for="designation" class="form-label">Designation</label>
                    <select class="form-select" id="designation" name="designation">
                        <option value="Students">Student</option>
                        <option value="Faculty">Faculty</option>
                    </select>
                    <input type="hidden" name="type" value="nptel">
                </div>
                <div class="mb-3">
                    <label for="startDate" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="startDate" name="startDate">
                </div>
                <div class="mb-3">
                    <label for="endDate" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="endDate" name="endDate">
                </div>
                <button type="submit" class="btn btn-primary w-100">Search</button>
            </form>
        </div>

        <div class="mt-4">
            <h5>Search Results:</h5>
            <%
                List<NptelCertification> certifications = (List<NptelCertification>) session.getAttribute("certifications");
                if (certifications != null && !certifications.isEmpty()) {
            %>
            <a href="DownloadExcel" class="btn btn-success mb-3 w-100">Download Excel</a>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <%if(certifications.get(0).getUsn()!=null){ %>
                            <th>USN</th>
                            <%}%>
                            <th>Course Name</th>
                            <th>Course Duration(In Weeks)</th>
                            <th>Certificate URL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (NptelCertification cert : certifications) {
                        %>
                        <tr>
                            <td><%= cert.getUserName() %></td>
                            <%if(cert.getUsn() != null){ %>
                            <td><%= cert.getUsn() != null ? cert.getUsn() : "N/A" %></td>
                            <%} %>
                            <td><%= cert.getCourseName() %></td>
                            <td><%= cert.getCourseDuration() %></td>
                            <td><a href="<%= cert.getCertificateUrl() %>" target="_blank">View Certificate</a></td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <p>No results found</p>
            <% } %>
        </div>
    </div>

    <footer class="footer mt-auto">
        <div class="container">
            <small>&copy; 2025 ISE Department. All rights reserved.</small>
        </div>
    </footer>


<script>
function validateForm() {
    const designation = document.getElementById("designation").value;
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;
    const today = new Date().toLocaleDateString('en-CA'); // Use local date

    if (designation === "") {
        alert("Please select a designation.");
        return false;
    }

    if (startDate === "") {
        alert("Please select a start date.");
        return false;
    }

    if (endDate === "") {
        alert("Please select an end date.");
        return false;
    }

    if (startDate > today) {
        alert("Start date cannot be in the future.");
        return false;
    }

    if (endDate > today) {
        alert("End date cannot be in the future.");
        return false;
    }

    if (startDate > endDate) {
        alert("Start date cannot be later than end date.");
        return false;
    }

    return true;
}

    
</script>
	
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
