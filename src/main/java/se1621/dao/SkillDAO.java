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
import se1621.utils.DBUtils;

/**
 *
 * @author lehad
 */
public class SkillDAO {

    private static final String GETLISTSKILL = "SELECT skillID, skillName FROM tblSkills ORDER BY skillName";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<Skill> getListSkill() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETLISTSKILL);
                rs = preStm.executeQuery();
                List<Skill> listSkill = new ArrayList<>();
                while (rs.next()) {
                    int skillID = rs.getInt("skillID");
                    String skillName = rs.getString("skillName");
                    Skill skill = new Skill(skillID, skillName);
                    listSkill.add(skill);
                }
                return listSkill;

            }

        } catch (Exception e) {
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
}