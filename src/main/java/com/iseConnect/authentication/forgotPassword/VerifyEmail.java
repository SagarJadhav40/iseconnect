package com.iseConnect.authentication.forgotPassword;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/VerifyEmail")
public class VerifyEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        String email = request.getParameter("email");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.getWriter().write("Session expired. Please try again.");
            return;
        }

        String sessionOtp = (String) session.getAttribute("otp");

        if (enteredOtp != null && enteredOtp.equals(sessionOtp)) {
            response.getWriter().write("OTP verified successfully.");
            session.setAttribute("email", email);
        } else {
            response.getWriter().write("Invalid OTP.");
        }
    }
}
