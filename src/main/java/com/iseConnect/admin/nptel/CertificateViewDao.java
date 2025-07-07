package com.iseConnect.admin.nptel;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.iseConnect.dao.DaoUtil;
import com.iseConnect.model.NptelCertification;

public class CertificateViewDao {

	private final Connection connection;

	public CertificateViewDao() {
		DaoUtil dao = new DaoUtil();
		this.connection = dao.getConnection();
	}

	public List<NptelCertification> getNptelCertifications(String designation, LocalDate startDate, LocalDate endDate,
			String type) throws SQLException {

		// Validate designation
		validateDesignation(designation);

		// Determine table name and ID column based on designation
		String tableName = getTableName(designation);
		String idColumn = getIdColumn(designation);
		String query = null;
		if (designation.equals("Faculty")) {
			query = "SELECT n.id, u.name AS user_name, n.course_name, n.course_duration, "
					+ "n.certificate_url, n.uploaded_at " + "FROM certifications n " + "JOIN " + tableName
					+ " u ON n.user_id = u." + idColumn + " " + "WHERE n.designation = ? AND certification_name= ? "
					+ "AND DATE(n.uploaded_at) BETWEEN ? AND ? " + "ORDER BY n.uploaded_at DESC";
		} else {
			query = "SELECT n.id, u.name AS user_name, u.usn, n.course_name, n.course_duration, "
					+ "n.certificate_url, n.uploaded_at " + "FROM certifications n " + "JOIN " + tableName
					+ " u ON n.user_id = u." + idColumn + " " + "WHERE n.designation = ? AND certification_name= ? "
					+ "AND DATE(n.uploaded_at) BETWEEN ? AND ? " + "ORDER BY n.uploaded_at DESC";
		}

		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, designation.toLowerCase());
			stmt.setDate(3, Date.valueOf(startDate)); // Start date
			stmt.setDate(4, Date.valueOf(endDate)); // End date
			stmt.setString(2, type);

			ResultSet rs = stmt.executeQuery();
			List<NptelCertification> certifications = new ArrayList<>();

			while (rs.next()) {
				if (designation.equals("Faculty"))
					certifications.add(new NptelCertification(rs.getInt("id"), rs.getString("user_name"),
							null, rs.getString("course_name"), rs.getString("course_duration"),
							rs.getString("certificate_url"), rs.getDate("uploaded_at")));
				else
					certifications.add(new NptelCertification(rs.getInt("id"), rs.getString("user_name"),
							rs.getString("usn"), rs.getString("course_name"), rs.getString("course_duration"),
							rs.getString("certificate_url"), rs.getDate("uploaded_at")));
			}

			return certifications;
		}

	}

	// Validate the designation
	private void validateDesignation(String designation) {
		if (!"faculty".equalsIgnoreCase(designation) && !"students".equalsIgnoreCase(designation)) {
			throw new IllegalArgumentException("Invalid designation. Must be 'faculty' or 'student'.");
		}
	}

	// Get the table name based on designation
	private String getTableName(String designation) {
		return designation.equalsIgnoreCase("faculty") ? "faculty" : "students";
	}

	// Get the ID column name based on designation
	private String getIdColumn(String designation) {
		return designation.equalsIgnoreCase("faculty") ? "faculty_id" : "student_id";
	}
}
