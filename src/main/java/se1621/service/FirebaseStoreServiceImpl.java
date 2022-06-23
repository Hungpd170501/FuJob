/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.service;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Bucket;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.UUID;
import se1621.utils.FirebaseUtils;

/**
 *
 * @author ACER
 */
public class FirebaseStoreServiceImpl {
    public Bucket bucket;

    public FirebaseStoreServiceImpl() throws IOException {
        this.bucket = FirebaseUtils.getInstance().getBucket();
    }

    public String uploadFile(Part part) throws IOException {
        String fileName = UUID.randomUUID().toString();
        BlobId blobId = BlobId.of(bucket.getName(), fileName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType(part.getContentType()).build();
        com.google.cloud.storage.Blob blob = bucket.getStorage().create(blobInfo, part.getInputStream().readAllBytes());
        return  "https://firebasestorage.googleapis.com/v0/b/" + bucket.getName() + "/o/" + fileName + "?alt=media";
    }
}
