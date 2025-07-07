package com.iseConnect.admin.Event;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

import com.iseConnect.dao.DaoUtil;

public class AddEventDAO {

    public boolean addEvent(String eventName, LocalDate eventDate, String eventUrl) {
        String query = "INSERT INTO upcoming_events (event_name, event_date, event_url) VALUES (?, ?, ?)";
        DaoUtil conObj = new DaoUtil();
        try (Connection connection = conObj.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, eventName);
            preparedStatement.setDate(2, Date.valueOf(eventDate));
            
            // If URL is null or empty, insert default '#'
            if (eventUrl == null || eventUrl.trim().isEmpty()) {
                preparedStatement.setString(3, "#");
            } else {
                preparedStatement.setString(3, eventUrl.trim());
            }

            int result = preparedStatement.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Error while inserting event.");
            e.printStackTrace();
            return false;
        }
    }
}
