package se1621.dao;

import se1621.dto.EvaluateCompletion;
import se1621.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EvaluateCompletionDAO {
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static final String SAVE = "INSERT INTO tblEvaluateCompletion(reviewerID, jobID, resumeID, ratingValue, content, evaluateCompletionStatus) VALUES(?,?,?,?,?,?)";
    public boolean saveEvaluateCompletion(EvaluateCompletion evaluateCompletion) throws SQLException, ClassNotFoundException{
        boolean check = false;
        conn = null;
        preStm = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SAVE);
                preStm.setInt(1, evaluateCompletion.getReviewer().getUserID());
                preStm.setInt(2, evaluateCompletion.getJob().getJobID());
                preStm.setInt(3, evaluateCompletion.getResume().getResumeID());
                preStm.setInt(4, evaluateCompletion.getRatingValue());
                preStm.setString(5, evaluateCompletion.getContent());
                preStm.setInt(6, evaluateCompletion.getEvaluateCompletionStatus());
                return preStm.executeUpdate()> 0;
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
        return check;
    }
}
