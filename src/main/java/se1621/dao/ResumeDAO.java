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
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<Resume> getListResume(int search) throws SQLException {
        List<Resume> listResume = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if(conn != null){
                preStm = conn.prepareStatement(SEARCH);
                preStm.setInt(1, search);
                rs = preStm.executeQuery();
                while(rs.next()){
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
            e.printStackTrace();;
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

}
