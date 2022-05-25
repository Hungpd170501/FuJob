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

//    private static Connection con;

//    static {
//        String url = "jdbc:jtds:sqlserver://localhost:1433;databaseName=FreelaceManagement";
//        String user = "sa";
//        String pass = "1472580369";
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            con = DriverManager.getConnection(url, user, pass);
//        } catch (ClassNotFoundException | SQLException e) {
//            e.printStackTrace();
//        }
//    }
//    public static Connection getConnection() {
//        return con;
//    }
        public static final Connection getConnection() throws ClassNotFoundException, SQLException{
     Connection conn = null;
     
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:jtds:sqlserver://localhost:1433;databaseName=FreelaceManagement";
        conn = DriverManager.getConnection(url, "sa", "1472580369");
        return conn;
}
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Connection conn = DBUtils.getConnection();
        System.out.println(conn);
    }
}
