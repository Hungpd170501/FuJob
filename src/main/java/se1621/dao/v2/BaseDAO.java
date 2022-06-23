/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author ACER
 */
public interface BaseDAO {
        //save an entity object
    public <T> void saveEntity(T entity);

    // delete an entity object

    public <T> void deleteEntity(T entity);

    //Delete an entity object based on entity type and ID
    public <T> void deleteEntityById(Class<T> entityClass, Serializable id);

    //modify an entity object
    public <T> void updateEntity(T entity);

    //Query all instances of an entity

    public <T> List<T> getAllEntity(String entityName);

    // An entity object obtained by the primary key

    public <T> T getEntityById(Class<T> entityClass, Serializable id);


    // paging
    public <T> List<T> getbyPage(String hql, int pageNo, int pageSize, int real);

    //most page number
    public <T> int realPage(String hql);


}
