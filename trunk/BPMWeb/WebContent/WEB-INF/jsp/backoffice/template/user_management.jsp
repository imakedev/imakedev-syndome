<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackUser(){
 
	  $.ajax({
		  type: "get",
		  url: "user/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
 
function doUserAction(action,mode,id){
	/* var ppName=jQuery.trim($("#ppName").val());
	if(ppName.length==0){
		 alert('กรุณากรอก ตำแหน่ง');  
		 $("#ppName").focus();
	        return false;
	    }  */
	
	var target="user"; 
 	$.post(target+"/action/user",$("#userForm").serialize(), function(data) {
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
	    <form:form id="userForm" name="userForm" modelAttribute="userForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${userForm.user.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${userForm.user.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="user.id" id="user_id" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>User</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Username :</span></td>
    					<td width="75%" colspan="2"> 
    					    <c:if test="${userForm.mode!='edit'}">
    					    	<form:input path="user.username" id="username" cssStyle="height: 30;"/>
    					    </c:if>
    					     <c:if test="${userForm.mode=='edit'}">
    					    	<form:input path="user.username" id="username" readonly="true" cssStyle="height: 30;"/>
    					    </c:if> 
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Password :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:password path="user.password" id="password" value="${userForm.user.password}" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ชื่อ :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="user.firstName" id="firstName" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">นามสกุล :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="user.lastName" id="lastName" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
				<%-- <tr valign="middle">
					<td width="25%" align="right"><span
						style="font-size: 13px; padding: 15px">อัตราค่าแรง(เท่า) :</span></td>
					<td width="75%" colspan="2"><form:input
							path="user.pesWageRate" id="pesWageRate"
							cssStyle="height: 30;width:80px" /></td>
				</tr> --%>
			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackUser()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doUserAction('action','${userForm.mode}','${userForm.user.id}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>