/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import se1621.entity.CategoryEntity;

/**
 *
 * @author ACER
 */
public class CategoryDAOImpl extends BaseDAOImpl implements  CategoryDAO{

    @Override
    public void save(CategoryEntity categoryEntity) {
        super.saveEntity(categoryEntity);
    }

    @Override
    public List<CategoryEntity> getAll(String categoryEntityName) {
        return(super.getAllEntity(categoryEntityName));
    }
}
