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
import se1621.dto.Resume;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class ResumeDAO {
    private static final String GETRESUME_BYUSERID = "SELECT resumeID, userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, major, gpa, website, gitHub, linkedIn, overview, createdDate, lastModifiedDate FROM tblResumes WHERE userID = ? and resumeStatus = 1";
    private static final String GETRESUME_BYRESUMEID ="SELECT resumeID, userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, major, gpa, website, gitHub, linkedIn, overview, createdDate, lastModifiedDate FROM tblResumes WHERE resumeID = ? and resumeStatus = 1";
    private static final String CREATERESUME = "INSERT INTO tblResumes( userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, major, gpa, website, gitHub, linkedIn, overview, resumeStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,1)";
    private static final String CHECK_DUPLICATE = "SELECT resumeID FROM tblResumes WHERE userID=?";
    private static final String UPDATERESUME = "UPDATE tblResumes SET avatar=?, fullName=?, gender=?, dateOfBirth=?, gmail=?, "
            + "phone=?, address=?, major=?, gpa=?, "
            + "website=?, gitHub=?, linkedIn=?, overview=? WHERE resumeID=?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<Resume> getListResume(int studentID) throws SQLException {
        List<Resume> listResume = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETRESUME_BYUSERID);
                preStm.setInt(1, studentID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int resumeID = rs.getInt("resumeID");
                    int userID = rs.getInt("userID");
                    String avatar = rs.getString("avatar");
                    String fullName = rs.getString("fullName");
                    String gender = rs.getString("gender");
                    Date dateOfBirth = rs.getDate("dateOfBirth");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String major = rs.getString("major");
                    String gpa = rs.getString("gpa");
                    String website = rs.getString("website");
                    String gitHub = rs.getString("gitHub");
                    String linkedIn = rs.getString("linkedIn");
                    String overview = rs.getString("overview");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Resume resume = Resume.builder()
                                          .resumeID(resumeID)
                                          .avatar(avatar)
                                          .fullName(fullName)
                                          .gender(gender)
                                          .dateOfBirth(dateOfBirth)
                                          .gmail(gmail)
                                          .phone(phone)
                                          .address(address)
                                          .major(major)
                                          .gpa(gpa)
                                          .website(website)
                                          .gitHub(gitHub)
                                          .linkedIn(linkedIn)
                                          .overview(overview)
                                          .createdDate(createdDate)
                                          .lastModifiedDate(lastModifiedDate)
                                          .build();
                    listResume.add(resume);
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
        return listResume;
    }

    public Resume getResumeByUserID(int userID) throws SQLException {
        Resume resume = new Resume();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETRESUME_BYUSERID);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                   int resumeID = rs.getInt("resumeID");
                    String avatar = rs.getString("avatar");
                    String fullName = rs.getString("fullName");
                    String gender = rs.getString("gender");
                    Date dateOfBirth = rs.getDate("dateOfBirth");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String major = rs.getString("major");
                    String gpa = rs.getString("gpa");
                    String website = rs.getString("website");
                    String gitHub = rs.getString("gitHub");
                    String linkedIn = rs.getString("linkedIn");
                    String overview = rs.getString("overview");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    resume = Resume.builder()
                                          .resumeID(resumeID)
                                          .userID(userID)
                                          .avatar(avatar)
                                          .fullName(fullName)
                                          .gender(gender)
                                          .dateOfBirth(dateOfBirth)
                                          .gmail(gmail)
                                          .phone(phone)
                                          .address(address)
                                          .major(major)
                                          .gpa(gpa)
                                          .website(website)
                                          .gitHub(gitHub)
                                          .linkedIn(linkedIn)
                                          .overview(overview)
                                          .createdDate(createdDate)
                                          .lastModifiedDate(lastModifiedDate)
                                          .build();
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
        return resume;
    }
    
    public Resume getResumeByResumeID(int resumeID) throws SQLException {
        Resume resume = new Resume();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETRESUME_BYRESUMEID);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                   int userID = rs.getInt("userID");
                    String avatar = rs.getString("avatar");
                    String fullName = rs.getString("fullName");
                    String gender = rs.getString("gender");
                    Date dateOfBirth = rs.getDate("dateOfBirth");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String major = rs.getString("major");
                    String gpa = rs.getString("gpa");
                    String website = rs.getString("website");
                    String gitHub = rs.getString("gitHub");
                    String linkedIn = rs.getString("linkedIn");
                    String overview = rs.getString("overview");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    resume = Resume.builder()
                                          .resumeID(resumeID)
                                          .userID(userID)
                                          .avatar(avatar)
                                          .fullName(fullName)
                                          .gender(gender)
                                          .dateOfBirth(dateOfBirth)
                                          .gmail(gmail)
                                          .phone(phone)
                                          .address(address)
                                          .major(major)
                                          .gpa(gpa)
                                          .website(website)
                                          .gitHub(gitHub)
                                          .linkedIn(linkedIn)
                                          .overview(overview)
                                          .createdDate(createdDate)
                                          .lastModifiedDate(lastModifiedDate)
                                          .build();
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
        return resume;
    }

    public boolean createResume(Resume resume) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATERESUME);
                preStm.setInt(1, resume.getUserID());
                preStm.setString(2, resume.getAvatar());
                preStm.setString(3, resume.getFullName());
                preStm.setString(4, resume.getGender());
                preStm.setDate(5, resume.getDateOfBirth());
                preStm.setString(6, resume.getGmail());
                preStm.setString(7, resume.getPhone());
                preStm.setString(8, resume.getAddress());
                preStm.setString(9, resume.getMajor());
                preStm.setString(10, resume.getGpa());
                preStm.setString(11, resume.getWebsite());
                preStm.setString(12, resume.getGitHub());
                preStm.setString(13, resume.getLinkedIn());
                preStm.setString(14, resume.getOverview());

                check = preStm.executeUpdate() > 0;
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
        return check;
    }

    public int getResumeID(int userID) throws SQLException {
        int resumeID = 0;
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECK_DUPLICATE);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    resumeID = rs.getInt("resumeID");
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
        return resumeID;
    }

    public boolean updateResume(Resume resume, int resumeID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATERESUME);
                preStm.setString(1, resume.getAvatar());
                preStm.setString(2, resume.getFullName());
                preStm.setString(3, resume.getGender());
                preStm.setDate(4, resume.getDateOfBirth());
                preStm.setString(5, resume.getGmail());
                preStm.setString(6, resume.getPhone());
                preStm.setString(7, resume.getAddress());
                preStm.setString(8, resume.getMajor());
                preStm.setString(9, resume.getGpa());
                preStm.setString(10, resume.getWebsite());
                preStm.setString(11, resume.getGitHub());
                preStm.setString(12, resume.getLinkedIn());
                preStm.setString(13, resume.getOverview());
                preStm.setInt(14, resumeID);
                check = preStm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
