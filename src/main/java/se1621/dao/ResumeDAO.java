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

    private static final String SEARCH = "SELECT resumeID, userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, schoolName, major, gpa, experienceYear, skills, website, overview FROM tblResume WHERE userID = ?";
    private static final String CREATERESUME = "INSERT INTO tblResume( userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address,"
            + " schoolName, major, gpa,"
            + " experienceYear, skills, website, overview) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    private static final String CHECK_DUPLICATE = "SELECT resumeID FROM tblResume WHERE userID=?";
    private static final String UPDATERESUME = "UPDATE tblResume SET avatar=?, fullName=?, gender=?, dateOfBirth=?, gmail=?, "
            + "phone=?, address=?, schoolName=?, major=?, gpa=?, experienceYear=?, skills=?, "
            + "website=?, overview=? WHERE userID=?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<Resume> getListResume(int search) throws SQLException {
        List<Resume> listResume = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SEARCH);
                preStm.setInt(1, search);
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
                    String schoolName = rs.getString("schoolName");
                    String major = rs.getString("major");
                    String gpa = rs.getString("gpa");
                    String experienceYear = rs.getString("experienceYear");
                    String skills = rs.getString("skills");
                    String website = rs.getString("website");
                    String overview = rs.getString("overview");
                    listResume.add(new Resume(resumeID, userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, schoolName, major, gpa, experienceYear, skills, website, overview));
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

    public Resume getResumeByID(int search) throws SQLException {
        Resume resume = new Resume();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SEARCH);
                preStm.setInt(1, search);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int resumeID = rs.getInt("resumeID");
                    int userID = rs.getInt("userID");
                    String avatar = rs.getString("avatar");
                    String fullName = rs.getString("fullName");
                    String gender = rs.getString("gender");
                    Date dateOfBirth = rs.getDate("dateOfBirth");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String schoolName = rs.getString("schoolName");
                    String major = rs.getString("major");
                    String gpa = rs.getString("gpa");
                    String experienceYear = rs.getString("experienceYear");
                    String skills = rs.getString("skills");
                    String website = rs.getString("website");
                    String overview = rs.getString("overview");
                    resume = new Resume(resumeID, userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, schoolName, major, gpa, experienceYear, skills, website, overview);
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
                preStm.setString(2, resume.getAvartar());
                preStm.setString(3, resume.getFullName());
                preStm.setString(4, resume.getGender());
                preStm.setDate(5, resume.getDateOfBirth());
                preStm.setString(6, resume.getGmail());
                preStm.setString(7, resume.getPhone());
                preStm.setString(8, resume.getAddress());
                preStm.setString(9, resume.getSchoolName());
                preStm.setString(10, resume.getMajor());
                preStm.setString(11, resume.getGpa());
                preStm.setString(12, resume.getExperienceYear());
                preStm.setString(13, resume.getSkills());
                preStm.setString(14, resume.getWebsite());
                preStm.setString(15, resume.getOverview());

                check = preStm.executeUpdate() > 0 ? true : false;
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

    public boolean checkDuplicate(int userID) throws SQLException {
        boolean check = false;
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
                    check = true;
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
        return check;
    }

    public boolean updateResume(Resume resume, int userID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATERESUME);
                preStm.setString(1, resume.getAvartar());
                preStm.setString(2, resume.getFullName());
                preStm.setString(3, resume.getGender());
                preStm.setDate(4, resume.getDateOfBirth());
                preStm.setString(5, resume.getGmail());
                preStm.setString(6, resume.getPhone());
                preStm.setString(7, resume.getAddress());
                preStm.setString(8, resume.getSchoolName());
                preStm.setString(9, resume.getMajor());
                preStm.setString(10, resume.getGpa());
                preStm.setString(11, resume.getExperienceYear());
                preStm.setString(12, resume.getSkills());
                preStm.setString(13, resume.getWebsite());
                preStm.setString(14, resume.getOverview());
                preStm.setInt(15, userID);
                check = preStm.executeUpdate() > 0 ? true : false;
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

    public List<Resume> getPaginateJobList(List<Resume> listPage, int startPage, int endPage) throws SQLException {
        ArrayList<Resume> jobPage = new ArrayList<>();
        for (int i = startPage; i < endPage; i++) {
            jobPage.add(listPage.get(i));
        }
        return jobPage;
    }
}
