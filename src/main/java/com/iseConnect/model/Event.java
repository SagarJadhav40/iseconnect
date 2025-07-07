package com.iseConnect.model;

import java.time.LocalDate;

public class Event {
    private int eventId;
    private String eventName;
    private LocalDate eventDate;
    private String eventUrl;

   
    public Event(int eventId, String eventName, LocalDate eventDate, String eventUrl) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.eventUrl = eventUrl;
    }

    // Getters and Setters
    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public LocalDate getEventDate() {
        return eventDate;
    }

    public void setEventDate(LocalDate eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventUrl() {
        return eventUrl;
    }

    public void setEventUrl(String eventUrl) {
        this.eventUrl = eventUrl;
    }

    // toString method (optional, useful for debugging/logging)
    @Override
    public String toString() {
        return "Event{" +
                "eventId=" + eventId +
                ", eventName='" + eventName + '\'' +
                ", eventDate=" + eventDate +
                ", eventUrl='" + eventUrl + '\'' +
                '}';
    }
}
