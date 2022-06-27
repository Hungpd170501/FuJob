package se1621.utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author is wrong
 */
public class HibernateUtils {
    private static final ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();
    private static SessionFactory factory = null;

    static {
        factory = new Configuration().configure().buildSessionFactory();
    }

    public static Session getSession() {
        Session session = null;
        if (threadLocal.get() == null) {
            session = factory.openSession();
            threadLocal.set(session);
        } else {
            session = threadLocal.get();
        }
        return session;
    }
    public static void closeSession(){
        Session session =null;
        if(threadLocal.get()!=null){
            session=threadLocal.get();
            session.close();
            threadLocal.remove();
        }
    }
    public static void closeSessionFactory(){
        factory.close();
    }
}