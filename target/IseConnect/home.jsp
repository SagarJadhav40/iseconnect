<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.iseConnect.model.User" %>
<%@ page import="com.iseConnect.model.Event" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ISE CONNECT - Home</title>
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

    .carousel-inner img {
      width: 80%;
      height: 610px;
      object-fit: cover;
    }

    .section-block {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    }

    .news-title, .quick-links-title {
      font-weight: bold;
      color: var(--blue-dark);
      margin-bottom: 10px;
    }

    .dropdown-menu a {
      color: var(--blue-dark) !important;
    }

    /* News Scrolling */
    .news-scroll {
      height: 160px;
      overflow: hidden;
      position: relative;
    }

    .news-scroll .scroll-content {
      position: absolute;
      animation: scrollUp 10s linear infinite;
    }

    .news-scroll:hover .scroll-content {
      animation-play-state: paused;
    }

    @keyframes scrollUp {
      0% {
        top: 100%;
      }
      100% {
        top: -100%;
      }
    }
    .quk{
          height: 160px;
    
    }
  </style>
</head>

<% 
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setHeader("Expires", "0"); // Proxies

if (session.getAttribute("name") == null) {
    response.sendRedirect("index.html");
}
User user = (User)session.getAttribute("user");
List<Event> eventList = (List<Event>) session.getAttribute("eventList");
%>

<body class="d-flex flex-column min-vh-100">

  <!-- Navbar Header -->
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
          <% if (user.getName().equals("Admin")) { %>
            <li class="nav-item"><a class="nav-link text-white" href="ViewNptel.jsp">NPTEL Certification</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="viewFdp.jsp">FDP Certification</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="ViewEvent.jsp">Events Certification</a></li>
            
            <li class="nav-item"><a class="nav-link text-white" href="addEvent.jsp">Add Events</a></li>
          <% } else if (user.getDesignation().equals("faculty")) { %>
            <li class="nav-item"><a class="nav-link text-white" href="nptelInput.jsp">NPTEL Certification</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="fdpInput.jsp">FDP Certification</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="eventInput.jsp">Event Certification</a></li>
          <% } else  { %>
            <li class="nav-item"><a class="nav-link text-white" href="nptelInput.jsp">NPTEL Certification</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="eventInput.jsp">Event Certification</a></li>
          <% } %>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button"
              data-bs-toggle="dropdown" aria-expanded="false">Profile</a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="#">Edit Profile</a></li>
              <li><a class="dropdown-item" href="Logout">Logout</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Carousel -->
  <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="pics\\PDACEK.jpg" class="d-block w-100" alt="Image 1">
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>

  <!-- News & Quick Links -->
  <div class="container my-5">
    <div class="row">
      <!-- News & Events with Scroll -->
      <div class="col-md-6">
        <div class="section-block">
          <h5 class="news-title">News & Events</h5>
          <div class="scroll-container news-scroll">
            <ul class="list-unstyled scroll-content">
              <%for(Event event:eventList) {%>
                <li><a href ="<%=event.getEventUrl()%>"><%=event.getEventName() %>[Date:<%=event.getEventDate() %>]</a></li>
              <%} %>
            </ul>
          </div>
        </div>
      </div>

      <!-- Quick Links -->
      <div class="col-md-6">
        <div class="section-block">
          <h5 class="quick-links-title">Quick Links</h5>
          <div class="quk">
          <ul class="list-unstyled">
            <li><a href="nptelInput.jsp" class="text-decoration-none">Submit NPTEL Certifications</a></li>
            <% if (user.getDesignation().equals("faculty")) { %>
            <li><a href="nptelInput.jsp" class="text-decoration-none">Submit FDP Certifications</a></li>
            <%} %>
          </ul>
          </div>
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
</body>
</html>
