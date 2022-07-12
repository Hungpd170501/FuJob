package se1621.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

/**
 * @author ACER
 */
public class DBUtils {
//    private static HikariConfig config = new HikariConfig();
//    private static HikariDataSource ds;
//    private static DBUtils instance;
//    private DBUtils() {
//        config.setJdbcUrl("jdbc:sqlserver://fujob2.database.windows.net:1433;database=FuJobDB;encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");
//        config.setUsername("se150222");
//        config.setPassword("jmpemldekukpuual@1");
//        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        config.addDataSourceProperty("cachePrepStmts", "true");
//        config.addDataSourceProperty("prepStmtCacheSize", "250");
//        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
//        ds = new HikariDataSource(config);
//    }
//    
//    public Connection getConnection() throws SQLException {
//        return ds.getConnection();
//    }
//
//    public static DBUtils getInstance() {
//        if (instance == null) {
//            instance = new DBUtils();
//        }
//        return instance;
//    }

    private static DBUtils instance;
    private Connection connection;

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
    private final String password = "1";

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
