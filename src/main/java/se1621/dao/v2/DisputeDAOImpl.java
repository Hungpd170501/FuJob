package se1621.dao.v2;

import org.hibernate.Session;
import se1621.entity.DisputeEntity;
import se1621.utils.HibernateUtils;

import java.util.List;

public class DisputeDAOImpl extends BaseDAOImpl implements DisputeDAO{
    private final Session session= HibernateUtils.getSession();
    @Override
    public void save(DisputeEntity disputeEntity) {
        super.saveEntity(disputeEntity);
    }

    @Override
    public List<DisputeEntity> getAll(String disputeEntityName) {
        return(super.getAllEntity(disputeEntityName));
    }

    @Override
    public List<DisputeEntity> getAllUsingHQL(String hql) {
        List list = session
                .createQuery(hql, DisputeEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;
    }
}
