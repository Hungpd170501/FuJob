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
import se1621.dto.ResumeSkill;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class ResumeSkillDAO {

    private static final String CREATESTUDENTSKILL = "INSERT INTO tblResumeSkills (resumeID, skillID) VALUES (?, ?)";
    private static final String GETSTUDENTSKILL = "SELECT stskill.resumeSkillID, stskill.resumeID, stskill.skillID, skill.skillName "
            + "FROM (tblResumeSkills stskill left join tblSkills skill on stskill.skillID = skill.skillID) "
            + "WHERE stskill.resumeID = ?";
    private static final String DELETESKILL = "DELETE FROM tblResumeSkills WHERE resumeID = ? ";
    private static final String CHECKSTUDENTHAVESKILL = "SELECT resumeSkillID FROM tblResumeSkills WHERE resumeID = ? ";
    private static final String GET_RESUMESKILL_FOR_ALL_RESUME = "SELECT rk.resumeSkillID, rk.resumeID, rk.skillID, skill.skillName "
            + "FROM tblResumeSkills rk left join tblSkills skill "
            + "on rk.skillID = skill.skillID "
            + "WHERE rk.resumeID IN  (SELECT resumeID FROM tblResumes)";

    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<ResumeSkill> getResumeSkillForAllResume() throws SQLException {
        List<ResumeSkill> listResumeSkills = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_RESUMESKILL_FOR_ALL_RESUME);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int resumeSkillID = rs.getInt("resumeSkillID");
                    int resumeID= rs.getInt("resumeID");
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = Skill.builder().skillID(skillID).skillName(skillName).build();
                    listResumeSkills.add(ResumeSkill.builder().resumeSkillID(resumeSkillID).resumeID(resumeID).skill(skill).build());
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
        return listResumeSkills;
    }
    
    public boolean createStudetnSkill(ResumeSkill resumeSkill) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATESTUDENTSKILL);
                preStm.setInt(1, resumeSkill.getResumeID());
                preStm.setInt(2, resumeSkill.getSkill().getSkillID());

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

    public List<ResumeSkill> getStudentSkill(int resumeID) throws SQLException {
        List<ResumeSkill> listStudentSkill = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETSTUDENTSKILL);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int resumeSkillID = rs.getInt("resumeSkillID");
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = Skill.builder().skillID(skillID).skillName(skillName).build();
                    listStudentSkill.add(ResumeSkill.builder().resumeSkillID(resumeSkillID).resumeID(resumeID).skill(skill).build());
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

    public boolean deleteStudetnSkill(int resumeID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETESKILL);
                preStm.setInt(1, resumeID);
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

    public boolean checkStudentHaveSkill(int resumeID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKSTUDENTHAVESKILL);
                preStm.setInt(1, resumeID);
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
