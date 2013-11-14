<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
	    <!--Body content-->
<script type="text/javascript">
$(document).ready(function() {
});
function callByYear(){
	//alert("xx "+document.getElementById("productReport_year").value)
	$.ajax({
		  type: "get",
		  url: "reportmanagement/productReportWithYear/"+document.getElementById("productReport_year").value,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				//alert(data)
				var obj = jQuery.parseJSON(data);
				//alert(obj.seryMaxUses[2])
				for(var i=0;i<obj.seryMaxUses.length;i++){
					$("#product_m_"+(i+1)).html(obj.seryMaxUses[i]);
				}
				// appendContentWithId(data,"tabs-3")
				// $("#tabs-3").html(data);
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
          <strong style="font-family: sans-serif;font-size: 14px">4. Product Report: รายงานสรุปภาพรวมของแบบประเมิน ที่ถูกใช้และซื้อ เข้าใช้งาน</strong><br/><br/>
<b>a. แสดงรายการใช้ของแต่ละ แบบประเมินจากมากไปน้อย</b><br/>
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">แบบประเมิน</div></th> 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>&nbsp;
            	 <c:forEach items="${reportManagement.seryUses}" var="seryUse" varStatus="loop"> 
	    					 ${seryUse} 
	    					 <c:if test="${not loop.last}"> 
	    					 	&gt;
	    					 </c:if>
	    					 &nbsp;
	    		  </c:forEach>
            	</td>
         	</tr>
         	
        	</tbody>
      </table>
<b>b. แสดงรายการ แบบประเมินที่ถูกซื้อมากสุดไปน้อยสุด</b><br/>
<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">แบบประเมิน</div></th> 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>&nbsp;
            	 <c:forEach items="${reportManagement.seryOrders}" var="seryOrder" varStatus="loop"> 
	    					 ${seryOrder}  
	    					 <c:if test="${not loop.last}"> 
	    					 	&gt;
	    					 </c:if>
	    					 &nbsp;
	    		  </c:forEach>
            	</td>
         	</tr>
        	</tbody>
      </table>
<b>c. แสดงรายการ แบบประเมินที่มีปัญหาการเข้าใช้งานมากสุด</b><br/>
	<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">แบบประเมิน</div></th> 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>&nbsp;
            	 <c:forEach items="${reportManagement.seryProblems}" var="seryProblem" varStatus="loop"> 
	    					 ${seryProblem}
	    					  <c:if test="${not loop.last}"> 
	    					 	&gt;
	    					 </c:if>
	    					 &nbsp;
	    		  </c:forEach>
	    		 </td>
         	</tr>
        	</tbody>
      </table>
<b>d. แสดงรายการ  แบบประเมินที่ถูกเข้าใช้งานมากสุดแต่ละเดือน ของปี 
<!-- <select style="width: 70px" >
<option value="">2011</option>
<option value="">2012</option>
</select> -->
<form:select path="productReport.year" id="productReport_year" cssStyle="width: 70px" onchange="callByYear()">
    		<form:option value="2010">2010</form:option>
    		<form:option value="2011">2011</form:option>
    		<form:option value="2012">2012</form:option>
    						<%--  <form:options items="${missSeries}" itemLabel="msSeriesName" itemValue="msId"></form:options> --%>
	    					     
</form:select>
</b><br/>
	<table class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="100%" colspan="12"><div class="th_class">แบบประเมิน</div></th> 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>&nbsp;ม.ค.</td>
            	<td>&nbsp;ก.พ.</td>
            	<td>&nbsp;มี.ค.</td>
            	<td>&nbsp;เม.ย.</td>
            	<td>&nbsp;พ.ค.</td>
            	<td>&nbsp;มิ.ย.</td>
            	<td>&nbsp;ก.ค.</td>
            	<td>&nbsp;ส.ค.</td>
            	<td>&nbsp;ก.ย.</td>
            	<td>&nbsp;ต.ค.</td>
            	<td>&nbsp;พ.ย.</td>
            	<td>&nbsp;ธ.ค.</td>
         	</tr>
         	<tr>
            	<td>&nbsp;<span id="product_m_1">${reportManagement.seryMaxUses[0]}</span></td>
            	<td>&nbsp;<span id="product_m_2">${reportManagement.seryMaxUses[1]}</span></td>
            	<td>&nbsp;<span id="product_m_3">${reportManagement.seryMaxUses[2]}</span></td>
            	<td>&nbsp;<span id="product_m_4">${reportManagement.seryMaxUses[3]}</span></td>
            	<td>&nbsp;<span id="product_m_5">${reportManagement.seryMaxUses[4]}</span></td>
            	<td>&nbsp;<span id="product_m_6">${reportManagement.seryMaxUses[5]}</span></td>
            	<td>&nbsp;<span id="product_m_7">${reportManagement.seryMaxUses[6]}</span></td>
            	<td>&nbsp;<span id="product_m_8">${reportManagement.seryMaxUses[7]}</span></td>
            	<td>&nbsp;<span id="product_m_9">${reportManagement.seryMaxUses[8]}</span></td>
            	<td>&nbsp;<span id="product_m_10">${reportManagement.seryMaxUses[9]}</span></td>
            	<td>&nbsp;<span id="product_m_11">${reportManagement.seryMaxUses[10]}</span></td>
            	<td>&nbsp;<span id="product_m_12">${reportManagement.seryMaxUses[11]}</span></td>
         	</tr>
        	</tbody>
      </table>
</form:form>
      </fieldset> 
  