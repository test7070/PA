<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "tranvcce";
            var q_readonly = ['txtNoa', 'txtWeight','txtTotal', 'txtWorker', 'txtWorker2','txtAddress'];
            var q_readonlys = ['txtOrdeno', 'txtNo2'];
            var bbmNum = [];
            var bbsNum = [['txtMount', 10, 0, 1],['txtVolume', 10, 2, 1],['txtTvolume', 10, 2, 1],['txtWeight', 10, 2, 1],['txtTotal', 15, 0, 1],['txtTotal2', 10, 0, 1]];
            var bbmMask = [['txtTimea', '999/99/99'],['txtCarno2', '999/99']];
            var bbsMask = [['txtBdate', '999/99/99'],['txtEdate', '999/99/99'],['txtUnit2', '999/99/99'],['txtTime3', '99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtAddrno', 'lblAddr_js', 'cust', 'noa,nick', 'txtAddrno,txtAddr', 'cust_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,nick', 'txtCustno_,txtCust_', 'cust_b.aspx']
            , ['txtAddrno_', 'btnAddrno_', 'addr2', 'noa,addr,conn,tel,address,direction', 'txtAddrno_,txtAddr_,txtConn_,txtTel_,txtAddress_,txtProduct2_', 'addr2_b.aspx']
            , ['txtAddrno2_', 'btnAddrno2_', 'addr2', 'noa,addr,conn,tel,address,direction', 'txtAddrno2_,txtAddr2_,txtLat_,txtLat2_,txtAddress2_,txtProductno2_', 'addr2_b.aspx']
            , ['txtAddrno3_', 'btnAddno3_', 'addr2', 'noa,addr', 'txtAddrno3_,txtAddr3_', 'addr2_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                window.parent.document.title='訂單作業'
            }
            var t_weight=0;
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                /*for(var i=0;i<q_bbsCount;i++){
                    $('#txtTotal_'+i).val(q_mul(q_float('txtVolume_' + i),q_float('txtMount_' + i)));
                }*/
                for(var i=0;i<q_bbsCount;i++){
                    var t_style=$('#txtProduct_'+i).val().split(' ');
                    var t_spec=t_style[0].split('*');
                    var t_spec1=t_style[0].split('x');
                    if (t_spec.length>1){
                        $('#txtTvolume_'+i).val(q_mul(q_mul(t_spec[0],t_spec[1]),t_spec[2]));
                    }else if(t_spec1.length>1){
                        $('#txtTvolume_'+i).val(q_mul(q_mul(t_spec1[0],t_spec1[1]),t_spec1[2]));
                    }else{
                        $('#txtTvolume_'+i).val(0);
                    }
                }
            }

            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("combStype",',郵寄,順送,自送,專車,空運,收貨,海運'); 
                q_cmbParse("cmbNo2",',O,F');
                q_cmbParse("cmbLng",',常日班,夜間班','s'); 
                if(r_len==4){           
                    $.datepicker.r_len=4;
                }
                
                $('#txtDatea').datepicker();
                $('#txtTimea').datepicker();
                
                
                $('#combStype').change(function() {
                    $('#txtUnit').val($('#combStype').find("option:selected").text());
                });

            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'tranorde_tranvcce':
                            if (q_cur > 0 && q_cur < 4) {
                                b_ret = getb_ret();
                                if (!b_ret || b_ret.length == 0)
                                    return;
                                    ret = q_gridAddRow(bbsHtm, 'tbbs', 
                                    'txtOrdeno,txtNo2,txtBdate,txtConn,txtTel,txtAddress,txtLat,txtLat2,txtAddress2,txtProductno,txtProduct,txtUnit,txtMount,txtVolume,txtTotal,txtAddrno,txtAddrno2,txtAddr,txtAddr2,txtTypea,txtTvolume,txtWeight,txtProduct2,txtProductno2', b_ret.length, b_ret, 
                                    'noa,noq,trandate,conn,tel,address,containerno1,containerno2,address2,productno,product,unit,mount,price,total,addrno,addrno2,addr,addr2,otype,volume,weight,product2,productno2',',txtConn,txtProductno,txtProduct,txtUnit,txtMount,txtTotal');
                             }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'view_tranvcces':
                            var as = _q_appendData("view_tranvcces", "", true);
                            if(as[0]!=undefined){
                                $('#chk1').prop('checked',true);
                            }
                            t_weight=0;
                            break;
                    case 'btnModi':
                        if(r_rank<7){
                            var as = _q_appendData("trans", "", true);
                            if (as[0] != undefined) {
                                var t_msg = "";
                                for(var i=0;i<as.length;i++){
                                    t_msg += String.fromCharCode(13)+'出車單號【'+as[i].noa+'】 ';
                                }
                                if(t_msg.length>0){
                                    alert('已出車:'+ t_msg);
                                    Unlock(1);
                                    return;
                                }
                            }
                        }else{
                            var as = _q_appendData("trans", "", true);
                            if (as[0] != undefined) {
                                var t_msg = "";
                                for(var i=0;i<as.length;i++){
                                    t_msg += String.fromCharCode(13)+'出車單號【'+as[i].noa+'】 ';
                                }
                                if(t_msg.length>0){
                                    alert('已出車:'+ t_msg);
                                }
                            }
                        }
                        _btnModi();
                        sum();
                        refreshBbs();
                        Unlock(1);
                        $('#txtDatea').focus();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {               
                if ($('#txtCarno2').val().length == 0) {
                    alert('帳款月份錯誤。');
                    Unlock(1);
                    return;
                }else if($('#txtCarno2').val()<q_date().substr(0,6)) {
                    alert('帳款月份不能小於當月份。');
                    Unlock(1);
                    return;
                }
                
            	sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranvcce_pa_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                        continue;
                        
                    $('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                    });
                    
                    $('#txtCarno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnCarno_'+n).click();
                    });
                    
                    $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnDriver_'+n).click();
                    });
                    
                    $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddrno_'+n).click();
                    });
                    
                    $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddrno2_'+n).click();
                    });
                    
                    $('#txtAddrno3_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddno3_'+n).click();
                    });
                      
                    $('#txtMount_' + i).change(function() {
                            sum();
                    });
                    
                    $('#txtTvolume_' + i).change(function() {
                            sum();
                    });
                    
                    $('#txtProduct_' + i).change(function() {
                            sum();
                    });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
                 refreshBbs();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                $('#txtTimea').val(q_date());
                refreshBbs();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                t_where=" where=^^ ordeno='"+$('#txtNoa').val()+"'^^";
                q_gt('trans', t_where, 0, 0, 0, "btnModi", r_accy);            
            }

            function btnPrint() {
                q_box('z_tran_pa.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['addrno2'] && !as['addrno'] && !as['addr'] && !as['addr2'] && !as['carno'] && !as['productno'] && !as['mount']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                as['custno'] = abbm2['addrno'];
                as['cust'] = abbm2['addr'];
                as['edate'] = abbm2['timea'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbs();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('#txtDatea').datepicker('destroy');
                    $('#btnOrde').attr('disabled','disabled');
                    $('#btnImport_trans').removeAttr('disabled');
                }else{
                    $('#txtDatea').datepicker();
                    $('#btnOrde').removeAttr('disabled');
                    $('#btnImport_trans').attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
                q_box('tranvcce_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranvcce2tran_wj':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
            }
            
            function refreshBbs() {
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 750px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 2800px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:150px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車日期</a></td>
                    <td colspan="4">
                    <input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    <span style="float:left;display:black;height:100%;width:30px;">~</span>
                    <input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車車號</a></td>
                    <td colspan="4">
                    <input id="textCarno"  type="text" style="float:left; width:100px; font-size: medium;"/>
                </tr>
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="匯入"/></td>
                    <td></td>
                    <td></td>
                    <td><input id="btnCancel_import" type="button" value="關閉"/></td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>電腦編號</a></td>
						<td align="center" style="width:40%"><a>客戶</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='addr'>~addr</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblTimea" class="lbl" >配送日期</a></td>
                        <td><input id="txtTimea" type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblNoa" class="lbl" > </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>					
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:30%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:70%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr_js" class="lbl btn">客戶</a></td>
                        <td colspan="3">
                            <input type="text" id="txtAddrno" class="txt" style="width:30%;float: left; " />
                            <input type="text" id="txtAddr" class="txt" style="width:70%;float: left; " />
                        </td>
                        <td><span> </span><a id="lblNo2_pa" class="lbl" >客戶性質</a></td>
                        <td><select id="cmbNo2" style="width: 75%;"> </select></td> 
                    </tr>
					<tr>
					    <td><span> </span><a id="lblCarno2_pa" class="lbl" >帳款月份</a></td>
                        <td><input id="txtCarno2" type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblOrdeno_pa" class="lbl" >帳款編號</a></td>
                        <td><input id="txtOrdeno" type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblUnit_pa" class="lbl" >JOB TYPE</a></td>
                        <td><input id="txtUnit" type="text" class="txt" style="width: 70%" />
                            <select id="combStype" style="width: 20%;"> </select> 
                        </td>                 
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl" > </a></td>
                        <td colspan="5"><textarea id="txtMemo" style="height:60px;" class="txt c1"> </textarea></td>
                    </tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
						<!--<td><input id="btnOrde" type="button" value="訂單匯入" style="width:100%;"/></td>-->
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' style="width:2100px;">
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="display:none;"><a>帳款日期</a></td>
					<td align="center" style="width:105px"><a>預計配送日期<br>裝車日期</a></td>
					<td align="center" style="width:200px"><a>取貨地<br>寄件人 / 電話<br>地址<br>取貨日期時間<br>特殊需求</a></td>
					<td align="center" style="width:200px"><a>配送地<br>收件人 / 電話<br>地址<br>送達日期時間<br>特殊需求</a></td>
					<td align="center" style="width:85px"><a>SFD擔當 / 倉庫聯絡人</a></td>
					<td align="center" style="width:150px"><a>尺寸</a></td>
					<td align="center" style="width:40px"><a>單位</a></td>
					<td align="center" style="width:70px"><a>數量</a></td>
					<td align="center" style="width:70px"><a>m3</a></td>
					<td align="center" style="width:70px"><a>重量</a></td>
                    <td align="center" style="width:70px"><a>運費金額</a></td>
                    <td align="center" style="width:70px"><a>代收金額</a></td>
                    <td align="center" style="width:70px"><a>出車時間</a></td>
                    <td align="center" style="width:100px"><a>中繼站</a></td>
					<td align="center" style="width:60px"><a>車牌</a></td>
                    <td align="center" style="width:100px"><a>準備工具<br>助理需求</a></td>
                    <td align="center" style="width:80px"><a>作業型態</a></td>              
                    <td align="center" style="width:150px"><a>銷貨單單號</a></td>
                    <td align="center" style="width:100px"><a>備註</a></td>
                    <!--<td align="center" style="width:40px"><a>結案</a></td>-->
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td style="display:none;"><input type="text" id="txtUnit2.*" style="display:none;"/></td>
                    <td><input type="text" id="txtBdate.*" style="width:95%;" />
                        <input type="text" id="txtEdate.*" style="width:95%;" />
                    </td>
                    <td>
                        <input type="text" id="txtAddrno.*" style="width:40%;" />
                        <input type="text" id="txtAddr.*" style="width:53%;" />
                        <input type="text" id="txtConn.*" style="width:40%;" />
                        <input type="text" id="txtTel.*" style="width:53%;" />
                        <input type="text" id="txtAddress.*" style="width:98%;" />
                        <input type="text" id="txtTime1.*" style="width:98%;" />
                        <input type="text" id="txtProduct2.*" style="width:98%;" />
                        <input type="button" id="btnAddrno.*" style="display:none;">
                    </td>
                    <td>
                        <input type="text" id="txtAddrno2.*" style="width:40%;" />
                        <input type="text" id="txtAddr2.*" style="width:53%;" />
                        <input type="text" id="txtLat.*" style="width:40%;" />
                        <input type="text" id="txtLat2.*" style="width:53%;" />
                        <input type="text" id="txtAddress2.*" style="width:98%;" />
                        <input type="text" id="txtTime2.*" style="width:98%;" />
                        <input type="text" id="txtProductno2.*" style="width:98%;" />
                        <input type="button" id="btnAddrno2.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtLng2.*" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtProduct.*" style="width:95%;" />      
                    </td>
                    <td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
                    <td><input type="text" id="txtTvolume.*" class="num" style="width:95%;"/></td>
                    <td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal3.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTime3.*" style="width:95%;" /> </td>
					<td>
                        <input type="text" id="txtAddrno3.*" style="width:98%;" />
                        <input type="text" id="txtAddr3.*" style="width:98%;" />
                        <input type="button" id="btnAddno3.*" style="display:none;">
                    </td>
					<td>
                        <input type="text" id="txtCarno.*" style="width:95%;"/>
                        <input type="text" id="txtDriverno.*" style="display:none;"/>
                        <input type="text" id="txtDriver.*" style="display:none;"/>
                        <input type="button" id="btnCarno.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtMemo2.*" style="width:95%;"/>
                        <input type="text" id="txtPaths.*" style="width:95%;"/></td>   
                    <td><select id="cmbLng.*" class="txt" style="width:95%;"> </select></td>
					<td>
                        <input type="text" id="txtAllowcar.*" style="width:98%;"/>
                    </td>
                    <td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>