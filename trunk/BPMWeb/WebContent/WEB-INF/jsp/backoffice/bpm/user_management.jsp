<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() { 
   getSLA();
}); 
function getSLA(){  
	var isEdit=false;
	var function_message="Add";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#user_title").html("User Management ("+function_message+")");
  if(isEdit){ 
	  var query="SELECT id,username,password,firstName,lastName ,email,mobile,BPM_ROLE_NAME,role.BPM_ROLE_ID,detail from "+SCHEMA_G+".user left join "+SCHEMA_G+".BPM_ROLE role "+
		 " on user.BPM_ROLE_ID=role.BPM_ROLE_ID  where user.id=${id}";
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
				 renderRoleSelect(BPM_ROLE_ID);
			}
	 	  }); 
  }else{
	  renderRoleSelect("0");
  }
}
function renderRoleSelect(BPM_ROLE_ID){
	 var query= "select bpm_role_id,bpm_role_name from SYNDOME_BPM_DB.BPM_ROLE role";
	 //alert("BPM_ROLE_ID->"+BPM_ROLE_ID)
	 SynDomeBPMAjax.searchObject(query,{
			callback:function(data2){ 
				if(data2.resultMessage.msgCode=='ok'){
					data2=data2.resultListObj;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data2.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data2!=null && data2.length>0){ 
					<%-- --%>
					var pageStr="<select name=\"roleSelect\" id=\"roleSelect\"  style=\"width: 205px\">"; 
					pageStr=pageStr+"<option value=\"0\">-- Select Role --</option>";
					for(var i=0;i<data2.length;i++){
						var selected=(BPM_ROLE_ID==data2[i][0])?"selected":"";
						//alert("data2[i][0]-->"+data2[i][0]);
						pageStr=pageStr+"<option value=\""+data2[i][0]+"\" "+selected+" >"+data2[i][1]+"</option>";
					}
					pageStr=pageStr+"</select>"; 
					$("#roleSelectElement").html(pageStr); 
				}else{
					
				}
			}
	 	  });
}
function doUserAction(){  
	 var username=jQuery.trim($("#username").val());
	 var password=jQuery.trim($("#password").val());
	 var firstName=jQuery.trim($("#firstName").val());  
	 var lastName=jQuery.trim($("#lastName").val());
	 var email=jQuery.trim($("#email").val());
	 var mobile=jQuery.trim($("#mobile").val());
	 var detail=jQuery.trim($("#detail").val());
	 
	 var role_id=$( "#roleSelect option:selected" ).val();
	// var position=jQuery.trim($("#position").val());
	 
	 if(username.length==0){
		 alert("กรุณากรอก Username.");
		 $("#username").focus();
		 return false;
	 }
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
	 if(role_id=='0'){
		 alert("กรุณาเลือก Role.");
		 $("#roleSelect").focus();
		 return false;
	 }
	var querys=[];
	var query="insert into "+SCHEMA_G+".user set username=?, password=?,firstName=?,lastName=?,email=?,mobile=?,detail=?,enabled=1,type=0,BPM_ROLE_ID="+role_id;
	if($("#mode").val()=='edit'){
		 query="update "+SCHEMA_G+".user set username=?, password=?,firstName=?,lastName=?,email=?,mobile=?,detail=?,BPM_ROLE_ID="+role_id+" where id=${id}";
	}
	querys.push(query); 
	var list_values=[];
		var values=[];
		values.push(username);
		values.push(password);
		values.push(firstName);
		values.push(lastName);
		values.push(email);
		values.push(mobile);
		values.push(detail);
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
					loadDynamicPage("dispatcher/page/user_search");
				}
			}
		});
  }
 
</script> 
<%--
 style="border:2px solid #B3D2EE;background: #F9F9F9"
  --%>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="user_id" id="user_id"  value="${id}"/> 
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
    					    <c:if test="${mode=='edit'}">
    							<input type="text" name="username" id="username" readonly="readonly" style="height: 30;"/>
    						</c:if>
    						<c:if test="${mode=='add'}">
    							<input type="text" name="username" id="username"  style="height: 30;"/>
    						</c:if>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Password :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="password" name="password" id="password" style="height: 30;"/>
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
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Detail :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="detail" id="detail" style="height: 30;"/>
    					</td>
    				</tr> 
    				<!-- <tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Position :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="position" id="position" style="height: 30;"/>
    					</td>
    				</tr> -->
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Role :</span></td>
    					<td width="75%" colspan="2"> 
    					<span id="roleSelectElement">
    					</span> 
    					</td>
    				</tr> 
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
						<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/user_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doUserAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
						</div>
			  </form>  
			
			</div>
</fieldset>