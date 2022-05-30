/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import se1621.dto.Resume;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */

public class ResumeDAO {
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
}
