/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.io.Serializable;
import java.util.List;

import se1621.utils.HibernateDriver;

/**
 * @author ACER
 */
public class BaseDAOImpl implements BaseDAO {

    HibernateDriver hibernateDriver = new HibernateDriver();

    @Override
    public <T> void saveEntity(T entity) {
        hibernateDriver.getSession();
        try {
            hibernateDriver.openSession();
            hibernateDriver.getSession().save(entity);
            hibernateDriver.getTransaction().commit();
        } catch (RuntimeException e) {
            hibernateDriver.roleBack();
        } finally {
            hibernateDriver.closeSession();
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
        hibernateDriver.getSession();
        try {
            hibernateDriver.openSession();
            hibernateDriver.getSession().update(entity);
            hibernateDriver.getTransaction().commit();
        } catch (RuntimeException e) {
            hibernateDriver.roleBack();
        } finally {
            hibernateDriver.closeSession();
        }
    }

    @Override
    public <T> List<T> getAllEntity(String entityName) {
        List<T> list = hibernateDriver.getSession().createQuery("FROM " + entityName).list();
        hibernateDriver.closeSession();
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
