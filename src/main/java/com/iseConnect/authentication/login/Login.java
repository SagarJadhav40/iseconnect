package com.iseConnect.authentication.login;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.iseConnect.admin.Event.GetEventDao;
import com.iseConnect.model.Event;
import com.iseConnect.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String uname = request.getParameter("email");
		String pass = request.getParameter("password");
		String designation = request.getParameter("designation");
		
		LoginDAO lDao = new LoginDAO();
		GetEventDao gEDao = new GetEventDao();
		HttpSession session = request.getSession();
		if( lDao.check(uname, pass,designation)) {
			User user =  lDao.getUserDetails(uname,designation);
			List<Event> eventList = gEDao.getAllEvents();
			session.setAttribute("name", user.getName());
			session.setAttribute("user", user);
			session.setAttribute("eventList", eventList);
			
			response.sendRedirect("home.jsp");
		}else {
			response.getWriter().print("<script>" +
		            "alert('Authentication Failed!');" +
		            "window.location.href = '"+designation+"Login.html';" + 
		            "</script>");
		}
	}

}