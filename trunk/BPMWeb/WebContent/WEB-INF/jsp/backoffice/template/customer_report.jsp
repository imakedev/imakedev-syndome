<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
	    <!--Body content-->
<script type="text/javascript">
$(document).ready(function() {
	initGroupList();
});
function initGroupList(){
	$.ajax({
		  type: "get",
		  url: "reportmanagement/customerReportListGroup",
		  cache: false
		}).done(function( data ) {
			if(data!=null){
				var str="เลือก กลุ่ม : <select id=\"groupListElement\" onchange=\"findCustomer('1')\">";
				var haveSale=false;
				if(data.groupList.length>0){
					haveSale=true;
					for(var i=0;i<data.groupList.length;i++){
						str=str+"<option value=\""+data.groupList[i][0]+"\">"+data.groupList[i][1]+"</option>";
					}
				}
				str=str+"</select>";
				$("#_groupList").html(str);
				if(haveSale)
					findCustomer("1");
			}
		});
}
function findCustomer(mode){
	var val = document.getElementById("groupListElement").value;
	var url= "reportmanagement/customerReportFind/"+val;
	//alert(url)
	$.ajax({
		  type: "get",
		  url:url,
		  cache: false
		}).done(function( data ) {
			if(data!=null){
				var obj = data;
				var _str="";
				if(mode=="1"){
					// set All 
		// 2b
       	_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
	   "<thead>"+
	   	 "<tr>"+        	 
   		"<th width=\"90%\"><div class=\"th_class\">ประเภทอุตสาหกรรม</div></th>"+ 
   		"<th width=\"10%\"><div class=\"th_class\">เปอร์เซนต์</div></th>"+
 		"</tr>"+
 	   "</thead>"+
	     "<tbody>";
				  if(obj.industryPercent!=null)
					  for(var i=0;i<obj.industryPercent.length;i++){
							_str=_str+"<tr>"+
							 	"<td>&nbsp;"+obj.industryPercent[i][2]+"&nbsp;&nbsp;("+obj.industryPercent[i][0]+")</td>"+
							 	"<td>&nbsp;"+obj.industryPercent[i][1]+"&nbsp;%</td>"+ 
							 	"</tr>"; 
						} 
						_str=_str+"</tbody>"+
					      "</table>";
					$("#_content_industryPercent").html(_str);
 
					 // 2c
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายการลูกค้า</div></th>"+ 
				   		"<th width=\"10%\"><div class=\"th_class\">ยอดการซื้อ(Unit)</div></th>"+
				   		"<th width=\"10%\"><div class=\"th_class\">การใช้(Unit)</div></th>"+
				   		"<th width=\"10%\"><div class=\"th_class\">คงเหลือ(Unit)</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>"; 
					  if(obj.orderStat!=null)
						for(var i=0;i<obj.orderStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.orderStat[i][0]+"</td>"+
									 	"<td>&nbsp;"+obj.orderStat[i][1]+"</td>"+
									 	"<td>&nbsp;"+obj.orderStat[i][2]+"</td>"+
									 	"<td>&nbsp;"+obj.orderStat[i][3]+"</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_orderStat").html(_str);
					
					//2d 
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายชื่อลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">การเข้าใช้(ครั้ง)</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.usedStat!=null)
						for(var i=0;i<obj.usedStat.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.usedStat[i][2]+"</td>"+
									 	"<td>&nbsp;"+obj.usedStat[i][0]+"</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_usedStat").html(_str); 
					
					//2e
					_str="<table class=\"table stable-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
					   "<thead>"+
					   	 "<tr>"+        	 
				   		"<th width=\"70%\"><div class=\"th_class\">รายการลูกค้า</div></th>"+ 
				   		"<th width=\"15%\"><div class=\"th_class\">เข้าใช้งานล่าสุด</div></th>"+
				   		"</tr>"+
				 	   "</thead>"+
					     "<tbody>";
					  if(obj.lastLogin!=null)
						for(var i=0;i<obj.lastLogin.length;i++){
							_str=_str+"<tr>"+
									 	"<td>&nbsp;"+obj.lastLogin[i][2]+"&nbsp;</td>"+
									 	"<td>&nbsp;"+obj.lastLogin[i][3].split(" ")[0]+"&nbsp;&nbsp;(&nbsp;"+obj.lastLogin[i][4]+"&nbsp;)</td>"+
									 	"</tr>"; 
								} 
								_str=_str+"</tbody>"+
							      "</table>";
					$("#_content_lastLogin").html(_str); 
					
					//2h
			 _str="";
			  if(obj.deadstock!=null)
				for(var i=0;i<obj.deadstock.length;i++){
					if(i==(obj.deadstock.length-1))
						_str=_str+obj.deadstock[i][0]+"";
					else
						_str=_str+obj.deadstock[i][0]+"&nbsp;,&nbsp;";
				}
				$("#_content_deadstock").html(_str);
				
				}
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
  <form   class="well" style="border:2px solid #DDD;background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
            <strong style="font-family: sans-serif;font-size: 14px">2. Customer Report: รายงานสรุปภาพรวมของลูกค้าที่ใช้บริการ</strong><br/><br/>
a. แบ่งกลุ่มลูกค้า ออกเป็น    4 ประเภท<br/>
i. กลุ่ม A คือ มีการเข้าใช้ การสั่งซื้อ อย่างสม่ำเสมอ<br/>
ii. กลุ่ม B คือ มีการเข้าใช้ จำนวนน้อย นานๆครั้ง หมดแล้วมีการสั่งซื้อเพิ่ม<br/>
iii. กลุ่ม C คือ มีการเข้าใช้ จำนวนน้อย นานๆครั้ง หมดแล้วไม่มีการสั่งซื้อเพิ่ม (หมดไปสามเดือนแล้วไม่มีการสั่งซื้อเพิ่ม)<br/>
iv. กลุ่ม D คือ มีการสั่งซื้อ เข้าใช้ไม่มากกว่า 10 ครั้ง แล้วไม่มีการเข้าใช้อีกเลย<br/>
<div id="_groupList">เลือก กลุ่ม : <select id="groupListElement" onchange="findCustomer('1')" style="width: 60px">
<!--  
<option value="">A</option>
<option value="">B</option>
<option value="">C</option>
<option value="">D</option>
 -->
</select></div>
b. ว่ามีกี่ประเภทอุตสาหกรรม และ มีกี่จำนวนแต่ละอุตสาหกรรม แบ่งเป็นเปอร์เซนต์<br/>
<span id="_content_industryPercent">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="90%"><div class="th_class">ประเภทอุตสาหกรรม</div></th>  
            		<th width="10%"><div class="th_class">เปอร์เซนต์</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;ประเภทอุตสาหกรรม 1 (40) </td>
            	<td>&nbsp;20% </td>  
            </tr>
           	<tr>
            	<td>&nbsp;ประเภทอุตสาหกรรม 2 (160) </td>
            	<td>&nbsp;80% </td> 
         	</tr> 
         	 -->
        	</tbody>
      </table>
</span>
c. ยอดการซื้อ การใช้ และ คงเหลือของแต่ละลูกค้า<br/>
<span id="_content_orderStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="70%"><div class="th_class">รายการลูกค้า</div></th>  
            		<th width="10%"><div class="th_class">ยอดการซื้อ(Unit)</div></th>
            		<th width="10%"><div class="th_class">การใช้(Unit)</div></th>
            		<th width="10%"><div class="th_class">คงเหลือ(Unit)</div></th>
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;ลูกค้า 1</td>
            	<td>&nbsp;20</td>  
            	<td>&nbsp;100</td>
            	<td>&nbsp;10</td> 
         	</tr> 
         	<tr>
            	<td>&nbsp;ลูกค้า 2</td>
            	<td>&nbsp;10</td>  
            	<td>&nbsp;50</td>
            	<td>&nbsp;5</td> 
         	</tr> 
         	 -->
        	</tbody>
      </table>
</span>
d. จำนวนการเข้าใช้ของแต่ละลูกค้า<br/>
<span id="_content_usedStat">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="90%"><div class="th_class">รายการลูกค้า</div></th>  
            		<th width="10%"><div class="th_class">การเข้าใช้(ครั้ง)</div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;ลูกค้า 1</td>
            	<td>&nbsp;20</td>   
         	</tr> 
         	<tr>
            	<td>&nbsp;ลูกค้า 2</td>
            	<td>&nbsp;10</td>   
         	</tr>
         	 --> 
        	</tbody>
      </table>
</span>
e. สถานการณ์การเข้าใช้งาน ล่าสุด อัตราการเข้าใช้งาน (ความถี่การเข้าใช้งาน)<br/>
<span id="_content_lastLogin">
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="80%"><div class="th_class">รายการลูกค้า</div></th>   
            		<th width="20%"><div class="th_class">เข้าใช้งานล่าสุด</div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	<!-- 
          	<tr>
            	<td>&nbsp;ลูกค้า 1</td> 
            	<td>&nbsp;28/08/2012 (2 ครั้ง)</td> 
         	</tr>
         	 -->  
        	</tbody>
      </table>
</span>
f. แสดงสถานภาพการใช้แบบประเมินแต่ละประเภทของแต่ละลูกค้า (ไม่เอาแล้ว)<br/>
g. แสดงรายงาน แนวโน้มการสั่งซื้อ (การเก็บประวัติการใช้งาน ประวัติการใช้งาน จำนวนการใช้งาน เพื่อดูแนวโน้มการใช้งานของแต่เดือนของแต่ละลูกค้า) แต่ละแบบประเมินที่ลูกค้าซื้อ<br/>
h. แสดงรายงาน พวก Dead stock คือ กลุ่มที่ซื้อแล้วไม่มีการเข้าใช้เลย <br/>

<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">รายการลูกค้า</div></th>   
          		</tr>
        	</thead>
        	<tbody> 
          	<tr>
          		<!-- 
            		<td>&nbsp;ลูกค้า 1 , ลูกค้า 1 </td>
            	 --> 
            	 <td>&nbsp;<span id="_content_deadstock"></span></td> 
         	</tr>
         	  
        	</tbody>
      </table>
</form>
      </fieldset> 
  