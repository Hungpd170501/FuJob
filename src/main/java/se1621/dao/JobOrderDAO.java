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

    private static final String ORDERJOB = "INSERT INTO tblJobOrder(userID, jobID, cvFile, salaryDeal, message, jobOrderStatus) VALUES(?,?,?,?,?,1)";
    private static final String CHECKDUPLICATE = "SELECT jobOrderID FROM tblJobOrder WHERE userID=? and jobID=? and jobOrderStatus = 1";
    private static final String CHECKDUPLICATE_NONSTATUS = "SELECT jobOrderID FROM tblJobOrder WHERE userID = ? and jobID = ? and jobOrderStatus = 0";
    private static final String DELETE = "UPDATE tblJobOrder SET jobOrderStatus = 0 WHERE jobOrderID = ? ";
    private static final String GETTALLUSERIDOFJOB = "SELECT userID FROM tblJobOrder WHERE jobID = ?";
    private static final String GETALLJOBAPPLIED = "SELECT jo.jobOrderID, j.jobID, j.jobTitle, j.ExperienceNeeded, j.jobCategoryID, jo.cvFile, jo.salaryDeal, jo.message,"
            + "jo.dateApplied, c.categoryName, c.img, com.companyName,"
            + "j.deadline, j.completionTime, j.salary, j.address, j.email, j.phone, j.description"
            + " FROM (((tblJobOrder jo left join (tblJob j left join tblCategory  c on j.jobCategoryID = c.categoryID ) on jo.jobID = j.jobID )"
            + "        left join tblUser us on us.userID = j.userID ) left join tblCompany com on com.companyID = us.companyID)"
            + "WHERE jo.userID=? and jo.jobOrderStatus = 1 ";
    private static final String UPDATE_STATUS = "UPDATE tblJobOrder SET cvFile = ?, salaryDeal = ?, message = ?, jobOrderStatus = 1 WHERE jobOrderID = ? and userID = ? and jobID = ?";
    private String SEARCHJOBORDER = "SELECT jo.jobOrderID, jo.userID, jo.cvFile, jo.dateApplied, jo.message, jo.salaryDeal, jo.jobID, "
            + "j.jobTitle, j.ExperienceNeeded, j.jobCategoryID, c.categoryName, c.img, j.deadline, j.completionTime, j.salary, "
            + "j.address, j.email, j.phone, j.description, j.lastDateUpdate "
            + "FROM ((tblJobOrder jo LEFT JOIN tblJob j ON jo.jobID = j.jobID)LEFT JOIN tblCategory c ON j.jobCategoryID = c.categoryID)";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public boolean orderJob(JobOrder jobOrder) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(ORDERJOB);
                preStm.setInt(1, jobOrder.getUserID());
                preStm.setInt(2, jobOrder.getJob().getJobID());
                preStm.setString(3, jobOrder.getCvFile());
                preStm.setString(4, jobOrder.getSalaryDeal());
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
                preStm.setString(2, jobOrder.getSalaryDeal());
                preStm.setString(3, jobOrder.getMessage());
                preStm.setInt(4, jobOrderID);
                preStm.setInt(5, jobOrder.getUserID());
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

    public boolean checkDuplicateJobOrderByOneUser(int userID, int jobID) throws Exception {
        boolean check = false;
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECKDUPLICATE);
                preStm.setInt(1, userID);
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
                    int jobOrderID = rs.getInt("jobOrderID");
                    int jobID = rs.getInt("jobID");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date dateApplied = rs.getDate("dateApplied");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    String companyName = rs.getString("companyName");
                    Job job = Job.builder().jobID(jobID)
                            .userID(userID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(ExperienceNeeded)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .company(CompanyInfo.builder().companyName(companyName).build())
                            .deadline(deadline)
                            .completionTime(completionTime)
                            .salary(salary)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .build();
                    JobOrder listJobOrder = JobOrder.builder().jobOrderID(jobOrderID).userID(userID).job(job).dateApplied(dateApplied).build();
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

    public boolean delete(String jobOrderID) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(DELETE);
                preStm.setString(1, jobOrderID);
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
                    int jobOrderID = rs.getInt("jobOrderID");
                    int jobID = rs.getInt("jobID");
                    String cvFile = rs.getString("cvFile");
                    String message = rs.getString("message");
                    String salaryDeal = rs.getString("salaryDeal");
                    String jobTitle = rs.getString("jobTitle");
                    String ExperienceNeeded = rs.getString("ExperienceNeeded");
                    Date deadline = rs.getDate("deadline");
                    String completionTime = rs.getString("completionTime");
                    String salary = rs.getString("salary");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String description = rs.getString("description");
                    Date lastDateUpdate = rs.getDate("lastDateUpdate");
                    Date dateApplied = rs.getDate("dateApplied");
                    int categoryID = rs.getInt("jobCategoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Job job = Job.builder().jobID(jobID)
                            .userID(studentID)
                            .jobTitle(jobTitle)
                            .ExperienceNeeded(ExperienceNeeded)
                            .category(Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build())
                            .deadline(deadline)
                            .completionTime(completionTime)
                            .salary(salary)
                            .address(address)
                            .email(email)
                            .phone(phone)
                            .description(description)
                            .lastDateUpdate(lastDateUpdate)
                            .build();
                    JobOrder jobOrder = JobOrder.builder()
                            .jobOrderID(jobOrderID)
                            .cvFile(cvFile)
                            .message(message)
                            .salaryDeal(salaryDeal)
                            .userID(studentID)
                            .job(job)
                            .dateApplied(dateApplied)
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
