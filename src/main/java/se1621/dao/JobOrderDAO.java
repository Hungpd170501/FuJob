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
import se1621.dto.JobOrder;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class JobOrderDAO {

    private static final String ORDERJOB = "INSERT INTO tblJobApplications(resumeID, jobID, cvFile, priceDeal, message, jobApplicationStatus) VALUES(?,?,?,?,?,1)";
    private static final String CHECKDUPLICATE = "SELECT jobApplicationID FROM tbljobApplications WHERE resumeID=? and jobID=? and jobApplicationStatus = 1";
    private static final String CHECKDUPLICATE_NONSTATUS = "SELECT jobApplicationID FROM tblJobApplications WHERE resumeID = ? and jobID = ? and jobApplicationStatus = 0";
    private static final String DELETE = "UPDATE tblJobApplications SET jobApplicationStatus = 0 WHERE jobApplicationID = ? ";
    private static final String GETTALLUSERIDOFJOB = "SELECT resumeID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETTALLJOBORDERIDOFJOB = "SELECT jobApplicationID FROM tblJobApplications WHERE jobID = ?";
    private static final String GETALLJOBAPPLIED = "SELECT jo.jobApplicationID, j.jobID, j.jobTitle, j.jobCategoryID, jo.cvFile, jo.priceDeal, jo.message,"
            + "            jo.createdDate, c.categoryName, c.img, com.companyName,"
            + "            j.createdDate, j.expiriedDate, j.lastModifiedDate, j.budget, j.address, j.email, j.phone, j.description"
            + "            FROM (((tblJobApplications jo left join (tblJobs j left join tblCategories  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID )"
            + "            left join tblUsers us on us.userID = j.userID ) left join tblCompanies com on com.companyID = us.companyID)"
            + "            WHERE jo.resumeID=? and jo.jobApplicationStatus = 1";
    private static final String UPDATE_STATUS = "UPDATE tblJobApplications SET cvFile = ?, priceDeal = ?, message = ?, jobApplicationStatus = 1 WHERE jobApplicationID = ? and resumeID = ? and jobID = ?";
    private String SEARCHJOBORDER = "SELECT jo.jobApplicationID, jo.resumeID, jo.cvFile, jo.createdDate, jo.message, jo.priceDeal, jo.jobID,"
            + "            j.jobTitle, j.jobCategoryID, c.categoryName, c.img, j.createdDate, j.expiriedDate, j.budget,"
            + "            j.address, j.email, j.phone, j.description, j.lastModifiedDate"
            + "            FROM ((tblJobApplications jo LEFT JOIN tblJobs j ON jo.jobID = j.jobID)LEFT JOIN tblCategories c ON j.jobCategoryID = c.categoryID)";

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

    public boolean orderJob(JobOrder jobOrder) throws SQLException, ClassNotFoundException {
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

    public boolean reApply(JobOrder jobOrder, int jobOrderID) throws SQLException, ClassNotFoundException {
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

    public List<JobOrder> getListJobApplied(int userID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETALLJOBAPPLIED);
                preStm.setInt(1, userID);
                rs = preStm.executeQuery();
                List<JobOrder> list = new ArrayList<>();
                while (rs.next()) {
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String jobTitle = rs.getString("jobTitle");
                    Date createdDate = rs.getDate("createdDate");
                    Date expiriedDate = rs.getDate("expiriedDate");
                    int budget = rs.getInt("budget");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .address(address)
                            .email(email)
                            .budget(budget)
                            .phone(phone)
                            .expiriedDate(expiriedDate)
                            .description(description)
                            .build();
                    JobOrder listJobOrder = JobOrder.builder()
                            .jobApplicationID(jobApplicationID)
                            .resumeID(userID).job(job)
                            .createdDate(createdDate)
                            .lastModifiedDate(createdDate)
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

    public List<JobOrder> getJobOrder(String searchJobTitle, String searchExperienceNeeded, int searchJobCategoryID, int studentID) throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                List<JobOrder> listJobOrder = new ArrayList<>();
                String getDataSQL = this.SEARCHJOBORDER;
                boolean checkCateID = true;
                if (searchJobCategoryID == 0) {
                    getDataSQL = getDataSQL + " WHERE j.jobTitle like ? and j.ExperienceNeeded like ? and jo.jobOrderStatus = 1 and jo.userID = " + studentID;
                } else {
                    getDataSQL = getDataSQL + " WHERE j.jobTitle like ? and j.ExperienceNeeded like ? and j.jobCategoryID = ? and jo.jobOrderStatus = 1 and jo.userID = " + studentID;
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
                    int jobApplicationID = rs.getInt("jobApplicationID");
                    int jobID = rs.getInt("jobID");
                    String cvFile = rs.getString("cvFile");
                    String message = rs.getString("message");
                    String priceDeal = rs.getString("priceDeal");
                    String jobTitle = rs.getString("jobTitle");
                    int budget = rs.getInt("budget");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    Date createdDate = rs.getDate("createdDate");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Job job = Job.builder().jobID(jobID)
                            .userID(studentID)
                            .jobTitle(jobTitle)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .budget(budget)
                            .build();
                    JobOrder jobOrder = JobOrder.builder()
                            .jobApplicationID(jobApplicationID)
                            .cvFile(cvFile)
                            .message(message)
                            .priceDeal(priceDeal)
                            .resumeID(studentID)
                            .job(job)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .build();
                    listJobOrder.add(jobOrder);
                }
                return listJobOrder;
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
