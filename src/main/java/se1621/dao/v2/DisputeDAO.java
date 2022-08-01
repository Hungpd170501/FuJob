package se1621.dao.v2;

import se1621.entity.DisputeEntity;

import java.util.List;

public interface DisputeDAO {
    void save(DisputeEntity disputeEntity);

    List<DisputeEntity> getAll(String disputeEntityName);
    List<DisputeEntity> getAllUsingHQL(String hql);
}
