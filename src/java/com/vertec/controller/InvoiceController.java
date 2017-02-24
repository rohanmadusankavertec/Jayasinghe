/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.controller;

import com.vertec.daoimpl.InvoiceDAOImpl;
import com.vertec.daoimpl.RegistrationDAOImpl;
import com.vertec.hibe.model.Category;
import com.vertec.hibe.model.Customer;
import com.vertec.hibe.model.Invoice;
import com.vertec.hibe.model.InvoiceInfo;
import com.vertec.hibe.model.InvoiceItems;
import com.vertec.hibe.model.Payment;
import com.vertec.hibe.model.PaymentType;
import com.vertec.hibe.model.SecurityOfficer;
import com.vertec.hibe.model.Supervisor;
import com.vertec.hibe.model.SysUser;
import com.vertec.util.VertecConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author vertec-r
 */
@WebServlet(name = "InvoiceController", urlPatterns = {"/InvoiceController"})
public class InvoiceController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final InvoiceDAOImpl invoicedao = new InvoiceDAOImpl();
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

                //Open Create invoice page
                case "ToCreateInvoice": {
                    List<Customer> customer = registrationdao.getListOfCustomer();
                    request.setAttribute("customer", customer);
                    List<Supervisor> supervisor = registrationdao.getListOfSupervisor();
                    request.setAttribute("supervisor", supervisor);
                    List<SecurityOfficer> security = registrationdao.getListOfSecurityOfficer();
                    request.setAttribute("securityofficer", security);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/CreateInvoice.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Open Invoice Page
                case "ToInvoice": {
                    String qty = request.getParameter("qty").trim();
                    String loadType = request.getParameter("load").trim();
//                    System.out.println("......"+loadType);
                    String customer = request.getParameter("customer");
                    String vehicleNo = request.getParameter("vehicleNo").trim();
                    String v_width = request.getParameter("width").trim();
                    String v_long = request.getParameter("long").trim();
                    String v_height = request.getParameter("height").trim();
                    String Reached = request.getParameter("Reached").trim();
                    String Loaded = request.getParameter("Loaded").trim();
                    String Name = request.getParameter("Name").trim();
                    String supervisor = request.getParameter("supervisor").trim();
                    String securityOfficer = request.getParameter("securityOfficer").trim();
                    List<Category> category = registrationdao.getListOfCategory();
                    request.setAttribute("category", category);
                    Customer cus = null;
                    if (customer != null) {
                        cus = registrationdao.viewCustomer(Integer.parseInt(customer));
                    }
                    request.setAttribute("qty", qty);
                    request.setAttribute("customer", cus);
                    request.setAttribute("vehicleNo", vehicleNo);
                    request.setAttribute("width", v_width);
                    request.setAttribute("long", v_long);
                    request.setAttribute("height", v_height);
                    request.setAttribute("reached", Reached);
                    request.setAttribute("loaded", Loaded);
                    request.setAttribute("name", Name);
                    request.setAttribute("supervisor", supervisor);
                    request.setAttribute("securityofficer", securityOfficer);

                    requestDispatcher = request.getRequestDispatcher("app/invoice/Invoice.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }

                //Save Invoice 
                case "SubmitInvoice": {
                    System.out.println("Submit Invoice Method..");
                    String data = request.getParameter("data");
                    
                    System.out.println(data);
                    JSONParser parser = new JSONParser();

                    JSONObject jSONObject = null;
                    try {
                        Object obj = parser.parse(data);
                        jSONObject = (JSONObject) obj;

                    } catch (ParseException ex) {
                        Logger.getLogger(InvoiceController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    String vno = jSONObject.get("vno").toString();
                    String width = jSONObject.get("width").toString();
                    String vlong = jSONObject.get("vlong").toString();
                    String height = jSONObject.get("height").toString();
                    String reached = jSONObject.get("reached").toString();
                    String loaded = jSONObject.get("loaded").toString();
                    String name = jSONObject.get("name").toString();
                    String supervisor = jSONObject.get("supervisor").toString();
                    String security = jSONObject.get("security").toString();
                    String customer = jSONObject.get("customer").toString();

                    String total = jSONObject.get("total").toString();
                    String chequeNo = jSONObject.get("chequeNo").toString();
                    String bankName = jSONObject.get("bankName").toString();
                    String chequeDate = jSONObject.get("chequeDate").toString();
                    String payment = jSONObject.get("payment").toString();
                    String outstanding = jSONObject.get("outstanding").toString();
                    String payType = jSONObject.get("payType").toString();

                    JSONObject itemDetails = (JSONObject) jSONObject.get("items");
                    Collection<Invoice> invoiceItemList = new ArrayList<>();
                    InvoiceInfo invoiceinfo = new InvoiceInfo();
                    for (Iterator iterator = itemDetails.keySet().iterator(); iterator.hasNext();) {
                        String key = (String) iterator.next();
                        JSONObject jSONObject1 = (JSONObject) itemDetails.get(key);
                        String qty = jSONObject1.get("qty").toString();
                        String transport = jSONObject1.get("transport").toString();
                        Invoice invoice = new Invoice();
                        invoice.setCategoryId(new Category(Integer.parseInt(key)));
                        invoice.setCubes(Double.parseDouble(qty));
                        invoice.setTransport(Double.parseDouble(transport));
                        invoice.setInvoiceInfoId(invoiceinfo);
                        invoiceItemList.add(invoice);
                    }

                    invoiceinfo.setInvoiceCollection(invoiceItemList);
                    invoiceinfo.setAddedBy(user1);
                    invoiceinfo.setDate(new Date());
                    invoiceinfo.setVHeight(Double.parseDouble(height));
                    invoiceinfo.setVLong(Double.parseDouble(vlong));
                    invoiceinfo.setVWidth(Double.parseDouble(width));
                    invoiceinfo.setVehicleNo(vno);
                    invoiceinfo.setSupervisorId(new Supervisor(Integer.parseInt(supervisor)));
                    invoiceinfo.setSecurityOfficerId(new SecurityOfficer(Integer.parseInt(security)));
                    invoiceinfo.setReceiver(name);
                    System.out.println(customer);
                    if (!customer.equals("")) {
                        int Customer = Integer.parseInt(customer);
                        invoiceinfo.setCustomerId(new Customer(Customer));
                    } else {
                        invoiceinfo.setCustomerId(null);
                    }

                    SimpleDateFormat TimeFormat = new SimpleDateFormat("hh:mm"); //if 24 hour format
                    Date reachedTime = null;
                    Date loadedTime = null;
                    try {
                        reachedTime = TimeFormat.parse(reached);
                        loadedTime = TimeFormat.parse(loaded);
                    } catch (java.text.ParseException ex) {
                        ex.printStackTrace();
                    }
                    invoiceinfo.setTotal(Double.parseDouble(total));
                    invoiceinfo.setOutstanding(Double.parseDouble(outstanding));
                    invoiceinfo.setIntime(reachedTime);
                    invoiceinfo.setLoadtime(loadedTime);
                    invoiceinfo.setIsValid(true);

                    Payment pay = new Payment();
                    pay.setAddedBy(user1);
                    pay.setAmount(Double.parseDouble(payment));

                    pay.setDate(new Date());
                    pay.setInvoiceInfoId(invoiceinfo);

                    if (payType.equals("1")) {
                        pay.setIsValid(true);
                        pay.setPaymentTypeId(new PaymentType(1));
                    } else {
                        pay.setIsValid(false);
                        pay.setPaymentTypeId(new PaymentType(2));
                        pay.setBank(bankName);

                        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

                        Date chequedate = null;
                        if (chequeDate.equals("") || chequeDate == null) {
                        } else {
                            try {
                                chequedate = date.parse(chequeDate);
                            } catch (java.text.ParseException ex) {
                                ex.printStackTrace();
                            }
                        }
                        pay.setChequeDate(chequedate);
                        pay.setChequeNo(chequeNo);

                    }
                    String result1 = invoicedao.saveInvoice(invoiceinfo);
                    String result2 = invoicedao.savePayment(pay);
                    if (result1.equals(VertecConstants.SUCCESS) && result2.equals(VertecConstants.SUCCESS)) {
                        out.write(VertecConstants.SUCCESS);
                    } else {
                        out.write(VertecConstants.ERROR);
                    }
                    break;
                }
                //Open View Invoice Details Page
                case "ViewInvoice": {
                    List<InvoiceInfo> InvoiceInfo = invoicedao.getListOfInvoiceInfo();
                    request.setAttribute("InvoiceInfo", InvoiceInfo);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/ViewInvoice.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Delete Invoice by ID
                case "DeleteInvoice": {
                    String id = request.getParameter("id").trim();
                    String result = invoicedao.DeleteInvoice(id);
                    out.write(result);
                    break;
                }
                //View Payment Page
                case "ToPayment": {
                    System.out.println("To Print");
                    List<InvoiceInfo> invoice = invoicedao.getListOfOutstandingInvoiceInfo();
                    request.setAttribute("invoice", invoice);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/Payment.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Load Total and outstanding
                case "LoadPaymentData": {
                    String ciid = request.getParameter("iid");
                    int coId = 0;
                    if (ciid != null) {
                        coId = Integer.parseInt(ciid.trim());
                    }

                    List<Object[]> inList = invoicedao.loadPaymentData(coId);

                    JSONObject jOB = new JSONObject();
                    JSONArray jar1 = new JSONArray();
                    JSONObject job1 = null;

                    for (Object[] p : inList) {
                        job1 = new JSONObject();
                        System.out.println(p[0] + " " + p[1]);

                        job1.put("total", p[0].toString());
                        job1.put("outstanding", p[1].toString());
                        jar1.add(job1);
                    }
                    jOB.put("jArr1", jar1);
                    response.getWriter().write(jOB.toString());
                    break;
                }
                //Save Payment
                case "SavePayment": {
                    String id = request.getParameter("ino").trim();
                    String payType = request.getParameter("payType").trim();
                    String bank = request.getParameter("bank").trim();
                    String chdate = request.getParameter("chdate").trim();
                    String chno = request.getParameter("chno").trim();
                    String payment = request.getParameter("payment").trim();
                    String crn = request.getParameter("crn").trim();

                    String result2 = VertecConstants.SUCCESS;
                    Payment p = new Payment();
                    p.setCrn(crn);
                    p.setAddedBy(user1);
                    p.setAmount(Double.parseDouble(payment));
                    p.setDate(new Date());
                    p.setInvoiceInfoId(new InvoiceInfo(Integer.parseInt(id)));
                    if (payType.equals("1")) {
                        p.setIsValid(true);
                        p.setPaymentTypeId(new PaymentType(1));
                        p.setBank(null);
                        p.setChequeDate(null);
                        p.setChequeNo(null);
                        result2 = invoicedao.UpdateOutstanding(Double.parseDouble(payment), Integer.parseInt(id));
                    } else {
                        p.setIsValid(false);
                        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
                        Date chequedate = null;
                        try {
                            chequedate = date.parse(chdate);
                        } catch (java.text.ParseException ex) {
                            ex.printStackTrace();
                        }
                        p.setChequeDate(chequedate);
                        p.setChequeNo(chno);
                        p.setBank(bank);
                        p.setPaymentTypeId(new PaymentType(2));
                    }
                    String result = invoicedao.savePayment(p);
                    if (result.equals(VertecConstants.SUCCESS) && result2.equals(VertecConstants.SUCCESS)) {
                        out.write(VertecConstants.SUCCESS);
                    } else {
                        out.write(VertecConstants.ERROR);
                    }
                    break;
                }
                //Load View Cheque Page
                case "ViewCheques": {
                    List<Payment> pay = invoicedao.getListOfCheques();
                    request.setAttribute("payment", pay);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/Cheques.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Delete Payment by id
                case "DeletePayment": {
                    String id = request.getParameter("id").trim();
                    String result = invoicedao.DeletePayment(id);
                    out.write(result);
                    break;
                }
                //Clear Cheque
                case "ClearCheque": {
                    String id = request.getParameter("id").trim();
                    Payment p = invoicedao.getPaymentById(Integer.parseInt(id));
                    String result1 = invoicedao.ClearCheque(id);
                    String result2 = invoicedao.UpdateInvoice(p);
                    if (result1.equals(VertecConstants.SUCCESS) && result2.equals(VertecConstants.SUCCESS)) {
                        out.write(VertecConstants.SUCCESS);
                    } else {
                        out.write(VertecConstants.ERROR);
                    }
                    break;
                }
                //Open Print view by id
                case "PrintInvoice": {
                    String id = request.getParameter("id").trim();
                    List<Invoice> invoices = invoicedao.getInvoiceById(Integer.parseInt(id));
                    InvoiceInfo invoiceinfo = invoicedao.getInvoiceInfoById(Integer.parseInt(id));

                    request.setAttribute("invoiceitems", invoices);
                    request.setAttribute("invoiceinfo", invoiceinfo);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/InvoicePrint.jsp");
                    requestDispatcher.forward(request, response);
                    break;
                }
                //Open print view ofs Last Invoice
                case "PrintLastInvoice": {
                    int id = invoicedao.getLastInvoice();
                    System.out.println(id + "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                    response.sendRedirect("app/invoice/InvoicePrint.jsp?id=" + id);
                    break;
                }
                //Load vehicle width, height , depth by id
                case "getVehicle": {
                    String id = request.getParameter("id").trim();
                    String result = invoicedao.getVehicle(id);
                    out.write(result);
                    break;
                }
                //Redirrect to invoice payment search page
                case "SearchPayment": {
                    List<Customer> customer = registrationdao.getListOfCustomer();
                    request.setAttribute("customer", customer);
                    requestDispatcher = request.getRequestDispatcher("app/invoice/InvoicePrint.jsp");
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
