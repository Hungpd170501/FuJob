/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;

import org.hibernate.Session;
import se1621.entity.JobEntity;
import se1621.entity.SkillEntity;
import se1621.utils.HibernateUtils;

/**
 *
 * @author ACER
 */
public class SkillDAOImpl extends BaseDAOImpl implements SkillDAO {
    private final Session session=HibernateUtils.getSession();
    @Override
    public void save(SkillEntity skillEntity) {
        super.saveEntity(skillEntity);
    }

    @Override
    public List<SkillEntity> getAll(String skillEntityName) {
        return (super.getAllEntity(skillEntityName));
    }

    public List<SkillEntity> getAllUsingHQL(String hql) {
        List list = session
                .createQuery(hql, SkillEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;
    }

}
