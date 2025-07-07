<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Forgot Password - ISE Connect</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap 5 -->
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
    }

    .header {
      background-color: var(--blue-dark);
      padding: 15px 30px;
    }

    .header-title {
      color: white;
      font-size: 1.5rem;
      font-weight: bold;
    }

    .footer {
      background-color: var(--blue-dark);
      color: white;
      padding: 15px 0;
      text-align: center;
      margin-top: auto;
    }

    .form-section {
      padding: 40px 15px;
    }

    .form-container {
      background-color: white;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .btn-custom {
      background-color: var(--blue-dark);
      color: white;
      transition: 0.3s ease;
    }

    .btn-custom:hover {
      background-color: #194a75;
      color: white;
    }
  </style>
</head>
<body class="d-flex flex-column min-vh-100">

  <!-- Header -->
  <header class="header">
    <div class="container-fluid">
      <span class="header-title">ISE CONNECT</span>
    </div>
  </header>

  <!-- Forgot Password Form -->
  <section class="form-section">
    <div class="container">
      <div class="form-container mx-auto" style="max-width: 600px;">
        <h2 class="mb-4 text-center">Forgot Password</h2>
        <form id="forgotPasswordForm" action="ForgotPassword" method="post" onsubmit="return validateForgotPasswordForm()">

          <!-- Designation -->
          <div class="mb-3">
            <label for="designation" class="form-label">Designation</label>
            <select class="form-select" name="designation" id="designation" required>
              <option value="">Select</option>
              <option value="students">Student</option>
              <option value="faculty">Faculty</option>
            </select>
          </div>

          <!-- Registered Email (disabled for display) -->
          <div class="mb-3">
            <label for="email" class="form-label">Registered Email</label>
            <input type="email" class="form-control" name="emailDisplay" id="email" value="<%=session.getAttribute("email") %>" disabled>
            <input type="hidden" name="email" value="<%=session.getAttribute("email") %>">
          </div>

          <!-- New Password -->
          <div class="mb-3">
            <label for="newPassword" class="form-label">New Password</label>
            <input type="password" class="form-control" name="newPassword" id="newPassword" required>
          </div>

          <!-- Confirm Password -->
          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required>
          </div>

          <!-- Submit -->
          <div class="d-grid">
            <button type="submit" class="btn btn-custom">Change Password</button>
          </div>

        </form>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer mt-auto">
    <div class="container">
      <small>&copy; 2025 ISE Department. All rights reserved.</small>
    </div>
  </footer>

  <!-- JavaScript -->
  <script>
    function validateEmail(email) {
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return regex.test(email);
    }

    function validatePassword(password) {
      const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
      return regex.test(password);
    }

    function validateForgotPasswordForm() {
      const email = document.getElementsByName("email")[0].value.trim();
      const newPassword = document.getElementById("newPassword").value.trim();
      const confirmPassword = document.getElementById("confirmPassword").value.trim();

      if (!validateEmail(email)) {
        alert("Please enter a valid email address.");
        return false;
      }

      if (!validatePassword(newPassword)) {
        alert("Password must be at least 8 characters with uppercase, lowercase, number, and special character.");
        return false;
      }

      if (newPassword !== confirmPassword) {
        alert("Passwords do not match.");
        return false;
      }

      return true; // All validations passed
    }
  </script>

</body>
</html>
