<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ISE CONNECT - Add NPTEL Certification</title>
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

    .form-container {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    }

    .form-label {
      font-weight: bold;
      color: var(--blue-dark);
    }

    .btn-primary {
      background-color: var(--blue-dark);
      border: none;
    }

    .btn-primary:hover {
      background-color: var(--blue-bright);
    }

    .form-heading {
      color: var(--blue-dark);
    }
  </style>
</head>

<% 
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

if (session.getAttribute("name") == null) {
    response.sendRedirect("index.html");
}
%>

<body class="d-flex flex-column min-vh-100">

  <!-- Header -->
<nav class="navbar navbar-expand-lg" style="background-color: var(--blue-dark);">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold me-3" href="#">ISE CONNECT</a>
    <span class="text-white fw-semibold d-none d-sm-inline">
      Welcome, <%= session.getAttribute("name") %>
    </span>
    <button class="navbar-toggler text-white ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
      aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarContent">
      <ul class="navbar-nav mb-2 mb-lg-0 align-items-center">
      
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

  <!-- Main Content -->
  <div class="container my-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="form-container">
          <h4 class="text-center mb-4 form-heading">Add NPTEL Certification</h4>
          <form id="nptelForm" action="AddNptel" method="POST" enctype="multipart/form-data">
            <div class="mb-3">
              <input type="hidden" value="nptel" name="type">
              <label for="courseName" class="form-label">Course Name</label>
              <input type="text" class="form-control" id="courseName" name="courseName" placeholder="Enter Course Name" required>
            </div>
            <div class="mb-3">
              <label for="courseDuration" class="form-label">Course Duration</label>
              <input type="text" class="form-control" id="courseDuration" name="courseDuration" placeholder="e.g., 4 Weeks" required>
            </div>
            <div class="mb-3">
              <label for="certificate" class="form-label">Upload Certificate (PDF)</label>
              <input type="file" class="form-control" id="certificate" name="certificate" accept=".pdf" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Submit</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <div class="container">
      <small>&copy; 2025 ISE Department. All rights reserved.</small>
    </div>
  </footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.getElementById('nptelForm').addEventListener('submit', function (e) {
      const courseName = document.getElementById('courseName').value.trim();
      const courseDuration = document.getElementById('courseDuration').value.trim();
      const certificate = document.getElementById('certificate').files[0];

      if (!courseName) {
        alert('Course Name is required!');
        e.preventDefault();
        return;
      }

      if (!courseDuration) {
        alert('Course Duration is required!');
        e.preventDefault();
        return;
      }

      if (!certificate) {
        alert('Certificate is required!');
        e.preventDefault();
        return;
      }

      if (certificate.type !== 'application/pdf') {
        alert('Only PDF files are allowed for the certificate!');
        e.preventDefault();
        return;
      }
    });
  </script>
</body>
</html>
