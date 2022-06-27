/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.cloud.StorageClient;

import java.io.IOException;

/**
 *
 * @author ACER
 */
public class FirebaseUtils {

    private static FirebaseUtils instance;

    public static FirebaseUtils getInstance() {
        if (instance == null) {
            instance = new FirebaseUtils();
        }
        return instance;
    }

    public FirebaseApp getFirebaseApp() throws IOException {
        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setStorageBucket("fujob-353304.appspot.com")
                    .setCredentials(GoogleCredentials.fromStream(getClass().getResourceAsStream("/fujob-353304-firebase-adminsdk-hhwo8-4eba3dea67.json")))
                    .build();
            FirebaseApp.initializeApp(options);
        }
        return FirebaseApp.getInstance();
    }

    //Init bean firebase authentication
    public FirebaseAuth getAuth() throws IOException {
        return FirebaseAuth.getInstance(getFirebaseApp());
    }

    public Bucket getBucket() throws IOException {
        return StorageClient.getInstance(getFirebaseApp()).bucket();
    }
}