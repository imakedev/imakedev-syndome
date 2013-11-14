<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackCustomerContact(){
     
	  $.ajax({
		  type: "get",
		  url: "customer/division/init/${customerForm.pstCustomerContact.pstCustomerDivision.pstCustomer.pcId}",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doCustomerContactAction(action,mode,id){
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
 	$.post(target+"/contact/action/customer",$("#customerForm").serialize(), function(data) {
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
			 <%--  <input type="hidden" value="${customerForm.pstCustomerContact.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${customerForm.pstCustomerContact.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstCustomerContact.pccId" id="pccId" />
			  <form:hidden path="pstCustomerContact.pstCustomerDivision.pcdId" id="pcdId" />  
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>ผู้ติดต่อ</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ชื่อผู้ติดต่อ :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstCustomerContact.pccName" id="pccName" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">เบอร์โทรศัพท์ :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstCustomerContact.pccMobileNo" id="pccMobileNo" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackCustomerContact()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doCustomerContactAction('action','${customerForm.mode}','${customerForm.pstCustomerContact.pccId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>