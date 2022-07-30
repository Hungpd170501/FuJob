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
    private static final String CREATEOBSKILLS = "INSERT INTO tblJobSkills (jobID, skillID) VALUES (?, ?)";
    private static final String GET_JOBSKILLS_FOR_ONE_JOB = "SELECT jk.jobSkillID, jk.jobID, jk.skillID, skill.skillName FROM (tblJobSkills jk left join tblSkills skill on jk.SkillID = skill.skillID)"
            + "WHERE jk.jobID = ?";
    private static final String GET_JOBSKILLS_FOR_ALLJOB = "SELECT jk.jobSkillID, jk.jobID, jk.skillID, skill.skillName "
            + "FROM (tblJobSkills jk left join tblSkills skill on jk.SkillID = skill.skillID) "
            + "WHERE jk.jobID IN  (SELECT jobID FROM tblJobs)";
    private static final String GET_JOBSKILLS_FOR_JOBAPPLY = "SELECT jk.jobSkillID, jk.jobID, jk.skillID, skill.skillName "
            + "    FROM (tblJobSkills jk left join tblSkills skill on jk.SkillID = skill.skillID)"
            + "    WHERE jk.jobID IN  (SELECT jobID FROM tblJobApplications WHERE jobApplicationStatus = 1)";
    private  static final String DELETESKILL = "DELETE FROM tblJobSkills WHERE jobID = ? ";
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
    public List<JobSkills> getSkillRequire(int jobID) throws SQLException {
        List<JobSkills> listJobSkills = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBSKILLS_FOR_ONE_JOB);
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

    public List<JobSkills> getJobSkillForAllJob() throws SQLException {
        List<JobSkills> listJobSkills = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBSKILLS_FOR_ALLJOB);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobSkillID = rs.getInt("jobSkillID");
                    int jobID = rs.getInt("jobID");
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

    public List<JobSkills> getJobSkillForJobApply() throws SQLException {
        List<JobSkills> listJobSkills = new ArrayList<>();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBSKILLS_FOR_JOBAPPLY);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobSkillID = rs.getInt("jobSkillID");
                    int jobID = rs.getInt("jobID");
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

    public boolean deleteJobSkills(int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETESKILL);
                preStm.setInt(1, jobID);
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
}
