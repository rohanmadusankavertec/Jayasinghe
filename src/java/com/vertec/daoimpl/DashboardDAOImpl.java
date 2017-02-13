/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.vertec.daoimpl;

import com.vertec.util.NewHibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author vertec-r
 */
public class DashboardDAOImpl {
    public String getEmployees() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(e.id) FROM Employee e WHERE e.isValid=:isValid");
                query.setParameter("isValid", true);
                long emcount =(long) query.uniqueResult();
                
                return emcount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getCustomers() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM Customer c WHERE c.isValid=:isValid");
                query.setParameter("isValid", true);
                long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getPackages() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM Package c WHERE c.isValid=:isValid");
                query.setParameter("isValid", true);
                long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getServices() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM Service c WHERE c.isValid=:isValid");
                query.setParameter("isValid", true);
                long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     
     
     
     
     public String getCompletedProject() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM ProjectDetails c WHERE c.statusId.status='complete'");
                long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getincompletedProject() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM ProjectDetails c WHERE c.statusId.status!='complete'");
                 long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getHoldProject() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM ProjectDetails c WHERE c.statusId.status='hold'");
               long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
     public String getOngoingProject() {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("SELECT COUNT(c.id) FROM ProjectDetails c WHERE c.statusId.status='continue'");
               long cucount =(long) query.uniqueResult();
                
                return cucount+"";

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "0";
    }
}
