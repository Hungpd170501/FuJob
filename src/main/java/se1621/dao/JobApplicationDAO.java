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
    private static final String GETTALLUSERIDOFJOB = "SELECT resumeID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETTALLJOBORDERIDOFJOB = "SELECT jobApplicationID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETALLJOBAPPLIED = "SELECT jo.jobApplicationID,jo.jobApplicationStatus, j.jobID, j.jobTitle, j.jobCategoryID, j.budget,j.paymentMethodID, pay.paymentMethodName, jo.cvFile, jo.priceDeal, jo.message,"
            + "                        jo.createdDate, c.categoryName, c.img, com.companyName, "
            + "                        j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget, j.address, j.email, j.phone, j.description "
            + "                        FROM ((((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID ) "
            + "                        left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)left join tblPaymentMethods pay on pay.paymentMethodID = j.paymentMethodID)"
            + "                        WHERE jo.resumeID=? and (jo.jobApplicationStatus = 1 OR "
            + "                        jo.jobApplicationStatus =  3 OR jo.jobApplicationStatus =  5 ) ORDER BY jobID";
    private static final String UPDATE_STATUS = "UPDATE tblJobApplications SET cvFile = ?, priceDeal = ?, message = ?, jobApplicationStatus = 1 WHERE jobApplicationID = ? and resumeID = ? and jobID = ?";
    private final String SEARCHJOBORDER = "SELECT ja.jobApplicationID, ja.resumeID, ja.jobID, ja.cvFile, ja.createdDate, ja.message, ja.priceDeal, "
            + "j.jobTitle, j.userID, j.jobCategoryID, c.categoryName, c.img, j.expiriedDate, j.budget, j.paymentMethodID, pm.paymentMethodName, "
            + "j.address, j.email, j.phone, j.description, j.lastModifiedDate "
            + "FROM (((tblJobApplications ja LEFT JOIN tblJobs j ON ja.jobID = j.jobID) "
            + "LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID) "
            + "left join tblPaymentMethods pm on pm.paymentMethodID = j.paymentMethodID) ";

    private static final String GETALLNUMBEROFJOBORDER = "SELECT COUNT (*) AS totalJobOrder FROM tblJobApplications";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

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

    public int getJobOrderID(int userID, int jobID) throws Exception {
        conn = null;
        preStm = null;
        rs = null;
        int jobOrderID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKDUPLICATE_NONSTATUS);
                preStm.setInt(1, userID);
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

    public List<JobApplication> getListJobApplied(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBAPPLIED);
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

    public List<Integer> getListUserIDOfJob(int jobID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETTALLUSERIDOFJOB);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                List<Integer> list = new ArrayList<>();
                while (rs.next()) {
                    int userID = rs.getInt("userID");
                    list.add(userID);
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

    public List<Integer> getListJobOrderOfJob(int jobID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETTALLJOBORDERIDOFJOB);
                preStm.setInt(1, jobID);
                rs = preStm.executeQuery();
                List<Integer> list = new ArrayList<>();
                while (rs.next()) {
                    int jobOrderID = rs.getInt("jobOrderID");
                    list.add(jobOrderID);
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
