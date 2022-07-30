/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;

import org.hibernate.Session;
import se1621.entity.JobEntity;
import se1621.utils.HibernateUtils;

/**
 *
 * @author ACER
 */
public class JobDAOImpl extends BaseDAOImpl implements  JobDAO{
    private final Session session=HibernateUtils.getSession();
    @Override
    public void save(JobEntity jobEntity) {
        super.saveEntity(jobEntity);
    }

    @Override
    public List<JobEntity> getAll(String jobEntityName) {
        return(super.getAllEntity(jobEntityName));
    }

    @Override
    public List<JobEntity> getAllUsingHQL(String hql) {
        List list = session
                .createQuery(hql, JobEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;
    }

    @Override
    public List<JobEntity> get8RecentJobPosted(String hql) {
        List list = session
                .createQuery(hql, JobEntity.class).setMaxResults(8)
                .list();
        HibernateUtils.closeSession();
        return list;
    }


}
