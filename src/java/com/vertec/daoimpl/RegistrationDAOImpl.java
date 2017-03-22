/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.daoimpl;

import com.vertec.hibe.model.Category;
import com.vertec.hibe.model.Customer;
import com.vertec.hibe.model.SecurityOfficer;
import com.vertec.hibe.model.Supervisor;
import com.vertec.util.NewHibernateUtil;
import com.vertec.util.VertecConstants;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author User
 */
public class RegistrationDAOImpl {
 
//    Category Methods Start
    
    public String saveCategory(Category service) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                session.save(service);
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

    public List<Category> getListOfCategory() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT c FROM Category c WHERE c.isValid=:isValid");
                query.setParameter("isValid", true);
                List<Category> csList = query.list();

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

    public Category viewCategory(int catId) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.getNamedQuery("Category.findById");
                query.setParameter("id", catId);

                Category user = (Category) query.uniqueResult();
                return user;

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

    public String updateCategory(Category service) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Category c set c.name=:name,c.price=:price where c.id=:Id");
                query.setParameter("name", service.getName());
                query.setParameter("price", service.getPrice());
                query.setParameter("Id", service.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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

    
    public String removeCategory(int catId) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                Query query = session.createQuery("Update Category c set c.isValid=:is_valid where c.id=:catId");
                query.setParameter("catId", catId);
                query.setParameter("is_valid", false);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;

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

//    Category Methods End
    
    
    
    
    
    
//    Customer Methods Start
    
    public String saveCustomer(Customer customer) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {

            try {
                session.save(customer);
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

    public List<Customer> getListOfCustomer() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT c FROM Customer c WHERE c.isValid=:isValid ORDER BY c.name ASC");
                query.setParameter("isValid", true);
                List<Customer> csList = query.list();

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

    public Customer viewCustomer(int cusId) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        if (session != null) {
            try {
                Query query = session.getNamedQuery("Customer.findById");
                query.setParameter("id", cusId);
                Customer user = (Customer) query.uniqueResult();
                return user;
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

    public String updateCustomer(Customer customer) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Customer c set c.name=:name,c.address=:address,c.contactNo=:contact,c.email=:email where c.id=:Id");
                query.setParameter("name", customer.getName());
                query.setParameter("address", customer.getAddress());
                query.setParameter("contact", customer.getContactNo());
                query.setParameter("email", customer.getEmail());
                query.setParameter("Id", customer.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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

    
    public String removeCustomer(int cusId) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                Query query = session.createQuery("Update Customer c set c.isValid=:is_valid where c.id=:cusId");
                query.setParameter("cusId", cusId);
                query.setParameter("is_valid", false);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;

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

//    Category Methods End
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    Supervisor Start
    
    public String saveSupervisor(Supervisor Supervisor) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {

            try {
                session.save(Supervisor);
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

    public List<Supervisor> getListOfSupervisor() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT s FROM Supervisor s WHERE s.isValid=:isValid");
                query.setParameter("isValid", true);
                List<Supervisor> csList = query.list();

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

    public Supervisor viewSupervisor(int supervisorId) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.getNamedQuery("Supervisor.findById");
                query.setParameter("id", supervisorId);

                Supervisor user = (Supervisor) query.uniqueResult();
                return user;

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

    public String updateSupervisor(Supervisor supervisor) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Supervisor s set s.name=:name where s.id=:Id");
                query.setParameter("name", supervisor.getName());
                query.setParameter("Id", supervisor.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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

    
    public String removeSupervisor(int catId) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                Query query = session.createQuery("Update Supervisor c set c.isValid=:is_valid where c.id=:catId");
                query.setParameter("catId", catId);
                query.setParameter("is_valid", false);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;

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

//    Category Methods End
    
    
    
    
    
    
    
    
    
    
    
//    Category Methods Start
    
    public String saveSecurityOfficer(SecurityOfficer service) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {

            try {
                session.save(service);
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

    public List<SecurityOfficer> getListOfSecurityOfficer() {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.createQuery("SELECT c FROM SecurityOfficer c WHERE c.isValid=:isValid");
                query.setParameter("isValid", true);
                List<SecurityOfficer> csList = query.list();

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

    public SecurityOfficer viewSecurityOfficer(int catId) {

        Session session = NewHibernateUtil.getSessionFactory().openSession();

        if (session != null) {
            try {
                Query query = session.getNamedQuery("SecurityOfficer.findById");
                query.setParameter("id", catId);

                SecurityOfficer user = (SecurityOfficer) query.uniqueResult();
                return user;

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

    public String updateSecurityOfficer(SecurityOfficer service) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update SecurityOfficer c set c.name=:name where c.id=:Id");
                query.setParameter("name", service.getName());
                query.setParameter("Id", service.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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

    
    public String removeSecurityOfficer(int catId) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        if (session != null) {
            try {
                Query query = session.createQuery("Update SecurityOfficer c set c.isValid=:is_valid where c.id=:catId");
                query.setParameter("catId", catId);
                query.setParameter("is_valid", false);
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;

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

//    Category Methods End
    
    
    
    
    
    
    
    public String CustomerDeposit(Customer c,double amount) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Customer c set c.balance=c.balance+:amount where c.id=:customer");
                query.setParameter("amount", amount);
                query.setParameter("customer", c.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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
    
     public String CustomerWithdraw(Customer c,double amount) {
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        if (session != null) {
            try {
                Query query = session.createQuery("Update Customer c set c.balance=c.balance-:amount where c.id=:customer");
                query.setParameter("amount", amount);
                query.setParameter("customer", c.getId());
                query.executeUpdate();
                transaction.commit();
                return VertecConstants.UPDATED;
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
}
