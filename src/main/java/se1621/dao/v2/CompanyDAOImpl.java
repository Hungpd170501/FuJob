/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import org.hibernate.Session;
import se1621.entity.CompanyEntity;
import se1621.utils.HibernateUtils;

/**
 *
 * @author ACER
 */
public class CompanyDAOImpl extends BaseDAOImpl implements CompanyDAO{
    private final Session session=HibernateUtils.getSession();
    
    @Override
    public void save(CompanyEntity companyEntity) {
        super.saveEntity(companyEntity);    
    }

    @Override
    public List<CompanyEntity> getAll(String companyEntityName) {
       return(super.getAllEntity(companyEntityName));    
    }

    @Override
    public List<CompanyEntity> getAllUsingHQL(String hql) {
                        List list = session
                .createQuery(hql, CompanyEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;    }
    
}
