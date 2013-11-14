<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackEmployee(){
 
	  $.ajax({
		  type: "get",
		  url: "employee/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doEmployeeAction(action,mode,id){
	var peWage=jQuery.trim($("#peWage").val());
	 if(!(intRegex.test(peWage) || floatRegex.test(peWage))) {
	        alert('Please fill Number !!!');  
	        $("#peWage").focus();
	        return false;
	     }
	var target="employee"; 
 	$.post(target+"/action/employee",$("#employeeForm").serialize(), function(data) {
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
	    <form:form id="employeeForm" name="employeeForm" modelAttribute="employeeForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${employeeForm.pstEmployee.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${employeeForm.pstEmployee.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstEmployee.peId" id="peId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Employee</strong><br></br>
            	</div> 
	 
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รหัส :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstEmployee.peUid" id="peUid" cssStyle="height: 30;width:80px"/>
    					</td> 
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">คำนำหน้า :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:select path="pstEmployee.pstTitle.ptId"  cssStyle="width:80px">
	    						     <%--  <form:option value="0">--</form:option> --%>
	    					      	  <form:options itemValue="ptId" itemLabel="ptName" items="${titles}"/>
	    					     
	    			 	</form:select>&nbsp;
    					ชื่อ :
    					<form:input path="pstEmployee.peFirstName" id="peFirstName" cssStyle="height: 30;"/>&nbsp;
    					นามสกุล :
    					<form:input path="pstEmployee.peLastName" id="peLastName" cssStyle="height: 30;"/>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ตำแหน่ง :</span></td>
    					<td width="75%" colspan="2">  
    					
	    			 	<form:select path="pstEmployee.pstPosition.ppId">
	    						   <%--	   <form:option value="0">--</form:option>  --%>
	    					      	  <form:options itemValue="ppId" itemLabel="ppName" items="${positions}"/>
	    					     
	    			 	</form:select>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ค่าแรง :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstEmployee.peWage" id="peWage" cssStyle="height: 30;width:80px"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">เบอร์รถ :</span></td>
    					<td width="75%" colspan="2">  
    					
	    			 	<form:select path="pstEmployee.pstRoadPump.prpId">
	    						   <%--    <form:option value="0">--</form:option>  --%>
	    					      	  <form:options itemValue="prpId" itemLabel="prpNo" items="${pstRoadPumpNos}"/>
	    			 	</form:select>
    					</td> 
    				</tr></table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackEmployee()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doEmployeeAction('action','${employeeForm.mode}','${employeeForm.pstEmployee.peId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>