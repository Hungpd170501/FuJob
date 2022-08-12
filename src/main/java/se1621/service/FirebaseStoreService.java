/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package se1621.service;


import jakarta.servlet.http.Part;

import java.io.IOException;

public interface FirebaseStoreService {
    <T> String uploadFile(Part part) throws IOException;
}
