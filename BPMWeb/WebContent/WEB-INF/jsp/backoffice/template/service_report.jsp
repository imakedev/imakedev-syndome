<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
	    <!--Body content-->
<script type="text/javascript">
$(document).ready(function() {
	 //0=month & year,1=all
	callByYear("1");
});
function callByYear(mode){
	//alert("xx "+document.getElementById("productReport_year").value)
	$.ajax({
		  type: "get",
		  url: "reportmanagement/serviceReportWithYear/"+mode+"/"+document.getElementById("serviceReport_month").value+"/"+document.getElementById("serviceReport_year").value,
		  cache: false
		 // dataType: 'xml',
		  //contentType: "application/json; charset=utf-8"
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				//alert(data["ServiceReport"]["seryPercentReactive"])
				//alert(data.seryProblem[0])
				//var obj = jQuery.parseJSON(data);
				var obj = data;
				//alert(obj["ServiceReport"]["seryCountReactive"][1])
				/*  alert(obj.seryCountReactive[0][1])
				alert(obj.seryProblem[0]) */
				//alert(obj.seryMaxUses[2])
				var _str="";
				if(mode=="1"){
					// set All
				
					for(var i=0;i<obj.seryProblem.length;i++){
						if(i==(obj.seryProblem.length-1))
							_str=_str+obj.seryProblem[i]+"";
						else
							_str=_str+obj.seryProblem[i]+" &gt; ";
					}
					$("#_content_seryProblem").html(_str);
					_str="";
					for(var i=0;i<obj.browsers.length;i++){
						if(i==(obj.browsers.length-1))
							_str=_str+obj.browsers[i]+"";
						else
							_str=_str+obj.browsers[i]+" &gt; ";
					}
					$("#_content_browsers").html(_str);
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
		            		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
		            		"<th width=\"15%\"><div class=\"th_class\">จำนวนการ Reactive</div></th>"+
		          		"</tr>"+
		          	   "</thead>"+
		        	     "<tbody>";
		            	 
		        	
					for(var i=0;i<obj.seryCountReactive.length;i++){
						_str=_str+"<tr>"+
						 	"<td>&nbsp;"+obj.seryCountReactive[i][1]+"</td>"+
						 	"<td>&nbsp;"+obj.seryCountReactive[i][0]+"</td>"+
						 	"</tr>"; 
					} 
					_str=_str+"</tbody>"+
				      "</table>";
					$("#_content_count_reactive").html(_str);
					
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
		            		"<th width=\"70%\"><div class=\"th_class\">แบบประเมิน</div></th>"+ 
		            		"<th width=\"15%\"><div class=\"th_class\">เปอร์เซนต์(Reactive)</div></th>"+
		          		"</tr>"+
		          	   "</thead>"+
		        	     "<tbody>";
		            	 
		        	
					for(var i=0;i<obj.seryPercentReactive.length;i++){
						_str=_str+"<tr>"+
						 	"<td>&nbsp;"+obj.seryPercentReactive[i][1]+"</td>"+
						 	"<td>&nbsp;"+obj.seryPercentReactive[i][0]+"&nbsp;%</td>"+
						 	"</tr>"; 
					} 
					_str=_str+"</tbody>"+
				      "</table>";
					$("#_content_percent_reactive").html(_str);
				}
				_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
				   "<thead>"+
				   	 "<tr>"+        	 
	            		"<th width=\"50%\"><div class=\"th_class\">Week</div></th>"+ 
	            		"<th width=\"25%\"><div class=\"th_class\">วัน/เวลา เข้าใช้งานมากสุด</div></th>"+
	            		"<th width=\"25%\"><div class=\"th_class\">วัน/เวลา เข้าใช้งานน้อยสุด</div></th>"+
	          		"</tr>"+
	          	   "</thead>"+
	        	     "<tbody>";
	            	 
	        	
				for(var i=0;i<obj.serySystemUsed.length;i++){
					_str=_str+"<tr>"+
					 	"<td>Week&nbsp;"+obj.serySystemUsed[i][0]+"</td>"+
					 	"<td>&nbsp;<span  align=\"center\">"+obj.serySystemUsed[i][1]+"</span></td>"+
					 	"<td>&nbsp;<span  align=\"center\">"+obj.serySystemUsed[i][2]+"</span></td>"+
					 	"</tr>"; 
				} 
				_str=_str+"</tbody>"+
			      "</table>";
				$("#_content_system_used").html(_str);
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
           <strong style="font-family: sans-serif;font-size: 14px">3. Service Report: รายงานสรุปภาพรวมของระบบการเข้าใช้งาน</strong><br/><br/>
a. เปอร์เซนต์ของลูกค้าที่เข้ามาแต่ใช้งานระบบในแต่ละอาทิตย์ เวลาไหน หรือ วันใดที่มีการเข้าใช้งานมากสุด น้อยสุด เลือกเดือน : 
<form:select path="serviceReport.month" id="serviceReport_month" cssStyle="width: 60px" onchange="callByYear('0')">
<form:option value="1">ม.ค.</form:option>>
<form:option value="2">ก.พ.</form:option>> 
<form:option value="3">มี.ค.</form:option>>
<form:option value="4">เม.ย.</form:option>>
<form:option value="5">พ.ค.</form:option>>
<form:option value="6">มิ.ย.</form:option>>
<form:option value="7">ก.ค.</form:option>>
<form:option value="8">ส.ค.</form:option>>
<form:option value="9">ก.ย.</form:option>>
<form:option value="10">ต.ค.</form:option>>
<form:option value="11">พ.ย.</form:option>>
<form:option value="12">ธ.ค.</form:option>>
</form:select> 	    					     
 เลือกปี : 
<form:select path="serviceReport.year" id="serviceReport_year" cssStyle="width: 70px" onchange="callByYear('0')">
    		<form:option value="2010">2010</form:option>
    		<form:option value="2011">2011</form:option>
    		<form:option value="2012">2012</form:option>
    						<%--  <form:options items="${missSeries}" itemLabel="msSeriesName" itemValue="msId"></form:options> --%>
	    					     
</form:select><br/>
<span id="_content_system_used">  
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="50%"><div class="th_class">Week</div></th> 
            		<th width="25%"><div class="th_class">วัน/เวลา เข้าใช้งานมากสุด</div></th>
            		<th width="25%"><div class="th_class">วัน/เวลา เข้าใช้งานน้อยสุด</div></th>
          		</tr>
        	</thead>
        	<tbody>
          <!-- 	<tr>
            	<td>&nbsp;Week 1</td>
            	<td>&nbsp;28/08/2012 13:00</td>
            	<td>&nbsp;28/08/2012 13:00</td>
         	</tr>
         	<tr>
         		<td>&nbsp;Week 1</td>
            	<td>&nbsp;28/08/2012 13:00</td>
            	<td>&nbsp;28/08/2012 13:00</td>
         	</tr>
         	<tr>
            	<td>&nbsp;Week 3</td>
            	<td>&nbsp;28/08/2012 13:00</td>
            	<td>&nbsp;28/08/2012 13:00</td>
         	</tr>
         	<tr>
            	<td>&nbsp;Week 4</td>
            	<td>&nbsp;28/08/2012 13:00</td>
            	<td>&nbsp;28/08/2012 13:00</td>
         	</tr> -->
        	</tbody>
      </table>
</span>
<b>b. เปอร์เซนต์ ของแต่ละแบบประเมินที่มีการ Reactive<br/>
- เก็บจำนวนครั้ง</b><br/>
<span id="_content_percent_reactive">  
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">แบบประเมิน</div></th> 
            		<th width="15%"><div class="th_class">เปอร์เซนต์(Reactive)</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	    	
        	 <!-- <tr>
            	<td>&nbsp;EPT s</td>
            	<td>&nbsp;10%</td>
         	</tr>
         	<tr>
            	<td>&nbsp;EPT 2</td>
            	<td>&nbsp;90%</td>
         	</tr>  -->
         	
        	</tbody>
      </table>
      </span>
<b>c. แสดงรายงาน ชื่อลูกค้า ที่เข้ามาทำการ Reactive และ จำนวนการ Reactive</b><br/>
<span id="_content_count_reactive"> 
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายชื่อลูกค้า</div></th> 
            		<th width="15%"><div class="th_class">จำนวนการ Reactive</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	 
          	<!-- <tr>
            	<td>&nbsp;Company 1</td>
            	<td>&nbsp;1</td>
         	</tr>
         	<tr>
            	<td>&nbsp;Company 2</td>
            	<td>&nbsp;9</td>
         	</tr> -->
         	
        	</tbody>
      </table>
</span>
<b>d. แสดงรายงาน การเรียกใช้ Browser แต่ละประเภท ของลูกค้า</b><br/>
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">Browser</div></th>  
          		</tr>
        	</thead>
        	<tbody> 
          	<tr>
            	<td>&nbsp;<span id="_content_browsers"></span></td> 
         	</tr>  
        	</tbody>
      </table>
<b>e. แสดงประเภทแบบประเมินที่ลูกค้าใช้เวลาทำ เกินกำหนดหรือทำไม่ครบแบบประเมินแล้วหมดเวลา</b><br/>
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">ประเภทแบบประเมิน</div></th>  
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>&nbsp;<span id="_content_seryProblem"></span></td> 
         	</tr> 
        	</tbody>
      </table>
f. จัดเก็บประวัติ การเกิดปัญหา ในแต่ละเดือน ตลอดปี<br/>
g. จัดเก็บประวัติ จำนวนการทำ Reactive ของแต่ละประเภทแบบทดสอบตลอดปี<br/>
h. จัดเก็บประวัติ ช่วงเวลาการเข้าทำแบบประเมินสูงสุด ตลอดปี<br/>
</form:form>
      </fieldset> 
  