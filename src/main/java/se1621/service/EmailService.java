/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package se1621.service;

import jakarta.servlet.ServletContext;
import se1621.dto.User;

/**
 *
 * @author ACER
 */
public interface EmailService {

    void sendEmail(ServletContext context, User repliient, String type);
    void sendEmail(ServletContext context, User recipient, String nameReporter, String subject, String messageDispute, String jobTitle);
    void sendEmailCancelDispute(ServletContext context, User recipient, String nameReporter, String subject, String messageDispute, String jobTitle);
}
