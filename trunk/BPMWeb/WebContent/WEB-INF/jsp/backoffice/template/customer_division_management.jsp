<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackCustomerDivision(){
 
	  $.ajax({
		  type: "get", 
		  url: "customer/division/init/${customerForm.pstCustomerDivision.pstCustomer.pcId}",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doCustomerDivisionAction(action,mode,id){
	/* var pbdUid=jQuery.trim($("#pbdUid").val());
	if(pbdUid.length==0){
		 alert('กรุณากรอก รหัสรายการ');  
		 $("#pbdUid").focus();
	        return false;
	    } 
	var pbdName=jQuery.trim($("#pbdName").val());
	if(pbdName.length==0){
		 alert('กรุณากรอก รายละเอียด');  
		 $("#pbdName").focus();
	        return false;
	    }  */
	var target="customer"; 
 	$.post(target+"/division/action/customer",$("#customerForm").serialize(), function(data) {
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
	    <form:form id="customerForm" name="customerForm" modelAttribute="customerForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${customerForm.pstCustomerDivision.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${customerForm.pstCustomerDivision.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstCustomerDivision.pcdId" id="pcdId" />
			  <form:hidden path="pstCustomerDivision.pstCustomer.pcId" id="pcId" />  
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>หน่วยงาน</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ชื่อ หน่วยงาน:</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstCustomerDivision.pcdName" id="pcdName" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
    			 
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackCustomerDivision()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doCustomerDivisionAction('action','${customerForm.mode}','${customerForm.pstCustomerDivision.pcdId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>