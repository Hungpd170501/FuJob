/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;

import org.hibernate.Session;
import se1621.entity.CategoryEntity;
import se1621.utils.HibernateUtils;

/**
 *
 * @author ACER
 */
public class CategoryDAOImpl extends BaseDAOImpl implements  CategoryDAO{
    private final Session session=HibernateUtils.getSession();
    @Override
    public void save(CategoryEntity categoryEntity) {
        super.saveEntity(categoryEntity);
    }

    @Override
    public List<CategoryEntity> getAll(String categoryEntityName) {
        return(super.getAllEntity(categoryEntityName));
    }
    public List<CategoryEntity> getAllUsingHQL(String hql) {
        List list = session
                .createQuery(hql, CategoryEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;
    }
}
