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
public class SkillDAOImpl extends BaseDAOImpl implements SkillDAO {

    @Override
    public void save(SkillEntity skillEntity) {
        super.saveEntity(skillEntity);
    }

    @Override
    public List<SkillEntity> getAll(String skillEntityName) {
        return (super.getAllEntity(skillEntityName));
    }

}
