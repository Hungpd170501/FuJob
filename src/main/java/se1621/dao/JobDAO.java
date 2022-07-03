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
import se1621.dto.PayMentMethod;

/**
 *
 * @author ACER
 */
public class JobDAO {

    private static final String CREATEJOB = "INSERT INTO tblJobs(userID, jobTitle, jobCategoryID,"
            + " budget, paymentMethodID, expiriedDate, address, email, phone, description, jobStatus) VALUES(?,?,?,?,?,?,?,?,?,?,1)";
    //xong ne
    private String SEARCHALL_JOBTITLE_SKILL_CATEGORY = "SELECT j.jobID, j.userID, j.jobTitle, j.lastModifiedDate, j.address, "
            + "j.jobCategoryID, c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, "
            + "pm.paymentMethodName, j.budget, j.expiriedDate "
            + "FROM ((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID)"
            + " left join tblPaymentMethods pm on j.paymentMethodID = pm.paymentMethodID) ";
    private static final String GETJOBIDJUSTCREATE = "SELECT jobID FROM tblJobs WHERE jobID = (SELECT MAX(jobID) FROM tblJobs) and jobStatus = 1 and userID = ?";
    //roi ne
    private static final String SEARCHBYJOBID = "SELECT j.jobID, j.userID, j.jobTitle,j.jobCategoryID, j.budget, j.paymentMethodID, payment.paymentMethodName, j.address, j.email, j.phone, j.description, j.createdDate, j.lastModifiedDate, j.expiriedDate, j.jobStatus FROM tblJobs j "
            + "            left join tblPaymentMethods payment on j.paymentMethodID = payment.paymentMethodID "
            + "           WHERE jobID = ?";
    //roi ne
    private static final String VIEWALLJOB = "SELECT j.jobID,j.jobStatus, j.jobTitle, j.lastModifiedDate, j.address, c.categoryName, c.img, j.description , j.createdDate, j.paymentMethodID, j.budget, j.expiriedDate, pay.paymentMethodName"
            + "                        FROM ((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID)"
            + "						left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID )"
            + "                        WHERE j.jobStatus = 1 ORDER BY jobID DESC";

    //sua roi
    private static final String VIEWHRJOB = "SELECT j.jobID,j.jobStatus, j.jobTitle, j.lastModifiedDate, j.address, c.categoryName, c.img, j.description , j.createdDate, j.paymentMethodID, j.budget, j.expiriedDate, p.paymentMethodName"
            + "                      FROM ((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) left join tblPaymentMethods p on p.paymentMethodID = j.paymentMethodID) "
            + "                    WHERE (j.jobStatus = 1 OR  j.jobStatus = 3 OR  j.jobStatus = 4)AND j.userID=? ORDER BY createdDate DESC";

    private static final String DELETEJOBPOST = "UPDATE tblJobs SET jobStatus=0 WHERE jobID=?";
    private static final String UPDATE_JOB_POST_HAVE_EMPLOYER = "UPDATE tblJobs SET jobStatus=3 WHERE jobID=? AND jobStatus=1 ";
    private static final String UPDATE_JOB_POST_UNCOMPLETE = "UPDATE tblJobs SET jobStatus=6 WHERE jobID=? AND jobStatus=3 ";
    private static final String UPDATE_JOB_POST_COMPLETE= "UPDATE tblJobs SET jobStatus=5 WHERE jobID=? AND jobStatus=3 ";
    
