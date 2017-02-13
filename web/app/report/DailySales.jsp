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
        List<Object[]> List = (List<Object[]>) request.getAttribute("dailysales");
    %>
    <div class="row">

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Sales Report<small>up to now</small></h2>
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
                                    <th>Category</th>
                                    <th>Qty</th>
                                    <th>Price</th>
                                    <th>Transport</th>
                                    <th>Total</th>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%      
                                    Double transport=0.0;
                                    Double price=0.0;
                                    Double qty=0.0;
                                    for (Object[] c : List) {
                                        transport+=Double.parseDouble(c[3].toString());
                                        qty+=Double.parseDouble(c[1].toString());
                                        price+=Double.parseDouble(c[2].toString());
                                %>
                                <tr>
                                    <td><%=c[0]%></td>
                                    <td><%=c[1]%></td>
                                    <td><%=c[2]%></td>
                                    <td><%=c[3]%></td>
                                    <td><%=Double.parseDouble(c[1].toString())*Double.parseDouble(c[2].toString())%></td>
                                    
                                </tr>
                                
                                <%}%>
                                <tr>
                                    <td class=""><strong>Total</strong></td>
                                    <td class=""><strong><%=qty%></strong></td>
                                    <td class=""><strong><%=price%></strong></td>
                                    <td class=""><strong><%=transport%></strong></td>
                                    <td class=""><strong><%=(qty*price)%></strong></td>
                                    
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
