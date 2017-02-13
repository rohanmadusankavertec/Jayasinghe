<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.util.CheckAuth"%>
<%@page import="com.vertec.hibe.model.UserGroupPrivilegeItem"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="com.vertec.hibe.model.SysUser"%>


<c:set var="context" value="${pageContext.request.contextPath}" />

<%    SysUser user = (SysUser) session.getAttribute("user");
    CheckAuth ca = new CheckAuth();
    int group = user.getUserGroupId().getUserGroupId();
%>

<div class="col-md-3 left_col">
    <div class="left_col scroll-view">
        <div class="navbar nav_title" style="border: 0;">
            <a href="${context}/dashboard.jsp" class="site_title">
                <!--<img src="${context}/resources/images/payroll-Logo.jpg" style="width: 200px; height: 60px;"/>-->
                Jayasinghe <small>Construction</small>
                
            </a>
        </div>
        <div class="clearfix"></div>
        <br/>

        <!-- sidebar menu -->
        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

            <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                    <li><a href="${context}/dashboard.jsp"><i class="fa fa-home"></i> DashBoard </a>

                    </li>

                    <li><a><i class="fa fa-user-plus"></i>Registration<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("MANAGE_CUSTOMERS", group) != null) {%>
                            <li><a href="${context}/Registration?action=ViewCustomer">Manage Customers</a></li>
                            <%}%>
                             <%if (ca.checkUserAuth("MANAGE_CATEGORY", group) != null) {%>
                            <li><a href="${context}/Registration?action=ViewCategory">Manage Categories</a></li>
                            <%}%>
                             <%if (ca.checkUserAuth("MANAGE_SUPERVISOR", group) != null) {%>
                            <li><a href="${context}/Registration?action=ViewSupervisor">Manage Supervisors</a></li>
                            <%}%>
                             <%if (ca.checkUserAuth("MANAGE_SECURITY", group) != null) {%>
                            <li><a href="${context}/Registration?action=ViewSecurityOfficer">Manage Security Officers</a></li>
                            <%}%>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-file-text"></i> Invoice <span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("INVOICE", group) != null) {%>
                             <li><a href="${context}/Invoice?action=ToCreateInvoice">Invoice</a></li>
                             <%}%>
                             <%if (ca.checkUserAuth("VIEW_INVOICE", group) != null) {%>
                             <li><a href="${context}/Invoice?action=ViewInvoice">View Invoices</a></li>
                             <%}%>
                             <%if (ca.checkUserAuth("PAYMENTS", group) != null) {%>
                             <li><a href="${context}/Invoice?action=ToPayment">Payments</a></li>
                             <%}%>
                             <%if (ca.checkUserAuth("CHEQUE", group) != null) {%>
                             <li><a href="${context}/Invoice?action=ViewCheques">Cheques</a></li>
                             <%}%>
                        </ul>
                    </li>
                   <li><a><i class="fa fa-newspaper-o"></i> Reports <span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("DAILY_SALES", group) != null) {%>
                             <li><a href="${context}/Report?action=SearchDailySales">Daily Sales</a></li>
                             <%}%>
                             <%if (ca.checkUserAuth("DAILY_COLLECTION", group) != null) {%>
                             <li><a href="${context}/Report?action=SearchDailyCollection">Daily Collection</a></li>
                             <%}%>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-user-secret"></i>User Management<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("ADD_USER", group) != null) {%>
                            <li><a href="${context}/app/users/userRegister.jsp">Add New User</a>
                            </li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_USERS", group) != null) {%>
                            <li><a href="${context}/User?action=ViewUsers">Manage Users</a>
                            </li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_USER_GROUP", group) != null) {%>
                            <li><a href="${context}/app/users/createUserGroup.jsp">Create User Group</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>

                    <li><a><i class="fa fa-check"></i>Privilege Management<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("ADD_PRIVILEGE", group) != null) {%>
                            <li><a href="${context}/Privilege?action=ViewPrivilege">Manage Privilege Groups</a>
                            </li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_PRIVILEGE_ITEM", group) != null) {%>
                            <li><a href="${context}/Privilege?action=ForPrivilegeItem">Manage Privileges</a>
                            </li>
                            <%}%>
<!--                            <li><a href="${context}/Privilege?action=LoadUserGroups">Set Privilege</a>
                            </li>-->
                            <%if (ca.checkUserAuth("SET_PRIVILEGE_ITEM", group) != null) {%>
                            <li><a href="${context}/Privilege?action=LoadUserGroupsForPI">Manage User Group Priviledges</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                    
                </ul>
            </div>
        </div>
        <!-- /sidebar menu -->

        <!-- /menu footer buttons -->
        <div class="sidebar-footer hidden-small">

            <a data-toggle="tooltip" data-placement="top" title="Logout" href="${context}/Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
            </a>
        </div>
        <!-- /menu footer buttons -->
    </div>
</div>


<div class="top_nav">

    <div class="nav_menu">
        <nav class="" role="navigation">
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
            <div style="" class="nav navbar-nav">
                <!-- Button -->
                <%
                    String success_message = (String) request.getAttribute("Success_Message");
                    String error_message = (String) request.getAttribute("Error_Message");
                    if (success_message == null) {
                        success_message = (String) session.getAttribute("Success_Message");
                    }
                    if (error_message == null) {
                        error_message = (String) session.getAttribute("Error_Message");
                    }
                    request.getSession().removeAttribute("Error_Message");

                %>
                <div class="" id="mydiv">
                    <strong><font color="green">
                        <% if (success_message != null) {
                                out.println(success_message);
                            }%>
                        </font>
                    </strong> 
                    <strong><font color="red">
                        <% if (error_message != null) {
                                out.println(error_message);
                            }%>
                        </font>
                    </strong> 
                </div>
            </div>
            <%
                request.getSession().removeAttribute("Error_Message");
                request.getSession().removeAttribute("Success_Message");

            %>
            <ul class="nav navbar-right">
                <li class="">
                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <%out.print(user.getFirstName() + " " + user.getLastName());%>
                        <span class=" fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                        <li><a href="${context}/app/users/editOwn.jsp">  Update Profile</a>
                        </li>
                        <li><a href="${context}/app/users/changePassword.jsp">  Change Password</a>
                        </li>

                        <li><a href="${context}/Logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                        </li>
                    </ul>
                </li>



            </ul>
        </nav>
    </div>

</div>

<!-- page content -->
<div class="right_col" role="main">