<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
	    <!--Body content-->
<script type="text/javascript">
$(document).ready(function() {
	initSaleList();
});
function initSaleList(){
	$.ajax({
		  type: "get",
		  url: "reportmanagement/consultantReportListSale",
		  cache: false
		}).done(function( data ) {
			if(data!=null){
				var str="ชื่อฝ่ายขาย : <select id=\"saleListElement\" onchange=\"findConsult('1')\">";
				var haveSale=false;
				if(data.salesList.length>0){
					haveSale=true;
					for(var i=0;i<data.salesList.length;i++){
						str=str+"<option value=\""+data.salesList[i][0]+"\">"+data.salesList[i][1]+"</option>";
					}
				}
				str=str+"</select>";
				$("#_saleList").html(str);
				if(haveSale)
					findConsult("1");
			}
		});
}
function findConsult(mode){
	var val = document.getElementById("saleListElement").value;
	var month= document.getElementById("consultantReport_month").value;
	var year=document.getElementById("consultantReport_year").value;
	//alert(mode+","+val+","+month+","+year);
	//return false;
	//alert("xx "+document.getElementById("productReport_year").value)
	// /consultantReport/{mode}/{mcontactId}/{month}/{year}
	var url= "reportmanagement/consultantReportFind/"+mode+"/"+val+"/"+month+"/"+year;
	//alert(url)
	$.ajax({
		  type: "get",
		  url:url,
		  cache: false
		}).done(function( data ) {
			if(data!=null){
				var obj = data;
				//alert(obj);
				
				var _str="";
				if(mode=="1"){
					// set All
					 
      	_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
	   "<thead>"+
	   	 "<tr>"+        	 
   		"<th width=\"60%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
   		"<th width=\"20%\"><div class=\"th_class\">เข้าระบบครั้งแรก</div></th>"+
   		"<th width=\"20%\"><div class=\"th_class\">เข้าระบบครั้งล่าสุด</div></th>"+
 		"</tr>"+
 	   "</thead>"+
	     "<tbody>";
				  if(obj.loginStat!=null)
					  for(var i=0;i<obj.loginStat.length;i++){
							_str=_str+"<tr>"+
							 	"<td>&nbsp;"+obj.loginStat[i][2]+"</td>"+
							 	"<td>&nbsp;"+obj.loginStat[i][4]+"</td>"+
							 	"<td>&nbsp;"+obj.loginStat[i][3]+"</td>"+
							 	"</tr>"; 
						} 
						_str=_str+"</tbody>"+
					      "</table>";
					$("#_content_loginStat").html(_str);

					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">จำนวนการ Reactive</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.reactiveStat!=null)
						for(var i=0;i<obj.reactiveStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.reactiveStat[i][0]+"</td>"+
									 	"<td>&nbsp;"+obj.reactiveStat[i][1]+"</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_reactiveStat").html(_str);
					
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">จำนวนการสั่งซื้อ</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.orderStat!=null)
						for(var i=0;i<obj.orderStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.orderStat[i][0]+"</td>"+
									 	"<td>&nbsp;"+obj.orderStat[i][1]+"</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_orderStat").html(_str); 
					
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">Update ล่าสุด</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.updateStat!=null)
						for(var i=0;i<obj.updateStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.updateStat[i][0]+"&nbsp;&nbsp;[&nbsp;"+obj.updateStat[i][1]+"&nbsp;]</td>"+
									 	"<td>&nbsp;"+obj.updateStat[i][2]+"&nbsp;</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_updateStat").html(_str);
					
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">วันเกิด</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.birthdayStat!=null)
						for(var i=0;i<obj.birthdayStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.birthdayStat[i][0]+"&nbsp;&nbsp;[&nbsp;"+obj.birthdayStat[i][1]+"&nbsp;]</td>"+
									 	"<td>&nbsp;"+obj.birthdayStat[i][2]+"&nbsp;</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#birthdayStat").html(_str);
				}

				_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
				   "<thead>"+
				   	 "<tr>"+        	 
			   		"<th width=\"70%\"><div class=\"th_class\">แบบประเมิน</div></th>"+ 
			   		"<th width=\"15%\"><div class=\"th_class\">เปอร์เซนต์</div></th>"+
			   		"</tr>"+
			 	   "</thead>"+
				     "<tbody>";
				  if(obj.saleStat!=null)
					for(var i=0;i<obj.saleStat.length;i++){
						_str=_str+"<tr>"+
								 	"<td>&nbsp;"+obj.saleStat[i][0]+"</td>"+
								 	"<td>&nbsp;"+obj.saleStat[i][1]+"&nbsp;%</td>"+
								 	"</tr>"; 
							} 
							_str=_str+"</tbody>"+
						      "</table>";
				$("#_content_saleStat").html(_str);	
				 
			  }
		});
}

</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
</style>
<div id="dialog-confirmDelete" title="Delete Candidate" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Candidate ?
</div>
<fieldset style="font-family: sans-serif;">
  <%-- <form   class="well" style="border:2px solid #DDD;background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}"> --%>
   <form:form  id="reportManagementForm" name="reportManagementForm" modelAttribute="reportManagementForm"  cssClass="well" method="post" action="" cssStyle="border:2px solid #DDD;background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
          <strong style="font-family: sans-serif;font-size: 14px">5. Consultant Report: รายงานสรุปภาพรวมของฝ่ายขาย</strong><br/><br/>
          <div id="_saleList">ชื่อฝ่ายขาย : <select id="saleListElement" onchange="findConsult('1')">
          <!--  
