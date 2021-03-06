<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.vertec.hibe.model.InvoiceItems"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vertec.daoimpl.InvoiceDAOImpl"%>
<%@page import="com.vertec.hibe.model.InvoiceInfo"%>
<%@page import="com.vertec.hibe.model.Invoice"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice</title>
        <style type="text/css">
            @media print {
                html, body {
                    display: block; 
                    font-family: "Calibri";
                    margin: 0;
                    size: 21.59cm 13.97cm ;
                    size: portrait;
                }
                @page {
                    size: 21.59cm 13.97cm ;
                    size: portrait;
                }
                body{ background-color:#FFFFFF; background-image:none; color:#000000 }
                #ad{ display:none;}
                #leftbar{ display:none;}
                #contentarea{ width:100%;}
            }
        </style>
        <script type="text/javascript">
            function printthis() {
                window.print();
                window.onfocus = function () {
                    window.close();
                };
            }
        </script>


    </head>
    <body onload="printthis();">

        <%
            String id = request.getParameter("id");
            List<Invoice> invoiceList = new InvoiceDAOImpl().getInvoiceById(Integer.parseInt(id));
            InvoiceInfo iin = new InvoiceDAOImpl().getInvoiceInfoById(Integer.parseInt(id));
            Double tot = 0.0;
            List<InvoiceItems> ii = new ArrayList<InvoiceItems>();
            for (Invoice invoice : invoiceList) {
                InvoiceItems i = new InvoiceItems();
                i.setCategory(invoice.getCategoryId().getName());
//                System.out.println("calling");
                i.setPrice(invoice.getCategoryId().getPrice());
                i.setQty(invoice.getCubes());
                i.setTransport(invoice.getTransport());
                i.setTotal((invoice.getCubes() * invoice.getCategoryId().getPrice()) + invoice.getTransport());
                ii.add(i);
                tot += ((invoice.getCubes() * invoice.getCategoryId().getPrice()) + invoice.getTransport());
            }

            DecimalFormat dFormat = new DecimalFormat("####,###,###.00");
        %>



    <center>
        <h2>JAYASINGHE CONSTRUCTION (PVT)LTD.</h2>

        <table style="border: 1px solid #000;">
            <tr>
                <td>DELIVERY NOTE / INVOICE</td>
            </tr>
        </table>
        <div style="font-size: 13px;">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>Date</td>
                                <td>:</td>
                                <td><%=iin.getDate()%></td>
                            </tr>
                            <tr>
                                <td>Customer</td>
                                <td>:</td>
                                <%if (iin.getCustomerId() != null) {%>
                                <td><%=iin.getCustomerId().getName()%></td>
                                <%} else {%>
                                <td></td>
                                <%}%>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td>:</td>
                                <%if (iin.getCustomerId() != null) {%>
                                <td><%=iin.getCustomerId().getAddress()%></td>
                                <%} else {%>
                                <td></td>
                                <%}%>
                            </tr>
                            <tr>
                                <td>Contact No</td>
                                <td>:</td>
                                <%if (iin.getCustomerId() != null) {%>
                                <td><%=iin.getCustomerId().getContactNo()%></td>
                                <%} else {%>
                                <td></td>
                                <%}%>
                            </tr>
                            <tr>
                                <td>Vehicle No</td>
                                <td>:</td>
                                <td><%=iin.getVehicleNo()%></td>
                            </tr>
                        </table>

                    </td>
                    <td>
                <center>
                    (Delivery by vehicle)<br>
                    Halawatha Road,<br>
                    Girathalana,<br>
                    Hettipola.<br>
                    037 - 4941301<br>
                    077 - 4786361<br>
                    <strong> Invoice No : <%=iin.getId()%></strong>    
                </center>
                </td>
                </tr>
            </table>
            <table style="border: 1px solid #000; width: 100%; margin-top: 5px;">
                <tr>
                    <td>
                        Vehicle's width : <%=iin.getVWidth()%>inches height : <%=iin.getVHeight()%>inches depth : <%=iin.getVLong()%>inches
                    </td>
                </tr>
            </table>
            <div style="height: 100px;">
                <table style="width: 100%; margin-top: 5px;border:1px solid #000 ;border-collapse: collapse;">

                    <tr style="border: 1px solid black;">
                        <th style="height: 15px;border: 1px solid black;padding: 10px;">Stone Category</th>
                        <th style="height: 15px;border: 1px solid black;padding: 10px;">Number of cubic feet</th>
                        <th style="height: 15px;border: 1px solid black;padding: 10px;">Price</th>
                        <th style="height: 15px;border: 1px solid black;padding: 10px;">Transport</th>
                        <th style="height: 15px;border: 1px solid black;padding: 10px;">Total</th>
                    </tr>
                    <%
                        for (Invoice invoice : invoiceList) {
                    %>
                    <tr style="text-align: center; height: 15px;">
                        <td><%=invoice.getCategoryId().getName()%></td>
                        <td><%=invoice.getCubes()%></td>
                        <td><%=dFormat.format(invoice.getCategoryId().getPrice())%></td>
                        <td><%=dFormat.format(invoice.getTransport())%></td>
                        <td><%=dFormat.format(((invoice.getCubes() * invoice.getCategoryId().getPrice()) / 100) + invoice.getTransport())%></td>
                    </tr>
                    <%}%>
                </table>
            </div>


            <table style="border: 1px solid #000; width: 100%; margin-top: 5px;">
                <tr>
                    <td>
                        <span >Total : Rs:<%=dFormat.format(iin.getTotal())%></span> <span style="margin-left: 150px;"> Payment : Rs:<%=dFormat.format(iin.getTotal() - iin.getOutstanding())%></span> <span style="margin-left: 150px;"> Outstanding : Rs:<%=dFormat.format(iin.getOutstanding())%></span>
                    </td>
                </tr>
            </table>



            <table style="width: 100%; margin-top: 5px;">
                <tr>
                    <td>


                        <table>
                            <tr style="height: 20px;">
                                <td>Arrive Time</td>
                                <td>:</td>
                                <td><%=iin.getIntime()%></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Loaded Time </td>
                                <td>:</td>
                                <td><%=iin.getLoadtime()%></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Driver's sign</td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Other</td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                        </table>







                    </td>
                    <td>


                        <table>
                            <tr style="height: 20px;">
                                <td>Supervisor</td>
                                <td>:</td>
                                <td><%

                                    if (iin.getSupervisorId() != null) {
                                        out.write(iin.getSupervisorId().getName());
                                    }
                                    %></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Sign </td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Receiver</td>
                                <td>:</td>
                                <td><%=iin.getReceiver()%></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Sign</td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                        </table>



                    </td>
                    <td>



                        <table>
                            <tr style="height: 20px;">
                                <td>Sec. Off.</td>
                                <td>:</td>
                                <td><%
                                    if (iin.getSecurityOfficerId() != null) {
                                        out.write(iin.getSecurityOfficerId().getName());
                                    }
                                    %></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Sign </td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>Time</td>
                                <td>:</td>
                                <td>.........................</td>
                            </tr>
                            <tr style="height: 20px;">
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>    

        </div>

    </center>
















</body>
</html>
