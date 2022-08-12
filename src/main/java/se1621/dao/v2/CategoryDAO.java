/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import se1621.entity.CategoryEntity;

import java.util.List;

/**
 * @author ACER
 */
public interface CategoryDAO {
    void save(CategoryEntity categoryEntity);

    List<CategoryEntity> getAll(String categoryEntityName);
}
