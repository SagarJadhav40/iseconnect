package com.iseConnect.authentication.signUp;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import com.iseConnect.dao.DaoUtil;

public class SignUpDAO {
	DaoUtil conObj = new DaoUtil();

	public boolean checkDuplicatEmail(String mail, String designation) {
		String query = "SELECT * FROM " + designation + " WHERE email = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = conObj.getConnection();
			if (connection != null) {
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, mail);
				resultSet = preparedStatement.executeQuery();

				if (resultSet.next()) {
					return false;
				}
			}
		} catch (SQLException e) {
			System.err.println("Error executing query.");
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing ResultSet.");
				e.printStackTrace();
			}

			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing PreparedStatement.");
				e.printStackTrace();
			}

			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing Connection.");
				e.printStackTrace();
			}
		}

		return true;
	}
	
	public boolean checkDuplicatUsn(String usn, String designation) {
		String query = "SELECT * FROM " + designation + " WHERE usn = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = conObj.getConnection();
			if (connection != null) {
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, usn);
				resultSet = preparedStatement.executeQuery();

				if (resultSet.next()) {
					return false;
				}
			}
		} catch (SQLException e) {
			System.err.println("Error executing query.");
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing ResultSet.");
				e.printStackTrace();
			}

			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing PreparedStatement.");
				e.printStackTrace();
			}

			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println("Error closing Connection.");
				e.printStackTrace();
			}
		}

		return true;
	}

	public boolean registerUser(String name, String mail, Long phone, String pass, LocalDate dob, String gender,
			String securityQuestion, String securityAnswer, String usn, int year, String designation) {

		String query = null;
		if ("students".equals(designation)) {
			query = "INSERT INTO students (name,email,password,mobile,usn,year,dob,gender,security_question,security_answer) VALUES (?,?,?,?,?,?,?,?,?,?)";
		} else if ("faculty".equals(designation)) {
			query = "INSERT INTO faculty (name,email,password,mobile,dob,gender,security_question,security_answer) VALUES (?,?,?,?,?,?,?,?)";
		} else {
			System.err.println("Invalid designation passed.");
			return false;
		}

		try (Connection connection = conObj.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, name);
			preparedStatement.setString(2, mail);
			preparedStatement.setString(3, pass);
			preparedStatement.setLong(4, phone);

			if ("students".equals(designation)) {
				preparedStatement.setString(5, usn);
				preparedStatement.setInt(6, year);
				preparedStatement.setDate(7, Date.valueOf(dob));
				preparedStatement.setString(8, gender);
				preparedStatement.setString(9, securityQuestion);
				preparedStatement.setString(10, securityAnswer);
			} else {
				preparedStatement.setDate(5, Date.valueOf(dob));
				preparedStatement.setString(6, gender);
				preparedStatement.setString(7, securityQuestion);
				preparedStatement.setString(8, securityAnswer);
			}

			int res = preparedStatement.executeUpdate();
			return res > 0;

		} catch (SQLException e) {
			System.err.println("Error executing query.");
			e.printStackTrace();
			return false;
		}
	}

}