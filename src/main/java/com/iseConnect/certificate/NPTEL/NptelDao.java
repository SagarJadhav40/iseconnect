package com.iseConnect.certificate.NPTEL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.iseConnect.dao.DaoUtil;

public class NptelDao {
	boolean AddNptel(int userId, String designation, String courseName, String courseDuration, String certificateUrl,String type) {
        
		DaoUtil daoObj = new DaoUtil();
        String query = "INSERT INTO certifications (user_id, designation, course_name, course_duration, certificate_url,certification_name) VALUES (?, ?, ?, ?, ?,?)";
        Connection conn = daoObj.getConnection();
        try (
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, designation);
            pstmt.setString(3, courseName);
            pstmt.setString(4, courseDuration);
            pstmt.setString(5, certificateUrl);
            pstmt.setString(6, type);
            if(pstmt.executeUpdate()<=0) {
            	return false;
            }
            
        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return true;
    }
}
