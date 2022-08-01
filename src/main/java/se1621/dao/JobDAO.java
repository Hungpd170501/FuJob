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
            + " minBudget, maxBudget, paymentMethodID, expiriedDate, address, email, phone, description, jobStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,1)";
    //xong ne
    private final String SEARCHALL_JOBTITLE_SKILL_CATEGORY = "SELECT j.jobID,ISNULL(jobAply.bids,0) AS bids, j.userID, j.jobTitle, j.lastModifiedDate, j.address, "
            + "            j.jobCategoryID, c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, "
            + "            pm.paymentMethodName, j.minBudget, j.maxBudget, j.expiriedDate "
            + "            FROM (((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) "
            + "             left join tblPaymentMethods pm on j.paymentMethodID = pm.paymentMethodID) "
            + "			 left join (select jobID, COUNT(jobID) AS bids  "
            + "              FROM tblJobApplications  "
            + "                WHERE jobApplicationStatus = 1  "
            + "                 GROUP BY jobID) AS jobAply  "
            + "            on jobAply.jobID = j.jobID )";
    private static final String GETJOBIDJUSTCREATE = "SELECT jobID FROM tblJobs WHERE jobID = (SELECT MAX(jobID) FROM tblJobs) and jobStatus = 1 and userID = ?";
    //roi ne
    private static final String SEARCHBYJOBID = "SELECT j.jobID, j.userID, j.jobTitle,j.jobCategoryID, c.categoryName, "
            + "j.minBudget, j.maxBudget, j.paymentMethodID, payment.paymentMethodName, j.address, j.email, j.phone, j.description, j.createdDate, "
            + "j.lastModifiedDate, j.expiriedDate, j.jobStatus  "
            + "FROM (tblJobs j left join tblPaymentMethods payment on j.paymentMethodID = payment.paymentMethodID ) "
            + "left join tblCategories c on c.categoryID = j.jobCategoryID WHERE jobID = ?";
    //roi ne
    private static final String VIEWALLJOB = "SELECT j.jobID,ISNULL(jobAply.bids,0) AS bids,j.jobStatus, j.jobTitle, j.lastModifiedDate, j.address, c.categoryName, c.img, j.description , j.createdDate, j.paymentMethodID, j.minBudget, j.maxBudget, j.expiriedDate, pay.paymentMethodName "
            + "                                    FROM (((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) "
            + "            						left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID ) "
            + "									left join (select jobID, COUNT(jobID) AS bids  "
            + "												FROM tblJobApplications  "
            + "													WHERE jobApplicationStatus = 1  "
            + "													GROUP BY jobID) AS jobAply  "
            + "													on jobAply.jobID = j.jobID ) "
            + "                                    WHERE j.jobStatus = 1 ORDER BY jobID DESC";

    //sua roi
    private static final String VIEWHRJOB = "SELECT j.jobID,ISNULL(jobApp.bids,0) AS bids, j.jobStatus, j.jobTitle, j.lastModifiedDate, j.address, c.categoryName, c.img, j.description , j.createdDate, j.paymentMethodID, j.minBudget, j.maxBudget, j.expiriedDate, p.paymentMethodName "
            + "                                  FROM (((tblJobs j left join tblCategories c "
            + "								  on j.jobCategoryID = c.categoryID) "
            + "								  left join tblPaymentMethods p "
            + "								  on p.paymentMethodID = j.paymentMethodID) "
            + "								  left join (select jobID, COUNT(jobID) AS bids "
            + "								FROM tblJobApplications "
            + "								WHERE jobApplicationStatus = 1 "
            + "								GROUP BY jobID) AS jobApp "
            + "								on j.jobID = jobApp.jobID) "
            + "                               WHERE (j.jobStatus = 1 )AND j.userID= ? ORDER BY createdDate DESC";
   

    private static final String DELETEJOBPOST = "UPDATE tblJobs SET jobStatus=0, reasonCancel = ? WHERE jobID=?";
    private static final String REJECTJOBPOST = "UPDATE tblJobs SET jobStatus=3 WHERE jobID=?";
    private static final String UPDATE_JOB_POST_HAVE_EMPLOYER = "UPDATE tblJobs SET jobStatus=3 WHERE jobID=? AND jobStatus=1 ";
    private static final String UPDATE_JOB_POST_UNCOMPLETE = "UPDATE tblJobs SET jobStatus=6 WHERE jobID=? AND jobStatus IN (3,8) ";
    private static final String UPDATE_JOB_POST_COMPLETE = "UPDATE tblJobs SET jobStatus=5 WHERE jobID=? AND jobStatus=8 ";

    private static final String GETALLNUMBEROFJOBPOST = "SELECT COUNT (jobID) AS totalJob FROM tblJobs";
    //roi ne
    private static final String GETVIEWRECENTJOB = "SELECT TOP(8) j.jobID, j.jobTitle, j.address, j.minBudget, j.maxBudget, c.categoryName, c.img, j.paymentMethodID, j.createdDate, j.lastModifiedDate, j.expiriedDate, pay.paymentMethodName"
            + "                                    FROM ((((tblJobs j left join tblCategories c on j.jobCategoryID = c.categoryID) left join tblUsers u on j.userID = u.userID)"
            + "                                    left join tblCompanies com on u.companyID = com.companyID)"
            + "									left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                                 WHERE j.jobStatus = 1 ORDER BY createdDate DESC";
    private final static String UPDATE_JOB_STATUS = "UPDATE tblJobs SET jobStatus = ? WHERE jobID = ?";
    private final static String GET_JOBID_BY_JOBAPPLYCATIONID = "SELECT jobID FROM tbljobApplications WHERE jobApplicationID = ?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    private static final String UPDATE_JOB = "UPDATE tblJobs SET userID=?, jobTitle=?, jobCategoryID=?, address=?, paymentMethodID=?, email=?, expiriedDate=?, phone=?, minBudget=?, maxBudget=? , description=? WHERE jobID=?";
    private final static String UPDATE_DISPUTE_STATUS = "UPDATE tblJobs SET disputeStatus = ? WHERE jobID = ?";
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
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
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
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
                if (rs.next()) {
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
                preStm.setFloat(4, job.getMinBudget());
                preStm.setFloat(5, job.getMaxBudget());
                preStm.setInt(6, job.getPayMentMethod().getPaymentMethodID());
                preStm.setDate(7, job.getExpiriedDate());
                preStm.setString(8, job.getAddress());
                preStm.setString(9, job.getEmail());
                preStm.setString(10, job.getPhone());
                preStm.setString(11, job.getDescription());
                check = preStm.executeUpdate() > 0;
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int status = rs.getInt("jobStatus");
                    int bids = rs.getInt("bids");
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
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .jobStatus(status)
                            .bids(bids)
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
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
                    String categoryName = rs.getString("categoryName");
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
                            .category(Category.builder().categoryID(jobCategoryID).categoryName(categoryName).build())
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
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
                String queryForSearchSkill = "SELECT j.jobID,ISNULL(jobAply.bids,0) AS bids, j.userID, j.jobTitle, j.lastModifiedDate, j.address, j.jobCategoryID, "
                        + "                         c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, pm.paymentMethodName, "
                        + "                         j.minBudget,j.maxBudget, j.expiriedDate "
                        + "                         FROM ((((tblJobSkills js left join tblJobs j on j.jobID = js.jobID)) "
                        + "                         left join tblCategories c on c.categoryID = j.jobCategoryID) left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID "
                        + "                         left join (select jobID, COUNT(jobID) AS bids  "
                        + "                        FROM tblJobApplications  "
                        + "                       	WHERE jobApplicationStatus = 1  "
                        + "                       		GROUP BY jobID) AS jobAply  "
                        + "                      	on jobAply.jobID = j.jobID )";
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
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
                    int bids = rs.getInt("bids");

                    Category category = Category.builder().categoryID(jobCategoryID).categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    listJob.add(Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(category)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payment)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .expiriedDate(expiriedDate)
                            .jobStatus(jobStatus)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .bids(bids)
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
                String queryForSearchSkill = "SELECT j.jobID,ISNULL(jobAply.bids,0) AS bids, j.userID, j.jobTitle, j.lastModifiedDate, j.address, j.jobCategoryID, "
                        + "c.categoryName, c.img, j.description , j.email, j.phone, j.createdDate, j.paymentMethodID, pm.paymentMethodName, "
                        + "j.minBudget, j.maxBudget, j.expiriedDate, j.jobStatus "
                        + "FROM ((((tblJobSkills js left join tblJobs j on j.jobID = js.jobID)) "
                        + "left join tblCategories c on c.categoryID = j.jobCategoryID) left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID "
                        + " left join (select jobID, COUNT(jobID) AS bids  "
                        + "           FROM tblJobApplications  "
                        + "              WHERE jobApplicationStatus = 1 "
                        + "                GROUP BY jobID) AS jobAply "
                        + "        on jobAply.jobID = j.jobID )";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and userID =" + hrID + " and jobStatus IN (1,3,4)";
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + "WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and userID =" + hrID + " and jobStatus IN (1,3,4)";
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and userID =" + hrID + " and jobStatus IN (1,3,4)";
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobCategoryID = ? and userID =" + hrID + " and jobStatus IN (1,3,4)";
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int bids = rs.getInt("bids");
                    int jobStatus = 1;

                    Category category = Category.builder().categoryID(jobCategoryID).categoryName(categoryName).img(img).build();
                    PayMentMethod payment = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    listJob.add(Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(category)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payment)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .expiriedDate(expiriedDate)
                            .jobStatus(jobStatus)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .bids(bids)
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int status = rs.getInt("jobStatus");
                    int bids = rs.getInt("bids");
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
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .jobStatus(status)
                            .bids(bids)
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
    public List<Job> getListHrPastJob(int userID) throws SQLException {
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    int status = rs.getInt("jobStatus");
                    int bids = rs.getInt("bids");
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
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .jobStatus(status)
                            .bids(bids)
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

    public boolean deleteJobPost(int jobPostID, String reasonCancel) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETEJOBPOST);
                preStm.setString(1, reasonCancel);
                preStm.setInt(2, jobPostID);
                check = preStm.executeUpdate() > 0;
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
   
    public boolean rejectJobPost(int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(REJECTJOBPOST);
                preStm.setInt(1, jobID);
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
                check = preStm.executeUpdate() > 0;
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
                check = preStm.executeUpdate() > 0;
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
                check = preStm.executeUpdate() > 0;
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

    public boolean updateJob(Job job) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_JOB);
                preStm.setInt(1, job.getUserID());
                preStm.setString(2, job.getJobTitle());
                preStm.setInt(3, job.getCategory().getCategoryID());
                preStm.setString(4, job.getAddress());
                preStm.setInt(5, job.getPayMentMethod().getPaymentMethodID());
                preStm.setString(6, job.getEmail());
                preStm.setDate(7, job.getExpiriedDate());
                preStm.setString(8, job.getPhone());
                preStm.setFloat(9, job.getMinBudget());
                preStm.setFloat(10, job.getMaxBudget());
                preStm.setString(11, job.getDescription());
                preStm.setInt(12, job.getJobID());
                check = preStm.executeUpdate() > 0;
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

    public int getJobIDByJobApplicationID(int jobApplicationID) throws SQLException {
        int jobID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBID_BY_JOBAPPLYCATIONID);
                preStm.setInt(1, jobApplicationID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    jobID = rs.getInt("jobID");
                }
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
        return jobID;
    }

    public boolean updateJobStatus(int jobID, int jobStatus) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_JOB_STATUS);
                preStm.setInt(1, jobStatus);
                preStm.setInt(2, jobID);
                check = preStm.executeUpdate() > 0;
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
    
    public boolean updateDisputeStatus(int disputeStatus, int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_DISPUTE_STATUS);
                preStm.setInt(1, disputeStatus);
                preStm.setInt(2, jobID);
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
