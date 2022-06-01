/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import se1621.dto.Job;
import se1621.utils.DBUtils;
import se1621.dto.Category;
/**
 *
 * @author ACER
 */
public class JobDAO {
    
    
    private static final String CREATEJOB = "INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, skill, deadline,"
                                            +"completionTime, salary, address, email, phone, description) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
    
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;
    public boolean createJob(Job job) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATEJOB);
                preStm.setInt(1, job.getUserID());
                preStm.setString(2, job.getJobTitle());
                preStm.setString(3, job.getExperienceNeeded());
                preStm.setInt(4, job.getCategory().getCategoryID());
                preStm.setString(5, job.getSkill());
                preStm.setDate(6, job.getDeadline());
                preStm.setString(7, job.getCompletionTime());
                preStm.setString(8, job.getSalary());
                preStm.setString(9, job.getAddress());
                preStm.setString(10, job.getEmail());
                preStm.setString(11, job.getPhone());
                preStm.setString(12, job.getDescription());
                

                check = preStm.executeUpdate() > 0 ? true : false;
            }
        }catch (Exception e) {
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
