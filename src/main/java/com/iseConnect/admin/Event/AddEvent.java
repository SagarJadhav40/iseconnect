package com.iseConnect.admin.Event;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.iseConnect.authentication.login.LoginDAO;
import com.iseConnect.model.Event;
import com.iseConnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/AddEvent")
public class AddEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String eventName = request.getParameter("eventName");
		LocalDate eventDate = LocalDate.parse(request.getParameter("eventDate"));
		String eventUrl = request.getParameter("eventUrl");
		
		AddEventDAO AEDao = new AddEventDAO();
		
		HttpSession session = request.getSession();
		if( AEDao.addEvent(eventName, eventDate,eventUrl)) {
			GetEventDao gEDao = new GetEventDao();
			List<Event> eventList = gEDao.getAllEvents();
			response.getWriter().print("<script>" +
		            "alert('Added Event Successfully');" +
		            "window.location.href = 'AddEvent.jsp';" + 
		            "</script>");
			session.setAttribute("eventList", eventList);
			response.sendRedirect("home.jsp");
			
		}else {
			response.getWriter().print("<script>" +
		            "alert(' Failed to Add Event!');" +
		            "window.location.href = 'AddEvent.jsp';" + 
		            "</script>");
		}
	}

}
