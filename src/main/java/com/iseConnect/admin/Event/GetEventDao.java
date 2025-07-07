package com.iseConnect.admin.Event;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

import com.iseConnect.model.Event;
import com.iseConnect.dao.DaoUtil;

public class GetEventDao {

    public List<Event> getAllEvents() {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT event_id, event_name, event_date, event_url FROM upcoming_events ORDER BY event_date DESC";
        DaoUtil conObj = new DaoUtil();
        try (Connection connection = conObj.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
        	
            while (rs.next()) {
                int eventId = rs.getInt("event_id");
                String eventName = rs.getString("event_name");
                LocalDate eventDate = rs.getDate("event_date").toLocalDate();
                String eventUrl = rs.getString("event_url");

                Event event = new Event(eventId, eventName, eventDate, eventUrl);
                eventList.add(event);
            }

        } catch (SQLException e) {
            System.err.println("Error while fetching events from database.");
            e.printStackTrace();
        }

        return eventList;
    }
}
