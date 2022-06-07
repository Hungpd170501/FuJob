/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import se1621.dto.Job;
import se1621.dto.JobOrder;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class JobOrderDAO {

    private static final String ORDERJOB = "INSERT INTO tblJobOrder(userID, jobID, cvFile, salaryDeal, message) VALUES(?,?,?,?,?)";
    private static final String CHECKDUPLICATE = "SELECT jobOrderID FROM tblJobOrder WHERE userID=? and jobID=?";
    private static final String GETALLJOBAPPLIED = "SELECT jobOrderID, jobID FROM tblJobOrder WHERE userID=?";
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
                    JobOrder listJobOrder = JobOrder.builder().jobOrderID(jobOrderID).job(Job.builder().jobID(jobID).build()).build();

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
    
    public List<JobOrder> getPaginateJobOrderList(List<JobOrder> listPage, int startPage, int endPage) throws SQLException {
        ArrayList<JobOrder> jobOrderPage = new ArrayList<>();
        for (int i = startPage; i < endPage; i++) {
            jobOrderPage.add(listPage.get(i));
        }
        return jobOrderPage;
    }
}