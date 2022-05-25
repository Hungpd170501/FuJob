/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
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

    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public User checkLogin(String email, String password) throws SQLException, Exception {
        User user = null;
        try {
            Connection conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, fullName, phone, username,tblUser.roleID, tblRole.roleName "
                    + "FROM tblUser LEFT JOIN tblRole ON tblRole.roleID = tblUser.roleID "
                    + "WHERE email=? AND password=?;";
            PreparedStatement preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            ResultSet rs = preStm.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("userID");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String username = rs.getString("username");
                String roleID = rs.getString("roleID");
                String roleName = rs.getString("roleName");
                Role role = new Role(roleID, roleName);
                user = User.builder()
                        .userID(userID)
                        .username(username)
                        .fullName(fullName)
                        .password("*****")
                        .phone(phone)
                        .email(email)
                        .role(role)
                        .build();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (preStm != null) {
                preStm.close();
            }

            if (conn != null) {

                conn.close();
            }
        }
        return user;
    }

    public User checkLoginGoogle(String email) throws SQLException, Exception {
        User user = null;
        try {
            Connection conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, username, fullName, phone, tblUser.roleID, tblRole.roleName "
                    + "FROM tblUser LEFT JOIN tblRole ON tblRole.roleID = tblUser.roleID "
                    + "WHERE email=?;";
            PreparedStatement preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            ResultSet rs = preStm.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("userID");
                String username = rs.getString("username");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String roleID = rs.getString("roleID");
                String roleName = rs.getString("roleName");
                Role role = new Role(roleID, roleName);
                user = User.builder()
                        .userID(userID)
                        .username(username)
                        .fullName(fullName)
                        .password("*****")
                        .phone(phone)
                        .email(email)
                        .role(role)
                        .build();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (preStm != null) {
                preStm.close();
            }

            if (conn != null) {

                conn.close();
            }
        }
        return user;
    }

}
