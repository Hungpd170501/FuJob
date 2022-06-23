package se1621.utils;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.cfg.Configuration;
import org.hibernate.SessionFactory;

/**
* Hibernate Utility class with a convenient method to get Session Factory
* object.
*
* @author is wrong
*/
public class HibernateUtils {

//    private static final SessionFactory sessionFactory;
//    
//    static {
//        try {
//            sessionFactory = new Configuration().configure().buildSessionFactory();
//        } catch (HibernateException ex) {
//            throw new ExceptionInInitializerError(ex);
//        }
//    }
//    
//    public static SessionFactory getSessionFactory() {
//        return sessionFactory;
//    }
    private static ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();
    private static SessionFactory factory=null;
    static{
        factory = new Configuration().configure().buildSessionFactory();
    }
    public static Session getSession(){
        Session session=null;
        if(threadLocal.get()==null){
            session=factory.openSession();
            threadLocal.set(session);
        }else{
            session=threadLocal.get();
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
    public static void main(String[] args) {
        System.out.println(HibernateUtils.getSession());
    }
}
