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
import se1621.dto.Category;
import se1621.dto.CompanyInfo;
import se1621.dto.Job;
import se1621.dto.JobApplication;
import se1621.dto.PayMentMethod;
import se1621.dto.Resume;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class JobApplicationDAO {

    private static final String ORDERJOB = "INSERT INTO tblJobApplications(resumeID, jobID, cvFile, priceDeal, message, jobApplicationStatus) VALUES(?,?,?,?,?,1)";
    private static final String CHECKDUPLICATE = "SELECT jobApplicationID FROM tbljobApplications WHERE resumeID=? and jobID=? and jobApplicationStatus = 1";

    private static final String CHECKDUPLICATE_NONSTATUS = "SELECT jobApplicationID FROM tblJobApplications WHERE resumeID = ? and jobID = ? and jobApplicationStatus = 0";
    private static final String DELETE = "UPDATE tblJobApplications SET jobApplicationStatus = 0 WHERE jobApplicationID = ? ";
    private static final String DENY_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 5 WHERE resumeID = ? AND jobID = ? AND jobApplicationStatus = 1 ";
    private static final String ACCEPT_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 3 WHERE resumeID = ? AND jobID = ? AND jobApplicationStatus = 1 ";
    private static final String UNCOMPLETE_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 7 WHERE jobApplicationID = ? AND jobApplicationStatus = 3";
    private static final String COMPLETE_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 6 WHERE jobApplicationID = ? AND jobApplicationStatus = 3";
    private static final String GETTALLUSERIDOFJOB = "SELECT resumeID FROM tblJobApplications WHERE jobID = ? and jobApplicationStatus = 1";
    private static final String GETALLJOBAPPLICATIONOFJOB = "SELECT jo.jobApplicationID, jo.priceDeal, jo.message, jo.cvFile, re.address, re.avatar"
            + ", re.createdDate, re.dateOfBirth, re.fullName, re.gender, re.gitHub, re.gmail, re.gpa, "
            + "re.lastModifiedDate, re.linkedIn, re.major, re.overview, re.phone , re.website, re.resumeID, re.userID "
            + "FROM tblJobApplications jo left join tblResumes re "
            + " ON jo.resumeID = re.resumeID "
            + "WHERE jo.jobID = ? AND re.resumeStatus = 1 AND jo.jobApplicationStatus = 1 ";
    private static final String GETTALLJOBORDERIDOFJOB = "SELECT jobApplicationID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETALLJOBAPPLIED = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.budget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "                        jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                        j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget,j.userID, j.address, j.email, j.phone, j.description "
            + "                        FROM ((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                        left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                        WHERE jo.resumeID= ? and (jo.jobApplicationStatus = 1 OR "
            + "                        jo.jobApplicationStatus =  3 OR jo.jobApplicationStatus =  5 ) ORDER BY jo.lastModifiedDate DESC";
    private static final String GETALLJOBACCEPTED = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.budget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "                        jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                        j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget, j.address, j.email, j.phone, j.description "
            + "                        FROM ((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                        left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                        WHERE jo.resumeID=? and (jo.jobApplicationStatus = 3 OR "
            + "                        jo.jobApplicationStatus =  6 OR jo.jobApplicationStatus =  7 ) ORDER BY jo.lastModifiedDate DESC";

    private static final String GETALLJOBCOMPLEANDUNCOMPLETE = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.budget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "                        jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                        j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget, j.address, j.email, j.phone, j.description "
            + "                        FROM ((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                        left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                        WHERE jo.resumeID=? and ( "
            + "                        jo.jobApplicationStatus =  6 OR jo.jobApplicationStatus =  7 ) ORDER BY jo.lastModifiedDate DESC";

    private static final String GETALLJOBONGOINGPOSTED = " SELECT jo.jobApplicationID,jo.resumeID,jo.jobApplicationStatus, j.jobID,j.userID,j.jobStatus, j.jobTitle, j.jobCategoryID, j.budget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "                                               jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                              j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget, j.address, j.email, j.phone, j.description "
            + "                                            FROM ((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                                left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                                               WHERE j.userID=? and (j.jobStatus = 3 OR j.jobStatus = 5 OR j.jobStatus=6)"
            + "                                             ORDER BY jo.lastModifiedDate DESC ";
    private static final String UPDATE_STATUS = "UPDATE tblJobApplications SET cvFile = ?, priceDeal = ?, message = ?, jobApplicationStatus = 1 WHERE jobApplicationID = ? and resumeID = ? and jobID = ?";
    private String SEARCHJOBORDER = "SELECT ja.jobApplicationID, ja.resumeID, ja.jobID, ja.cvFile, ja.createdDate, ja.message, ja.priceDeal, "
            + "j.jobTitle, j.userID, j.jobCategoryID, c.categoryName, c.img, j.expiriedDate, j.budget, j.paymentMethodID, pm.paymentMethodName, "
            + "j.address, j.email, j.phone, j.description, j.lastModifiedDate "
            + "FROM (((tblJobApplications ja LEFT JOIN tblJobs j ON ja.jobID = j.jobID) "
            + "LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID) "
            + "left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID) ";

    private static final String GETALLNUMBEROFJOBORDER = "SELECT COUNT (*) AS totalJobOrder FROM tblJobApplications";
    private static final String UPDATE_FORM_APPLICATON_OF_RESUME = "UPDATE tblJobApplications SET priceDeal = ?, message = ?, cvFile = ? WHERE resumeID = ? and jobID = ?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public boolean updateFormApplicationOfResume(JobApplication form, int resumeID, int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_FORM_APPLICATON_OF_RESUME);
                preStm.setString(1, form.getPriceDeal());
                preStm.setString(2, form.getMessage());
                preStm.setString(3, form.getCvFile());
                preStm.setInt(4, resumeID);
                preStm.setInt(5, jobID);
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
    
    // tong so job da order
    public int getAllTotalJobOrder() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLNUMBEROFJOBORDER);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    return rs.getInt("totalJobOrder");
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

    public boolean orderJob(JobApplication jobOrder) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(ORDERJOB);
                preStm.setInt(1, jobOrder.getResumeID());
                preStm.setInt(2, jobOrder.getJob().getJobID());
                preStm.setString(3, jobOrder.getCvFile());
                preStm.setString(4, jobOrder.getPriceDeal());
                preStm.setString(5, jobOrder.getMessage());
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

    public boolean reApply(JobApplication jobOrder, int jobOrderID) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_STATUS);
                preStm.setString(1, jobOrder.getCvFile());
                preStm.setString(2, jobOrder.getPriceDeal());
                preStm.setString(3, jobOrder.getMessage());
                preStm.setInt(4, jobOrderID);
                preStm.setInt(5, jobOrder.getResumeID());
                preStm.setInt(6, jobOrder.getJob().getJobID());
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

    public boolean checkDuplicateJobOrderByOneUser(int resumeID, int jobID) throws Exception {
        boolean check = false;
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKDUPLICATE);
                preStm.setInt(1, resumeID);
                preStm.setInt(2, jobID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
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

    public int getJobOrderID(int resumeID, int jobID) throws Exception {
        conn = null;
        preStm = null;
        rs = null;
        int jobOrderID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKDUPLICATE_NONSTATUS);
                preStm.setInt(1, resumeID);
                preStm.setInt(2, jobID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    jobOrderID = rs.getInt("jobOrderID");
                }
                return jobOrderID;
            }
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
        return jobOrderID;
    }

    public List<JobApplication> getListJobApplied(int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBAPPLIED);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String priceDeal = rs.getString("priceDeal");
                    String message = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    int jobAppStatus = rs.getInt("jobApplicationStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .budget(budget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(resumeID)
                            .job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .cvFile(cvFile)
                            .message(message)
                            .lastModifiedDate(createdDate)
                            .jobApplicationStatus(jobAppStatus)
                            .build();
                    list.add(listJobOrder);
                }
                return list;
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

    public List<JobApplication> getListJobCompleteAndUncomplete(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBCOMPLEANDUNCOMPLETE);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    int jobAppStatus = rs.getInt("jobApplicationStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .budget(budget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(userID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .lastModifiedDate(createdDate)
                            .jobApplicationStatus(jobAppStatus)
                            .build();
                    list.add(listJobOrder);
                }
                return list;
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

    public List<JobApplication> getListJobAccepcted(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBACCEPTED);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    int jobAppStatus = rs.getInt("jobApplicationStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .budget(budget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(userID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .lastModifiedDate(createdDate)
                            .jobApplicationStatus(jobAppStatus)
                            .build();
                    list.add(listJobOrder);
                }
                return list;
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

    public List<JobApplication> getListJobOngoingPosted(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBONGOINGPOSTED);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int budget = rs.getInt("budget");
                    int paymentMethodID = rs.getInt("paymentMethodID");
                    String paymentMethodName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    int jobAppStatus = rs.getInt("jobApplicationStatus");
                    int jobStatus = rs.getInt("jobStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .budget(budget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .jobStatus(jobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(userID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .lastModifiedDate(createdDate)
                            .jobApplicationStatus(jobAppStatus)
                            .build();
                    list.add(listJobOrder);
                }
                return list;
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

    public boolean delete(int jobOrderID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETE);
                preStm.setInt(1, jobOrderID);
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

    public boolean denyJobApplication(int resumeID, int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DENY_JOBAPPLICATION);
                preStm.setInt(1, resumeID);
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

    public boolean uncompleteJobApp(int jobAppID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UNCOMPLETE_JOBAPPLICATION);
                preStm.setInt(1, jobAppID);
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

    public boolean completeJobApp(int jobAppID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(COMPLETE_JOBAPPLICATION);
                preStm.setInt(1, jobAppID);
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

    public boolean acceptJobApplication(int resumeID, int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(ACCEPT_JOBAPPLICATION);
                preStm.setInt(1, resumeID);
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

    public List<Integer> getListResumeIDOfJob(int jobID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETTALLUSERIDOFJOB);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                List<Integer> list = new ArrayList<>();
                while (rs.next()) {
                    int resumeID = rs.getInt("resumeID");
                    list.add(resumeID);
                }
                return list;
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

    public List<JobApplication> getListApplicationOfJob(int jobID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBAPPLICATIONOFJOB);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                List<JobApplication> listJobApplication = new ArrayList<>();
                while (rs.next()) {
                    int userID = rs.getInt("userID");
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    String priceDeal = rs.getString("priceDeal");
                    String message = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    String address = rs.getString("address");
                    String avatar = rs.getString("avatar");
                    Date createdDate = rs.getDate("createdDate");
                    Date dateOfBirth = rs.getDate("dateOfBirth");
                    String fullName = rs.getString("fullName");
                    String gender = rs.getString("gender");
                    String gitHub = rs.getString("gitHub");
                    String gmail = rs.getString("gmail");
                    String gpa = rs.getString("gpa");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    String linkedIn = rs.getString("linkedIn");
                    String major = rs.getString("major");
                    String overview = rs.getString("overview");
                    String phone = rs.getString("phone");
                    String website = rs.getString("website");
                    int resumeID = rs.getInt("resumeID");
                    listJobApplication.add(JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .priceDeal(priceDeal)
                            .message(message)
                            .cvFile(cvFile)
                            .resumeID(resumeID)
                            .resume(Resume.builder()
                                    .userID(userID)
                                    .address(address)
                                    .avatar(avatar)
                                    .createdDate(createdDate)
                                    .dateOfBirth(dateOfBirth)
                                    .fullName(fullName)
                                    .gender(gender)
                                    .gitHub(gitHub)
                                    .gmail(gmail)
                                    .gpa(gpa)
                                    .lastModifiedDate(lastModifiedDate)
                                    .linkedIn(linkedIn)
                                    .major(major)
                                    .overview(overview)
                                    .phone(phone)
                                    .website(website)
                                    .build()
                            ).build()
                    );
                }
                return listJobApplication;
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

    public List<Integer> getListJobOrderOfJob(int jobID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETTALLJOBORDERIDOFJOB);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                List<Integer> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    list.add(jobApplicationID);
                }
                return list;
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

    public List<JobApplication> getJobOrder(String searchJobTitle, int searchSkillID, int searchJobCategoryID, int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<JobApplication> listJobApp = new ArrayList<>();
                String getDataSQL = "";
                String getDataSQL1 = this.SEARCHJOBORDER;

                String queryForSearchSkill
                        = "SELECT ja.jobApplicationID, ja.resumeID, ja.jobID, ja.cvFile, ja.createdDate, ja.message, ja.priceDeal, "
                        + "j.jobTitle, j.userID, j.jobCategoryID, c.categoryName, c.img, j.expiriedDate, j.budget, j.paymentMethodID, pm.paymentMethodName, "
                        + "j.address, j.email, j.phone, j.description, j.lastModifiedDate "
                        + "FROM (((tblJobApplications ja LEFT JOIN tblJobs j ON ja.jobID = j.jobID) "
                        + "LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID) "
                        + "left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID) "
                        + "left join tblJobSkills js on js.jobID = j.jobID ";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobApplicationStatus = 1 and resumeID =" + resumeID;
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + "WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and jobStatus = 1 and userID =" + resumeID;
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ? and jobStatus = 1 and userID =" + resumeID;
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobCategoryID = ? and jobStatus = 1 and userID =" + resumeID;
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
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    int userID = rs.getInt("userID");
                    String cvFile = rs.getString("cvFile");
                    String message = rs.getString("message");
                    String priceDeal = rs.getString("priceDeal");
                    String jobTitle = rs.getString("jobTitle");
                    float budget = rs.getFloat("budget");
                    int payID = rs.getInt("paymentMethodID");
                    String payName = rs.getString("paymentMethodName");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .budget(budget)
                            .payMentMethod(PayMentMethod.builder().paymentMethodID(payID).paymentMethodName(payName).build())
                            .description(description)
                            .expiriedDate(expiriedDate)
                            .lastModifiedDate(lastModifiedDate)
                            .build();
                    JobApplication jobApp = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .cvFile(cvFile)
                            .message(message)
                            .priceDeal(priceDeal)
                            .resumeID(resumeID)
                            .job(job)
                            .jobApplicationStatus(1)
                            .build();
                    listJobApp.add(jobApp);
                }
                return listJobApp;
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
