<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Faculty Login</title>
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

    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
      background-color: var(--gray-light);
    }

    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .header {
      background-color: #27445D;
      padding: 15px 30px;
    }

    .header-title {
      color: white;
      font-size: 1.5rem;
      font-weight: bold;
    }

    .footer {
      background-color: #27445D;
      color: white;
      padding: 15px 0;
      text-align: center;
    }

    .login-card {
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 400px;
    }

    .btn-custom {
      background-color: #27445D;
      color: white;
      border: none;
      transition: 0.3s ease;
    }

    .btn-custom:hover {
      background-color: #194a75;
    }

    a {
      color: var(--blue-bright);
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<script>
  function validateLogin() {
    const email = document.getElementsByName("email")[0].value.trim();
    const password = document.getElementsByName("password")[0].value;

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

    if (!emailPattern.test(email)) {
      alert("Please enter a valid email address.");
      return false;
    }

    if (!passwordPattern.test(password)) {
      alert("Password must be at least 8 characters long and include:\n- A lowercase letter\n- An uppercase letter\n- A number\n- A special character");
      return false;
    }

    return true;
  }
</script>

<body>

  <!-- Header -->
  <header class="header">
    <div class="container-fluid">
      <span class="header-title">ISE CONNECT</span>
    </div>
  </header>

  <!-- Login Form Section -->
  <main>
    <div class="login-card">
      <h3 class="text-center mb-4">Admin Login</h3>
      <form onsubmit="return validateLogin()" action="Login" method="post">
      	<input type="hidden" value="faculty" name="designation">
        <div class="mb-3">
          <label for="email" class="form-label">Email address</label>
          <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
        </div>
        <div class="mb-2">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
        </div>
        <div class="d-grid">
          <button type="submit" class="btn btn-custom">Login</button>
        </div>
      </form>
    </div>
  </main>

  <!-- Footer -->
  <footer class="footer mt-auto">
    <div class="container">
      <small>&copy; 2025 ISE Connect. All rights reserved.</small>
    </div>
  </footer>

</body>
</html>
    