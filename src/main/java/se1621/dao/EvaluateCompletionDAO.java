package se1621.dao;

import se1621.dto.EvaluateCompletion;
import se1621.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import se1621.dto.Job;
import se1621.dto.Resume;
import se1621.dto.User;

public class EvaluateCompletionDAO {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static final String SAVE = "INSERT INTO tblEvaluateCompletion(reviewerID, jobID, resumeID, ratingValue, content, evaluateCompletionStatus) VALUES(?,?,?,?,?,?)";
    private static final String GETALL_EVALUATE = "SELECT * FROM tblEvaluateCompletion";

    public boolean saveEvaluateCompletion(EvaluateCompletion evaluateCompletion) throws SQLException, ClassNotFoundException {
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
                return preStm.executeUpdate() > 0;
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

    public List<EvaluateCompletion> getAllEvaluate() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {

                preStm = conn.prepareStatement(GETALL_EVALUATE);
                rs = preStm.executeQuery();
                List<EvaluateCompletion> listEc = new ArrayList<>();
                while (rs.next()) {
                    int evaluateCompletionID = rs.getInt("evaluateCompletionID");
                    int reviewerID = rs.getInt("reviewerID");
                    int jobID = rs.getInt("jobID");
                    int resumeID = rs.getInt("resumeID");
                    int ratingValue = rs.getInt("ratingValue");
                    String content = rs.getString("content");
                    int evaluateCompletionStatus = rs.getInt("evaluateCompletionStatus");
                    EvaluateCompletion ec = EvaluateCompletion.builder()
                            .evaluateCompletionID(evaluateCompletionID)
                            .reviewer(User.builder().userID(reviewerID).build())
                            .job(Job.builder().jobID(jobID).build())
                            .resume(Resume.builder().resumeID(resumeID).build())
                            .ratingValue(ratingValue)
                            .evaluateCompletionStatus(evaluateCompletionStatus)
                            .content(content)
                            .build();
                    listEc.add(ec);
                }
                return listEc;
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
