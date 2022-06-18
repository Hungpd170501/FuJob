/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import se1621.dto.Skill;
import se1621.dto.StudentSkill;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class StudentSkillDAO {
    private static final String CREATESTUDENTSKILL = "INSERT INTO tblStudentSkill (studentID, skillID) VALUES (?, ?)";
    private static final String GETSTUDENTSKILL = "SELECT stskill.StudentSkillID, stskill.StudentID, stskill.skillID, skill.skillName "
            + "FROM (tblStudentSkill stskill left join tblSkill skill on stskill.skillID = skill.skillID) "
            + "WHERE stskill.StudentID = ?";
    private  static final String DELETESKILL = "DELETE FROM tblStudentSkill WHERE StudentID = ? ";
    private  static final String CHECKSTUDENTHAVESKILL = "SELECT StudentSkillID FROM tblStudentSkill WHERE StudentID = ? ";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;
    
    public boolean createStudetnSkill(StudentSkill studentSkill) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATESTUDENTSKILL);
                preStm.setInt(1, studentSkill.getStudentID());
                preStm.setInt(2, studentSkill.getSkill().getSkillID());

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
    
    public List<StudentSkill> getStudentSkill(int studentID) throws SQLException {
        List<StudentSkill> listStudentSkill = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETSTUDENTSKILL);
                preStm.setInt(1, studentID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int studentSkillID = rs.getInt("studentSkillID");
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = Skill.builder().skillID(skillID).skillName(skillName).build();
                    listStudentSkill.add(StudentSkill.builder().studentSkillID(studentSkillID).studentID(studentID).skill(skill).build());
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
        return listStudentSkill;
    }
    
    public boolean deleteStudetnSkill(int studentID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETESKILL);
                preStm.setInt(1, studentID);
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
    
    public boolean checkStudentHaveSkill(int studentID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKSTUDENTHAVESKILL);
                preStm.setInt(1, studentID);
                rs = preStm.executeQuery();
                while (rs.next()) {
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
}
