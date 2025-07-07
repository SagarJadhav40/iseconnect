package com.iseConnect.authentication.signUp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;


@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String usn=null;
		int year=0;
		
		String designation = request.getParameter("designation");
		if("students".equals(designation)) {
			usn = request.getParameter("usn");	
			year = Integer.parseInt(request.getParameter("year"));
		}
		String name = request.getParameter("name");
		String mail = request.getParameter("email");
		Long phone = Long.parseLong(request.getParameter("mobile"));
		String pass = request.getParameter("password");
		LocalDate dob = LocalDate.parse(request.getParameter("dob"));
		String gender = request.getParameter("gender");
		String securityQuestion = request.getParameter("security");
		String securityAnswer = request.getParameter("securityAnswer");
		
		SignUpDAO daoObj = new SignUpDAO();
		
	if("students".equals(designation) && !daoObj.checkDuplicatUsn(usn,designation)) {
			out.print("<script>" +
		            "alert('User USN Already Exist!');" +
		            "window.location.href = '"+designation+"Signup.html';" + 
		            "</script>");
		}
	else if(daoObj.registerUser(name, mail, phone, pass, dob,gender,securityQuestion,securityAnswer,usn,year,designation)){
				out.print("<script>" +
			            "alert('Succesfully SignedUp!');" +
			            "window.location.href = '"+designation+"Login.html';" + 
			            "</script>");
		}else {
			out.print("<script>" +
		            "alert('Error Occured!\n Please Try Again!');" +
		            "window.location.href = '"+designation+".html';" + 
		            "</script>");
		}
	}

}
