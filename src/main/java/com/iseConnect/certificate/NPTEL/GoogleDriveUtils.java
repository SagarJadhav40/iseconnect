package com.iseConnect.certificate.NPTEL;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;

public class GoogleDriveUtils {
    private static final String APPLICATION_NAME = "ISE Connect";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);

    /**
     * Builds and returns the Drive service object.
     * Reads Base64 encoded JSON credentials from environment variable,
     * decodes it, and uses it to authenticate.
     */
    public static Drive getDriveService() throws IOException, GeneralSecurityException {
        String base64Credentials = System.getenv("GOOGLE_APPLICATION_CREDENTIALS_BASE64");
        if (base64Credentials == null || base64Credentials.isEmpty()) {
            throw new IOException("Environment variable GOOGLE_SERVICE_ACCOUNT_KEY_BASE64 not set or empty.");
        }

        // Decode the Base64 string to bytes
        byte[] decodedBytes = java.util.Base64.getDecoder().decode(base64Credentials);

        // Create input stream from decoded bytes
        try (ByteArrayInputStream credentialsStream = new ByteArrayInputStream(decodedBytes)) {

            GoogleCredentials credentials = GoogleCredentials.fromStream(credentialsStream)
                    .createScoped(SCOPES);

            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();

            return new Drive.Builder(httpTransport, JSON_FACTORY, new HttpCredentialsAdapter(credentials))
                    .setApplicationName(APPLICATION_NAME)
                    .build();
        }
    }
}
