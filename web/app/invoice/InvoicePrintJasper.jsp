<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>


<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.vertec.hibe.model.InvoiceItems"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vertec.daoimpl.InvoiceDAOImpl"%>
<%@page import="com.vertec.hibe.model.InvoiceInfo"%>
<%@page import="com.vertec.hibe.model.Invoice"%>
<%@page import="java.util.List"%>
<%@ page contentType="application/pdf" %>

<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            String id = request.getParameter("id");
//            String id="7";
            List<Invoice> invoiceList = new InvoiceDAOImpl().getInvoiceById(Integer.parseInt(id));
            InvoiceInfo iin = new InvoiceDAOImpl().getInvoiceInfoById(Integer.parseInt(id));
//                    
            Double tot = 0.0;
            List<InvoiceItems> ii = new ArrayList<InvoiceItems>();
            for (Invoice invoice : invoiceList) {
                InvoiceItems i = new InvoiceItems();
                i.setCategory(invoice.getCategoryId().getName());
                System.out.println("calling");
                i.setPrice(invoice.getCategoryId().getPrice());
                i.setQty(invoice.getCubes());
                i.setTransport(invoice.getTransport());
                i.setTotal((invoice.getCubes() * invoice.getCategoryId().getPrice()) + invoice.getTransport());
                ii.add(i);
                tot += ((invoice.getCubes() * invoice.getCategoryId().getPrice()) + invoice.getTransport());
            }

            Map parameters = new HashMap();
            parameters.put("id", iin.getId());
            parameters.put("date", iin.getDate());
            parameters.put("customer", iin.getCustomerId().getName());
            parameters.put("address", iin.getCustomerId().getAddress());
            parameters.put("contact", iin.getCustomerId().getContactNo());
            parameters.put("vehicle", iin.getVehicleNo());
            parameters.put("width", iin.getVWidth());
            parameters.put("height", iin.getVHeight());
            parameters.put("length", iin.getVLong());
            parameters.put("arrive", iin.getIntime());
            parameters.put("loaded", iin.getLoadtime());
            parameters.put("supervisor", iin.getSupervisorId().getName());
            parameters.put("security", iin.getSecurityOfficerId().getName());
            parameters.put("total", tot);

            try {
                //Parse details to jasper Report
                InputStream input = new FileInputStream(application.getRealPath("/app/invoice/Invoice.jasper"));

                JRBeanCollectionDataSource beanBurritoWrap = new JRBeanCollectionDataSource(ii);
                parameters.put("DataList", beanBurritoWrap);
                JasperPrint jasperPrint = JasperFillManager.fillReport(input, parameters, new JREmptyDataSource());

                JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (JRException e) {
                e.printStackTrace();

            } finally {
            }

        %>
    </body>
</html>
