<%-- 
 *
 * @author Rohan Madusanka
 * @e-mail rohanmadusanka72@gmail.com
 * @contact 071-9085504
 *
--%>

<%@page import="com.vertec.hibe.model.Payment"%>
<%@page import="com.vertec.hibe.model.InvoiceInfo"%>
<%@page import="com.vertec.hibe.model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>

<script type="text/javascript">
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
    //Delete Payment Using id
    function DeletePayment(id) {
        BootstrapDialog.show({
            message: 'Do you want to Delete This Cheque ?',
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
                                    nom_Success("Successfully Deleted");
                                    setTimeout("location.href = 'Invoice?action=ViewInvoice';", 1500);
                                } else {
                                    sm_warning("Cheque is Not Correctly Deleted. Please Try Again");
                                }
                            }
                        };
                        xmlHttp.open("POST", "Invoice?action=DeletePayment&id=" + id, true);
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
    //Clear Cheque using payment ID
    function ClearCheque(id) {
        BootstrapDialog.show({
            message: 'Do you want to Clear This Cheque ?',
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
                                    nom_Success("Successfully Cleared.");
                                    setTimeout("location.href = 'Invoice?action=ViewInvoice';", 1500);
                                } else {
                                    sm_warning("Cheque is Not Correctly Cleared. Please Try Again");
                                }
                            }
                        };
                        xmlHttp.open("POST", "Invoice?action=ClearCheque&id=" + id, true);
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
    <div class="clearfix"></div>
    

    <%
        List<Payment> paymentList = (List<Payment>) request.getAttribute("payment");
    %>
    <div class="row">

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Pending Cheques <small>up to now</small></h2>
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
                                    <th>#</th>
                                    <th>Date</th>
                                    <th>Bank</th>
                                    <th>Cheque No</th>
                                    <th>Cheque Date</th>
                                    <th>Amount</th>
                                    <th>Customer</th>
                                    <th class=" no-link last"><span class="nobr">Action</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    
                                    for (Payment c : paymentList) {
                                %>
                                <tr>
                                    <td class=" "><%=c.getId()%></td>
                                    <td class=" "><%=c.getDate()%></td>
                                    <td class=" "><%=c.getBank()%></td>
                                    <td class=" "><%=c.getChequeNo()%></td>
                                    <td class=" "><%=c.getChequeDate()%></td>
                                    <td class=" "><%=c.getAmount()%></td>
                                    <%if(c.getInvoiceInfoId().getCustomerId()!= null){%>
                                        <td class=" "><%=c.getInvoiceInfoId().getCustomerId().getName() %></td>
                                    <%}%>
                                    <td class="last"> 
                                        <span class="btn btn-default glyphicon glyphicon-ok text-center" onclick="ClearCheque(<%=c.getId()%>)"></span>
                                        <span class="btn btn-default glyphicon glyphicon-remove text-center" onclick="DeletePayment(<%=c.getId()%>)"></span>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../template/footer.jsp"%>
<script>
    // initialize the validator function
    validator.message['date'] = 'not a real date';

    // validate a field on "blur" event, a 'select' on 'change' event & a '.reuired' classed multifield on 'keyup':
    $('form')
            .on('blur', 'input[required], input.optional, select.required', validator.checkField)
            .on('change', 'select.required', validator.checkField)
            .on('keypress', 'input[required][pattern]', validator.keypress);

    $('.multi.required')
            .on('keyup blur', 'input', function() {
                validator.checkField.apply($(this).siblings().last()[0]);
            });

    // bind the validation to the form submit event
    //$('#send').click('submit');//.prop('disabled', true);

    $('form').submit(function(e) {
        e.preventDefault();
        var submit = true;
        // evaluate the form using generic validaing
        if (!validator.checkAll($(this))) {
            submit = false;
        }

        if (submit)
            this.submit();
        return false;
    });

    /* FOR DEMO ONLY */
    $('#vfields').change(function() {
        $('form').toggleClass('mode2');
    }).prop('checked', false);

    $('#alerts').change(function() {
        validator.defaults.alerts = (this.checked) ? false : true;
        if (this.checked)
            $('form .alert').remove();
    }).prop('checked', false);
</script>
<script>
    $(document).ready(function() {
        $('input.tableflat').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });
    });

    var asInitVals = new Array();
    $(document).ready(function() {
        var oTable = $('#example').dataTable({
            "oLanguage": {
                "sSearch": "Search all columns:"
            },
            "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [0]
                } //disables sorting for column one
            ],
            'iDisplayLength': 12,
            "sPaginationType": "full_numbers",
            "dom": 'T<"clear">lfrtip',
            "tableTools": {
                "sSwfPath": "${context}/resources/js/datatables/tools/swf/copy_csv_xls_pdf.swf"
            }
        });
        $("tfoot input").keyup(function() {
            /* Filter on the column based on the index of this element's parent <th> */
            oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
        });
        $("tfoot input").each(function(i) {
            asInitVals[i] = this.value;
        });
        $("tfoot input").focus(function() {
            if (this.className == "search_init") {
                this.className = "";
                this.value = "";
            }
        });
        $("tfoot input").blur(function(i) {
            if (this.value == "") {
                this.className = "search_init";
                this.value = asInitVals[$("tfoot input").index(this)];
            }
        });
    });
</script>