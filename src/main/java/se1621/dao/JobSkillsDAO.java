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
import se1621.dto.JobSkills;
import se1621.dto.Skill;
import se1621.utils.DBUtils;

/**
 *
 * @author lehad
 */
public class JobSkillsDAO {
    private static final String CREATEOBSKILLS= "INSERT INTO tblJobSkills (jobID, skillID) VALUES (?, ?)";
    private static final String GETJOBSKILLS = "SELECT jk.jobSkillID, jk.jobID, jk.skillID, skill.skillName FROM (tblJobSkills jk left join tblSkills skill on jk.SkillID = skill.skillID)"
            +"WHERE jk.jobID = ?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;
    
    public boolean createSkillRequire(JobSkills JobSkills) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATEOBSKILLS);
                preStm.setInt(1, JobSkills.getJobID());
                preStm.setInt(2, JobSkills.getSkill().getSkillID());

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
    
    public List<JobSkills> getSkillRequire(int jobID) throws SQLException {
        List<JobSkills> listJobSkills = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETJOBSKILLS);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobSkillID = rs.getInt("jobSkillID");
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = Skill.builder().skillID(skillID).skillName(skillName).build();
                    listJobSkills.add(JobSkills.builder().jobSkillID(jobSkillID).jobID(jobID).skill(skill).build());
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
        return listJobSkills;
    }
}
