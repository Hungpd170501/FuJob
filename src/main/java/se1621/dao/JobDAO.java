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
import se1621.utils.DBUtils;
import se1621.dto.Category;
import se1621.dto.Job;
/**
 *
 * @author ACER
 */
public class JobDAO {

    private static final String CREATEJOB = "INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, deadline,"
            + "completionTime, salary, address, email, phone, description, jobStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,1)";
    private String SEARCHALL_JOBTITLE_EXPERIENCE_CATEGORY = "SELECT jobID, userID, jobTitle, ExperienceNeeded, jobCategoryID, "
            + "deadline, completionTime, salary, address, email, phone, description, lastDateUpdate FROM tblJob ";
    private static final String GETJOBIDJUSTCREATE = "SELECT jobID FROM tblJob WHERE jobID = (SELECT MAX(jobID) FROM tblJob) and jobStatus = 1";
    private static final String SEARCHBYJOBID = "SELECT * FROM tblJOB where jobID = ? and jobStatus = 1";
    
    private static final String VIEWALLJOB = "SELECT j.jobID, j.jobTitle, j.lastDateUpdate, j.address, c.categoryName, c.img, j.ExperienceNeeded " +
"FROM (((tblJob j left join tblCategory c on j.jobCategoryID = c.categoryID) left join tblUser u on j.userID = u.userID) " +
"left join tblCompany com on u.companyID = com.companyID) " +
"WHERE j.jobStatus = 1";
    
    private static final String VIEWHRJOB = "SELECT j.jobID, j.jobTitle, j.lastDateUpdate, j.address, c.categoryName, c.img, j.ExperienceNeeded " +
"FROM (((tblJob j left join tblCategory c on j.jobCategoryID = c.categoryID) left join tblUser u on j.userID = u.userID) " +
"left join tblCompany com on u.companyID = com.companyID) " +
"WHERE j.jobStatus = 1 and j.userID = ?";
    
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
                preStm.setDate(5, job.getDeadline());
                preStm.setString(6, job.getCompletionTime());
                preStm.setString(7, job.getSalary());
                preStm.setString(8, job.getAddress());
                preStm.setString(9, job.getEmail());
                preStm.setString(10, job.getPhone());
                preStm.setString(11, job.getDescription());

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
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    String categoryName = rs.getString("categoryName");
                    String address = rs.getString("address");
                    String img = rs.getString("img");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .lastDateUpdate(lastDateUpdate)
                            .ExperienceNeeded(ExperienceNeeded)
                            .category(category)
                            .build();
                    listJob.add(job);
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

    public Job getJob(int jobIDSearch) throws SQLException {
        Job job = new Job();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SEARCHBYJOBID);
                preStm.setInt(1, jobIDSearch);
                rs = preStm.executeQuery();
                if (rs.next()) {

                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(ExperienceNeeded)
                            .category(Category.builder().categoryID(jobCategoryID).build())
                            .deadline(deadline)
                            .completionTime(completionTime)
                            .salary(salary)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .lastDateUpdate(lastDateUpdate)
                            .build();
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
        return job;
    }

    public int getJobIDJustCreate() throws SQLException {
        int jobID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETJOBIDJUSTCREATE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    jobID = rs.getInt("jobID");
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
        return jobID;
    }

    public List<Job> searchAllJobTile_Experience_Category(String searchJobTitle, String searchExperienceNeeded, int searchJobCategoryID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<Job> listJob = new ArrayList<>();
                String getDataSQL = this.SEARCHALL_JOBTITLE_EXPERIENCE_CATEGORY;
                boolean checkCateID = true;
                if (searchJobCategoryID == 0) {
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobStatus = 1";
                } else {
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobCategoryID = ? and jobStatus = 1";
                    checkCateID = false;
                }
                preStm = conn.prepareStatement(getDataSQL);
                preStm.setString(1, "%" + searchJobTitle + "%");
                preStm.setString(2, "%" + searchExperienceNeeded + "%");
                if (!checkCateID) {
                    preStm.setInt(3, searchJobCategoryID);
                }
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    String experienceNeeded = rs.getString("experienceNeeded");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    listJob.add(Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(experienceNeeded)
                            .category(Category.builder().categoryID(jobCategoryID).build())
                            .deadline(deadline)
                            .completionTime(completionTime)
                            .salary(salary)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .lastDateUpdate(lastDateUpdate)
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
    // search for all page
    public List<Job> getJobPosted(String searchJobTitle, String searchExperienceNeeded, int searchJobCategoryID, int hrID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<Job> listJob = new ArrayList<>();
                String getDataSQL = this.SEARCHALL_JOBTITLE_EXPERIENCE_CATEGORY;
                boolean checkCateID = true;
                if (searchJobCategoryID == 0) {
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobStatus = 1 and userID = " + hrID;
                } else {
                    getDataSQL = getDataSQL + " WHERE jobTitle like ? and ExperienceNeeded like ? and jobCategoryID = ? and jobStatus = 1 and userID = " + hrID;
                    checkCateID = false;
                }
                preStm = conn.prepareStatement(getDataSQL);
                preStm.setString(1, "%" + searchJobTitle + "%");
                preStm.setString(2, "%" + searchExperienceNeeded + "%");
                if (!checkCateID) {
                    preStm.setInt(3, searchJobCategoryID);
                }
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    String experienceNeeded = rs.getString("experienceNeeded");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    listJob.add(Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(experienceNeeded)
                            .category(Category.builder().categoryID(jobCategoryID).build())
                            .deadline(deadline)
                            .completionTime(completionTime)
                            .salary(salary)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .lastDateUpdate(lastDateUpdate)
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
    public List<Job> getListHrJob(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(VIEWHRJOB);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<Job> listHrJob = new ArrayList<>();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    String categoryName = rs.getString("categoryName");
                    String address = rs.getString("address");
                    String img = rs.getString("img");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .lastDateUpdate(lastDateUpdate)
                            .ExperienceNeeded(ExperienceNeeded)
                            .category(category)
                            .build();
                    listHrJob.add(job);
                }
                return listHrJob;
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
