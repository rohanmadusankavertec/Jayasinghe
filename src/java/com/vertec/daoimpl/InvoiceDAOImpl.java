/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.daoimpl;


import com.vertec.hibe.model.Invoice;
import com.vertec.hibe.model.InvoiceInfo;
import com.vertec.hibe.model.Payment;
import com.vertec.hibe.model.PaymentType;
import com.vertec.util.NewHibernateUtil;
import com.vertec.util.VertecConstants;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author vertec-r
 */
public class InvoiceDAOImpl {
   public String saveInvoice(InvoiceInfo invoice) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {

            try {
                session.save(invoice);
                session.flush();

                transaction.commit();
                return VertecConstants.SUCCESS;

            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;

            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }

        return null;

    }
   public String savePayment(Payment payment) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                session.save(payment);
                session.flush();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   public String savePaymentType(PaymentType payment) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                session.save(payment);
                session.flush();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   
   
   public List<InvoiceInfo> getListOfInvoiceInfo() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT i FROM InvoiceInfo i WHERE i.isValid=:isValid");
                query.setParameter("isValid", true);
                List<InvoiceInfo> inList = query.list();
                
                return inList;

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
   public List<Payment> getListOfCheques() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT p FROM Payment p WHERE p.isValid=:isValid");
                query.setParameter("isValid", false);
                List<Payment> inList = query.list();
                
                return inList;

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
   
   public List<Invoice> getInvoiceById(int id) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT i FROM Invoice i WHERE i.invoiceInfoId.id=:id");
                query.setParameter("id", id);
                List<Invoice> inList = query.list();
                return inList;

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
   
   public int getLastInvoice() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT MAX(i.id) FROM InvoiceInfo i");
                Integer iid = (Integer) query.uniqueResult();
                System.out.println("IDDDDDDDDDDDDDDDDDDDDDDDDDDDDD "+iid);
                return iid;

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return 0;

    }
      public InvoiceInfo getInvoiceInfoById(int id) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT i FROM InvoiceInfo i WHERE i.id=:id");
                query.setParameter("id", id);
                InvoiceInfo inList = (InvoiceInfo) query.uniqueResult();
                return inList;

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
   
   public Payment getPaymentById(int id) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                
                Query query = session.getNamedQuery("Payment.findById");
                query.setParameter("id", id);
                Payment inList = (Payment) query.uniqueResult();
                
                return inList;

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
   
   public List<InvoiceInfo> getListOfOutstandingInvoiceInfo() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                
                Query query = session.createQuery("SELECT i FROM InvoiceInfo i WHERE i.isValid=:isValid AND i.outstanding>0");
                query.setParameter("isValid", true);
                List<InvoiceInfo> inList = query.list();
                
                return inList;

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
   
   public String DeleteInvoice(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update InvoiceInfo i set i.isValid=:isValid where i.id=:Id");
                query.setParameter("Id", Integer.parseInt(id));
                query.setParameter("isValid", false);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   
   
   public String UpdateInvoice(Payment p) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update InvoiceInfo ii set ii.outstanding=ii.outstanding-:payment where ii.id=:Id");
                query.setParameter("Id", p.getInvoiceInfoId().getId());
                query.setParameter("payment", p.getAmount());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   public String ClearCheque(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Payment i set i.isValid=:isValid where i.id=:Id");
                query.setParameter("Id", Integer.parseInt(id));
                query.setParameter("isValid", true);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   public String DeletePayment(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("DELETE FROM Payment p where p.id=:Id");
                query.setParameter("Id", Integer.parseInt(id));
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
   public String UpdateOutstanding(double payment,int id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update InvoiceInfo i set i.outstanding=i.outstanding-:payment where i.id=:Id");
                query.setParameter("Id", id);
                query.setParameter("payment", payment);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.SUCCESS;
            } catch (Exception e) {
                e.printStackTrace();
                return VertecConstants.ERROR;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return null;
    }
  
   public List<Object[]> loadPaymentData(int coId) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                String hql = "SELECT ii.total,ii.outstanding FROM invoice_info ii WHERE ii.id='" + coId + "'";

                SQLQuery query = session.createSQLQuery(hql);
                List<Object[]> inList = query.list();
                return inList;

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
   public String getVehicle(String id) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.createQuery("Select i from InvoiceInfo i where i.vehicleNo=:vno");
                query.setParameter("vno", id);
                query.setMaxResults(1);
                
                InvoiceInfo invoice = (InvoiceInfo) query.uniqueResult();
                if(invoice!=null){
                return invoice.getVWidth()+"~"+invoice.getVHeight()+"~"+invoice.getVLong();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
        return "";
    }
   public List<Payment> getListOfPayments(int id) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                String hql="SELECT p FROM Payment p WHERE p.isValid=:isvalid";
                if(id!=0){
                hql+=" AND p.invoiceInfoId.customerId.id=:id";
                }
                
                Query query = session.createQuery(hql);
                if(id!=0){
                query.setParameter("id", id);
                }
                query.setParameter("isvalid", true);
                List<Payment> inList = query.list();
                
                return inList;

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
