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
import java.util.ArrayList;
import java.util.List;
import se1621.dto.Role;
import se1621.dto.User;
import se1621.utils.DBUtils;

public class UserDAO {

    private static final String CHECK_DUPLICATE = "SELECT userID FROM tblUsers WHERE email=?";
    private static final String SINGUP = "INSERT INTO tblUsers(fullName, email, password, roleID, userStatus) VALUES(?,?,?,?,2)";
    private static final String REGISTER_HR = "INSERT INTO tblUsers(fullName, email, password, roleID, userStatus, companyID) VALUES(?,?,?,?,1,?)";
    private static final String UPDATECOMID = "UPDATE tblUsers SET fullName=?, email=?, roleID=?, companyID=? WHERE userID=?";
    private static final String GETUSER = "SELECT fullName, email, u.roleID, r.roleName, companyID, r.createdDate, userStatus "
            + "FROM (tblUsers u left join tblRoles r on u.roleID = r.roleID) WHERE userID =?";
    private static final String GETALLTOTALUSER_NONAD = "SELECT COUNT (userID) AS totalUser FROM tblUsers "
            + "WHERE roleID <> 'AD';";
    private static final String GETLISTUSERBYCOMPANYID = "SELECT u.userID, u.fullName, u.email, u.roleID, r.roleName, u.companyID, "
            + "r.createdDate, u.userStatus, (SELECT COUNT (*) FROM tblJobs j WHERE j.userID = u.userID and j.jobStatus IN (1)) AS projectPosted  "
            + "FROM (tblUsers u left join tblRoles r on u.roleID = r.roleID) WHERE u.companyID = ?";
    private static final String UPDATE_USERSTATUS = "UPDATE tblUsers SET userStatus=? WHERE userID=?";
    private static final String UPDATE_USERFULLNAME = "UPDATE tblUsers SET fullName=? WHERE userID=?";
    private static final String CREATE_USER = "INSERT INTO tblUsers(fullName, email, password, roleID, userStatus) VALUES(?,?,?,?,1)";
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    // tong so job da order
    public int getAllTotalUser_NonAD() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLTOTALUSER_NONAD);
                rs = preStm.executeQuery();
                if(rs.next()){
                    return rs.getInt("totalUser");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return 0;
    }
    
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
                preStm.setString(1, user.getFullName());
                preStm.setString(2, user.getEmail());
                preStm.setString(3, user.getPassword());
                preStm.setString(4, user.getRole().getRoleID());
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
    
    
    public boolean registerHR(User user) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(REGISTER_HR);
                preStm.setString(1, user.getFullName());
                preStm.setString(2, user.getEmail());
                preStm.setString(3, user.getPassword());
                preStm.setString(4, user.getRole().getRoleID());
                preStm.setInt(5, user.getCompanyID());
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

    public User checkLogin(String email, String password) throws Exception {
        User user = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, fullName, companyID, tblUsers.roleID, tblRoles.roleName "
                    + "FROM tblUsers LEFT JOIN tblRoles ON tblRoles.roleID = tblUsers.roleID "
                    + "WHERE email=? AND password=?;";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int userID = rs.getInt("userID");
                String fullName = rs.getString("fullName");
                int companyID = rs.getInt("companyID");
                String roleID = rs.getString("roleID");
                String roleName = rs.getString("roleName");
                Role role = new Role(roleID, roleName);
                user = User.builder()
                        .userID(userID)
                        .fullName(fullName)
                        .password(password)
                        .companyID(companyID)
                        .email(email)
                        .role(role)
                        .build();
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }

    public User checkUserByEmail(String email) throws Exception {
        User user = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "SELECT userID, password, companyID, fullName, userStatus, tblUsers.roleID, tblRoles.roleName "
                    + "FROM tblUsers LEFT JOIN tblRoles ON tblRoles.roleID = tblUsers.roleID "
                    + "WHERE email=?;";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("userID");
                int companyID = rs.getInt("companyID");
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                String password = rs.getString("password");
                String roleName = rs.getString("roleName");
                int status = rs.getInt("userStatus");
                Role role = new Role(roleID, roleName);
                user = User.builder()
                        .userID(userID)
                        .companyID(companyID)
                        .fullName(fullName)
                        .password(password)
                        .email(email)
                        .role(role)
                        .userStatus(status)
                        .build();
            }
        } finally {
            this.closeConnection();
        }
        return user;
    }

    public boolean updateUserPassword(String userEmail, String newPassword) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "UPDATE tblUsers SET password=? WHERE email=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, newPassword);
            preStm.setString(2, userEmail);
            check = preStm.executeUpdate() > 0;
        } catch (SQLException e) {
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

    public boolean activeUserAccount(String userEmail) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            String sql = "UPDATE tblUsers SET userStatus=1 WHERE email=?";
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userEmail);
            check = preStm.executeUpdate() > 0;
        } catch (SQLException e) {
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

    public boolean updateCompanyID(User user, int companyID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATECOMID);
                preStm.setString(1, user.getFullName());
                preStm.setString(2, user.getEmail());
                preStm.setString(3, user.getRole().getRoleID());
                preStm.setInt(4, companyID);
                preStm.setInt(5, user.getUserID());
                check = preStm.executeUpdate() > 0;
            }
        } catch (SQLException e) {
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

    public User getUser(int userID) throws SQLException {
        User user = new User();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GETUSER);
                ptm.setInt(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String email = rs.getString("email");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    int companyID = rs.getInt("companyID");
                    Date createdDate = rs.getDate("createdDate");
                    int userStatus = rs.getInt("userStatus");
                    Role role = new Role(roleID, roleName);
                    user = User.builder()
                                .userID(userID)
                                .fullName(fullName)
                                .email(email)
                                .role(role)
                                .companyID(companyID)
                                .createdDate(createdDate)
                                .userStatus(userStatus)
                                .build();
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
    
    public List<User> getListUserByCompanyID(int companyID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                
                preStm = conn.prepareStatement(GETLISTUSERBYCOMPANYID);
                preStm.setInt(1, companyID);
                rs = preStm.executeQuery();
                List<User> listUser = new ArrayList<>();
                while (rs.next()) {
                    int userID = rs.getInt("userID");
                    String fullName = rs.getString("fullName");
                    String email = rs.getString("email");
                    String roleID = rs.getString("roleID");
                    String roleName = rs.getString("roleName");
                    Date createdDate = rs.getDate("createdDate");
                    int projectPosted = rs.getInt("projectPosted");
                    int userStatus = rs.getInt("userStatus");
                    User user = User.builder()
                            .userID(userID)
                            .fullName(fullName)
                            .email(email)
                            .role(new Role(roleID, roleName))
                            .createdDate(createdDate)
                            .projectPosted(projectPosted)
                            .userStatus(userStatus)
                            .companyID(companyID)
                            .build();
                    listUser.add(user);
                }
                return listUser;
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return null;
    }
    
    public boolean updateUserStatus(int userID, int userStatus) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_USERSTATUS);
                preStm.setInt(1, userStatus);
                preStm.setInt(2, userID);
                check = preStm.executeUpdate() > 0;
            }
        } catch (SQLException e) {
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
    
    public boolean updateUserFullName(int userID, String userFullName) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_USERFULLNAME);
                preStm.setString(1, userFullName);
                preStm.setInt(2, userID);
                check = preStm.executeUpdate() > 0;
            }
        } catch (SQLException e) {
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
    
    public boolean createUser(User user) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATE_USER);
                preStm.setString(1, user.getFullName());
                preStm.setString(2, user.getEmail());
                preStm.setString(3, user.getPassword());
                preStm.setString(4, user.getRole().getRoleID());
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
}

