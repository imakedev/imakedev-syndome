<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackEmployeeStatus(){
 
	  $.ajax({
		  type: "get",
		  url: "employeeStatus/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
 
function doEmployeeStatusAction(action,mode,id){
	var pesName=jQuery.trim($("#pesName").val());
	if(pesName.length==0){
		 alert('กรุณากรอก คำอธิบาย');  
		 $("#pesName").focus();
	        return false;
	    } 
	var pesWageRate=jQuery.trim($("#pesWageRate").val());
	 if(!(intRegex.test(pesWageRate) || floatRegex.test(pesWageRate))) {
	        alert('Please fill Number !!!');  
	        $("#pesWageRate").focus();
	        return false;
	     }
	var target="employeeStatus"; 
 	$.post(target+"/action/employeestatus",$("#employeeStatusForm").serialize(), function(data) {
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
	    <form:form id="employeeStatusForm" name="employeeStatusForm" modelAttribute="employeeStatusForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${employeeStatusForm.pstEmployeeStatus.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${employeeStatusForm.pstEmployeeStatus.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstEmployeeStatus.pesId" id="pesId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Employee Status</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">คำอธิบาย :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstEmployeeStatus.pesName" id="pesName" cssStyle="height: 30;"/>
    					</td> 
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">อัตราค่าแรง(เท่า) :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:input path="pstEmployeeStatus.pesWageRate" id="pesWageRate" cssStyle="height: 30;width:80px"/>
    					</td>
    				</tr> 
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackEmployeeStatus()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doEmployeeStatusAction('action','${employeeStatusForm.mode}','${employeeStatusForm.pstEmployeeStatus.pesId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>