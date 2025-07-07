package com.iseConnect.authentication.forgotPassword;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.iseConnect.dao.DaoUtil;

public class ForgotPasswordDAO {

    public boolean resetPassword(String mail, String pass, String designation) {
        // Sanitize input: only allow "students" or "faculty" to prevent SQL injection
        if (!designation.equals("students") && !designation.equals("faculty")) {
            System.err.println("Invalid designation input!");
            return false;
        }

        String query = "UPDATE " + designation + " SET password = ? WHERE email = ?";
        
        DaoUtil conObj = new DaoUtil();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int res = 0;

        try {
            connection = conObj.getConnection();
            if (connection != null) {
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, pass); 
                preparedStatement.setString(2, mail);
                res = preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            System.err.println("Error executing query.");
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }

        return res > 0;
    }
}
