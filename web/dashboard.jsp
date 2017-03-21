<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="com.vertec.util.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="template/header.jsp"%>
<%@include file="template/sidebar.jsp"%>
<script src="app/js/notAlert.js"></script>

<script type="text/javascript">
    loadData();
    function loadData() {
        $.ajax({
            type: "POST",
            url: "Report?action=dashboard",
            success: function(msg) {
                var reply = eval('(' + msg + ')');
                var arrLn1 = reply.des;
                for (var f = 0; f < arrLn1.length; f++) {
                    document.getElementById("allsales").innerHTML=arrLn1[f].allsales;
                    document.getElementById("cashpayments").innerHTML=arrLn1[f].cashpayments;
                    document.getElementById("chequepayment").innerHTML=arrLn1[f].chequepayment;
                    document.getElementById("outstandingpayment").innerHTML=arrLn1[f].outstandingpayment;
                }
            }
        });
    }
</script>




<%
//    SessionFactory sf = NewHibernateUtil.getSessionFactory();
//    Session ses = sf.openSession();
//    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//    Date d = new Date();
//    String cudate = sdf.format(d);
//
//    double sales = 0.0;
//    double cash = 0.0;
//    double cheque = 0.0;
//    double outstanding = 0.0;
//
//    SQLQuery query = ses.createSQLQuery("SELECT sum(total) from invoice_info where date='" + cudate + "'");
//    try {
//        sales = (double) query.uniqueResult();
//    } catch (NullPointerException e) {
//
//    }
//
//    SQLQuery query2 = ses.createSQLQuery("SELECT sum(amount) from payment where payment_type_id='1' and date like '" + cudate + "%'");
//    
//
//    try {
//        cash = (double) query2.uniqueResult();
//    } catch (NullPointerException e) {
//
//    }
//
//    SQLQuery query3 = ses.createSQLQuery("SELECT sum(amount) from payment where payment_type_id='2' and date like '" + cudate + "%'");
//    
//    try {
//        cheque = (double) query3.uniqueResult();
//    } catch (NullPointerException e) {
//
//    }
//
//    SQLQuery query4 = ses.createSQLQuery("SELECT sum(outstanding) from invoice_info where date='" + cudate + "'");
//
//    try {
//        outstanding = (double) query4.uniqueResult();
//    } catch (NullPointerException e) {
//
//    }

%>






<div class="">
    <div class="row top_tiles">
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="allsales"></div>
                <h3>Total Sales</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i></div>
                <div class="count" id="cashpayments"></div>
                <h3>Cash Payments</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="chequepayment"></div>
                <h3>Cheque Payment</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="outstandingpayment"></div>
                <h3>Outstanding</h3>
                <p></p>
            </div>
        </div>
    </div>




</div>

<script src="resources/js/echart/echarts-all.js"></script>
<script src="resources/js/echart/green.js"></script>
<script src="app/js/dashboard.js"></script>

<!-- footer content -->
<%@include file="template/footer.jsp"%>
