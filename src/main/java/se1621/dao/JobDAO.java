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
<<<<<<< HEAD
import se1621.dto.Category;
import se1621.dto.Job;
import se1621.utils.DBUtils;

=======
import se1621.dto.Job;
import se1621.utils.DBUtils;
import se1621.dto.Category;
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
/**
 *
 * @author ACER
 */
public class JobDAO {
<<<<<<< HEAD
    public List<Job> getListJob() throws SQLException {
        Connection conn = null;
        PreparedStatement preStm = null;
        ResultSet rs = null;
        try {
            String query = "SELECT* FROM tblJob";
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(query);
=======
    
    
    private static final String CREATEJOB = "INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, skill, deadline,"
                                            +"completionTime, salary, address, email, phone, description) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
    private static final String VIEWALLJOB = "SELECT* FROM tblJob";
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
    
    public List<Job> getListJob() throws SQLException {
        try { 
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(VIEWALLJOB);
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
                rs = preStm.executeQuery();
                List<Job> listJob = new ArrayList<>();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    int jobCategoryID = rs.getInt("jobCategoryID");
<<<<<<< HEAD
//                    String categoryName = rs.getString("categoryName");
//                    Category category = new Category(categoryID, categoryName);
=======
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
                    String skill = rs.getString("skill");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
<<<<<<< HEAD
                    Job job = new Job(jobID, userID, jobTitle, ExperienceNeeded, new Category(jobCategoryID, ""), skill, deadline, completionTime, salary, address, email, phone, description);
                    listJob.add(job);
=======
                    listJob.add(Job.builder().jobID(jobID)
                                              .userID(userID)
                                              .jobTitle(jobTitle)
                                              .ExperienceNeeded(ExperienceNeeded)
                                              .category(Category.builder().categoryID(jobCategoryID).build())
                                              .skill(skill)
                                              .deadline(deadline)
                                              .completionTime(completionTime)
                                              .salary(salary)
                                              .address(address)
                                              .email(email)
                                              .phone(phone)
                                              .description(description)
                                                .build());
>>>>>>> 128d229c6b685ed8cb04b26deeaa84d14ca38160
                }
                return listJob;
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

        return null;
    }
}
