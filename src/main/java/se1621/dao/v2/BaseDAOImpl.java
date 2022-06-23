/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.io.Serializable;
import java.util.List;
import org.hibernate.Session;

import se1621.utils.HibernateUtils;

public class BaseDAOImpl implements BaseDAO {

    private Session session;

    @Override
    public <T> void saveEntity(T entity) {
        session = HibernateUtils.getSession();
        try {
            session.beginTransaction();
            session.save(entity);
            session.getTransaction().commit();
        } catch (RuntimeException e) {
            if (null != session.getTransaction()) {
                session.getTransaction().rollback();
            }
        } finally {
            HibernateUtils.closeSession();
        }
    }

    @Override
    public <T> void deleteEntity(T entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public <T> void deleteEntityById(Class<T> entityClass, Serializable id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public <T> void updateEntity(T entity) {
        session = HibernateUtils.getSession();
        try {
            session.beginTransaction();
            session.update(entity);
            session.getTransaction().commit();

        } catch (RuntimeException e) {
            session.getTransaction().rollback();
        } finally {
            HibernateUtils.closeSession();
        }
    }

    @Override
    public <T> List<T> getAllEntity(String entityName) {
        session = HibernateUtils.getSession();
        List<T> list = session
                .createQuery("FROM " + entityName)
                .list();
        HibernateUtils.closeSession();
        return list;
    }

    @Override
    public <T> T getEntityById(Class<T> entityClass, Serializable id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public <T> List<T> getbyPage(String hql, int pageNo, int pageSize, int real) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public <T> int realPage(String hql) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
