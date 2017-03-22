/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.controller;

import com.vertec.daoimpl.RegistrationDAOImpl;
import com.vertec.hibe.model.Category;
import com.vertec.hibe.model.Customer;
import com.vertec.hibe.model.SecurityOfficer;
import com.vertec.hibe.model.Supervisor;
import com.vertec.hibe.model.SysUser;
import com.vertec.util.VertecConstants;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "RegistrationController", urlPatterns = {"/RegistrationController"})
public class RegistrationController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // private  final EmployeeDAOImpl employeedao = new EmployeeDAOImpl();
    private final RegistrationDAOImpl registrationdao = new RegistrationDAOImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession httpSession = request.getSession();
        SysUser user1 = (SysUser) httpSession.getAttribute("user");
        RequestDispatcher requestDispatcher;

        switch (action) {
//            Category Registration Start
//            Category Registration
            case "CategoryRegister": {
                String Name = request.getParameter("Name").trim();
                String Price = request.getParameter("Price").trim();
                Category c = new Category();
                c.setName(Name);
                c.setPrice(Double.parseDouble(Price));
                c.setIsValid(true);
                String result = registrationdao.saveCategory(c);
                if (result.equals(VertecConstants.SUCCESS)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Added");
                    response.sendRedirect("Registration?action=ViewCategory");
                } else {
                    request.getSession().removeAttribute("Error_Message");
                    request.getSession().setAttribute("Error_Message", "Not Added,Please Try again");
                    response.sendRedirect("app/service/registerService.jsp");
                }

                break;
            }
            //Load Category Registration Page
            case "ViewCategory": {
                List<Category> catList = registrationdao.getListOfCategory();
                request.setAttribute("category", catList);
                requestDispatcher = request.getRequestDispatcher("app/registration/registerCategory.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Load Update Category Page
            case "UpdateCategory": {
                String cId = request.getParameter("categoryId").trim();
                int cuId = Integer.parseInt(cId);
                Category category = registrationdao.viewCategory(cuId);
                request.setAttribute("service", category);
                requestDispatcher = request.getRequestDispatcher("app/registration/viewCategory.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Update Category
            case "UpdateCat": {
                String sId = request.getParameter("catId").trim();
                String Name = request.getParameter("Name").trim();
                String Price = request.getParameter("Price").trim();
                Category c = new Category();
                c.setId(Integer.parseInt(sId));
                c.setName(Name);
                c.setPrice(Double.parseDouble(Price));
                String result = registrationdao.updateCategory(c);
                if (result.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Updated");
                    response.sendRedirect("Registration?action=ViewCategory");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Updated,Please Try again");
                    response.sendRedirect("Registration?action=ViewCategory");
                }
                break;
            }
            //Delete Catogory using  category id
            case "RemoveCategory": {
                String userId = request.getParameter("categoryId").trim();
                int csId = Integer.parseInt(userId);
                String status = registrationdao.removeCategory(csId);
                if (status.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");

                    request.getSession().setAttribute("Success_Message", "Successfully Deleted");
                    response.sendRedirect("Registration?action=ViewCategory");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Deleted,Please Try again");
                    response.sendRedirect("Registration?action=ViewCategory");
                }
                break;
            }

//            Category Registration End
//            Customer Registration Start
            //Register a customer
            case "CustomerRegister": {
                String Name = request.getParameter("Name").trim();
                String Address = request.getParameter("Address").trim();
                String Contact = request.getParameter("Contact").trim();
                String Email = request.getParameter("Email").trim();
                Customer c = new Customer();
                c.setName(Name);
                c.setAddress(Address);
                c.setContactNo(Contact);
                c.setEmail(Email);
                c.setIsValid(true);
                c.setAddedBy(user1);
                c.setBalance(0.0);
                String result = registrationdao.saveCustomer(c);
                if (result.equals(VertecConstants.SUCCESS)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Added");
                    response.sendRedirect("Registration?action=ViewCustomer");
                } else {
                    request.getSession().removeAttribute("Error_Message");
                    request.getSession().setAttribute("Error_Message", "Not Added,Please Try again");
                    response.sendRedirect("Registration?action=ViewCustomer");
                }
                break;
            }
            //Open Customer Registration Page
            case "ViewCustomer": {
                List<Customer> catList = registrationdao.getListOfCustomer();
                request.setAttribute("customer", catList);
                requestDispatcher = request.getRequestDispatcher("app/registration/registerCustomer.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Open Update Customer Page
            case "UpdateCustomer": {
                String cId = request.getParameter("customerId").trim();
                int cuId = Integer.parseInt(cId);
                Customer category = registrationdao.viewCustomer(cuId);
                request.setAttribute("customer", category);
                requestDispatcher = request.getRequestDispatcher("app/registration/viewCustomer.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Update Customer Page
            case "UpdateCus": {
                String sId = request.getParameter("cusId").trim();
                String Name = request.getParameter("Name").trim();
                String Address = request.getParameter("Address").trim();
                String Contact = request.getParameter("Contact").trim();
                String Email = request.getParameter("Email").trim();
                Customer c = new Customer();
                c.setId(Integer.parseInt(sId));
                c.setName(Name);
                c.setAddress(Address);
                c.setContactNo(Contact);
                c.setEmail(Email);
                String result = registrationdao.updateCustomer(c);
                if (result.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Updated");
                    response.sendRedirect("Registration?action=ViewCustomer");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Updated,Please Try again");
                    response.sendRedirect("Registration?action=ViewCustomer");
                }
                break;
            }
            //remove customer by Id
            case "RemoveCustomer": {
                String userId = request.getParameter("customerId").trim();
                int csId = Integer.parseInt(userId);
                String status = registrationdao.removeCustomer(csId);
                if (status.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");

                    request.getSession().setAttribute("Success_Message", "Successfully Deleted");
                    response.sendRedirect("Registration?action=ViewCustomer");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Deleted,Please Try again");
                    response.sendRedirect("Registration?action=ViewCustomer");
                }
                break;
            }
//            Customer Registration End

            //            Supervisor Registration Start
            //Register a supervisor
            case "SupervisorRegister": {
                String Name = request.getParameter("Name").trim();
                Supervisor c = new Supervisor();
                c.setName(Name);
                c.setIsValid(true);
                String result = registrationdao.saveSupervisor(c);
                if (result.equals(VertecConstants.SUCCESS)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Added");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                } else {
                    request.getSession().removeAttribute("Error_Message");
                    request.getSession().setAttribute("Error_Message", "Not Added,Please Try again");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                }

                break;
            }
            //Open Supervisor registration page
            case "ViewSupervisor": {
                List<Supervisor> catList = registrationdao.getListOfSupervisor();
                request.setAttribute("supervisor", catList);
                requestDispatcher = request.getRequestDispatcher("app/registration/registerSupervisor.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Open Supervisor update page
            case "UpdateSupervisor": {
                String cId = request.getParameter("categoryId").trim();
                int cuId = Integer.parseInt(cId);
                Supervisor category = registrationdao.viewSupervisor(cuId);
                request.setAttribute("supervisor", category);
                requestDispatcher = request.getRequestDispatcher("app/registration/viewSupervisor.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Update supervisor page
            case "UpdateSup": {
                String sId = request.getParameter("supId").trim();
                String Name = request.getParameter("Name").trim();
                Supervisor c = new Supervisor();
                c.setId(Integer.parseInt(sId));
                c.setName(Name);
                String result = registrationdao.updateSupervisor(c);
                if (result.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Updated");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Updated,Please Try again");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                }
                break;
            }
            //Delete supervisor by id
            case "RemoveSupervisor": {
                String userId = request.getParameter("categoryId").trim();
                int csId = Integer.parseInt(userId);
                String status = registrationdao.removeSupervisor(csId);
                if (status.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");

                    request.getSession().setAttribute("Success_Message", "Successfully Deleted");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Deleted,Please Try again");
                    response.sendRedirect("Registration?action=ViewSupervisor");
                }
                break;
            }

//            Supervisor Registration End
            
            //            SecurityOfficer Registration Start
            //Security Officer Registration Page
            case "SecurityOfficerRegister": {
                String Name = request.getParameter("Name").trim();
                SecurityOfficer c = new SecurityOfficer();
                c.setName(Name);
                c.setIsValid(true);
                String result = registrationdao.saveSecurityOfficer(c);
                if (result.equals(VertecConstants.SUCCESS)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Added");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                } else {
                    request.getSession().removeAttribute("Error_Message");
                    request.getSession().setAttribute("Error_Message", "Not Added,Please Try again");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                }

                break;
            }
            // Open Security Officer registration Page
            case "ViewSecurityOfficer": {
                List<SecurityOfficer> catList = registrationdao.getListOfSecurityOfficer();
                request.setAttribute("securityofficer", catList);
                requestDispatcher = request.getRequestDispatcher("app/registration/registerSecurityOfficer.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Open Security Officer Update page
            case "UpdateSecurityOfficer": {
                String cId = request.getParameter("securityId").trim();
                int cuId = Integer.parseInt(cId);
                SecurityOfficer category = registrationdao.viewSecurityOfficer(cuId);
                request.setAttribute("securityofficer", category);
                requestDispatcher = request.getRequestDispatcher("app/registration/viewSecurityOfficer.jsp");
                requestDispatcher.forward(request, response);
                break;
            }
            //Update Security Officer 
            case "UpdateSec": {
                String sId = request.getParameter("secId").trim();
                String Name = request.getParameter("Name").trim();
                SecurityOfficer c = new SecurityOfficer();
                c.setId(Integer.parseInt(sId));
                c.setName(Name);
                String result = registrationdao.updateSecurityOfficer(c);
                if (result.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");
                    request.getSession().setAttribute("Success_Message", "Successfully Updated");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Updated,Please Try again");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                }
                break;
            }
            //Delete Security Officer 
            case "RemoveSecurityOfficer": {
                String userId = request.getParameter("securityId").trim();
                int csId = Integer.parseInt(userId);
                String status = registrationdao.removeSecurityOfficer(csId);
                if (status.equals(VertecConstants.UPDATED)) {
                    request.getSession().removeAttribute("Success_Message");

                    request.getSession().setAttribute("Success_Message", "Successfully Deleted");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                } else {
                    request.getSession().removeAttribute("Error_Message");

                    request.getSession().setAttribute("Error_Message", "Not Deleted,Please Try again");
                    response.sendRedirect("Registration?action=ViewSecurityOfficer");
                }
                break;
            }

//            Category Registration End
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
