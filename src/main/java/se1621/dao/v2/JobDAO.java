/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import se1621.entity.JobEntity;

/**
 *
 * @author ACER
 */
public interface JobDAO {

    public void save(JobEntity jobEntity);

    public List<JobEntity> getAll(String JobEntityName);

}
