<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="template/header.jsp"%>
<%@include file="template/sidebar.jsp"%>
<script src="app/js/notAlert.js"></script>

<script type="text/javascript">
//    loadData();
//    function loadData() {
//        $.ajax({
//            type: "POST",
//            url: "Report?action=dashboard",
//            success: function(msg) {
//                var reply = eval('(' + msg + ')');
//                var arrLn1 = reply.des;
//                for (var f = 0; f < arrLn1.length; f++) {
//                    document.getElementById("employee").innerHTML=arrLn1[f].employee;
//                    document.getElementById("advance").innerHTML=arrLn1[f].advance;
//                    document.getElementById("salary").innerHTML=arrLn1[f].salary;
//                    document.getElementById("payment").innerHTML=arrLn1[f].payment;
//                    document.getElementById("outstanding").innerHTML=arrLn1[f].outstanding;
//                    document.getElementById("loan").innerHTML=arrLn1[f].loan;
//                    document.getElementById("holiday").innerHTML=arrLn1[f].holiday;
//                    document.getElementById("users").innerHTML=arrLn1[f].users;
//                }
//            }
//        });
//    }
</script>




<div class="">
    <div class="row top_tiles">
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="employee">0</div>
                <h3>Total Sales</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i></div>
                <div class="count" id="advance">0</div>
                <h3>Cash Payments</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="salary">0</div>
                <h3>Cheque Payment</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-money"></i>
                </div>
                <div class="count" id="salary">0</div>
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
