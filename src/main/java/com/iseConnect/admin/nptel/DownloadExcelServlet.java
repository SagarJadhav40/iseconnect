package com.iseConnect.admin.nptel;



import com.iseConnect.model.NptelCertification;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/DownloadExcel")
public class DownloadExcelServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<NptelCertification> certifications = (List<NptelCertification>) session.getAttribute("certifications");

        if (certifications == null || certifications.isEmpty()) {
            response.getWriter().write("No data available to download.");
            return;
        }

        // Set the response headers for Excel download
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=NptelCertifications.xlsx");

        try (Workbook workbook = new XSSFWorkbook(); OutputStream out = response.getOutputStream()) {
            // Create a sheet
            Sheet sheet = workbook.createSheet("Certifications");

            // Create the header row
            Row headerRow = sheet.createRow(0);
            String[] headers= {};
            if(certifications.get(0).getUsn()==null){
            String[] headers1= {"User Name", "Course Name", "Course Duration", "Certificate URL"};
            headers=headers1;
            }else {
            	 String[] headers1= {"User Name", "USN", "Course Name", "Course Duration", "Certificate URL"};
            	 headers=headers1;
            }
            
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                CellStyle style = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                style.setFont(font);
                cell.setCellStyle(style);
            }

            // Populate the sheet with data
            int rowIndex = 1;
            for (NptelCertification cert : certifications) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(0).setCellValue(cert.getUserName());
                if(cert.getUsn() != null) {
                row.createCell(1).setCellValue(cert.getUsn() != null ? cert.getUsn() : "N/A");
                row.createCell(2).setCellValue(cert.getCourseName());
                row.createCell(3).setCellValue(cert.getCourseDuration());
                row.createCell(4).setCellValue(cert.getCertificateUrl());
                }else {
                	row.createCell(1).setCellValue(cert.getCourseName());
                    row.createCell(2).setCellValue(cert.getCourseDuration());
                    row.createCell(3).setCellValue(cert.getCertificateUrl());
                }
                
            }

            // Autosize columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write to output stream
            workbook.write(out);
        }
    }
}
