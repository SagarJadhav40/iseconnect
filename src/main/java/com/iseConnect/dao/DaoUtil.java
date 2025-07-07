package com.iseConnect.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DaoUtil {
    public  Connection getConnection() {
    	String url = "jdbc:postgresql://iseconnect-lawnilaxmikant07-0da0.g.aivencloud.com:24633/defaultdb?sslmode=require";
        String username = "avnadmin";
        String password = "AVNS_lH5FJvpJ2dDKvjXOPRq";
        
        try {
            // Correct driver for PostgreSQL
            Class.forName("org.postgresql.Driver");

            return DriverManager.getConnection(url, username, password);

        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        }

        return null;
    }
}
