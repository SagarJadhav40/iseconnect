package com.iseConnect.certificate.NPTEL;

import com.google.api.client.http.InputStreamContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.iseConnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet("/AddNptel")
@MultipartConfig
public class AddNptel extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DRIVE_FOLDER_ID = "1g90tICxGT7gpoQ2Xp5Z5_usk0dEFKRhd";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login page if user is not logged in
            response.sendRedirect("Login.jsp");
            return;
        }
        String type = null;
        try {
            String courseName = request.getParameter("courseName");
            type= request.getParameter("type");
            String courseDuration = request.getParameter("courseDuration");
            Part certificatePart = request.getPart("certificate");

            // Call updated upload method without ServletContext parameter
            String certificateUrl = uploadFileToDrive(certificatePart);

            NptelDao nptelDao = new NptelDao();
            boolean success = nptelDao.AddNptel(
                    user.getId(),
                    user.getDesignation(),
                    courseName,
                    courseDuration,
                    certificateUrl,
                    type
            );

            setSessionMessage(session, success);
            response.sendRedirect(type+"Input.jsp");

        } catch (Exception e) {
            handleError(session, e);
            response.sendRedirect(type+"Input.jsp");
        }
    }

    private String uploadFileToDrive(Part filePart)
            throws IOException, GeneralSecurityException {
        if (filePart == null || filePart.getSize() == 0) {
            throw new IOException("No file uploaded");
        }

        Drive driveService = GoogleDriveUtils.getDriveService();

        File fileMetadata = new File();
        fileMetadata.setName(filePart.getSubmittedFileName());
        fileMetadata.setParents(Collections.singletonList(DRIVE_FOLDER_ID));

        try (InputStream fileContent = filePart.getInputStream()) {
            File file = driveService.files().create(fileMetadata,
                    new InputStreamContent(filePart.getContentType(), fileContent))
                    .setFields("id, webViewLink")
                    .execute();

            return "https://drive.google.com/file/d/" + file.getId() + "/view";
        }
    }

    private void setSessionMessage(HttpSession session, boolean success) {
        String message = success ?
                "NPTEL course added successfully!" :
                "Failed to add NPTEL course!";
        String messageType = success ? "success" : "error";

        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
    }

    private void handleError(HttpSession session, Exception e) {
        e.printStackTrace();
        session.setAttribute("message", "Error: " + e.getMessage());
        session.setAttribute("messageType", "error");
    }
}
