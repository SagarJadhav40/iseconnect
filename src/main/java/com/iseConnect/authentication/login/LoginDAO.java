package com.iseConnect.authentication.login;

import java.sql.*;
import com.iseConnect.dao.DaoUtil;
import com.iseConnect.model.User;

public class LoginDAO {
  
    public boolean check(String uname, String pass,String designation) {
        String query = "SELECT * FROM "+designation+ " WHERE email = ? AND password = ?";
        DaoUtil dao = new DaoUtil();
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = dao.getConnection();
            if (connection != null) {
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, uname); 
                preparedStatement.setString(2, pass); 

                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    return true; 
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

        return false; 
    }
    
    public  User getUserDetails(String mail,String designation) {
		DaoUtil dao = new DaoUtil();
		User user = new User();
		
		String query = "SELECT * FROM "+designation+" WHERE email = ?";
        
		 
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = dao.getConnection();
            if (connection != null) {
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, mail); 

                resultSet = preparedStatement.executeQuery();
                String s = null;
                if(designation.equals("students"))s="student";
                else s="faculty";
                if(resultSet.next()) {
                	user.setName(resultSet.getString("name"));
                	user.setId(resultSet.getInt(s+"_id"));
                    user.setEmail(mail);
                    user.setMobile(Long.parseLong(resultSet.getString("mobile")));
                    user.setDesignation(designation);
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
			return user;
		
	}

}
