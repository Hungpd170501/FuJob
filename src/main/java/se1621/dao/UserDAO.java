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

public class UserDAO {

    private static final String CHECK_DUPLICATE = "SELECT userID FROM tblUser WHERE email=?";
    private static final String SINGUP = "INSERT INTO tblUser(userName, fullName, email, password, phone, roleID, status) VALUES(?,?,?,?,?,?,1)";

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    private void closeConnection() throws Exception {
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

    public boolean checkDuplicateEmail(String email) throws Exception {
        boolean check = false;
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECK_DUPLICATE);
                preStm.setString(1, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            this.closeConnection();
        }
        return check;
    }

    public boolean signup(User user) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SINGUP);
                //preStm.setString(1, user.getUserID());
                preStm.setString(1, user.getFullName());
                preStm.setString(2, user.getFullName());
                preStm.setString(3, user.getEmail());
                preStm.setString(4, user.getPassword());
                preStm.setString(5, "");
                preStm.setString(6, user.getRole().getRoleID());
                //preStm.setBoolean(5, user.isStatus());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            if (preStm != null) {
                preStm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public User checkLogin(String email, String password) throws SQLException, Exception {
        User user = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, fullName, phone, username,tblUser.roleID, tblRole.roleName "
                    + "FROM tblUser LEFT JOIN tblRole ON tblRole.roleID = tblUser.roleID "
                    + "WHERE email=? AND password=?;";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
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
                        .password(password)
                        .phone(phone)
                        .email(email)
                        .role(role)
                        .build();
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }

    public User checkUserByEmail(String email) throws SQLException, Exception {
        User user = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, password, username, fullName, phone, status, tblUser.roleID, tblRole.roleName "
                    + "FROM tblUser LEFT JOIN tblRole ON tblRole.roleID = tblUser.roleID "
                    + "WHERE email=?;";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("userID");
                String username = rs.getString("username");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String roleID = rs.getString("roleID");
                String password = rs.getString("password");
                String roleName = rs.getString("roleName");
                int status = rs.getInt("status");
                Role role = new Role(roleID, roleName);
                user = User.builder()
                        .userID(userID)
                        .username(username)
                        .fullName(fullName)
                        .password(password)
                        .phone(phone)
                        .email(email)
                        .role(role)
                        .status(status)
                        .build();
            }
        } finally {
            this.closeConnection();;
        }
        return user;
    }
}
