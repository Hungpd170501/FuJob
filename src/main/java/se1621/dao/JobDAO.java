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
import se1621.dto.Job;
import se1621.utils.DBUtils;
import se1621.dto.Category;

/**
 *
 * @author ACER
 */
public class JobDAO {

    private static final String CREATEJOB = "INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, skill, deadline,"
            + "completionTime, salary, address, email, phone, description) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

    private static final String VIEWALLJOB = "SELECT jobID, userID, jobTitle, ExperienceNeeded, jobCategoryID, skill, "
            + "deadline, completionTime, salary, address, email, phone, description FROM tblJob";

    private String SEARCHALL_JOBTITLE_EXPERIENCE_CATEGORY = "SELECT jobID, userID, jobTitle, ExperienceNeeded, jobCategoryID, skill, "
            + "deadline, completionTime, salary, address, email, phone, description FROM tblJob ";

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

    // View all job in job-list.jsp
    public List<Job> getListJob() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(VIEWALLJOB);
                rs = preStm.executeQuery();
                List<Job> listJob = new ArrayList<>();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    String skill = rs.getString("skill");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
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

    public List<Job> searchAllJobTile_Experience_Category(String searchJobTitle, String searchExperienceNeeded, int searchJobCategoryID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<Job> listJob = new ArrayList<>();
                String getDataSQL = this.SEARCHALL_JOBTITLE_EXPERIENCE_CATEGORY;
                
//                if (searchJobTitle != null && !searchJobTitle.isEmpty()) {
//                    // nhap jobTile
//                    getDataSQL = getDataSQL + " WHERE jobTitle like ?";
//                } else if (searchExperienceNeeded != null && !searchExperienceNeeded.isEmpty()) {
//                    // nhap Experience
//                    getDataSQL = getDataSQL + " WHERE ExperienceNeeded like ?";
//                } else if (searchJobCategoryID != 0) {
//                    // nhap searchJobCategoryID
//                    getDataSQL = getDataSQL + " WHERE jobCategoryID = ?";
//                } else if (searchJobTitle != null && !searchJobTitle.isEmpty() && searchExperienceNeeded != null && !searchExperienceNeeded.isEmpty()) {
//                    // nhap searchJobTitle + Experience
//                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ?";
//                } else if (searchJobTitle != null && !searchJobTitle.isEmpty() && searchJobCategoryID != 0) {
//                    // nhap searchJobTitle + searchJobCategoryID
//                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and jobCategoryID = ?";
//                } else if (searchExperienceNeeded != null && !searchExperienceNeeded.isEmpty() && searchJobCategoryID != 0) {
//                    // nhap Experience + searchJobCategoryID
//                    getDataSQL = getDataSQL + " WHERE ExperienceNeeded like ? and jobCategoryID = ?";
//                } else if (searchJobTitle != null && !searchJobTitle.isEmpty() && searchExperienceNeeded != null && !searchExperienceNeeded.isEmpty() && searchJobCategoryID != 0) {
//                    // nhap searchJobTitle + Experience + searchJobCategoryID
//                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobCategoryID = ?";
//                } else {
//                    getDataSQL = getDataSQL + "";
//                }
                boolean checkCateID = true;
                if(searchJobCategoryID==0){
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? ";               
                }else{
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobCategoryID = ?";
                    checkCateID = false;
                }
                preStm = conn.prepareStatement(getDataSQL);
                preStm.setString(1, "%" + searchJobTitle + "%");
                preStm.setString(2, "%" + searchExperienceNeeded + "%");                
                if(!checkCateID){
                   preStm.setInt(3, searchJobCategoryID); 
                }
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String skill = rs.getString("skill");
                    String jobTitle = rs.getString("jobTitle");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    listJob.add(Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(searchExperienceNeeded)
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

    // Tao page for job in view-all-job controller
    public List<Job> getPaginateJobList(List<Job> listPage, int startPage, int endPage) throws SQLException {
        ArrayList<Job> jobPage = new ArrayList<>();
        for (int i = startPage; i < endPage; i++) {
            jobPage.add(listPage.get(i));
        }
        return jobPage;
    }

    public static void main(String[] args) throws SQLException {
//        JobDAO dao = new JobDAO();
//        List<Job> list = dao.searchAllJobTile_Experience_Category("d", "5", 0);
//        System.out.println();
//        JobDAO dao = new JobDAO();
//        List<Job> list = dao.getListJob();
//        System.out.println(list.get(1).getCategory());
    }
}
