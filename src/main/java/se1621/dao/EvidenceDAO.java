/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import se1621.dto.Evidences;
import se1621.utils.DBUtils;

/**
 *
 * @author HNGB
 */
public class EvidenceDAO {

    public static final String CREATE_EVIDENCE = "INSERT INTO tblEvidences (disputeID, userID, message, evidenceFile) VALUES (?,?,?,?)";

    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public boolean createEvidence(Evidences evidence) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATE_EVIDENCE);
               preStm.setInt(1, evidence.getDisputes().getDisputeID());
               preStm.setInt(2, evidence.getUser().getUserID());
               preStm.setString(3, evidence.getMessage());
               preStm.setString(4, evidence.getEvidenceFile());
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
