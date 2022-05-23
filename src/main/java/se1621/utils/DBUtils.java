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
    	    private static Connection con;
	  
	    static {
	        String url = "jdbc:sqlserver://localhost:1433;databaseName=VegetableManagement";
	        String user = "sa";
	        String pass = "sa";
	        try {
	            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	            con = DriverManager.getConnection(url, user, pass);
	        }
	        catch (ClassNotFoundException | SQLException e) {
	        }
	    } 
	    
	    public static Connection getConnection() {
	        return con;
	    }
}
