/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Session;
import org.hibernate.Transaction;

@Getter
@Setter
public class HibernateDriver implements Serializable {

    private static final long serialVersionUID = 1L;
    private Session session;
    private Transaction transaction;

    public HibernateDriver() {
        session = HibernateUtil.getSessionFactory().openSession();
    }

    public void openSession() {
        session = HibernateUtil.getSessionFactory().openSession();
        setTransaction(getSession().beginTransaction());
    }

    public void closeSession() {
        session.close();
    }

    public void roleBack() {
        if (null != transaction) {
            transaction.rollback();
        }
    }
}
