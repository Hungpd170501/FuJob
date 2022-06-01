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
import se1621.dto.CompanyInfo;
import se1621.utils.DBUtils;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import se1621.dto.CompanyInfo;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class CompanyInfoDAO {

    private static final String CREATECOMINFO = "INSERT INTO tblCompany(companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar) VALUES(?,?,?,?,?,?,?,?,?,?)";
    private static final String GETLISTCOMPANY = "SELECT * FROM tblCompany";
    private static final String GETCOMID = "SELECT companyID FROM tblCompany WHERE companyName=?";
    private static final String CHECK_DUPLICATE = "SELECT companyID FROM tblCompany WHERE companyName=?";
    private static final String SEARCH = "SELECT companyID, companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar FROM tblCompany WHERE companyID = ?";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public boolean createComInfo(CompanyInfo company) throws SQLException, ClassNotFoundException {
        boolean check = false;
        conn = null;
        preStm = null;

        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CREATECOMINFO);
                preStm.setString(1, company.getCompanyName());
                preStm.setString(2, company.getAddress());
                preStm.setString(3, company.getWebsite());
                preStm.setString(4, company.getGmail());
                preStm.setString(5, company.getPhone());
                preStm.setString(6, company.getTypeCompany());
                preStm.setString(7, company.getEstablishedYear());
                preStm.setInt(8, company.getNumberOfEmployee());
                preStm.setString(9, company.getCompanyOverview());
                preStm.setString(10, company.getAvatar());

                check = preStm.executeUpdate() > 0 ? true : false;
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

    public List<CompanyInfo> getListCompany() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETLISTCOMPANY);
                rs = preStm.executeQuery();
                List<CompanyInfo> list = new ArrayList<>();
                while (rs.next()) {
                    int companyID = rs.getInt("companyID");
                    String companyName = rs.getString("companyName");
                    String address = rs.getString("address");
                    String website = rs.getString("website");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String typeCompany = rs.getString("typeCompany");
                    String establishedYear = rs.getString("establishedYear");
                    int numberOfEmployee = rs.getInt("numberOfEmployee");
                    String companyOverview = rs.getString("companyOverview");
                    String avatar = rs.getString("avatar");
                    CompanyInfo companyInfo = new CompanyInfo(companyID, companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar);

                    list.add(companyInfo);
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

    public boolean checkDuplicate(String companyName) throws SQLException {
        boolean check = false;
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(CHECK_DUPLICATE);
                preStm.setString(1, companyName);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
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
        return check;
    }

    public int getCompanyID(String companyName) throws SQLException {
        int companyID = 0;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETCOMID);
                preStm.setString(1, companyName);
                rs = preStm.executeQuery();
                while (rs.next()) {
                    companyID = rs.getInt("companyID");
                }
                return companyID;

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
        return companyID;
    }

    public List<CompanyInfo> getListCompany(int search) throws SQLException {
        List<CompanyInfo> listCompany = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
//              ptm.setString(1, "%" + search + "%");
                ptm.setInt(1, search);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int companyID = rs.getInt("companyID");
                    String companyName = rs.getString("companyName");
                    String address = rs.getString("address");
                    String website = rs.getString("website");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String typeCompany = rs.getString("typeCompany");
                    String establishedYear = rs.getString("establishedYear");
                    int numberOfEmployee = rs.getInt("numberOfEmployee");
                    String companyOverview = rs.getString("companyOverview");
                    String avatar = rs.getString("avatar");
                    listCompany.add(new CompanyInfo(companyID, companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listCompany;
    }

    public List<CompanyInfo> getListCompany_v2() throws SQLException {
        try {
            String query = "SELECT* FROM tblCompany";
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {

            }
            preStm = conn.prepareStatement(query);
            rs = preStm.executeQuery();
            List<CompanyInfo> listCompany = new ArrayList<>();
            while (rs.next()) {
                int companyID = rs.getInt("companyID");
                String companyName = rs.getString("companyName");
                String address = rs.getString("address");
                String website = rs.getString("website");
                String gmail = rs.getString("gmail");
                String phone = rs.getString("phone");
                String typeCompany = rs.getString("typeCompany");
                String establishedYear = rs.getString("establishedYear");
                int numberOfEmployee = rs.getInt("numberOfEmployee");
                String companyOverview = rs.getString("companyOverview");
                String avatar = rs.getString("avatar");
                CompanyInfo company = new CompanyInfo(companyID, companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar);
                listCompany.add(company);
            }
            return listCompany;
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
