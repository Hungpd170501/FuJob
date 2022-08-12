/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import jakarta.servlet.ServletContext;
import org.jboss.logging.Logger;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author ACER
 */
public class PropertiesFileHelper {
    public static Properties getProperties(ServletContext context, String fileRelartiveParth) {
        InputStream input = context.getResourceAsStream(fileRelartiveParth);
        Properties properties = null;
        try {
            properties = new Properties();
            properties.load(input);
        } catch (IOException ex) {
            Logger.getLogger(PropertiesFileHelper.class.getName()).log(Logger.Level.ERROR, null, ex);
        }
        return properties;
    }
}
