/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import se1621.entity.JobEntity;

/**
 *
 * @author ACER
 */
public class JobDAOImpl extends BaseDAOImpl implements  JobDAO{

    @Override
    public void save(JobEntity jobEntity) {
        super.saveEntity(jobEntity);
    }

    @Override
    public List<JobEntity> getAll(String jobEntityName) {
        return(super.getAllEntity(jobEntityName));
    }
    
}
