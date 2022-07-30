package se1621.dao.v2;

import se1621.entity.RoleEntity;

import java.util.List;

public interface RoleDAO {
    void save(RoleEntity roleEntity);

    List<RoleEntity> getAll(String roleEntityName);
    List<RoleEntity> getAllUsingHQL(String hql);
}
