<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ISE CONNECT - Add Upcoming Event</title>
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

if (session.getAttribute("name") == "Admin") {
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
          <h4 class="text-center mb-4 form-heading">Add Upcoming Event</h4>
          <form id="eventForm" action="AddEvent" method="POST">
            <div class="mb-3">
              <label for="eventName" class="form-label">Event Name</label>
              <input type="text" class="form-control" id="eventName" name="eventName" placeholder="Enter Event Name" required>
            </div>
            <div class="mb-3">
              <label for="eventDate" class="form-label">Event Date</label>
              <input type="date" class="form-control" id="eventDate" name="eventDate" required>
            </div>
            <div class="mb-3">
              <label for="eventUrl" class="form-label">Event URL (optional)</label>
              <input type="url" class="form-control" id="eventUrl" name="eventUrl" placeholder="Enter Event URL or leave blank">
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
<script type="text/javascript">
 document.getElementById('eventForm').addEventListener('submit', function (e) {
  const eventName = document.getElementById('eventName').value.trim();
  const eventDate = document.getElementById('eventDate').value;
  const eventUrl = document.getElementById('eventUrl').value.trim();

  if (!eventName) {
    alert('Event Name is required!');
    e.preventDefault();
    return;
  }

  if (!eventDate) {
    alert('Event Date is required!');
    e.preventDefault();
    return;
  }

  // Only validate URL format if user entered a URL
  if (eventUrl !== '') {
    const urlPattern = /^https?:\/\/.+/;
    if (!urlPattern.test(eventUrl)) {
      alert('Please enter a valid URL starting with http:// or https://');
      e.preventDefault();
      return;
    }
  }
});
 </script>

</body>
</html>
