package se1621.dao.v2;

import org.hibernate.Session;
import se1621.entity.RoleEntity;
import se1621.utils.HibernateUtils;

import java.util.List;

public class RoleDAOImpl extends BaseDAOImpl implements RoleDAO {
    private final Session session = HibernateUtils.getSession();

    @Override
    public void save(RoleEntity roleEntity) {
        super.saveEntity(roleEntity);
    }

    @Override
    public List<RoleEntity> getAll(String roleEntityName) {
        return (super.getAllEntity(roleEntityName));
    }

    @Override
    public List<RoleEntity> getAllUsingHQL(String hql) {
        List list = session
                .createQuery(hql, RoleEntity.class)
                .list();
        HibernateUtils.closeSession();
        return list;
    }
}
