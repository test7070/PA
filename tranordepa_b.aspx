﻿<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "tranorde_tranvcce", t_content = "where=^^['','','')", afilter = [], bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';

            $(document).ready(function() {
                if (!q_paraChk())
                    return;
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
                
                main();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                 var t_para = new Array();
                try{
                    t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
                    t_content = t_content = "where=^^['"+t_para.trandate+"','"+t_para.custno+"','"+t_para.cno+"')^^";
                }catch(e){
                }    
                brwCount = -1;
                mainBrow(0, t_content);
            }

			function mainPost(){
			}

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                q_bbsCount = abbs.length;
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtNoa_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:25px" ><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:25px;"> </td>
					<th align="center"><a id=''>訂單編號</a></th>
					<th align="center"><a id=''>配送日期</a></th>
					<th align="center"><a id=''>寄件人</a></th>
                    <th align="center"><a id=''>收件人</a></th>
					<th align="center"><a id=''>尺寸</a></th>
					<th align="center"><a id=''>數量</a></th>
					<th align="center"><a id=''>m3</a></th>
					<th align="center"><a id=''>重量</a></th>
					<th align="center"><a id=''>備註</a></th>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:10px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:150px;">
						<input id="txtNoa.*" type="text" style="float:left;width:75%; background: rgb(237, 237, 238);" readonly="readonly" />
						<input id="txtNoq.*" type="text" style="float:left;width:25%; text-align: right; background: rgb(237, 237, 238);"  readonly="readonly" />
					</td>
					<td style="width:90px;">
                        <input id="txtTrandate.*" type="text" style="float:left;width:98%; background: rgb(237, 237, 238);" readonly="readonly" />
                    </td>
					<td style="width:200px;">
                        <input id="txtConn.*" type="text" style="float:left;width:25%; background: rgb(237, 237, 238);" readonly="readonly"/>
                        <input id="txtAddr.*" type="text" style="float:left;width:75%; background: rgb(237, 237, 238);" readonly="readonly"/>
                        <input id="txtAddress.*" type="text" style="float:left;width:100%; background: rgb(237, 237, 238);" readonly="readonly"/>
                    </td>
					<td style="width:200px;">
                        <input id="txtContainerno1.*" type="text" style="float:left;width:25%; background: rgb(237, 237, 238);" readonly="readonly"/>
                        <input id="txtAddr2.*" type="text" style="float:left;width:75%; background: rgb(237, 237, 238);" readonly="readonly" />
                        <input id="txtAddress2.*" type="text" style="float:left;width:100%; background: rgb(237, 237, 238);" readonly="readonly" />
                    </td>
                    <td style="width:100px;">
                        <input id="txtProduct.*" type="text" style="float:left;width:95%; background: rgb(237, 237, 238);" readonly="readonly" />
                    </td>
                    <td style="width:70px;"><input id="txtMount.*" type="text" style="text-align:right;width:95%; background: rgb(237, 237, 238);" readonly="readonly"/></td>
                    <td style="width:70px;"><input id="txtVolume.*" type="text" style="text-align:right;width:95%; background: rgb(237, 237, 238);" readonly="readonly"/></td>
                    <td style="width:70px;"><input id="txtWeight.*" type="text" style="text-align:right;width:95%; background: rgb(237, 237, 238);" readonly="readonly"/></td>
                    <td style="width:120px;"><textarea id="txtMemo.*" class="txt c1" style="height:50px;width:98%;"> </textarea></td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


