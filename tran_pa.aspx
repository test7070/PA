﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
		<!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4lkDc9H0JanDkP8MUpO-mzXRtmugbiI8&signed_in=true&callback=initMap" async defer></script>
		-->
		<script type="text/javascript">
			q_tables = 's';
			var q_name = "tran";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtTotal','txtTotal2','txtTotal3','txtMount','txtVolume','txtWeight','txtPrice','txtBmiles','txtEmiles','txtVoyage'];
			var q_readonlys = ['txtOrdeno','txtCaseno2'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = new Array(['txtDatea', '999/99/99'],['txtTrandate', '999/99/99']);
			var bbsNum = new Array(['txtTotal', 10, 0, 1],['txtVolume', 10,2, 1],['txtWeight', 10,2, 1],['txtTotal2', 10, 0, 1],['txtPrice', 10, 0, 1],['txtPrice2', 10, 0, 1],['txtPrice3', 10, 0, 1],['txtMount', 10, 0, 1],['txtPlus', 10, 0, 1],['txtMinus', 10, 0, 1]);
			var bbsMask = new Array(['txtDatea', '999/99/99'],['txtTrandate', '999/99/99'],['txtDtime', '999/99/99'],['txtTimea', '999/99/99']);
			var bbtNum  = new Array(); 
			var bbtMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 7;
			aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
				, ['txtAddrno', 'lblAddrno', 'cust', 'noa,comp', 'txtAddrno,txtAddr', 'cust_b.aspx']
				, ['txtStraddrno_', 'btnStraddr_', 'addr2', 'noa,addr,conn,tel,address,direction', 'txtStraddrno_,txtStraddr_,txtSalesno_,txtAddno4_,txtSaddr_', 'addr2_b.aspx']
                , ['txtEndaddrno_', 'btnEndaddr_', 'addr2', 'noa,addr,conn,tel,address,direction', 'txtEndaddrno_,txtEndaddr_,txtSales_,txtAdd4_,txtAaddr_', 'addr2_b.aspx']
                , ['txtAddno3_', 'btnAddno3_', 'addr2', 'noa,addr', 'txtAddno3_,txtAdd3_', 'addr2_b.aspx']
				, ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
				, ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
				, ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
				, ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'])
				;

			function sum() {
			    if (!(q_cur == 1 || q_cur == 2))
                    return;
				for(var i=0;i<q_bbsCount;i++){
                    var t_style=$('#txtProduct_'+i).val().split(' ');
                    var t_spec=t_style[0].split('*');
                    var t_spec1=t_style[0].split('x');
                    if (t_spec.length>1){
                        $('#txtVolume_'+i).val(q_mul(q_mul(t_spec[0],t_spec[1]),t_spec[2]));
                    }else if(t_spec1.length>1){
                        $('#txtVolume_'+i).val(q_mul(q_mul(t_spec1[0],t_spec1[1]),t_spec1[2]));
                    }else{
                        $('#txtVolume_'+i).val(0);
                    }
                }
			}
			
			$(document).ready(function() {
				var t_where = '';
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
			}

			function mainPost() {
				q_mask(bbmMask);
				q_getFormat();
				q_cmbParse("cmbStatus",',常日班,夜間班','s'); 
				if(r_len==4){           
                    $.datepicker.r_len=4;
                }
				$('#btnOrde').click(function(e){
                    t_trandate=$('#txtTrandate').val();
                    var t_where = "edate='"+t_trandate+"' and not exists(select noa,noq from view_trans where view_tranvcces.noa=ordeno and view_tranvcces.noq=caseno2)";
                    q_box("tranvcce_pa_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranvcce_tran', "95%", "650px");
                });
	
			}
			
			function bbsAssign() {
			for (var i = 0; i < q_bbsCount; i++) {
			  $('#lblNo_' + i).text(i + 1);
                   	if($('#btnMinus_' + i).hasClass('isAssign'))
                    		continue;
                	$('#txtMount_' + i).change(function(e) {
                        	sum();
                   	});                 	
                	$('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                   	});

                    $('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                    });
                    
                    $('#txtEndaddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                    });
                    
                    $('#txtAddno3_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddno3_'+n).click();
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
			function refreshWV(n){
				var t_productno = $.trim($('#txtProductno_'+n).val());
				if(t_productno.length==0){
					$('#txtWeight_'+n).val(0);
					$('#txtVolume_'+n).val(0);
				}else{
					q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0, JSON.stringify({action:"getUcc",n:n}));
				}
			}

			function bbsSave(as) {
				if (!as['comp'] && !as['productno'] && !as['product'] && !as['carno'] && !as['mount'] && !as['driverno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                as['custno'] = abbm2['addrno'];
                as['comp'] = abbm2['addr'];
                as['trandate'] = abbm2['trandate'];
				return true;
			}
			function q_boxClose(s2) {
                	var ret;
                	switch (b_pop) {
                	case 'tranvcce_tran':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                                ret = q_gridAddRow(bbsHtm, 'tbbs', 
                                'txtOrdeno,txtCaseno2,txtDtime,txtDatea,txtTimea,txtStraddrno,txtStraddr,txtSalesno,txtAddno4,txtSaddr,txtStime,txtStel,txtEndaddrno,txtEndaddr,txtSales,txtAdd4,txtAaddr,txtLtime,txtAtel,txtCstype,txtProduct,txtMount,txtVolume,txtWeight,txtUnit,txtTotal,txtPrice,txtCarno,txtDriverno,txtDriver,txtQtime,txtAddno3,txtAdd3,txtAddressee,txtSender,cmbStatus,txtCustorde', b_ret.length, b_ret, 
                                'noa,noq,unit2,bdate,edate,addrno,addr,conn,tel,time1,address,product2,addrno2,addr,lat,lat2,address2,time2,productno2,lng2,product,mount,tvolume,weight,unit,total,total3,carno,driverno,driver,time3,addrno3,addr3,memo2,paths,lng,allowcar', 'txtOrdeno,txtCaseno2,txtDatea,txtUccno,txtProductno,txtMount');
                            }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                	}
                	b_pop='';
           	}
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tran_pa_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtTrandate').val(q_date()).focus();
                $('#txtDatea').val(q_date());
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
			    q_box('z_tran_pa.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
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
				//var t_date = trim($('#txtTrandate').val());
				if (t_noa.length == 0 || t_noa == "AUTO"){
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				}
				else{
					wrServer(t_noa);
				}
		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				
			}
			function refreshBbs(){
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtTrandate').datepicker('destroy');
					$('#btnTranvcce').attr('disabled','disabled');
				}else{
					$('#txtDatea').datepicker();
					$('#txtTrandate').datepicker();
					$('#btnTranvcce').removeAttr('disabled');
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
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id){
					case 'txtProductno_':
						var n = b_seq;
						refreshWV(n);
						break;
					default:
						break;
				}
			}
			
		</script>
		
		<style type="text/css">
			#dmain {
				overflow: auto;
				width: 1600px;
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
				width: 700px;
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
				width: 2400px;
			}
			.dbbt {
				width: 2000px;
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
			
          /*  #tbbt {
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
            }*/
		</style>

	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="toolbar">
  <div id="q_menu"></div>
  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input id="btnXchg" type="button" style="display:none;background:url(../image/xchg_24.png) no-repeat;width:28px;height:26px"/>
  <a id='lblQcopy' style="display:none;"></a>
  <input id="chekQcopy" type="checkbox" style="display:none;"/>
  <input id="btnIns" type="button"/>
  <input id="btnModi" type="button"/>
  <input id="btnDele" type="button"/>
  <input id="btnSeek" type="button"/>
  <input id="btnPrint" type="button"/>
  <input id="btnPrevPage" type="button"/>
  <input id="btnPrev" type="button"/>
  <input id="btnNext" type="button"/>
  <input id="btnNextPage" type="button"/>
  <input id="btnOk" type="button" disabled="disabled" />&nbsp;&nbsp;&nbsp;
  <input id="btnCancel" type="button" disabled="disabled"/>&nbsp;
  <input id="btnAuthority" type="button" />&nbsp;&nbsp;
  <span id="btnSign" style="text-decoration: underline;"></span>&nbsp;&nbsp;
  <span id="btnAsign" style="text-decoration: underline;"></span>&nbsp;&nbsp;
  <span id="btnLogout" style="text-decoration: underline;color:orange;"></span>&nbsp;&nbsp;
  <input id="pageNow" type="text"  style="position: relative;text-align:center;"  size="2"/> /
  <input id="pageAll" type="text"  style="position: relative;text-align:center;"  size="2"/>
  </div>
  <div id="q_acDiv"></div>
</div>
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a>日期</a></td>
						<td align="center" style="width:120px; color:black;"><a>客戶</a></td>
						<td align="center" style="width:150px; color:black;"><a>單號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='addr' style="text-align: center;">~addr</td>
						<td id='noa' style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl">登錄日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a id="lblTrandate_pa" class="lbl">配送日期</a></td>
						<td><input type="text" id="txtTrandate" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa_pa" class="lbl">電腦編號</a></td>
                        <td colspan="2"><input type="text" id="txtNoa" class="txt c1" style="float:left;width:95%;"/></td>
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:30%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:70%;"/>
                        </td>
                    </tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6">
							<textarea id="txtMemo" class="txt c1" style="height:75px;width:98%;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><input id="btnOrde" type="button" value="訂單匯入" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="display:none;"><a>帳單日期</a></td>
					<td align="center" style="width:90px"><a>預計配送日期<BR>裝車日期</a></td>
					<td align="center" style="width:200px"><a>取貨地<br>寄件人 / 電話<br>地址<br>取貨日期時間<br>特殊需求</a></td>
                    <td align="center" style="width:200px"><a>配送地<br>收件人 / 電話<br>地址<br>送達日期時間<br>特殊需求</a></td>
                    <td align="center" style="width:85px"><a>SFD擔當 / 倉庫聯絡人</a></td>
					<td align="center" style="width:150px;"><a>尺寸</a></td>
					<td align="center" style="width:60px;"><a>單位</a></td>
					<td align="center" style="width:70px;"><a>儲位</a></td>  
					<td align="center" style="width:70px;"><a>數量</a></td>
					<td align="center" style="width:70px"><a>m3</a></td>
                    <td align="center" style="width:70px"><a>重量</a></td>
					<td align="center" style="width:80px;"><a>運費金額</a></td>
					<td align="center" style="width:80px;"><a>代收金額</a></td>
					<td align="center" style="width:70px"><a>出車時間</a></td>
                    <td align="center" style="width:90px"><a>中繼站</a></td>
					<td align="center" style="width:80px;"><a>車牌</a></td>
					<td align="center" style="width:100px"><a>準備工具<br>助理需求</a></td>
                    <td align="center" style="width:80px"><a>作業型態</a></td>
					<td align="center" style="width:150px;"><a>訂單編號<BR>銷貨單單號</a></td>
					<td align="center" style="width:100px;"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="display:none;"><input type="text" id="txtDtime.*" style="display:none;" /></td>
					<td><input type="text" id="txtDatea.*" style="width:95%;" />
					    <input type="text" id="txtTimea.*" style="width:95%;" />
					</td>
					<td>
					    <input type="text" id="txtStraddrno.*" style="float:left;width:30%;"/>
					    <input type="text" id="txtStraddr.*" style="float:left;width:65%;"/>
					    <input type="text" id="txtSalesno.*" style="float:left;width:30%;"/>
					    <input type="text" id="txtAddno4.*" style="float:left;width:65%;"/>
                        <input type="text" id="txtSaddr.*" style="float:left;width:98%;"/>
                        <input type="text" id="txtStime.*" style="float:left;width:98%;"/>
                        <input type="text" id="txtStel.*" style="float:left;width:98%;"/>
                        <input type="button" id="btnStraddr.*" style="display:none;">
                    </td>
                    <td>
                        <input type="text" id="txtEndaddrno.*" style="float:left;width:30%;"/>
                        <input type="text" id="txtEndaddr.*" style="float:left;width:65%;"/>
                        <input type="text" id="txtSales.*" style="float:left;width:30%;"/>
                        <input type="text" id="txtAdd4.*" style="float:left;width:65%;"/>
                        <input type="text" id="txtAaddr.*" style="float:left;width:98%;"/>
                        <input type="text" id="txtLtime.*" style="float:left;width:98%;"/>
                        <input type="text" id="txtAtel.*" style="float:left;width:98%;"/>
                        <input type="button" id="btnEndaddr.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtCstype.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtProduct.*" style="float:left;width:95%;"/>	
					</td>
					<td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtCaseuseno.*" style="width:95%;"/></td>
					<td><input type="text" id="txtMount.*" class="num" style="float:left;width:95%;"/></td>
					<td><input type="text" id="txtVolume.*" class="num" style="float:left;width:95%;"/></td>
					<td><input type="text" id="txtWeight.*" class="num" style="float:left;width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="float:center;width:95%;"/></td>
					<td><input type="text" id="txtPrice.*" class="num" style="float:left;width:95%;"/></td>
					<td><input type="text" id="txtQtime.*" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtAddno3.*" style="width:95%;"/>
                        <input type="text" id="txtAdd3.*" style="width:95%;"/>
                        <input type="button" id="btnAddno3.*" style="display:none;">
                    </td>
					<td>
                        <input type="text" id="txtCarno.*" style="width:95%;"/>
                        <input type="text" id="txtDriverno.*" style="display:none;"/>
                        <input type="text" id="txtDriver.*" style="display:none;"/>
                        <input type="button" id="btnCarno.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtAddressee.*" style="width:95%;"/>
                        <input type="text" id="txtSender.*" style="width:95%;"/>
                    </td>
                    <td><select id="cmbStatus.*" class="txt" style="width:95%;"> </select></td>
					<td><input type="text" id="txtOrdeno.*" style="float:left;width:65%;"/>
                        <input type="text" id="txtCaseno2.*" style="float:left;width:25%;"/>
                        <input type="text" id="txtCustorde.*" style="float:left;width:95%;"/></td>
                    <td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<datalist id="listUnit"> </datalist>
		<datalist id="listTypea"> </datalist>
		<datalist id="listCar"> </datalist>
		<input id="q_sys" type="hidden" />
	</body>
</html>