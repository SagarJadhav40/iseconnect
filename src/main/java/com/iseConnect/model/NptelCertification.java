package com.iseConnect.model;


import java.sql.Date;

public class NptelCertification {
    private int id;
    private String userName;
    private String usn; // Nullable, displayed only for students
    private String courseName;
    private String courseDuration;
    private String certificateUrl;
    private Date uploadedAt;

    public NptelCertification(int id, String userName, String usn, String courseName, String courseDuration, String certificateUrl, Date date) {
        this.id = id;
        this.userName = userName;
        this.usn = usn;
        this.courseName = courseName;
        this.courseDuration = courseDuration;
        this.certificateUrl = certificateUrl;
        this.uploadedAt = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUsn() {
        return usn;
    }

    public void setUsn(String usn) {
        this.usn = usn;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseDuration() {
        return courseDuration;
    }

    public void setCourseDuration(String courseDuration) {
        this.courseDuration = courseDuration;
    }

    public String getCertificateUrl() {
        return certificateUrl;
    }

    public void setCertificateUrl(String certificateUrl) {
        this.certificateUrl = certificateUrl;
    }

    public Date getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(Date uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
}
