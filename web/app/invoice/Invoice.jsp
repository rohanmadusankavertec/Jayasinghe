<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.vertec.hibe.model.SecurityOfficer"%>
<%@page import="com.vertec.hibe.model.Supervisor"%>
<%@page import="com.vertec.hibe.model.Customer"%>
<%@page import="com.vertec.hibe.model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>

<%
    System.out.println("Invoice Page");
    List<Category> category = (List<Category>) request.getAttribute("category");
    Customer customer = (Customer) request.getAttribute("customer");
    String vehicleNo = (String) request.getAttribute("vehicleNo");
    String reached = (String) request.getAttribute("reached");
    String loaded = (String) request.getAttribute("loaded");
    String name = (String) request.getAttribute("name");
    String supervisor = (String) request.getAttribute("supervisor");
    String securityofficer = (String) request.getAttribute("securityofficer");
    String loadType = (String) request.getAttribute("loadType");
    System.out.println("loading type is ...." + loadType);
    String width = "0";
    String vlong = "0";
    String height = "0";
    String cube = "0";
    if (loadType.equals("full")) {
        width = (String) request.getAttribute("width");
        vlong = (String) request.getAttribute("long");
        height = (String) request.getAttribute("height");
//       System.out.println(width+" "+vlong+" "+height);

        double d = Math.ceil(((Double.parseDouble(width) * Double.parseDouble(vlong) * Double.parseDouble(height)) / 1728) * 100.0) / 100.0;
//        System.out.println("loading type is full....//////////  "+ qty);
        double cubeqty = Math.ceil(d);
        if (cubeqty < 100 && cubeqty > 97) {
            cube = "100";
        } else {
            cube = Double.toString(cubeqty);
        }
//        System.out.println("................................  "+ d);
    } else {
        System.out.println("loading type is custom....");
//        System.out.println("loading type is custom...."+qty);
    }

//    System.out.println("...............................");
//    System.out.println(qty);
//    System.out.println("...............................");
//    System.out.println(loadType);
//    System.out.println("...........cube...................."+ cube);

%>

<script type="text/javascript">

//    var t = setTimeout(startTime, 1000);
    //add 0 if not exist in time
    function checkTime(i) {
        if (i < 10) {
            i = "0" + i;
        } // add zero in front of numbers < 10
        return i;
    }


    window.history.forward();
    function noBack() {
        window.history.forward();
    }


    function showQtyField() {
        window.history.forward(-1);
        var qt = "<%=loadType%>";
//        alert("ok");
        if (qt === "full") {
            document.getElementById('cubesqty').className = 'hidden';

        }
        startTime();
    }
    setTimeout(showQtyField, 1000);

// Show time in invoice
    function startTime() {
        var today = new Date();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        document.getElementById('datetime').innerHTML = "  " + h + ":" + m + ":" + s;
        var t = setTimeout(startTime, 500);
    }

