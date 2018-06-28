<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
           var xspecItem = '';
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_tran_pa');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_tran_pa',
                        options : [{
							type : '0',//[1]
							name : 'accy',
							value : r_accy
					},{
						type : '1',//[2][3]
						name : 'date'
					},{
						type : '1',//[4][5]
						name : 'noa'
					},{
                        type : '2', //[6][7]
                        name : 'xcno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    },{
						type : '2', //[8][9]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
                        type : '2', //[10][11]
                        name : 'xproduct',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    },{
						type : '2', //[12][13]
						name : 'xcar2',
						dbf : 'car2',
						index : 'noa,driver',
						src : 'car2_b.aspx'
					},{
                        type : '2', //[14][15]
                        name : 'xdriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    },{
                        type : '1',//[16][17]
                        name : 'Xmon'
                    },{
                        type : '1',//[18][19]
                        name : 'vnoa'
                    },{
                        type : '1',//[20][21]
                        name : 'odate'
                    },{
                        type : '6',
                        name : 'xstype', //[22]
                        value : xspecItem.split(',')
                    },{
                        type : '5', //[23]
                        name : 'xshow1',
                        value : (' @全部,0@未派車,1@已派車').split(',')
                    },{
                        type : '5', //[24]
                        name : 'xshow2',
                        value : (' @全部,0@未完工,1@已完工').split(',')
                    },{//2
                        type : '8',//[25]
                        name : 'xdetail',
                        value : "1@顯示明細".split(',')
                    }]
                    });
                q_popAssign();
                
                var r_1911=1911;
                if(r_len==4){           
                    $.datepicker.r_len=4;
                    r_1911=0
                }
                
                 $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker();
	             $('#txtXmon1').mask('999/99');
	             $('#txtXmon2').mask('999/99');
                 
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtNoa1').val(t_noa);
                $('#txtNoa2').val(t_noa);
                
                var tmp = document.getElementById("txtXstype");
                var selectbox = document.createElement("select");
                selectbox.id = "combXstype";
                selectbox.style.cssText = "width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox, tmp);
                
                $('#combXstype').change(function() {
                    $('#txtXstype').val($('#combXstype').find("option:selected").text());
                });
                
                 var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-r_1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                $('#txtOdate1').val(t_year+'/'+t_month+'/'+t_day);
	                $('#txtXmon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-r_1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
	                $('#txtOdate2').val(t_year+'/'+t_month+'/'+t_day);
	                $('#txtXmon2').val(t_year+'/'+t_month);
	                
	                q_gt('view_tranorde', '1=1 ', 0, 0, 0, "view_tranorde");
	        }

            function q_boxClose(s2) {
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'view_tranorde':
                        var as = _q_appendData("view_tranorde", "", true);
                        xspecItem = " @ ";
                        for ( i = 0; i < as.length; i++) {
                                var txspecItem = xspecItem.split(',');
                                var t_exists = false;
                                for (var j = 0; j < txspecItem.length; j++) {
                                    if (as[i].stype == txspecItem[j]) {
                                        t_exists = true;
                                        break;
                                    }
                                }
                                if (!t_exists)
                                    xspecItem += "," + as[i].stype;
                                if (xspecItem.length != 0) {
                                    $('#combXstype').empty();
                                    q_cmbParse("combXstype", xspecItem);
                                }
                        }
                        break;
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          