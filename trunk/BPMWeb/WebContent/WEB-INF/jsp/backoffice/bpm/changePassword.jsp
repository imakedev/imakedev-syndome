<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authorize access="hasAnyRole('ROLE_CALL_CENTER_ACCOUNT')" var="isCallCenter"/>
 <sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/> 
<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  }  
 
table > thead > tr > th
{
background	:#e5e5e5;
}
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 
	getProfile();
}); 
function getProfile(){
	var query="SELECT id,username,password,firstName,lastName ,email,mobile,BPM_ROLE_NAME,role.BPM_ROLE_ID,detail from "+SCHEMA_G+".user left join "+SCHEMA_G+".BPM_ROLE role "+
	 " on user.BPM_ROLE_ID=role.BPM_ROLE_ID  where username='${username}'";
	//  alert(query)
 var BPM_ROLE_ID="0";
  SynDomeBPMAjax.searchObject(query,{
		callback:function(data){ 
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			if(data!=null && data.length>0){
				$("#username").val(data[0][1]);
				$("#password").val(data[0][2]);
				$("#firstName").val(data[0][3]);
				$("#lastName").val(data[0][4]);
				$("#email").val(data[0][5]); 
				$("#mobile").val(data[0][6]); 
				$("#role").val(data[0][8]);
				$("#detail").val(data[0][9]);
				if(data[0][8]!=null)
					BPM_ROLE_ID=data[0][8];
				//$("#position").val(data[0][7]);
			}else{
				
			} 
			// renderRoleSelect(BPM_ROLE_ID);
		}
	  }); 
}
function doChangePassword(){
	var password_change=jQuery.trim($("#password").val());
	if(password_change.length==0){
		bootbox.dialog("กรุณากรอกรหัสผ่าน",[{
		    "label" : "Close",
		     "class" : "btn-danger"
	 }]);
	 return false;
	}
	var querys=[];  
	username
	var query="update   "+SCHEMA_G+".user set password='"+password_change+"' "+
	  " where username='${username}'";
	querys.push(query); 
	SynDomeBPMAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data.resultMessage.msgCode=='ok'){
				data=data.updateRecord;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			 bootbox.dialog("เปลี่ยน Password เรียบร้อยแล้ว",[{
				    "label" : "Ok",
				     "class" : "btn-success"
			 }]);
			 return false;
		}});
}
	function doUpdateProfile(){  
		// var username=jQuery.trim($("#username").val());
		 var password=jQuery.trim($("#password").val());
		 var firstName=jQuery.trim($("#firstName").val());  
		 var lastName=jQuery.trim($("#lastName").val());
		 var email=jQuery.trim($("#email").val());
		 var mobile=jQuery.trim($("#mobile").val()); 
		// var position=jQuery.trim($("#position").val());
		 
		 
		 if(password.length==0){
			 alert("กรุณากรอก Password.");
			 $("#password").focus();
			 return false;
		 }
		 if(firstName.length==0){
			 alert("กรุณากรอก First Name.");
			 $("#firstName").focus();
			 return false;
		 }
		 if(lastName.length==0){
			 alert("กรุณากรอก Last Name.");
			 $("#lastName").focus();
			 return false;
		 }
		 
		var querys=[]; 
			 query="update "+SCHEMA_G+".user set   password=?,firstName=?,lastName=?,email=?,mobile=? where username='${username}'";
		 
		querys.push(query); 
		var list_values=[];
			var values=[];
			//values.push(username);
			values.push(password);
			values.push(firstName);
			values.push(lastName);
			values.push(email);
			values.push(mobile);
			//values.push(detail);
			//values.push(position);
			
			list_values.push(values);
		SynDomeBPMAjax.executeQueryWithValues(querys,list_values,{
				callback:function(data){ 
					if(data.resultMessage.msgCode=='ok'){
						data=data.updateRecord;
					}else{// Error Code
						//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
						  bootbox.dialog(data.resultMessage.msgDesc,[{
							    "label" : "Close",
							     "class" : "btn-danger"
						 }]);
						 return false;
					}
					if(data!=0){
						 bootbox.dialog("ข้อมูลถูกแก้ใขเรียบร้อยแล้ว",[{
							    "label" : "Ok",
							     "class" : "btn-success"
						 }]);
						 return false;
					}else{
						 bootbox.dialog("ข้อมูลไม่ได้ถูกเปลี่ยนแปลง",[{
							    "label" : "Ok",
							     "class" : "btn-success"
						 }]);
						 return false;
					}
						
				}
			});
	  }
	 
</script>  
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			   
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="user_title"></strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Username :</span></td>
    					<td width="75%" colspan="2">  
    							<input type="text" name="username" id="username" readonly="readonly" style="height: 30;"/>
    						 
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Password :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="password" name="password" id="password" style="height: 30;"/>
    					<a class="btn btn-primary"  onclick="doChangePassword()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">แก้ใข Password</span></a>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">First Name :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="firstName" id="firstName" style="height: 30;"/>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Last Name :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="lastName" id="lastName" style="height: 30;"/>
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Email :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="email" id="email" style="height: 30;"/>
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Mobile :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="mobile" id="mobile" style="height: 30;"/>
    					</td>
    				</tr> 
    				   
    				  
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
    					 <a class="btn btn-primary"  onclick="doUpdateProfile()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">แก้ใขข้อมูล</span></a>
						</div>
			  </form>  
			
			</div>
</fieldset>