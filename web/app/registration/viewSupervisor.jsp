<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.hibe.model.Supervisor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>


<div class="">
    <%
        Supervisor supervisor = (Supervisor) request.getAttribute("supervisor");
    %>
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2><small></small></h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <form action="Registration?action=UpdateSup" method="post" class="form-horizontal form-label-left" novalidate >
                        <span class="section">Supervisor Update</span>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name"> Supervisor Name 
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input class="form-control col-md-7 col-xs-12" name="Name" data-validate-words="2" required="required" type="text" value="<%=supervisor.getName()%>">
                                <input name="supId" required="required" type="hidden" value="<%=supervisor.getId()%>"> 
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">
                            <div class="col-md-6 col-md-offset-3">
                                <button id="send" type="submit" class="btn btn-success">Update</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
                            
                            <%@include file="../../template/footer.jsp"%>