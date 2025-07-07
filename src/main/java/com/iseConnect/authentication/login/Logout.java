package com.iseConnect.authentication.login;

import java.io.IOException;

import com.iseConnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user=(User) session.getAttribute("user");
		String designation = user.getName();
		session.removeAttribute("uname");
		session.invalidate();
		if(designation.equals("Admin")) {
			response.sendRedirect("AdminPanelLoginPage.jsp");
		}
		else
		response.sendRedirect("index.html");
	}

}
