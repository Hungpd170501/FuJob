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
import se1621.dto.SkillRequire;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class SkillRequireDAO {
    private static final String CREATESKILLREQUIRE = "INSERT INTO tblSkillRequire (jobID, skillID) VALUES (?, ?)";
    private static final String GETSKILLREQUIRE = "SELECT skillRequired.skillRequireID, skillRequired.jobID, skillRequired.skillID, skill.skillName FROM (tblSkillRequire skillRequired left join tblSkill skill on skillRequired.skillID = skill.skillID)"
            +"WHERE skillRequired.jobID = ?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;
    
    public boolean createSkillRequire(SkillRequire skillRequire) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATESKILLREQUIRE);
                preStm.setInt(1, skillRequire.getJobID());
                preStm.setInt(2, skillRequire.getSkill().getSkillID());

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
    
    public List<SkillRequire> getSkillRequire(int jobID) throws SQLException {
        List<SkillRequire> listSkillRequire = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETSKILLREQUIRE);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int skillRequireID = rs.getInt("skillRequireID");
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = Skill.builder().skillID(skillID).skillName(skillName).build();
                    listSkillRequire.add(SkillRequire.builder().skillRequireID(skillRequireID).jobID(jobID).skill(skill).build());
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
        return listSkillRequire;
    }
}
