/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 *
 * @author ACER
 */
public class DBUtils {

    private static DBUtils instance;
    private Connection connection;

    private final String serverName = "fujob.database.windows.net";
    private final String dbName = "FuJobDB";
    private final String portNumber = "1433";
    private final String userID = "se150222";
    private final String password = "jmpemldekukpuual@1";
//jdbc:sqlserver://fujob.database.windows.net:1433;database=FuJobDB;user=se150222@fujob;password=jmpemldekukpuual@1;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;
    private DBUtils() {
        String url = "jdbc:sqlserver://fujob.database.windows.net:1433;database=FuJobDB;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30";
          try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
        }
        try {
            this.connection = DriverManager.getConnection(url,userID,password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Connection getConnection() {
        return connection;
    }

    public static DBUtils getInstance() {
        if (instance == null) {
            instance = new DBUtils();
        } else {
            try {
                if (instance.getConnection().isClosed()) {
                    instance = new DBUtils();
                }
            } catch (SQLException e) {
            }
        }
        return instance;
    }

//    public static void main(String[] args) {
//        System.out.println(DBUtils.getInstance().getConnection());
//    }
}