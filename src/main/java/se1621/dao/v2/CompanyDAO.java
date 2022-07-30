/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import se1621.entity.CompanyEntity;

/**
 *
 * @author ACER
 */
public interface CompanyDAO {
    void save(CompanyEntity companyEntity);
    List<CompanyEntity> getAll(String companyEntityName);
    List<CompanyEntity> getAllUsingHQL(String hql);
}
