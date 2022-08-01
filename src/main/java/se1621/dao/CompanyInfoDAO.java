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
import se1621.dto.CompanyInfo;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class CompanyInfoDAO {

    private static final String CREATECOMINFO = "INSERT INTO tblCompanies(companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar, companyStatus) VALUES(?,?,?,?,?,?,?,?,?,?,1)";
    private static final String GETLISTCOMPANY = "SELECT * FROM tblCompanies and companyStatus = 1";
    private static final String GETCOMID = "SELECT companyID FROM tblCompanies WHERE companyName=?";
    private static final String CHECK_DUPLICATE = "SELECT companyID FROM tblCompanies WHERE companyName=?";
    private static final String SEARCH = "SELECT companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, avatar, createdDate, lastModifiedDate, companyStatus FROM tblCompanies WHERE companyID = ?";
    private static final String UPDATE_COMPANYINFO = "UPDATE tblCompanies"
            + "   SET companyName = ? ,address = ? ,website = ? ,gmail = ? ,phone = ? ,typeCompany = ? ,establishedYear = ? ,numberOfEmployee = ? ,companyOverview = ? ,avatar = ? "
            + "   WHERE companyID = ?";
    private static final String UPDATE_BUSINESSLICENSE = "UPDATE tblCompanies SET businessLicense = ?, companyStatus = 2 WHERE companyID = ?";
    private static final String UPDATE_COMPANY_STATUS = "UPDATE tblCompanies SET companyStatus=? WHERE companyID=?";

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
                preStm.setInt(7, company.getEstablishedYear());
                preStm.setInt(8, company.getNumberOfEmployee());
                preStm.setString(9, company.getCompanyOverview());
                preStm.setString(10, company.getAvatar());

                check = preStm.executeUpdate() > 0;
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
                List<CompanyInfo> listCompany = new ArrayList<>();
                while (rs.next()) {
                    int companyID = rs.getInt("companyID");
                    String companyName = rs.getString("companyName");
                    String address = rs.getString("address");
                    String website = rs.getString("website");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String typeCompany = rs.getString("typeCompany");
                    int establishedYear = rs.getInt("establishedYear");
                    int numberOfEmployee = rs.getInt("numberOfEmployee");
                    String companyOverview = rs.getString("companyOverview");
                    String avatar = rs.getString("avatar");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    CompanyInfo company = CompanyInfo.builder()
                            .companyID(companyID)
                            .companyName(companyName)
                            .address(address)
                            .website(website)
                            .gmail(gmail)
                            .phone(phone)
                            .typeCompany(typeCompany)
                            .establishedYear(establishedYear)
                            .numberOfEmployee(numberOfEmployee)
                            .companyOverview(companyOverview)
                            .avatar(avatar)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .build();
                    listCompany.add(company);
                }
                return listCompany;
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

    public CompanyInfo getCompanyInfo(int companyID) throws SQLException {
        CompanyInfo companyInfo = new CompanyInfo();
        conn = null;
        preStm = null;
        rs = null;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(SEARCH);
                preStm.setInt(1, companyID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String companyName = rs.getString("companyName");
                    String address = rs.getString("address");
                    String website = rs.getString("website");
                    String gmail = rs.getString("gmail");
                    String phone = rs.getString("phone");
                    String typeCompany = rs.getString("typeCompany");
                    int establishedYear = rs.getInt("establishedYear");
                    int numberOfEmployee = rs.getInt("numberOfEmployee");
                    String companyOverview = rs.getString("companyOverview");
                    String avatar = rs.getString("avatar");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    int companyStatus = rs.getInt("companyStatus");
                    companyInfo = CompanyInfo.builder()
                            .companyID(companyID)
                            .companyName(companyName)
                            .address(address)
                            .website(website)
                            .gmail(gmail)
                            .phone(phone)
                            .typeCompany(typeCompany)
                            .establishedYear(establishedYear)
                            .numberOfEmployee(numberOfEmployee)
                            .companyOverview(companyOverview)
                            .avatar(avatar)
                            .createdDate(createdDate)
                            .lastModifiedDate(lastModifiedDate)
                            .companyStatus(companyStatus)
                            .build();
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
        return companyInfo;
    }

    public boolean updateCompanyInfo(CompanyInfo company) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_COMPANYINFO);
                preStm.setString(1, company.getCompanyName());
                preStm.setString(2, company.getAddress());
                preStm.setString(3, company.getWebsite());
                preStm.setString(4, company.getGmail());
                preStm.setString(5, company.getPhone());
                preStm.setString(6, company.getTypeCompany());
                preStm.setInt(7, company.getEstablishedYear());
                preStm.setInt(8, company.getNumberOfEmployee());
                preStm.setString(9, company.getCompanyOverview());
                preStm.setString(10, company.getAvatar());
                preStm.setInt(11, company.getCompanyID());
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

    public boolean updateBusinessLicense(int companyID, String businessLicense) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_BUSINESSLICENSE);
                preStm.setString(1, businessLicense);
                preStm.setInt(2, companyID);
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
    
    public boolean updateCompanyStatus(int companyID, int userStatus) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(UPDATE_COMPANY_STATUS);
                preStm.setInt(1, userStatus);
                preStm.setInt(2, companyID);
                check = preStm.executeUpdate() > 0;
            }
        } catch (SQLException e) {
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
