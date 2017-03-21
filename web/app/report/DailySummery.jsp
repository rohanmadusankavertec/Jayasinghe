<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.util.NewHibernateUtil"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.vertec.hibe.model.InvoiceInfo"%>
<%@page import="com.vertec.hibe.model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>

<div class="">
    <div class="clearfix"></div>
    <%
        List<InvoiceInfo> List = (List<InvoiceInfo>) request.getAttribute("dailycollection");
    %>
    <div class="row">

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Daily Collection Report<small>up to now</small></h2>
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
                                    <th>Invoice No</th>
                                    <th>Description</th>
                                    <th>Cubes</th>
                                    <th>Invoice Amount</th>
                                    <th>Paid Amount</th>
                                    <th>Outstanding</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Double total1 = 0.0;
                                    Double outstanding1 = 0.0;
                                    Double paid1 = 0.0;
                                    for (InvoiceInfo c : List) {
                                        if (c.getCustomerId() == null) {
                                            



                                %>
                                
                                
                                
                                <%
        
        SessionFactory sf = NewHibernateUtil.getSessionFactory();
        Session ses = sf.openSession();
        SQLQuery query = ses.createSQLQuery("SELECT c.name,i.cubes from invoice i inner join category c on c.id=i.category_id where i.invoice_info_id='"+c.getId()+"'");

        List<Object[]> inList = query.list();
        for (Object[] list : inList) {
            %>
          <tr>
                                    <td><%=c.getId()%></td>
                                    <td><%=list[0] %></td>
                                    <td><%=list[1]%></td>
                                    <td><%=c.getTotal()%></td>
                                    <td><%=(c.getTotal() - c.getOutstanding())%></td>
                                    <td><%=c.getOutstanding()%></td>
                                </tr>
            
            
            <%
        }
    %>
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                <%  }

                                    }
                                %>
                                <tr>
                                    <td class=""><strong>Total</strong></td>
                                    <td class=""><strong><%=total1%></strong></td>
                                    <td class=""><strong><%=paid1%></strong></td>
                                    <td class=""><strong><%=outstanding1%></strong></td>
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