<option value="">นาย A</option>
<option value="">นาย B</option>
 -->
</select></div>
<b>a. แสดงรายการ ลูกค้า (แสดงการเข้าระบบครั้งแรก และ ล่าสุด ) ของแต่ละคนของ ฝ่ายขาย</b><br/>
<span id="_content_loginStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="60%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="20%"><div class="th_class">เข้าระบบครั้งแรก</div></th>
            		<th width="20%"><div class="th_class">เข้าระบบครั้งล่าสุด</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!--   
          	<tr>
            	<td>&nbsp;Company 1</td>
            	<td>&nbsp;28/08/2012 12:00</td>
            	<td>&nbsp;28/09/2012 12:00</td>
         	</tr>
         	-->
        	</tbody>
      </table>
 </span>
<b>b. แสดงรายการ สถานการณ์การเข้าใช้งานของลูกค้าและจำนวนการ Reactive ของลูกค้าแต่ละคนของฝ่ายขาย</b><br/>
<span id="_content_reactiveStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="15%"><div class="th_class">จำนวนการ Reactive</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!--   
          	<tr>
            	<td>&nbsp;Company 1</td>
            	<td>&nbsp;10</td>
         	</tr>
         	-->
        	</tbody>
      </table>
</span>
<b>c. แสดงรายการ การสั่งซื้อแบบประเมินเพิ่ม หรือ ใหม่ของแต่ละคนของฝ่ายขาย</b><br/>
<span id="_content_orderStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="15%"><div class="th_class">จำนวนการสั่งซื้อ</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!--  
          	<tr>
            	<td>&nbsp;Company 1</td>
            	<td>&nbsp;10</td>
         	</tr>
         	 -->
        	</tbody>
      </table>
</span>
<b>d. แสดงรายการ  การขายได้ของแบบประเมินแต่ละแบบของฝ่ายขายแต่ละคน (คิดเป็นเปอร์เซนต์) ในแต่ละเดือนและเก็บประวัติในแต่ละเดือนด้วย เลือกเดือน : 
 
 <form:select path="consultantReport.month" id="consultantReport_month" cssStyle="width: 60px" onchange="findConsult('0')">
<form:option value="1">ม.ค.</form:option>
<form:option value="2">ก.พ.</form:option> 
<form:option value="3">มี.ค.</form:option>
<form:option value="4">เม.ย.</form:option>
<form:option value="5">พ.ค.</form:option>
<form:option value="6">มิ.ย.</form:option>
<form:option value="7">ก.ค.</form:option>
<form:option value="8">ส.ค.</form:option>
<form:option value="9">ก.ย.</form:option>
<form:option value="10">ต.ค.</form:option>
<form:option value="11">พ.ย.</form:option>
<form:option value="12">ธ.ค.</form:option>
</form:select> 	    					     
 เลือกปี : 
<form:select path="consultantReport.year" id="consultantReport_year" cssStyle="width: 70px" onchange="findConsult('0')">
    		<form:option value="2010">2010</form:option>
    		<form:option value="2011">2011</form:option>
    		<form:option value="2012">2012</form:option>
	    					     
</form:select>
<!--  
<select id="consultantReport_month" style="width: 60px" onchange="findConsult('0')">
<option value="1">ม.ค.</option>
<option value="2">ก.พ.</option> 
<option value="3">มี.ค.</option>
<option value="4">เม.ย.</option>
<option value="5">พ.ค.</option>
<option value="6">มิ.ย.</option>
<option value="7">ก.ค.</option>
<option value="8">ส.ค.</option>
<option value="9">ก.ย.</option>
<option value="10">ต.ค.</option>
<option value="11">พ.ย.</option>
<option value="12">ธ.ค.</option>
</select> เลือกปี : 
<select id="consultantReport_year" style="width: 70px" onchange="findConsult('0')">
<option value="2011">2011</option>
<option value="2012">2012</option>
</select>
 -->
</b> <br/>
<span id="_content_saleStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">แบบประเมิน</div></th> 
            		<th width="15%"><div class="th_class">เปอร์เซนต์</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;EPT 1</td>
            	<td>&nbsp;10%</td>
         	</tr>
         	<tr>
            	<td>&nbsp;EPT 2</td>
            	<td>&nbsp;90%</td>
         	</tr>
         	 -->
        	</tbody>
      </table>
</span>
<b>e. แสดงรายการ การ update ผู้ติดต่อหลักของแต่ละลูกค้าฝ่ายขายที่มีการขาย</b><br/>
<span id="_content_updateStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="15%"><div class="th_class">Update ล่าสุด</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;นาย A [ Company 1 ]</td>
            	<td>&nbsp;28/09/2012 12:00</td>
         	</tr>
         	 -->
        	</tbody>
      </table>
</span>
<b>f. แสดงรายการ เตือนแต่ละเดือน วันเกิดลูกค้าที่รับผิดชอบ </b><br/>

<span id="birthdayStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="15%"><div class="th_class">วันเกิด</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!--  
          	<tr>
            	<td>&nbsp;นาย A</td>
            	<td>&nbsp;28</td>
         	</tr>
         	-->
        	</tbody>
      </table>
</span>
</form:form>
      </fieldset> 
  