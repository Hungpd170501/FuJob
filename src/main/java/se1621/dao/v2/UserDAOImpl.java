/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import org.hibernate.Session;
import se1621.entity.UserEntity;
import se1621.utils.HibernateUtils;

/**
 *
 * @author ACER
 */
public class UserDAOImpl extends BaseDAOImpl implements UserDAO{
    private final Session session=HibernateUtils.getSession();
    @Override
    public void save(UserEntity userEntity) {
         super.saveEntity(userEntity);    }

    @Override
    public List<UserEntity> getAll(String userEntityName) {
        return(super.getAllEntity(userEntityName));    }

    @Override
    public List<UserEntity> getAllUsingHQL(String hql) {
                List list = session
                .createQuery(hql, UserEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;    }
    
}
