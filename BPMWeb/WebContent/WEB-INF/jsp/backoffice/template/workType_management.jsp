<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<style>
hr{
border-top:1px solid #B3D2EE;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackWorkType(){
 
	  $.ajax({
		  type: "get",
		  url: "workType/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
 
function doWorkTypeAction(action,mode,id){
	/* var pwtName=jQuery.trim($("#pwtName").val());
	if(pwtName.length==0){
		 alert('กรุณากรอก รายการตรวจเช็ค');  
		 $("#pwtName").focus();
	        return false;
	    }  */
	
	var target="workType"; 
 	$.post(target+"/action/workType",$("#workTypeForm").serialize(), function(data) {
		  // alert(data);
		  appendContent(data);
		   //appendContentWithId(data,"tabs-3");
		  // alert($("#_content").html());
		});
  }
 
</script>
<div style="${display};padding-top:10px">
 <div class="alert alert-success" style="${display}">    
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	    <form:form id="workTypeForm" name="workTypeForm" modelAttribute="workTypeForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${workTypeForm.pstWorkType.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${workTypeForm.pstWorkType.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstWorkType.pwtId" id="pwtId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>จัดการประเภทงาน</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">แผนก :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:select path="pstWorkType.pstDepartment.pdId" cssStyle="width:120px">
    						 	<%-- <form:option value="-1">---</form:option> --%> 
    						 	<form:options items="${pstDepartments}" itemLabel="pdName" itemValue="pdId"></form:options> 
    						 </form:select> 
    					</td> 
    				</tr>
    				
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รายการตรวจเช็ค :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstWorkType.pwtName" id="pwtName" cssStyle="height: 30;width:300px"/>
    					</td> 
    				</tr>
				<%-- <tr valign="middle">
					<td width="25%" align="right"><span
						style="font-size: 13px; padding: 15px">อัตราค่าแรง(เท่า) :</span></td>
					<td width="75%" colspan="2"><form:input
							path="pstWorkType.pesWageRate" id="pesWageRate"
							cssStyle="height: 30;width:80px" /></td>
				</tr> --%>
			</table> 
			<hr/>
			<table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"><strong style="padding-left: 50px">Config for Maintenance</strong></td>
    				</tr> 		
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ระยะเวลา :</span></td>
    					<td width="75%" colspan="2"> 
    					<fmt:formatNumber pattern="###.##"  
     value="${workTypeForm.pstWorkType.pwtPeriod}"  var="pwtPeriod_formated"/>
    						<form:input path="pstWorkType.pwtPeriod" id="pwtPeriod" value="${pwtPeriod_formated}"  cssStyle="height: 30;width:120px;text-align:right"/>&nbsp;วัน
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">คอนกรีต :</span></td>
    					<td width="75%" colspan="2"> 
    					<fmt:formatNumber pattern="###.##"  
     value="${workTypeForm.pstWorkType.pwtConcrete}"  var="pwtConcrete_formated"/>
    						<form:input path="pstWorkType.pwtConcrete" id="pwtConcrete"  value="${pwtConcrete_formated}"  cssStyle="height: 30;width:120px;text-align:right"/>&nbsp;คิว
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">เลขไมค์ :</span></td>
    					<td width="75%" colspan="2"> 
    					<fmt:formatNumber pattern="###.##"  
     value="${workTypeForm.pstWorkType.pwtMile}"  var="pwtMile_formated"/>
    						<form:input path="pstWorkType.pwtMile" id="pwtMile"  value="${pwtMile_formated}"  cssStyle="height: 30;width:120px;text-align:right"/>&nbsp;กม.
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ชม.การทำงาน :</span></td>
    					<td width="75%" colspan="2"> 
    					<fmt:formatNumber pattern="###.##"  
     value="${workTypeForm.pstWorkType.pwtHoursOfWork}"  var="pwtHoursOfWork_formated"/>
    						<form:input path="pstWorkType.pwtHoursOfWork" id="pwtHoursOfWork" value="${pwtHoursOfWork_formated}"  cssStyle="height: 30;width:120px;text-align:right"/>&nbsp;ชม.
    					</td> 
    				</tr>
				<%-- <tr valign="middle">
					<td width="25%" align="right"><span
						style="font-size: 13px; padding: 15px">อัตราค่าแรง(เท่า) :</span></td>
					<td width="75%" colspan="2"><form:input
							path="pstWorkType.pesWageRate" id="pesWageRate"
							cssStyle="height: 30;width:80px" /></td>
				</tr> --%>
			</table>
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackWorkType()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a> 
    					 <a class="btn btn-primary"  onclick="doWorkTypeAction('action','${workTypeForm.mode}','${workTypeForm.pstWorkType.pwtId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>