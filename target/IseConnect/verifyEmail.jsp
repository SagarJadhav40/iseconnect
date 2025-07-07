<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Verify Email</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
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

    .otp-card {
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

    .btn-disabled {
      opacity: 0.6;
      pointer-events: none;
    }

    #resendOtp {
      margin-top: 10px;
      font-size: 0.9rem;
    }
  </style>

  <script>
    let resendTimer;
    let resendCountdown = 30;

    function sendOtp() {
      const email = document.getElementById("email").value.trim();
      const designation = document.getElementById("designation").value.trim();
      if (!email) {
        alert("Please enter your email.");
        return;
      }
      document.getElementById("send-btn").disabled = true;

      fetch("SendOtpServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "email=" + encodeURIComponent(email) + "&designation=" + encodeURIComponent(designation)
      })
      .then(response => response.text())
      .then(data => {
        alert(data);
        if (data.trim() === 'User Email Already Exist') {
        	  window.location.href = designation + 'Login.html';
        	} else {
        	  document.getElementById("emailSection").style.display = "none";
        	  document.getElementById("otpSection").style.display = "block";
        	  document.getElementById("designationSection").style.display = "block";
        	  document.getElementById("verifyBtnSection").style.display = "block";
        	  document.getElementById("resendOtpSection").style.display = "block";

        	  startResendTimer();
        	}

      });
    }

    function resendOtp() {
      const email = document.getElementById("email").value.trim();
      if (!email) {
        alert("Email is missing.");
        return;
      }

      fetch("SendOtpServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "email=" + encodeURIComponent(email)
      })
      .then(response => response.text())
      .then(data => {
        alert("New OTP sent!");
        startResendTimer();
      });
    }

    function startResendTimer() {
      const resendBtn = document.getElementById("resendOtp");
      resendBtn.disabled = true;
      resendBtn.classList.add("btn-disabled");
      resendBtn.textContent = `Resend OTP in 30s`;
      resendCountdown = 30;

      clearInterval(resendTimer);
      resendTimer = setInterval(() => {
        resendCountdown--;
        if (resendCountdown > 0) {
          resendBtn.textContent = `Resend OTP in ${resendCountdown}s`;
        } else {
          clearInterval(resendTimer);
          resendBtn.disabled = false;
          resendBtn.classList.remove("btn-disabled");
          resendBtn.textContent = "Resend OTP";
        }
      }, 1000);
    }

    function verifyOtp() {
      const email = document.getElementById("email").value.trim();
      const otp = document.getElementById("otp").value.trim();
      const designation = document.getElementById("designation").value;

      if (!otp || !designation) {
        alert("Please enter OTP and select designation.");
        return;
      }

      fetch("VerifyEmail", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body:
          "otp=" + encodeURIComponent(otp) +
          "&email=" + encodeURIComponent(email)
      })
      .then(response => response.text())
      .then(data => {
        if (data.trim() === "OTP verified successfully.") {
          window.location.href = designation + "Signup.jsp";
        } else {
          alert(data);
        }
      });
    }
  </script>
</head>
<body>

  <!-- Header -->
  <header class="header">
    <div class="container-fluid">
      <span class="header-title">ISE CONNECT</span>
    </div>
  </header>

  <!-- Main Section -->
  <main>
    <div class="otp-card">
      <h3 class="text-center mb-4">Verify Email</h3>

      <!-- Email Section -->
      <div id="emailSection">
        <div class="mb-3">
          <label for="email" class="form-label">Enter your registered email</label>
          <input type="email" class="form-control" id="email" placeholder="example@gmail.com" required>
        </div>
         <label for="designation" class="form-label">Designation</label>
        <select class="form-select" id="designation" required>
          <option value="">Select</option>
          <option value="students">Student</option>
          <option value="faculty">Faculty</option>
        </select><br>
        <div class="d-grid" >
          <button class="btn btn-custom"  id="send-btn" onclick="sendOtp()">Send OTP</button>
        </div>
      </div>

      <!-- OTP Section -->
      <div id="otpSection" style="display: none;">
        <div class="mb-3">
          <label for="otp" class="form-label">Enter OTP</label>
          <input type="text" class="form-control" id="otp" placeholder="Enter the OTP sent to your email" required>
        </div>
      </div>

      <!-- Resend OTP -->
      <div id="resendOtpSection" class="text-center" style="display: none;">
        <button class="btn btn-link" id="resendOtp" onclick="resendOtp()">Resend OTP</button>
      </div>

      <!-- Designation Dropdown -->
      <div class="mb-3" id="designationSection" style="display: none;">
       <br>
        
        <div class="d-grid" id="verifyBtnSection" style="display: none;">
        <button class="btn btn-custom" onclick="verifyOtp()">Verify OTP</button>
      </div>
      </div>

      <!-- Verify Button -->
      
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
