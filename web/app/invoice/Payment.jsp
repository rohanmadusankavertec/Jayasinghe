<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.hibe.model.InvoiceInfo"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>
<script type="text/javascript">

//get payment's invoice total, paid and outstanding
    function getInfo() {
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var response = xmlHttp.responseText;
                var reply = eval('(' + response + ')');
                var arrLn1 = reply.jArr1;

                for (var f = 0; arrLn1.length > f; f++) {
                    var tot = reply.jArr1[f].total;
                    var due = reply.jArr1[f].outstanding;
                    var paid = (parseFloat(tot) - parseFloat(due));
                    document.getElementById("invoicetotal").innerHTML = tot;
                    document.getElementById("paid").innerHTML = paid;
                    document.getElementById("outs").innerHTML = due;
                    getBalance();
                }
            }
        };
        var id = document.getElementById("ino").value;
        xmlHttp.open("POST", "Invoice?action=LoadPaymentData&iid=" + id, true);
        xmlHttp.send();
    }
    //get payment's outstanding and balance
    function getBalance() {
        var out = document.getElementById("outs").innerHTML;
        var pay2 = document.getElementById("payment").value;
        if (pay2 !== "") {

            if (!isNaN(out)) {
                var pay = parseFloat(pay2);
                var o2 = parseFloat(out);

                if (o2 >= pay) {
                    document.getElementById("balance2").innerHTML = "0000.00";
                    document.getElementById("outs2").innerHTML = out - pay;
                } else {
                    document.getElementById("balance2").innerHTML = pay - out;
                    document.getElementById("outs2").innerHTML = "0000.00";
                }
            }
        } else {
            document.getElementById("outs2").innerHTML = out;
        }
    }

// show and hide cheque details
    function payTypeCheck() {
        var pay = document.getElementById("payType").value;
        if (pay === "0") {
            document.getElementById('bnfield').className = 'item form-group';
            document.getElementById('cnfield').className = 'item form-group';
            document.getElementById('cdfield').className = 'item form-group';
        } else {
            document.getElementById('bnfield').className = 'hidden';
            document.getElementById('cnfield').className = 'hidden';
            document.getElementById('cdfield').className = 'hidden';
        }
    }
    function sm_warning(text) {
        BootstrapDialog.show({
            title: 'Warning',
            type: BootstrapDialog.TYPE_WARNING,
            message: text,
            size: BootstrapDialog.SIZE_SMALL
        });
    }


    function nom_Success(text) {
        BootstrapDialog.show({
            title: 'Notification',
            type: BootstrapDialog.TYPE_SUCCESS,
            message: text,
            size: BootstrapDialog.SIZE_NORMAL
        });
    }

// Save payment details
    function SavePayment() {

        var ino = document.getElementById('ino').value;
        var payType = document.getElementById('payType').value;
        var bank = document.getElementById('bank').value;
        var chdate = document.getElementById('chdate').value;
        var chno = document.getElementById('chno').value;
        var payment = document.getElementById('payment').value;


        BootstrapDialog.show({
            message: 'Do you want to Save Payment ?',
            closable: false,
            buttons: [{
                    label: 'Yes',
                    action: function (dialogRef) {
                        dialogRef.close();
                        var xmlHttp = getAjaxObject();
                        xmlHttp.onreadystatechange = function ()
                        {
                            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                            {
                                var reply = xmlHttp.responseText;
                                if (reply === "Success") {
                                    nom_Success("Successfully Saved..");
                                    setTimeout("location.href = 'Invoice?action=ToPayment';", 1500);
                                } else {
                                    sm_warning("Payment Not Correctly Entered Please Try Again");
                                }
                            }
                        };
                        xmlHttp.open("POST", "Invoice?action=SavePayment&ino=" + ino + "&payType=" + payType + "&bank=" + bank + "&chdate=" + chdate + "&chno=" + chno + "&payment=" + payment, true);
                        xmlHttp.send();
                    }
                }, {
                    label: 'No',
                    action: function (dialogRef) {
                        dialogRef.close();
                    }
                }]
        });

    }


</script>
<div class="">
    <%
        List<InvoiceInfo> invoiceList = (List<InvoiceInfo>) request.getAttribute("invoice");
    %>
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Invoice Payment<small>Add Payment</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>

                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <!--<form class="form-horizontal" validate>-->
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Invoice 
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="form-control" name="ino" id="ino"  required="required" onchange="getInfo()">
                                <option disabled selected>Select Invoice</option>
                                <%
                                    for (InvoiceInfo ii : invoiceList) {
                                %>
                                <option  value="<%=ii.getId()%>"><%=ii.getCustomerId().getName() + " ~ Total: " + ii.getTotal() + " ~ Outstanding: " + ii.getOutstanding()%></option>
                                <%
                                    }
                                %>
                            </select>                              
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Invoice Total (LKR)
                        </label>
                        <label class="control-label col-md-6 col-sm-6 col-xs-12" for="name" style="text-align: left;"><span id="invoicetotal">0000.00</span>
                        </label>
                    </div>
                    <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Paid Amount (LKR)
                        </label>
                        <label class="control-label col-md-6 col-sm-6 col-xs-12" for="name" style="text-align: left;"><span id="paid">0000.00</span>
                        </label>
                    </div> 
                    <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Current Outstanding (LKR)<span class="required"></span>
                        </label>
                        <label class="control-label col-md-6 col-sm-6 col-xs-12" for="name" style="text-align: left;"><span id="outs">0000.00</span>
                        </label>
                    </div> 
                    <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Payment Type <span class="required"></span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="form-control" name="payType" id="payType" onchange="payTypeCheck()" required="required" >
                                <option value="1">Cash</option>
                                <option value="0">Cheque</option>
                            </select>                              
                        </div>
                    </div>   
                    <div class="clearfix"></div>
                    <div class="hidden" style="padding-top: 20px;" id="bnfield">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Enter Bank Name<span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="bank" name="bank" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>     
                    <div class="clearfix"></div>
                    <div class="hidden" style="padding-top: 20px;" id="cdfield">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Enter Cheque Date<span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="date" id="chdate" name="chdate" required="required" class="form-control col-md-7 col-xs-12" >
                        </div>
                    </div>    
                    <div class="clearfix"></div>
                    <div class="hidden" style="padding-top: 20px;" id="cnfield">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Enter Cheque No<span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="chno" name="chno" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>         
                    <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Enter Payment Amount (LKR)<span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="payment" name="payment" required="required" class="form-control col-md-7 col-xs-12" onkeyup="getBalance()">
                        </div>
                    </div>  <div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Outstanding (LKR)<span class="required"></span>
                        </label>
                        <label class="control-label col-md-6 col-sm-6 col-xs-12" style="text-align: left;"><span id="outs2">0000.00</span>
                        </label>
                    </div><div class="clearfix"></div>
                    <div class="item form-group" style="padding-top: 20px;">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Balance (LKR)<span class="required"></span>
                        </label>
                        <label class="control-label col-md-6 col-sm-6 col-xs-12" style="text-align: left;"><span id="balance2">0000.00</span>
                        </label>
                    </div> <div class="clearfix"></div>

                    <div class="item form-group" style="padding-top: 50px;">
                        <div class="col-xs-12 col-lg-offset-3">
                            <button class="btn btn-success" id="updateP" onclick="SavePayment()"><i class="fa fa-arrow-right"></i>Save</button>
                        </div>
                    </div>

                    <!--</form>-->
                </div>
            </div>
        </div>

    </div>


</div>
<!-- footer content -->
<%@include file="../../template/footer.jsp"%>
