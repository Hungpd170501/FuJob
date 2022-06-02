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
import se1621.dto.Category;
import se1621.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class CategoryDAO {
    private static final String GETLISTCATEGORY = "SELECT * FROM tblCategory";
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
                    Category category = new Category(categoryID, categoryName);
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
}
