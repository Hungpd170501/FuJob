/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ACER
 */
public class DBUtils {

    private static DBUtils instance;
    private Connection connection;

    private final String serverName = "localhost";
    private final String dbName = "FuJobDB_1";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "1472580369";


    private DBUtils() {
        String url = "jdbc:jtds:sqlserver://" + serverName + ":" + portNumber + "/" + dbName;
        try {
            Class.forName("net.sourceforge.jtds.jdbc.Driver");
        } catch (ClassNotFoundException e) {
        }
        try {
            this.connection = DriverManager.getConnection(url, userID, password);
        } catch (SQLException e) {
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

}
