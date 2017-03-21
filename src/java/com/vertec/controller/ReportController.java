/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.controller;

import com.vertec.daoimpl.RegistrationDAOImpl;
import com.vertec.daoimpl.ReportDAOImpl;
import com.vertec.hibe.model.Customer;
import com.vertec.hibe.model.InvoiceInfo;
import com.vertec.hibe.model.SysUser;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author vertec-r
 */
@WebServlet(name = "ReportController", urlPatterns = {"/ReportController"})
public class ReportController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final ReportDAOImpl reportdao = new ReportDAOImpl();
    private final RegistrationDAOImpl registrationdao = new RegistrationDAOImpl();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String action = request.getParameter("action");
            HttpSession httpSession = request.getSession();
            SysUser user1 = (SysUser) httpSession.getAttribute("user");
            RequestDispatcher requestDispatcher;

            switch (action) {
                //Open Search Daily sales Page
                case "SearchDailySales": {
                    requestDispatcher = request.getRequestDispatcher("app/report/SearchDailySales.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Open Daily Sales Report
                case "DailySales": {
                    String from = request.getParameter("from").trim();
                    String to = request.getParameter("to").trim();
                    List<Object[]> list=reportdao.getDailySales(from, to);
                    request.setAttribute("dailysales", list);
                    requestDispatcher = request.getRequestDispatcher("app/report/DailySales.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Open Search daily collection Page
                case "CreditorPurchaseHistory": {
                    List<Customer> customer = registrationdao.getListOfCustomer();
                    request.setAttribute("customer", customer);
                    requestDispatcher = request.getRequestDispatcher("app/report/SearchDailyCollection.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Open Daily Collection Page
                case "cphistory": {
                    String from = request.getParameter("from").trim();
                    String to = request.getParameter("to").trim();
                    String customer = request.getParameter("customer").trim();
                    List<Object[]> list=reportdao.getDailyCollection(from, to,Integer.parseInt(customer));
                    request.setAttribute("dailycollection", list);
                    requestDispatcher = request.getRequestDispatcher("app/report/DailyCollection.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "SearchDailySummery": {
                    requestDispatcher = request.getRequestDispatcher("app/report/SearchDailySummery.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                case "DailySummery": {
                    String date = request.getParameter("date").trim();
                    List<InvoiceInfo> list=reportdao.getDailySummery(date);
                    request.setAttribute("dailycollection", list);
                    request.setAttribute("date", date);
                    requestDispatcher = request.getRequestDispatcher("app/report/DailySummery.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                
            }
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
