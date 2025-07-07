package com.iseConnect.authentication.forgotPassword;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;

@WebServlet("/SendOtpServlet")
public class SendOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String FROM_EMAIL = "lawnilaxmikant5@gmail.com";
	private static final String FROM_PASSWORD = "yggyplnbvkqfbdhi"; // Use app password if Gmail

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String recipientEmail = request.getParameter("email");

		// Generate OTP
		String otp = generateOtp(6);

		// Save OTP in session for verification later
		HttpSession session = request.getSession();
		session.setAttribute("otp", otp);
		session.setAttribute("email", recipientEmail);

		// Send Email
		boolean result = sendOtpEmail(recipientEmail, otp);

		if (result) {
			response.getWriter().write("OTP sent successfully.");
		} else {
			response.getWriter().write("Failed to send OTP.");
		}
	}

	private String generateOtp(int length) {
		String digits = "0123456789";
		Random random = new Random();
		StringBuilder otp = new StringBuilder();

		for (int i = 0; i < length; i++) {
			otp.append(digits.charAt(random.nextInt(digits.length())));
		}

		return otp.toString();
	}

	private boolean sendOtpEmail(String toEmail, String otp) {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject("Your OTP Code for IseConnect");
			message.setText("Your OTP code is: " + otp + ". Please use this to verify your email in IseConnect.");


			Transport.send(message);
			return true;

		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}
}
