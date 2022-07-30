/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.dao.v2;

import java.util.List;
import se1621.entity.SkillEntity;

/**
 *
 * @author ACER
 */
public interface SkillDAO {

    void save(SkillEntity skillEntity);
    List<SkillEntity> getAll(String skillEntityName);
}