    private static final String GETALLNUMBEROFJOBPOST = "SELECT COUNT (*) AS totalJob FROM tblJobs";
    //roi ne
    private static final String GETVIEWRECENTJOB = "SELECT TOP(8) j.jobID, j.jobTitle, j.address, j.budget, c.categoryName, c.img, j.paymentMethodID, j.createdDate, j.lastModifiedDate, j.expiriedDate, pay.paymentMethodName"
            + "                                    FROM ((((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) left join tblUsers u on j.userID = u.userID)"
            + "                                    left join tblCompanies com on u.companyID = com.companyID)"
            + "									left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                                 WHERE j.jobStatus = 1 ORDER BY createdDate DESC";
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
                    float budget = rs.getFloat("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String img = rs.getString("img");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .budget(budget)
                            .payMentMethod(payMent)
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
                preStm.setFloat(4, job.getBudget());
                preStm.setInt(5, job.getPayMentMethod().getPaymentMethodID());
                preStm.setDate(6, job.getExpiriedDate());
                preStm.setString(7, job.getAddress());
                preStm.setString(8, job.getEmail());
                preStm.setString(9, job.getPhone());
                preStm.setString(10, job.getDescription());
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
                    String paymentMethodName = rs.getString("paymentMethodName");
                    float budget = rs.getFloat("budget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int status = rs.getInt("jobStatus");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .category(category)
                            .description(description)
                            .lastModifiedDate(lastModifiedDate)
                            .createdDate(createdDate)
                            .expiriedDate(expiriedDate)
                            .payMentMethod(payment)
                            .budget(budget)
                            .jobStatus(status)
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
                    float budget = rs.getFloat("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
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
                            .payMentMethod(PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build())
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
                String queryForSearchSkill = "SELECT j.jobID, j.userID, j.jobTitle, j.lastModifiedDate, j.address, j.jobCategoryID, "
                        + "c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, pm.paymentMethodName, "
                        + "j.budget, j.expiriedDate "
                        + "FROM (((tblJobSkills js left join tblJobs j on j.jobID = js.jobID)) "
                        + "left join tblCategories c on c.categoryID = j.jobCategoryID) left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID ";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobStatus = 1";
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and jobStatus = 1";
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and jobStatus = 1";
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + " WHERE jobTitle like ? and jobCategoryID = ? and jobStatus = 1";
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
                    float budget = rs.getFloat("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int jobStatus = 1;

                    Category category = Category.builder().categoryID(jobCategoryID).categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    listJob.add(Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(category)
                            .budget(budget)
                            .payMentMethod(payment)
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
    public List<Job> getJobPosted(String searchJobTitle, int searchSkillID, int searchJobCategoryID, int hrID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<Job> listJob = new ArrayList<>();
                String getDataSQL = "";
                String getDataSQL1 = this.SEARCHALL_JOBTITLE_SKILL_CATEGORY;
                String queryForSearchSkill = "SELECT j.jobID, j.userID, j.jobTitle, j.lastModifiedDate, j.address, j.jobCategoryID, "
                        + "c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, pm.paymentMethodName, "
                        + "j.budget, j.expiriedDate "
                        + "FROM (((tblJobSkills js left join tblJobs j on j.jobID = js.jobID)) "
                        + "left join tblCategories c on c.categoryID = j.jobCategoryID) left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID ";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobStatus = 1 and userID =" + hrID;
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + "WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and jobStatus = 1 and userID =" + hrID;
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and jobStatus = 1 and userID =" + hrID;
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobCategoryID = ? and jobStatus = 1 and userID =" + hrID;
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
                    float budget = rs.getFloat("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int jobStatus = 1;

                    Category category = Category.builder().categoryID(jobCategoryID).categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    listJob.add(Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(category)
                            .budget(budget)
                            .payMentMethod(payment)
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
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    String address = rs.getString("address");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    float budget = rs.getFloat("budget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int status = rs.getInt("jobStatus");
                    Category category = Category.builder().categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .userID(userID)
                            .jobID(jobID)
                            .jobTitle(jobTitle)
                            .address(address)
                            .category(category)
                            .description(description)
                            .lastModifiedDate(lastModifiedDate)
                            .createdDate(createdDate)
                            .expiriedDate(expiriedDate)
                            .payMentMethod(payment)
                            .budget(budget)
                            .jobStatus(status)
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

    public boolean updateJobPostHaveEmployer(int jobPostID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_JOB_POST_HAVE_EMPLOYER);
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
    
    public boolean updateJobPostUncomplete(int jobPostID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_JOB_POST_UNCOMPLETE);
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
    
    public boolean updateJobPostComplete(int jobPostID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_JOB_POST_COMPLETE);
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
