<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.hibe.model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>

<div class="">
    <div class="clearfix"></div>
    <%
        List<Object[]> List = (List<Object[]>) request.getAttribute("dailycollection");
    %>
    <div class="row">

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Creditors' Purchase History<small>up to now</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="table-responsive">
                        <table id="example" class="table table-striped responsive-utilities jambo_table">
                            <thead>
                                <tr class="headings">
                                    <th>Customer</th>
                                    <th>Invoice Amount</th>
                                    <th>Paid Amount</th>
                                    <th>Outstanding</th>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%      
                                    Double total=0.0;
                                    Double outstanding=0.0;
                                    Double paid=0.0;
                                    for (Object[] c : List) {
                                        total+=Double.parseDouble(c[1].toString());
                                        outstanding+=Double.parseDouble(c[2].toString());
                                        paid+=Double.parseDouble(c[1].toString())-Double.parseDouble(c[2].toString());
                                %>
                                <tr>
                                    <td><%=c[0]%></td>
                                    <td><%=c[1]%></td>
                                    <td><%=(Double.parseDouble(c[1].toString())-Double.parseDouble(c[2].toString()))%></td>
                                    <td><%=c[2]%></td>
                                    
                                    
                                </tr>
                                
                                <%}%>
                                <tr>
                                    <td class=""><strong>Total</strong></td>
                                    <td class=""><strong><%=total%></strong></td>
                                    <td class=""><strong><%=paid%></strong></td>
                                    <td class=""><strong><%=outstanding%></strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../template/footer.jsp"%>
