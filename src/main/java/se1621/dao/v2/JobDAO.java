/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package se1621.dao.v2;

import se1621.entity.JobEntity;

import java.util.List;

/**
 * @author ACER
 */
public interface JobDAO {

    void save(JobEntity jobEntity);

    List<JobEntity> getAll(String JobEntityName);

    List<JobEntity> getAllUsingHQL(String hql);

    List<JobEntity> get8RecentJobPosted(String hql);

}
