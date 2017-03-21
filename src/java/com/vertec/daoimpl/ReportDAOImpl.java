/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.daoimpl;

import com.vertec.util.NewHibernateUtil;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author vertec-r
 */
public class ReportDAOImpl {

    public List<Object[]> getDailySales(String From, String To) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {

                SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

                Date fromDate = null;
                Date toDate = null;
                try {
                    fromDate = date.parse(From);
                    toDate = date.parse(To);
                } catch (java.text.ParseException ex) {
                    ex.printStackTrace();
                }

                Query query = session.createSQLQuery("SELECT c.name,SUM(i.cubes),c.price,SUM(i.transport) FROM invoice i INNER JOIN invoice_info ii ON i.invoice_info_id=ii.id INNER JOIN category c ON c.id=i.category_id WHERE ii.is_valid=:isValid AND ii.date BETWEEN :from AND :to ORDER BY i.category_id");
                query.setParameter("isValid", true);
                query.setParameter("from", fromDate);
                query.setParameter("to", toDate);
                List<Object[]> csList = query.list();

                return csList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;

    }
    
    
    
    
    public List<Object[]> getDailyCollection(String From, String To) {
        System.out.println("callint methord.........");
        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {

                SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

                Date fromDate = null;
                Date toDate = null;
                try {
                    fromDate = date.parse(From);
                    toDate = date.parse(To);
                } catch (java.text.ParseException ex) {
                    ex.printStackTrace();
                }
                System.out.println("callint methord........."+fromDate);
                System.out.println("callint methord........."+toDate);
                Query query = session.createSQLQuery("SELECT c.name,ii.total,ii.outstanding FROM invoice_info ii INNER JOIN customer c ON c.id=ii.customer_id INNER JOIN payment p ON p.invoice_info_id=ii.id WHERE ii.is_valid=:isValid AND p.is_valid=:isValid AND ii.date BETWEEN :from AND :to GROUP BY ii.id");
                query.setParameter("isValid", true);
                query.setParameter("from", fromDate);
                query.setParameter("to", toDate);
                List<Object[]> csList = query.list();
                for (Object[] o : csList) {
                    System.out.println(o[0].toString()+","+o[1].toString()+","+o[2].toString());
                }

                return csList;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;

    }
}
