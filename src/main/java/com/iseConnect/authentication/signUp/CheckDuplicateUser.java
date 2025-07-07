package com.iseConnect.authentication.signUp;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;


@WebFilter("/SendOtpServlet") 
public class CheckDuplicateUser implements Filter {
	
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
    	String recipientEmail = request.getParameter("email");
        String designation = request.getParameter("designation");
        String check = request.getParameter("check");
        
        SignUpDAO daoObj = new SignUpDAO();
        if("no".equals(check)) {
        	if (!daoObj.checkDuplicatEmail(recipientEmail,designation)) {
                chain.doFilter(request, response); // Continue to the servlet
            } else {
            	response.getWriter().print("User Email Does Not Exist");
                
            }
        }else {
        	if (daoObj.checkDuplicatEmail(recipientEmail,designation)) {
                chain.doFilter(request, response); // Continue to the servlet
            } else {
            	response.getWriter().print("User Email Already Exist");
                
            }
        }
        
    }

    public void destroy() {
        // Clean up resources if needed
    }
}
