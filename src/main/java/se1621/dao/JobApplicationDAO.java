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
import se1621.dto.EvaluateCompletion;
import se1621.dto.Job;
import se1621.dto.JobApplication;
import se1621.dto.PayMentMethod;
import se1621.dto.Resume;
import se1621.dto.SubmitJob;
import se1621.dto.User;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class JobApplicationDAO {

    private static final String ORDERJOB = "INSERT INTO tblJobApplications(resumeID, jobID, cvFile, priceDeal, message, jobApplicationStatus) VALUES(?,?,?,?,?,1)";
    private static final String CHECKDUPLICATE = "SELECT jobApplicationID FROM tbljobApplications WHERE resumeID=? and jobID=? and jobApplicationStatus in (1,3,5,6)";

    private static final String CHECKDUPLICATE_NONSTATUS = "SELECT jobApplicationID FROM tblJobApplications WHERE resumeID = ? and jobID = ? and jobApplicationStatus = 0";
    private static final String DELETE = "UPDATE tblJobApplications SET jobApplicationStatus = 0 WHERE jobApplicationID = ? ";
    private static final String ENDPROJECT = "UPDATE tblJobApplications SET jobApplicationStatus = 10 WHERE jobApplicationID = ? ";
    private static final String UNAPLLY = "UPDATE tblJobApplications SET jobApplicationStatus = 0 , reasonUnaplly = ? WHERE jobApplicationID = ? ";
    private static final String DENY_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 5, reasonRejection = ? WHERE resumeID = ? AND jobID = ? AND jobApplicationStatus = 1 ";
    private static final String ACCEPT_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 3 WHERE resumeID = ? AND jobID = ? AND jobApplicationStatus = 1 ";
    private static final String UNAPLLYWHENJOBHAVECANDIDATES_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 5, reasonRejection = ? WHERE jobID = ? AND jobApplicationStatus = 1 ";
    private static final String UNCOMPLETE_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 7 WHERE jobApplicationID = ? AND jobApplicationStatus IN (3,8)";
    private static final String REJECT_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 9, reasonRejectSubmit = ? WHERE jobApplicationID = ? AND jobApplicationStatus IN (3,8)";
    private static final String COMPLETE_JOBAPPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = 6 WHERE jobApplicationID = ? AND jobApplicationStatus IN (3,8)";
    private static final String GETTALLUSERIDOFJOB = "SELECT resumeID FROM tblJobApplications WHERE jobID = ? and jobApplicationStatus = 1";
    private static final String GETALLJOBAPPLICATIONOFJOB = "SELECT jo.jobApplicationID, jo.priceDeal, jo.message, jo.cvFile, re.address, re.avatar"
            + ", re.createdDate, re.dateOfBirth, re.fullName, re.gender, re.gitHub, re.gmail, re.gpa, "
            + "re.lastModifiedDate, re.linkedIn, re.major, re.overview, re.phone , re.website, re.resumeID, re.userID "
            + "FROM tblJobApplications jo left join tblResumes re "
            + " ON jo.resumeID = re.resumeID "
            + "WHERE jo.jobID = ? AND re.resumeStatus = 1 AND jo.jobApplicationStatus = 1 ";
    private static final String GETTALLJOBORDERIDOFJOB = "SELECT jobApplicationID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETALLJOBAPPLIED = "SELECT jo.jobApplicationID,ISNULL(jobApp.bids,0) AS bids,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.minBudget, j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile,jo.reasonRejection, jo.priceDeal, jo.message, "
            + "                                    jo.createdDate , c.categoryName, c.img, com.companyName, "
            + "                                    j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget, j.maxBudget,j.userID, j.address, j.email, j.phone, j.description "
            + "                                    FROM (((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                    left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID) "
            + "									left join (select jobID, COUNT(jobID) AS bids "
            + "									FROM tblJobApplications "
            + "									WHERE jobApplicationStatus = 1 "
            + "									GROUP BY jobID) AS jobApp "
            + "									on jo.jobID = jobApp.jobID) "
            + "                                    WHERE jo.resumeID= ? and jo.jobApplicationStatus IN (1, 5) ORDER BY jo.lastModifiedDate DESC";
    private static final String GETALLJOBACCEPTED = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.userID, jo.reasonRejectSubmit, j.disputeStatus, "
            + "								j.jobTitle, j.jobCategoryID, j.minBudget,j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "								jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "								sb.messageSubmit, sb.jobFile, sb.submitJobID, sb.submitJobStatus"
            + "                                FROM (((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "								left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID)"
            + "                                WHERE jo.resumeID=? and jo.jobApplicationStatus IN (3,8, 9)"
            + "                                 ORDER BY jo.lastModifiedDate DESC";

    private static final String GETALLJOBCOMPLEANDUNCOMPLETE = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.minBudget,j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message, "
            + "                                            jo.createdDate, c.categoryName, c.img, com.companyName,com.avatar as avatarCompany , resumeEvaluate.avatar as avatarEvalua, resumeEvaluate.fullName as nameEvaluate,  "
            + "                                             j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "            							   ec.content, ec.createdDate as createDateEvalua, ec.evaluateCompletionID, ec.evaluateCompletionStatus, ec.ratingValue, ec.reviewerID "
            + "                                             FROM ((((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                              left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID) "
            + "                                               left join tblEvaluateCompletion ec on (ec.resumeID = jo.resumeID AND ec.jobID = jo.jobID)) "
            + "											   left join tblResumes resumeEvaluate on resumeEvaluate.userID = us.userID) "
            + "           									WHERE jo.resumeID=? and ( jo.jobApplicationStatus =  6 OR jo.jobApplicationStatus =  7 ) ORDER BY jo.lastModifiedDate DESC";

    private static final String GETALLJOBONGOINGPOSTED = " SELECT jo.jobApplicationID,jo.resumeID,resumeUs.userID as userIDofResume,jo.jobApplicationStatus, j.jobID,j.userID,j.jobStatus, j.jobTitle, j.jobCategoryID,j.disputeStatus, j.minBudget, j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message, "
            + "                                                                                               jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                                                                               j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "                                                                                           sb.submitJobID,sb.messageSubmit, sb.jobFile, sb.createdDate, sb.lastModifiedDate, sb.submitJobStatus "
            + "                                                                                            FROM ((((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                                                                            left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID) "
            + "                                                                                             left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID) "
            + "																							 left join tblResumes resumeUs on resumeUs.resumeID = jo.resumeID ) "
            + "                                                                                               WHERE j.userID = ? and j.jobStatus IN (3,8) AND jo.jobApplicationStatus IN (3,8,9)"
            + "                                                                                            ORDER BY jo.lastModifiedDate DESC ";
    private static final String GETALLJOBPASTPOSTED = " SELECT jo.jobApplicationID,jo.resumeID,resumeUs.userID as userIDofResume,jo.jobApplicationStatus, j.jobID,j.userID,j.jobStatus, j.jobTitle, j.jobCategoryID, j.minBudget, j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message, "
            + "                                                                                               jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                                                                               j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "                                                                                           sb.submitJobID,sb.messageSubmit, sb.jobFile, sb.createdDate, sb.lastModifiedDate, sb.submitJobStatus "
            + "                                                                                            FROM ((((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                                                                            left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID) "
            + "                                                                                             left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID) "
            + "																							 left join tblResumes resumeUs on resumeUs.resumeID = jo.resumeID ) "
            + "                                                                                               WHERE j.userID = ? and j.jobStatus IN (5,6) AND jo.jobApplicationStatus IN (6,7)"
            + "                                                                                            ORDER BY jo.lastModifiedDate DESC ";

    private static final String UPDATE_STATUS = "UPDATE tblJobApplications SET cvFile = ?, priceDeal = ?, message = ?, jobApplicationStatus = 1 WHERE jobApplicationID = ? and resumeID = ? and jobID = ?";
    private final String SEARCHJOBORDER = "SELECT ja.jobApplicationID,ISNULL(jobAply.bids,0) AS bids, ja.resumeID, ja.jobID, ja.cvFile, ja.createdDate, ja.message, ja.priceDeal, ja.jobApplicationStatus, "
            + "j.jobTitle, j.userID, j.jobCategoryID, c.categoryName, c.img, j.expiriedDate, j.minBudget,j.maxBudget, j.paymentMethodID, pm.paymentMethodName, "
            + "j.address, j.email, j.phone, j.description, j.lastModifiedDate "
            + "FROM ((((tblJobApplications ja LEFT JOIN tblJobs j ON ja.jobID = j.jobID) "
            + "LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID) "
            + "left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID) "
            + "left join (select jobID, COUNT(jobID) AS bids  "
            + "           FROM tblJobApplications  "
            + "              WHERE jobApplicationStatus = 1 "
            + "                GROUP BY jobID) AS jobAply "
            + "        on jobAply.jobID = j.jobID )";

    private static final String GET_LIST_ST_PAST_WORK = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.userID, "
            + "						j.disputeStatus, j.jobTitle, j.jobCategoryID, j.minBudget,j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "								jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "								sb.messageSubmit, sb.jobFile, sb.submitJobID, sb.submitJobStatus"
            + "                                FROM (((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "								left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID)"
            + "                                WHERE jo.resumeID=? and jo.jobApplicationStatus IN (6,7)"
            + "                                ORDER BY jo.lastModifiedDate DESC";
    private static final String GETALLNUMBEROFJOBORDER = "SELECT COUNT (jobApplicationID) AS totalJobOrder FROM tblJobApplications";
    private static final String UPDATE_FORM_APPLICATON_OF_RESUME = "UPDATE tblJobApplications SET priceDeal = ?, message = ?, cvFile = ? WHERE resumeID = ? and jobID = ?";
    private static final String UPDATE_STATUS_APPLICATION = "UPDATE tblJobApplications SET jobApplicationStatus = ? WHERE jobApplicationID = ?";

    private static final String GET_JOBAPPLICATION_DISPUTE = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.userID, "
            + "								j.jobTitle, j.jobCategoryID, j.minBudget,j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "								jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "								sb.messageSubmit, sb.jobFile, sb.submitJobID, sb.submitJobStatus"
            + "                                FROM (((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "								left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID)"
            + "                                WHERE jo.resumeID=? and j.disputeStatus = 1"
            + "                                ORDER BY jo.lastModifiedDate DESC";
    private static final String GET_JOBAPPLICATION_HR_DISPUTE = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.userID, "
            + "								j.jobTitle, j.jobCategoryID, j.minBudget,j.maxBudget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "								jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                                j.createdDate, j.expiriedDate, j.lastModifiedDate, j.minBudget,j.maxBudget, j.address, j.email, j.phone, j.description, "
            + "								sb.messageSubmit, sb.jobFile, sb.submitJobID, sb.submitJobStatus"
            + "                                FROM (((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                                left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "								left join tblSubmitJob sb on sb.jobApplicationID = jo.jobApplicationID)"
            + "                                WHERE j.userID= ? and j.disputeStatus = 1"
            + "                                ORDER BY jo.lastModifiedDate DESC";

    private static final String GET_JA_BY_JAID = "SELECT r.userID"
            + " FROM tblJobApplications ja left join tblResumes r on ja.resumeID = r.resumeID"
            + " WHERE ja.jobApplicationID = ?";
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
                    jobOrderID = rs.getInt("jobApplicationID");
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
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int bids = rs.getInt("bids");
                    String reasonRejection = rs.getString("reasonRejection");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .bids(bids)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(resumeID)
                            .job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .cvFile(cvFile)
                            .message(message)
                            .reasonRejection(reasonRejection)
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
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int evaluateCompletionID = rs.getInt("evaluateCompletionID");
                    int ratingValue = rs.getInt("ratingValue");
                    String content = rs.getString("content");
                    Date createDateEva = rs.getDate("createDateEvalua");
                    String avatarCompany = rs.getString("avatarCompany");
                    String avatarResumeEvalua = rs.getString("avatarEvalua");
                    String nameEvaluate = rs.getString("nameEvaluate");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    EvaluateCompletion evaluate = EvaluateCompletion.builder().evaluateCompletionID(evaluateCompletionID)
                            .ratingValue(ratingValue)
                            .createdDate(createDateEva)
                            .content(content)
                            .build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).avatar(avatarCompany).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
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
                            .evaluateCompletion(evaluate)
                            .resume(Resume.builder().avatar(avatarResumeEvalua).fullName(nameEvaluate).build())
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

    public List<JobApplication> getListJobAccepcted(int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBACCEPTED);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String mess = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    int hrID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    String reasonRejectSubmit = rs.getString("reasonRejectSubmit");
                    int disputeStatus = rs.getInt("disputeStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(hrID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .disputeStatus(disputeStatus)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .submitJob(sbJob)
                            .resumeID(resumeID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(mess)
                            .cvFile(cvFile)
                            .lastModifiedDate(createdDate)
                            .jobApplicationStatus(jobAppStatus)
                            .reasonRejectionSubmmit(reasonRejectSubmit)
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
                    int resumeID = rs.getInt("resumeID");
                    String priceDeal = rs.getString("priceDeal");
                    String message = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    // Data of SubmitJobDTO
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    int userIDofResume = rs.getInt("userIDofResume");
                    int disputeStatus = rs.getInt("disputeStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .disputeStatus(disputeStatus)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .jobStatus(jobStatus)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(resumeID)
                            .resume(Resume.builder().userID(userIDofResume).build())
                            .job(job)
                            .submitJob(sbJob)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(message)
                            .cvFile(cvFile)
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

    public List<JobApplication> getListPastProjects(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBPASTPOSTED);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    int resumeID = rs.getInt("resumeID");
                    String priceDeal = rs.getString("priceDeal");
                    String message = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    // Data of SubmitJobDTO
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    int userIDofResume = rs.getInt("userIDofResume");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder()
                            .jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .jobStatus(jobStatus)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(resumeID)
                            .resume(Resume.builder().userID(userIDofResume).build())
                            .job(job)
                            .submitJob(sbJob)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(message)
                            .cvFile(cvFile)
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

    public boolean endProject(int jobOrderID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(ENDPROJECT);
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

    public boolean unApply(int jobOrderID, String reasonUnaplly) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UNAPLLY);
                preStm.setString(1, reasonUnaplly);
                preStm.setInt(2, jobOrderID);
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

    public boolean denyJobApplication(int resumeID, int jobID, String reasonReject) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DENY_JOBAPPLICATION);
                preStm.setString(1, reasonReject);
                preStm.setInt(2, resumeID);
                preStm.setInt(3, jobID);
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

    public boolean uncompleteJobApp(int jobAppID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UNCOMPLETE_JOBAPPLICATION);
                preStm.setInt(1, jobAppID);
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

    public boolean rejectJobApp(int jobAppID, String reasonRejectSubmit) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(REJECT_JOBAPPLICATION);
                preStm.setString(1, reasonRejectSubmit);
                preStm.setInt(2, jobAppID);
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

    public boolean acceptJobApplication(int resumeID, int jobID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(ACCEPT_JOBAPPLICATION);
                preStm.setInt(1, resumeID);
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

    public boolean unApplyWhenJobHaveCandidates(int jobID, String reasonRejection) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UNAPLLYWHENJOBHAVECANDIDATES_JOBAPPLICATION);
                preStm.setString(1, reasonRejection);
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
                        = "SELECT ja.jobApplicationID,ISNULL(jobAply.bids,0) AS bids, ja.resumeID, ja.jobID, ja.cvFile, ja.createdDate, ja.message, ja.priceDeal, ja.jobApplicationStatus, "
                        + "j.jobTitle, j.userID, j.jobCategoryID, c.categoryName, c.img, j.expiriedDate, j.minBudget, j.maxBudget, j.paymentMethodID, pm.paymentMethodName, "
                        + "j.address, j.email, j.phone, j.description, j.lastModifiedDate "
                        + "FROM ((((tblJobApplications ja LEFT JOIN tblJobs j ON ja.jobID = j.jobID) "
                        + "LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID) "
                        + "left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID) "
                        + "left join tblJobSkills js on js.jobID = j.jobID "
                        + "left join (select jobID, COUNT(jobID) AS bids  "
                        + "           FROM tblJobApplications  "
                        + "              WHERE jobApplicationStatus = 1 "
                        + "                GROUP BY jobID) AS jobAply "
                        + "        on jobAply.jobID = j.jobID )";
                boolean checkCateID = false;
                boolean checkSkillID = false;

                if (searchJobCategoryID == 0 && searchSkillID == 0) {
                    getDataSQL = getDataSQL1 + "WHERE jobTitle like ?  and resumeID =" + resumeID + " and jobApplicationStatus IN (1,3,5)";
                    checkCateID = true;
                    checkSkillID = true;
                } else {
                    getDataSQL = queryForSearchSkill + "WHERE jobTitle like ? and skillID = ? and jobCategoryID = ? and resumeID =" + resumeID + " and jobApplicationStatus IN (1,3,5)";
                    if (searchJobCategoryID == 0) {
                        getDataSQL = queryForSearchSkill + " WHERE jobTitle like ? and skillID = ?  and resumeID =" + resumeID + " and jobApplicationStatus IN (1,3,5)";
                        checkCateID = true;
                    }
                    if (searchSkillID == 0) {
                        getDataSQL = getDataSQL1 + "WHERE jobTitle like ? and jobCategoryID = ?  and resumeID =" + resumeID + " and jobApplicationStatus IN (1,3,5)";
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
                    float minBudget = rs.getFloat("minBudget");
                    float maxBudget = rs.getFloat("maxBudget");
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
                    int jobApplicationStatus = rs.getInt("jobApplicationStatus");
                    int bids = rs.getInt("bids");
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(PayMentMethod.builder().paymentMethodID(payID).paymentMethodName(payName).build())
                            .description(description)
                            .expiriedDate(expiriedDate)
                            .lastModifiedDate(lastModifiedDate)
                            .bids(bids)
                            .build();
                    JobApplication jobApp = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .cvFile(cvFile)
                            .message(message)
                            .priceDeal(priceDeal)
                            .resumeID(resumeID)
                            .job(job)
                            .jobApplicationStatus(jobApplicationStatus)
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

    public boolean updateJobApplicationStatus(int jobApplicationID, int jobApplicationStatus) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_STATUS_APPLICATION);
                preStm.setInt(1, jobApplicationStatus);
                preStm.setInt(2, jobApplicationID);
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

    public List<JobApplication> getListStudentPastWork(int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_LIST_ST_PAST_WORK);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String mess = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    int hrID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    int disputeStatus = rs.getInt("disputeStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(hrID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .disputeStatus(disputeStatus)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .submitJob(sbJob)
                            .resumeID(resumeID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(mess)
                            .cvFile(cvFile)
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

    public List<JobApplication> getListJobAppDispute(int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBAPPLICATION_DISPUTE);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String mess = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    int hrID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(hrID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .disputeStatus(1)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .submitJob(sbJob)
                            .resumeID(resumeID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(mess)
                            .cvFile(cvFile)
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

    public List<JobApplication> getListJobAppHRDispute(int resumeID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JOBAPPLICATION_HR_DISPUTE);
                preStm.setInt(1, resumeID);
                rs = preStm.executeQuery();
                List<JobApplication> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String priceDeal = rs.getString("priceDeal");
                    String mess = rs.getString("message");
                    String cvFile = rs.getString("cvFile");
                    int hrID = rs.getInt("userID");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int minBudget = rs.getInt("minBudget");
                    int maxBudget = rs.getInt("maxBudget");
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
                    int submitJobID = rs.getInt("submitJobID");
                    String messageSubmit = rs.getString("messageSubmit");
                    String jobFile = rs.getString("jobFile");
                    int submitJobStatus = rs.getInt("submitJobStatus");
                    PayMentMethod payMent = PayMentMethod.builder().paymentMethodID(paymentMethodID).paymentMethodName(paymentMethodName).build();
                    Job job = Job.builder().jobID(jobID)
                            .userID(hrID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .minBudget(minBudget)
                            .maxBudget(maxBudget)
                            .payMentMethod(payMent)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .disputeStatus(1)
                            .build();
                    SubmitJob sbJob = SubmitJob.builder()
                            .submitJobID(submitJobID)
                            .messageSubmit(messageSubmit)
                            .jobFile(jobFile)
                            .submitJobStatus(submitJobStatus)
                            .build();
                    JobApplication listJobOrder = JobApplication.builder()
                            .jobApplicationID(jobApplicationID)
                            .submitJob(sbJob)
                            .resumeID(resumeID).job(job)
                            .createdDate(createdDate)
                            .priceDeal(priceDeal)
                            .message(mess)
                            .cvFile(cvFile)
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

    public JobApplication getJobOrderByJobApplicationID(int jobApplicationID) throws SQLException {
        JobApplication ja = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GET_JA_BY_JAID);
                preStm.setInt(1, jobApplicationID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    int studentID = rs.getInt("userID");
                    ja = JobApplication.builder()
                            .resume(Resume.builder().userID(studentID).build())
                            .build();
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
        return ja;
    }
}
