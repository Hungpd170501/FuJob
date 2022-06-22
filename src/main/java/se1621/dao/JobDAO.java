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

    private static final String CREATEJOB = "INSERT INTO tblJobs(userID, jobTitle, jobCategoryID,"
            + " budget, address, email, phone, description, jobStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,1)";
    private String SEARCHALL_JOBTITLE_SKILL_CATEGORY = "SELECT j.jobID, j.userID, j.jobTitle, j.lastModifiedDate, j.address, "
            + "j.jobCategoryID, c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, j.budget, j.expiriedDate "
            + "FROM (tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID)";
    private static final String GETJOBIDJUSTCREATE = "SELECT jobID FROM tblJobs WHERE jobID = (SELECT MAX(jobID) FROM tblJobs) and jobStatus = 1 and userID = ?";
    private static final String SEARCHBYJOBID = "SELECT * FROM tblJobs WHERE jobID = ? and jobStatus = 1";

    private static final String VIEWALLJOB = "SELECT j.jobID, j.jobTitle, j.lastModifiedDate, j.address, c.categoryName, c.img, j.description , j.createdDate, j.paymentMethodID, j.budget, j.expiriedDate"
            + "            FROM (tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID)"
            + "            WHERE j.jobStatus = 1 ORDER BY createdDate DESC";

    private static final String VIEWHRJOB = "SELECT j.jobID, j.jobTitle, j.lastDateUpdate, j.address, c.categoryName, c.img, j.ExperienceNeeded "
            + "FROM (((tblJob j left join tblCategory c on j.jobCategoryID = c.categoryID) left join tblUser u on j.userID = u.userID) "
            + "left join tblCompany com on u.companyID = com.companyID) "
            + "WHERE j.jobStatus = 1 and j.userID = ?";
    private static final String DELETEJOBPOST = "UPDATE tblJobs SET jobStatus=0 WHERE jobID=?";
    private static final String GETALLNUMBEROFJOBPOST = "SELECT COUNT (*) AS totalJob FROM tblJobs";
    private static final String GETVIEWRECENTJOB = "SELECT TOP(8) j.jobID, j.jobTitle, j.address, j.budget, c.categoryName, c.img, j.paymentMethodID, j.createdDate, j.lastModifiedDate, j.expiriedDate"
            + "                        FROM (((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) left join tblUsers u on j.userID = u.userID)"
            + "                        left join tblCompanies com on u.companyID = com.companyID)"
            + "                       WHERE j.jobStatus = 1 ORDER BY createdDate DESC";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    // top recent job in index.jsp
    public List<Job> getRecentJobPosted() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETVIEWRECENTJOB);
                rs = preStm.executeQuery();
                List<Job> listJob = new ArrayList<>();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    String jobTitle = rs.getString("jobTitle");
                    String address = rs.getString("address");
                    String categoryName = rs.getString("categoryName");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String img = rs.getString("img");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .budget(budget)
                            .paymentMethodID(paymentMethodID)
                            .category(category)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .expiriedDate(expiriedDate)
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

    // tong so job da post
    public int getAllTotalJobPost() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLNUMBEROFJOBPOST);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    return rs.getInt("totalJob");
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

        return 0;
    }

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
                preStm.setInt(3, job.getCategory().getCategoryID());
                preStm.setInt(4, job.getBudget());
                preStm.setString(6, job.getAddress());
                preStm.setString(7, job.getEmail());
                preStm.setString(8, job.getPhone());
                preStm.setString(9, job.getDescription());

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
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    String address = rs.getString("address");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    int budget = rs.getInt("budget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .category(category)
                            .description(description)
                            .lastModifiedDate(lastModifiedDate)
                            .createdDate(createdDate)
                            .expiriedDate(expiriedDate)
                            .paymentMethodID(paymentMethodID)
                            .budget(budget)
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
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int jobStatus = rs.getInt("jobStatus");
                    job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(jobCategoryID).build())
                            .budget(budget)
                            .paymentMethodID(paymentMethodID)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .expiriedDate(expiriedDate)
                            .jobStatus(jobStatus)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
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

    public int getJobIDJustCreate(int userID) throws SQLException {
        int jobID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETJOBIDJUSTCREATE);
                preStm.setInt(1, userID);
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

    public List<Job> searchAllJobTile_Skill_Category(String searchJobTitle, int searchSkillID, int searchJobCategoryID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<Job> listJob = new ArrayList<>();
                String getDataSQL = "";
                String getDataSQL1 = this.SEARCHALL_JOBTITLE_SKILL_CATEGORY;
                String queryForSearchSkill = "SELECT j.jobID, j.userID, j.jobTitle, j.lastModifiedDate, j.address, "
                            + " j.jobCategoryID, c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, "
                            + "j.paymentMethodID, j.budget, j.expiriedDate "
                            + "FROM ((tblJobSkills js left join tblJobs j on j.jobID = js.jobID)) "
                            + "left join tblCategories c on c.categoryID = j.jobCategoryID ";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobStatus = 1";
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + "WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and jobStatus = 1";
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and jobStatus = 1";
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobCategoryID = ? and jobStatus = 1";
                        checkSkillID = true;
                    }
                }

                preStm = conn.prepareStatement(getDataSQL);
                if (checkCateID == true && checkSkillID == true) {
                    preStm.setString(1, "%" + searchJobTitle + "%");
                } else {
                    preStm.setString(1, "%" + searchJobTitle + "%");
                    if (checkCateID == false && checkSkillID == false) {
                        preStm.setInt(2, searchSkillID);
                        preStm.setInt(3, searchJobCategoryID);
                    } else {
                        if (checkSkillID == false) {
                            preStm.setInt(2, searchSkillID);
                        }
                        if (checkCateID == false) {
                            preStm.setInt(2, searchJobCategoryID);
                        }
                    }

                }
                rs = preStm.executeQuery();
                while (rs.next()) {
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    int jobCategoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int jobStatus = 1;

                    Category category = Category.builder().categoryID(jobCategoryID).categoryName(categoryName).img(img).build();
                    listJob.add(Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(category)
                            .budget(budget)
                            .paymentMethodID(paymentMethodID)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .expiriedDate(expiriedDate)
                            .jobStatus(jobStatus)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .build()
                    );
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
                String getDataSQL = this.SEARCHALL_JOBTITLE_SKILL_CATEGORY;
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
                            .category(Category.builder().categoryID(jobCategoryID).build())
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

    public boolean deleteJobPost(int jobPostID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETEJOBPOST);
                preStm.setInt(1, jobPostID);
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

}
