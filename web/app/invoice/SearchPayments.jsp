<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.hibe.model.SecurityOfficer"%>
<%@page import="com.vertec.hibe.model.Supervisor"%>
<%@page import="com.vertec.hibe.model.Customer"%>
<%@page import="com.vertec.hibe.model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>

<%
    List<Customer> customer = (List<Customer>) request.getAttribute("customer");
%>
<div class="">
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>View Payments<small></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <form action="Invoice?action=ToViewPayment" method="post" class="form-horizontal form-label-left" validate>
                        <span class="section">Add Invoice Info</span>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Customer</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="form-control" name="customer" id="customer">
                                    <option value="" selected="true">Select Customer</option>
                                    <%
                                        for (Customer c : customer) {
                                    %>
                                    <option value="<%=c.getId()%>"><%=c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">
                            <div class="col-md-6 col-md-offset-3">
                                <button id="send" type="submit" class="btn btn-success">Next</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<%@include file="../../template/footer.jsp"%>