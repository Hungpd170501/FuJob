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
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class CategoryDAO {

    private static final String GETLISTCATEGORY = "SELECT * FROM tblCategories WHERE categoryStatus = 1 ORDER BY categoryName";
    private static final String GETLISTCATEGORY_NonOrderBy = "SELECT * FROM tblCategories";
    private static final String GETCATEGORY = "SELECT * FROM tblCategories WHERE categoryID = ? and categoryStatus = 1";
    Connection conn;
    PreparedStatement preStm;
    private ResultSet rs;

    public List<Category> getListCategory() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETLISTCATEGORY);
                rs = preStm.executeQuery();
                List<Category> list = new ArrayList<>();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    int categoryStatus = rs.getInt("categoryStatus");
                    Category category = new Category(categoryID, categoryName, img, createdDate, lastModifiedDate, categoryStatus);
                    list.add(category);
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
    
     public List<Category> getListCategory_nonOrderBy() throws SQLException {
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETLISTCATEGORY_NonOrderBy);
                rs = preStm.executeQuery();
                List<Category> list = new ArrayList<>();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    Date createdDate = rs.getDate("createdDate");
                    Date lastModifiedDate = rs.getDate("lastModifiedDate");
                    int categoryStatus = rs.getInt("categoryStatus");
                    Category category = new Category(categoryID, categoryName, img, createdDate, lastModifiedDate, categoryID);
                    list.add(category);
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

    public Category getCategory(int categoryID) throws SQLException {
        Category category = new Category();
        try {
            conn = DBUtils.getInstance().getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(GETCATEGORY);
                preStm.setInt(1, categoryID);
                rs = preStm.executeQuery();

                if (rs.next()) {
                    String categoryName = rs.getString("categoryName");
                    String img = rs.getString("img");
                    category = Category.builder().categoryID(categoryID).categoryName(categoryName).img(img).build();
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
        return category;
    }
}