// to hide and show cheque details
    function paymentType() {
        var ptype = document.getElementById("cash");
        if (ptype.checked) {
            document.getElementById('cn').className = 'hidden';
            document.getElementById('bn').className = 'hidden';
            document.getElementById('cd').className = 'hidden';
        } else {
            document.getElementById('cn').className = '';
            document.getElementById('bn').className = '';
            document.getElementById('cd').className = '';
        }
    }
    // View outstanding and balance
    function outstanding() {
        var total = document.getElementById('total').innerHTML;
        var payment = document.getElementById('payment').value;
        if (payment === "") {
            payment = 0;
            document.getElementById("ost").innerHTML = total;
            document.getElementById("bal").innerHTML = "00.00";
        } else {
            var deff = parseFloat(total) - parseFloat(payment);
            if (deff > 0) {
                document.getElementById("ost").innerHTML = deff;
                document.getElementById("bal").innerHTML = "00.00";
            } else if (deff < 0) {
                document.getElementById("ost").innerHTML = "00.00";
                document.getElementById("bal").innerHTML = deff * (-1);
            } else if (deff === 0) {
                document.getElementById("ost").innerHTML = "00.00";
                document.getElementById("bal").innerHTML = "00.00";
            } else {
                document.getElementById("ost").innerHTML = total;
                document.getElementById("bal").innerHTML = "00.00";
            }
        }
    }
    var item_details = {};
    function addtogrid() {

//       
        var bool = true;
        var type = "<%=loadType%>";
        var qty = "<%=cube%>";



        var cat2 = document.getElementById("category").value;
        var transport = document.getElementById("transport").value;
        if (cat2 === "") {
            bool = false;
            sm_warning("Please select a stone category");
        } else {

            var items = {};
            var catarr = cat2.split("~~");
            var catId = catarr[0];
            var catName = catarr[1];
            var catPrice = catarr[2];

            if (type === "full") {
                if (transport === "") {
                    bool = false;
                    sm_warning("Please select a Transport Amount");
                } else {
                    var total = ((parseFloat(catPrice) * parseFloat(qty)) / 100) + parseFloat(transport);
//                    alert(qty);
//                    document.getElementById("invoicespace").innerHTML = qty;

                    document.getElementById("cate").className = 'hidden';
                    document.getElementById("cubesqty").className = 'hidden';
                    document.getElementById("trans").className = 'hidden';
                    document.getElementById("btn").className = 'hidden';
                }
                //--------------------------------------------------------------------------------------------------               
            } else {
                var c = document.getElementById("qty").value;
                if (c === "") {
                    bool = false;
                    sm_warning("Please select a stone Quantity...");
                } else if (transport === "") {
                    bool = false;
                    sm_warning("Please select a Transport Amount");
                } else {
                    qty = document.getElementById("qty").value;
                    var total = ((parseFloat(qty) * parseFloat(catPrice)) / 100) + parseFloat(transport);
                    var cqty = parseFloat(document.getElementById("invoicespace").innerHTML);
                    var totqty = cqty + parseFloat(qty);
                    document.getElementById("invoicespace").innerHTML = totqty;
                }

            }
            items["category"] = catarr[1];
            items["price"] = catarr[2];
            items["qty"] = qty;
            items["transport"] = transport;
        }

        if (bool) {
            item_details[catId] = items;
            var invoiceItemTable = document.getElementById('invoiceItemTable').getElementsByTagName('tbody')[0];
            var row = document.createElement("tr");
            row.id = catId;
            var col1 = document.createElement("td");
            col1.type = "text";
            col1.value = catName;
            col1.innerHTML = catName;
            var col2 = document.createElement("td");
            col2.type = "text";
            col2.value = qty;


            col2.innerHTML = qty;
            var col3 = document.createElement("td");
            col3.type = "text";
            col3.value = catPrice;
            col3.innerHTML = catPrice;
            var col4 = document.createElement("td");
            col4.type = "text";
            col4.value = transport;
            col4.innerHTML = transport;
            var col5 = document.createElement("td");
            col5.type = "text";
            col5.value = total;
            col5.innerHTML = total;
            var col6 = document.createElement("td");
            var elem = document.createElement("span");
            elem.id = catId;
            elem.name = catId;
            elem.type = "button";
            elem.className = "btn btn-default glyphicon glyphicon-remove text-center";
            col6.appendChild(elem);
            row.appendChild(col1);
            row.appendChild(col2);
            row.appendChild(col3);
            row.appendChild(col4);
            row.appendChild(col5);
            row.appendChild(col6);
            invoiceItemTable.appendChild(row);
            var currenttot = document.getElementById("total").innerHTML;
            document.getElementById("total").innerHTML = parseFloat(currenttot) + parseFloat(total);
            outstanding();
            document.getElementById("qty").value = "";
            document.getElementById("transport").value = "";
            document.getElementById("category").value = "";
        }
    }

    //Delete item from table and item_details Array
    $(document).on('click', '#invoiceItemTable span', function () {
        var r = confirm("Are you Sure You want to delete this?");
        if (r === true) {
            var tr = $(this).closest('tr');
            var gross = tr.find('td:nth-child(5)').text();
            var qty = tr.find('td:nth-child(2)').text();
            var currenttot = document.getElementById("total").innerHTML;
            document.getElementById("total").innerHTML = parseFloat(currenttot) - parseFloat(gross);
            outstanding();
            var cqty = parseFloat(document.getElementById("invoicespace").innerHTML);
            var totqty = cqty - parseFloat(qty);
            document.getElementById("invoicespace").innerHTML = totqty;
            $(this).closest('tr').remove();
            delete item_details[this.id];
            document.getElementById("cate").className = 'item form-group';
            document.getElementById("cubesqty").className = 'item form-group';
            document.getElementById("trans").className = 'item form-group';
            document.getElementById("btn").className = 'item form-group';
            document.getElementById('cubesqty').className = 'hidden';

        }
    });
    function sm_alert(text) {
        BootstrapDialog.alert({
            title: 'Alert',
            type: BootstrapDialog.TYPE_DANGER,
            message: text,
            size: BootstrapDialog.SIZE_SMALL
        });
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








    function SaveInvoice() {

//        alert("call........");
        var data = {};
        var width = document.getElementById('width').value;

        var vlong = document.getElementById('vlong').value;
        var height = document.getElementById('height').value;
//        var aspace = parseFloat(document.getElementById('availablespace').innerHTML);
//        var ispace = parseFloat(document.getElementById('invoicespace').innerHTML);
//        if (aspace >= ispace) {
        var vno = document.getElementById('vno').value;
        var reached = document.getElementById('reached').value;
        var loaded = document.getElementById('loaded').value;
        var name = document.getElementById('name').value;
        var supervisor = document.getElementById('supervisor').value;
        var security = document.getElementById('security').value;
        var customer = document.getElementById('customer').value;
        var total = document.getElementById('total').innerHTML;
        var chequeNo = document.getElementById('chequeNo').value;
        var bankName = document.getElementById('bankName').value;
        var chequeDate = document.getElementById('chequeDate').value;
        var payment = document.getElementById('payment').value;
        if (payment === "") {
            payment = "0";
        }
        var outstanding = document.getElementById('ost').innerHTML;
        var pt = 0;
        var ptype = document.getElementById("cash");
        if (ptype.checked) {
            pt = 1;
        }
        data["vno"] = vno;
        data["width"] = width;
        data["vlong"] = vlong;
        data["height"] = height;
        data["reached"] = reached;
        data["loaded"] = loaded;
        data["name"] = name;
        data["supervisor"] = supervisor;
        data["security"] = security;
        data["customer"] = customer;
        data["total"] = total;
        data["chequeNo"] = chequeNo;
        data["bankName"] = bankName;
        data["chequeDate"] = chequeDate;
        data["payment"] = payment;
        data["outstanding"] = outstanding;
        data["payType"] = pt;
//            data["maindata"]=vno+"~"+width+"~"+vlong+"~"+height+"~"+reached+"~"+loaded+"~"+name+"~"+supervisor+"~"+security+"~"+customer+"~"+total+"~"+chequeNo+"~"+bankName+"~"+chequeDate+"~"+payment+"~"+outstanding+"~"+outstanding+"~"+pt;

        data["items"] = item_details;
        var jsonDetails = JSON.stringify(data);



        BootstrapDialog.show({
            message: 'Do you want to Submit ?',
            closable: false,
            buttons: [{
                    label: 'Yes',
                    action: function (dialogRef) {
                        dialogRef.close();
                        $.ajax({
                            type: "POST",
                            url: "Invoice?action=SubmitInvoice&data=" + jsonDetails,
                            success: function (msg) {
                                if (msg === "Success") {
                                    nom_Success("Successfully  Added");





                                    setTimeout("loadprintPage();", 3000);
                                    setTimeout("location.href = 'Invoice?action=ToCreateInvoice';", 3200);
                                } else {
                                    sm_warning("Not Submited , Please Try again");
                                }
                            }
                        });
                    }
                }, {
                    label: 'No',
                    action: function (dialogRef) {
                        dialogRef.close();
                    }
                }]
        });
//        } else {
//            sm_warning("This stone quantity can not load to vehicle...");
//        }
    }


    function loadprintPage() {

        var windowName = 'Invoice';
        var popUp = window.open('Invoice?action=PrintLastInvoice', windowName, 'width=1000, height=700, left=24, top=24, scrollbars, resizable');
        if (popUp == null || typeof (popUp) == 'undefined') {
            alert('Please disable your pop-up blocker and print invoice again.');
        } else {
            popUp.focus();
        }
    }




</script>

<div>
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Invoice<small></small></h2>
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
                    <div class="row">
                        <div class="col-xs-12 invoice-header">
                            <h1>
                                <i class="fa fa-globe"></i> Invoice.
                                <input type="hidden" value="<%=vehicleNo%>" id="vno"/>
                                <!--<input type="hidden" value="<>" id="lqty"/>-->
                                <input type="hidden" value="<%=loadType%>" id="ltype"/>


                                <input type="hidden" value="<%=width%>" id="width"/>
                                <input type="hidden" value="<%=vlong%>" id="vlong"/>
                                <input type="hidden" value="<%=height%>" id="height"/>

                                <input type="hidden" value="<%=reached%>" id="reached"/>
                                <input type="hidden" value="<%=loaded%>" id="loaded"/>
                                <input type="hidden" value="<%=name%>" id="name"/>
                                <input type="hidden" value="<%=supervisor%>" id="supervisor"/>
                                <input type="hidden" value="<%=securityofficer%>" id="security"/>

                                <%
                                    Date date = new Date();
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    String date2 = sdf.format(date);

                                    String cusid = "";
                                    String cusname = "";
                                    String cusadd = "";

                                    if (customer != null) {
                                        cusid = customer.getId() + "";
                                        cusname = customer.getName();
                                        cusadd = customer.getName();
                                    }


                                %>
                                <input type="hidden" value="<%=cusid%>" id="customer"/>
                                <small class="pull-right"><%=date2%><span id="datetime"></span></small>
                            </h1>
                        </div>
                        <!-- /.col -->
                    </div>

                    <div class="row invoice-info">
                        <div class="col-sm-12 col-lg-6 col-md-6 invoice-col">
                            Issue By :

                            <address>
                                <strong><%=user.getFirstName() + " " + user.getLastName()%></strong><br/>
                            </address>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-12 col-lg-6 col-md-6 invoice-col">
                            To
                            <input type="hidden" id="customerId" name="customerId" required="required" class="form-control col-md-7 col-xs-12" value="<%=cusid%>">
                            <address>
                                <strong><%=cusname%></strong><br/>
                                <%
                                    if (!cusadd.equals("")) {
                                        out.write(cusadd.replace(",", "<br>"));
                                    }

                                %>
                            </address>
                        </div>
                    </div>

                    <form action="#" method="post" class="form-horizontal form-label-left" validate>
                        <span class="section">Invoice</span>
                        <div id="cate" class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Stone Category</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="form-control" name="category" id="category"  required="required" >
                                    <option value="" disabled selected="true">Select Stone Category</option>
                                    <%                                        for (Category c : category) {
                                    %>
                                    <option value="<%=c.getId() + "~~" + c.getName() + "~~" + c.getPrice()%>"><%=c.getName() + " - Rs:" + c.getPrice()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div id="cubesqty" class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Stone Quantity (Cubic feet)</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input class="form-control col-md-7 col-xs-12" data-validate-words="1" name="qty" id="qty" placeholder="Enter Quantity" required="required" type="number">
                            </div>
                        </div>
                        <div id="trans" class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Transport</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input class="form-control col-md-7 col-xs-12" data-validate-words="1" name="transport" id="transport" placeholder="Enter Amount For Transport" required="required" type="number">
                            </div>
                        </div>
                        <div id="btn" class="form-group" >
                            <div class="col-md-3 col-md-offset-3" style="float: right;">
                                <button id="send" type="button" onclick="addtogrid()" class="btn btn-success">Add Category</button>
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                    </form>

                    <table class="table table-striped responsive-utilities jambo_table" id="invoiceItemTable">
                        <thead>
                            <tr>
                                <th>Stone Category</th>
                                <th>Cubic feets</th>
                                <th>Price</th>
                                <th>Transport</th>
                                <th>Total</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>


                    <div class="col-xs-6" style="padding-top: 50px; float: right;">
                        <!--                                <p class="lead">Amount Due 2/22/2014</p>-->
                        <div class="table-responsive">
                            <table class="table">
                                <tbody>
                                    
                                    <%
                                        if (loadType.equals("full")) {
                                    %>
                                    <tr>
                                        <th style="width:50%">Total Space(cubic feet)</th>
                                        <td><span><%=cube%></span></td>
                                    </tr>
                                    <%
                                    } else {
                                    %>
                                    <tr>
                                        <th style="width:50%">Total Space(cubic feet)</th>
                                        <td><span id="invoicespace">00</span> Cubic feet</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    <tr>
                                        <th style="width:50%">Total</th>
                                        <td ><span id="total">0000.00</span> LKR</td>
                                    </tr>
                                    <tr>
                                        <th>Payment Type:</th>
                                        <td>
                                            <input type="radio"  value="cash" name="pt" id="cash" checked onchange="paymentType()" />Cash
                                            <input type="radio" value="cheque" name="pt" id="cheque" onchange="paymentType()"/>Cheque
                                        </td>
                                    </tr>
                                    <tr class="hidden" id="cn">
                                        <th>Cheque No</th>
                                        <td>
                                            <input type="text" id="chequeNo" placeholder="Cheque No" class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr class="hidden" id="bn">
                                        <th>Bank Name:</th>
                                        <td>
                                            <input type="text" id="bankName" placeholder="Bank Name" class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr class="hidden" id="cd">
                                        <th>Cheque Date:</th>
                                        <td> <input type="date" id="chequeDate"  placeholder="Cheque Date" class="form-control"/></td>
                                    </tr>
                                    <tr>
                                        <th>Amount:</th>
                                        <td> <input type="text" id="payment" placeholder="Payment" class="form-control" onkeyup="outstanding()"/></td>
                                    </tr>
                                    <tr>
                                        <th>Outstanding:</th>
                                        <td><span id="ost">0000.00</span>LKR</td>
                                    </tr>
                                    <tr>
                                        <th>Balance</th>
                                        <td><span id="bal">0000.00</span>LKR</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group" >
                            <div class="col-md-3 col-md-offset-3" style="float: right;">
                                <button id="send" type="submit" onclick="SaveInvoice()" class="btn btn-success">Submit</button>
                            </div>
                        </div>
                    </div>  

                </div>
            </div>
        </div>
    </div>

</div>
<%@include file="../../template/footer.jsp"%>
