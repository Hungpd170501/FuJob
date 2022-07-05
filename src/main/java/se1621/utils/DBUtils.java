package se1621.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author ACER
 */
public class DBUtils {

    private static DBUtils instance;
    private Connection connection;
    
//    private final String serverName = "fujob.database.windows.net";
//    private final String dbName = "FuJobDB";
//    private final String portNumber = "1433";
//    private final String userID = "se150222";
//    private final String password = "jmpemldekukpuual@1";
//
//    private DBUtils() {
//        String url = "jdbc:sqlserver://fujob.database.windows.net:1433;database=FuJobDB;encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        } catch (ClassNotFoundException e) {
//        }
//        try {
//            this.connection = DriverManager.getConnection(url, userID, password);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

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

    private final String serverName = "localhost";
    private final String dbName = "FuJobDB_1";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "Hngiabao2211";

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

}
