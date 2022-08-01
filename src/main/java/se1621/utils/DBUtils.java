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
    private static final HikariConfig config = new HikariConfig();
    private static HikariDataSource ds;
    private static DBUtils instance;
    public Connection getConnection() throws SQLException {
        return ds.getConnection();
    }
    public static DBUtils getInstance() {
        if (instance == null) {
            instance = new DBUtils();
        }
        return instance;
    }

    private DBUtils() {
        config.setJdbcUrl("jdbc:sqlserver://fujob2.database.windows.net:1433;database=FuJobDB;encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");
        config.setUsername("se150222");
        config.setPassword("jmpemldekukpuual@1");
        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        ds = new HikariDataSource(config);
    }


//    private final String dbName = "FuJobDB_1";
//    private final String userID = "sa";
//    private final String password = "Hngiabao2211";
//    private DBUtils() {
//        config.setMaximumPoolSize(10);
//        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        config.setConnectionTimeout(1000L);
//        config.setJdbcUrl("jdbc:sqlserver://localhost:1433;database="+ dbName +";trustServerCertificate=true;");
//        config.setUsername(userID);
//        config.setPassword(password);
//        config.addDataSourceProperty("autoReconnect", true);
//        config.addDataSourceProperty("cachePrepStmts", true);
//        config.addDataSourceProperty("prepStmtCacheSize", 250);
//        config.addDataSourceProperty("prepStmtCacheSqlLimit", 2048);
//        config.addDataSourceProperty("useServerPrepStmts", true);
//        config.addDataSourceProperty("cacheResultSetMetadata", true);
//        ds = new HikariDataSource(config);
//    }
}
