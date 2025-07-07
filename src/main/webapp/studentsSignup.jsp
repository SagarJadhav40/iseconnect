<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Student Signup</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root {
      --blue-dark: #0f2d4f;
      --blue-bright: #00a8ef;
      --beige: #d9cec3;
      --gray-light: #f3f1ee;
      --black: #000000;
    }
    body { background-color: var(--gray-light); margin: 0; }
    .header, .footer { background-color: #27445D; color: white; padding: 15px 30px; text-align: left; font-weight: bold; }
    .footer { text-align: center; font-weight: normal; }
    .form-section { background-color: white; margin: 2rem auto; padding: 2rem; border-radius: 10px; max-width: 600px; }
    .btn-custom { background-color: #27445D; color: white; border: none; }
    .btn-custom:hover { background-color: #194a75; color: white; }
  </style>
</head>
<%
	if(session.getAttribute("email")==null){
		response.sendRedirect("verifyEmail.jsp");
	}
%>
<body>
  <header class="header">ISE CONNECT</header>

  <section class="form-section">
    <h3 class="mb-4 text-center">Student Signup</h3>
    <form onsubmit="return validateForm()" action="SignUp" method="post">
      <input type="hidden" value="students" name="designation">
      <div class="row g-3">
        <div class="col-md-6">
          <label for="name" class="form-label">Name</label>
          <input type="text" class="form-control" name="name" required>
        </div>
        <div class="col-md-6">
          <label for="email" class="form-label">Email</label>
          <input type="email" class="form-control" value="<%=session.getAttribute("email") %>" name="mail" disabled>
        </div>
        <input type="hidden" value="<%=session.getAttribute("email")%>" name="email">
        <div class="col-md-6">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" name="password" required>
        </div>
        <div class="col-md-6">
          <label for="confirm" class="form-label">Confirm Password</label>
          <input type="password" class="form-control" name="confirm" required>
        </div>
        <div class="col-md-6">
          <label for="mobile" class="form-label">Mobile</label>
          <input type="tel" class="form-control" name="mobile" required>
        </div>
        <div class="col-md-6">
          <label for="usn" class="form-label">USN</label>
          <input type="text" class="form-control" name="usn" required>
        </div>
        <div class="col-md-6">
          <label for="year" class="form-label">Year</label>
          <input type="number" class="form-control" name="year" required>
        </div>
        <div class="col-md-6">
          <label for="dob" class="form-label">Date of Birth</label>
          <input type="date" class="form-control" name="dob" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">Gender</label>
          <select class="form-select" name="gender" required>
            <option value="">Select</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="security" class="form-label">Security Question</label>
          <select class="form-select" name="security" required>
            <option value="">Select</option>
            <option value="nickname">What is your nickname?</option>
            <option value="birthplace">What is your place of birth?</option>
          </select>
        </div>
        <div class="col-md-12">
          <label for="securityAnswer" class="form-label">Security Answer</label>
          <input type="text" class="form-control" name="securityAnswer" required>
        </div>
      </div>
      <div class="text-center mt-4">
        <button type="submit" class="btn btn-custom px-5">Sign Up</button>
      </div>
    </form>
  </section>

  <footer class="footer">&copy; 2025 ISE Department. All rights reserved.</footer>

  <script>
    function validateForm() {
      const usn = document.getElementsByName('usn')[0].value.trim().toUpperCase();
      const email = document.getElementsByName('email')[0].value;
      const password = document.getElementsByName('password')[0].value;
      const confirm = document.getElementsByName('confirm')[0].value;

      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      const passPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
      const usnPattern = /^[1-9][A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{3}$/;

      if (!usnPattern.test(usn)) {
        alert("Invalid USN format! Example: 3PD21IS026");
        return false;
      }

      if (!emailPattern.test(email)) {
        alert("Enter a valid email address.");
        return false;
      }

      if (!passPattern.test(password)) {
        alert("Password must be at least 8 characters with uppercase, lowercase, number, and special character.");
        return false;
      }

      if (password !== confirm) {
        alert("Passwords do not match.");
        return false;
      }

      return true;
    }
  </script>
</body>
</html>
