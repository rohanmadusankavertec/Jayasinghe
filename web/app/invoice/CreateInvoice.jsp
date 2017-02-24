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

<script type="text/javascript">
    function getVehicle() {
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = xmlHttp.responseText;

                if (reply.length > 2) {
                    var arr = reply.split("~");
                    document.getElementById("width").value = arr[0];
                    document.getElementById("height").value = arr[1];
                    document.getElementById("long").value = arr[2];
                } else {
                    document.getElementById("width").value = "";
                    document.getElementById("height").value = "";
                    document.getElementById("long").value = "";
                }
            }
        };
        var id = document.getElementById("vehicleNo").value;
        xmlHttp.open("POST", "Invoice?action=getVehicle&id=" + id, true);
        xmlHttp.send();
    }
    
    function loadingType(){
        var type = document.getElementById('full');
        
        if(type.checked){
            document.getElementById('lqty').className='hidden';
            document.getElementById('width').className='item form-group';
            document.getElementById('height').className='item form-group';
            document.getElementById('depth').className='item form-group';
        }else{
            document.getElementById('lqty').className='item form-group';
            document.getElementById('width').className='hidden';
            document.getElementById('height').className='hidden';
            document.getElementById('depth').className='hidden';
        }
        
        
    }
    
    
    function sentData(){
        var type = document.getElementById('load').value;
        var height = document.getElementById('height').value;
        var depth = document.getElementById('long').value;
        var width = document.getElementById('width').value;
        var qty = document.getElementById('width').value;
        
        if(type === "full"){
            
            if(width === ""){
                sm_warning("Please Enter Vehicle Width....");
            }else if(depth === ""){
                sm_warning("Please Enter Vehicle Depth....");
            }else(height === ""){
                sm_warning("Please Enter Vehicle Height....");
            }
        }else{
            sm_warning("Please Enter Vehicle Height....");
        }
        
        var customer = document.getElementById('customer').value;
        var vnumber = document.getElementById('vehicleNo').value;
        
        
        var Atime = document.getElementById('Reached').value;
        var dtime = document.getElementById('Loaded').value;
        var name = document.getElementById('Name').value;
        var sup = document.getElementById('supervisor').value;
        var secu = document.getElementById('securityOfficer').value;
    }
    
</script>




<%
    List<Customer> customer = (List<Customer>) request.getAttribute("customer");
    List<Supervisor> supervisor = (List<Supervisor>) request.getAttribute("supervisor");
    List<SecurityOfficer> securityofficer = (List<SecurityOfficer>) request.getAttribute("securityofficer");
%>
<div class="">
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Create Invoice<small></small></h2>
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
                    <form action="Invoice?action=ToInvoice" method="post" class="form-horizontal form-label-left" validate>
                        <span class="section">Add Invoice Info</span>

                        <div class="item form-group">
                            <label for="Privilege" class="control-label col-md-3 col-sm-3 col-xs-12">Customer</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="form-control" name="customer" id="customer">
                                    <option value="" selected="true">Select Customer</option>
                                    <%                                        for (Customer c : customer) {
                                    %>
                                    <option value="<%=c.getId()%>"><%=c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Vehicle Number</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input class="form-control col-md-7 col-xs-12" onkeyup="getVehicle()" data-validate-words="1" id="vehicleNo" name="vehicleNo" placeholder="Enter Vehicle Number" required="required" type="text">
                            </div>
                        </div>
                        <div class="item form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Qty Level</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="radio"  value="full" name="load" id="load" checked onchange="loadingType()" />Full
                                <input type="radio" value="custom" name="load" id="load" onchange="loadingType()"/>Custom
                            </div>
                        </div>        
                        <div class="clearfix">
<!--                            <div id="lqty" class="hidden">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Loading QTY</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="qty" name="qty" placeholder="Enter Loading Quantity"  type="number">
                                </div>
                            </div>-->
                            <div id="width" class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Vehicle Width (inches)</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="width" name="width" placeholder="Enter Vehicle Width"  type="text">
                                </div>
                            </div>
<div class="clearfix"></div>
                            <div id="height" class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Vehicle Height (inches)</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="height" name="height" placeholder="Enter Vehicle Height" type="text">
                                </div>
                            </div>
<div class="clearfix"></div>
                            <div id="depth" class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Vehicle depth (inches)</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="long" name="long" placeholder="Enter Vehicle Long" type="text">
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div id="lqty" class="hidden">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Loading QTY (Cubic Feet) </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="qty" name="qty" placeholder="Enter Loading Quantity" type="text">
                                </div>
                            </div>
                            
<div class="clearfix"></div>

                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Arrive Time</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="Reached"  name="Reached" placeholder="Enter the Arrive Time" type="time">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Loaded Time</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="Loaded" name="Loaded" placeholder="Enter the Loaded Time" type="time">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Receiver Name</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" id="Name" name="Name" placeholder="Enter the Receiver Name" type="text">
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="Privilege" class="control-label col-md-3 col-sm-3 col-xs-12">Supervisor</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select class="form-control" name="supervisor" id="supervisor" >
                                        <option value="" disabled selected="true">Select Supervisor</option>
                                        <%
                                            for (Supervisor c : supervisor) {
                                        %>
                                        <option value="<%=c.getId()%>"><%=c.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label for="Privilege" class="control-label col-md-3 col-sm-3 col-xs-12">Security Officer</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select class="form-control" name="securityOfficer" id="securityOfficer" >
                                        <option value="" disabled selected="true">Select Security Officer</option>
                                        <%
                                            for (SecurityOfficer c : securityofficer) {
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