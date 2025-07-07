package com.iseConnect.admin.nptel;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;
import com.iseConnect.dao.DaoUtil;
import com.iseConnect.model.NptelCertification;

@WebServlet("/ViewNptel")

public class ViewNptel extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String designation = request.getParameter("designation");
        String type = request.getParameter("type");

        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
        
        try {
        	CertificateViewDao dao = new CertificateViewDao();
            List<NptelCertification> certifications = dao.getNptelCertifications(designation, startDate, endDate,type);
            HttpSession session = request.getSession();
            session.setAttribute("certifications", certifications);
            if(type.equals("nptel"))
            response.sendRedirect("ViewNptel.jsp");
            else if(type.equals("fdp"))
                response.sendRedirect("viewFdp.jsp");
            else
            	 response.sendRedirect("ViewEvent.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
