/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import se1621.dto.Role;
import se1621.dto.User;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class UserDAO {

    private static final String LOGIN = "SELECT userID, roleID, userName FROM tblUsers WHERE email=? AND password=? ";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
    public User checkLogin(String email, String password) throws SQLException {
        User user = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, email);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int userID = rs.getInt("userID");
                    String roleID = rs.getString("roleID");
//                    String userName = rs.getString("userName");
                    Role role = new Role(roleID, "");
                    user=User.builder().userID(userID).role(role).build();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

}
