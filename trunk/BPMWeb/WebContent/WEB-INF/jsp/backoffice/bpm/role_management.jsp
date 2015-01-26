<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
   //alert("${bpmRoleId}");
   getRole();
}); 
function getRole(){ 
	//alert("${mode}")
	var isEdit=false;
	var function_message="Add";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#role_title").html("Role Management ("+function_message+")");
  if(isEdit){
	var query="SELECT BPM_ROLE_ID,BPM_ROLE_NAME,BPM_ROLE_DETAIL,BPM_ORDER FROM "+SCHEMA_G+".BPM_ROLE where BPM_ROLE_ID=${bpmRoleId}";
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
				//alert(data)
				$("#bpmRoleName").val(data[0][1]);
				$("#bpmRoleDetail").val(data[0][2]);
				//$("#bsSlaDetail").val(data[0][3]); 
			}else{
				
			}
		}
 	  });
  }
}
function doRoleAction(){
	var bpmRoleName=jQuery.trim($("#bpmRoleName").val());
	var bpmRoleDetail= jQuery.trim($("#bpmRoleDetail").val()); 
	//var bsSlaDetail=$("#bsSlaDetail").val().replace(/'/g,"\\'"); 
	//var bsSlaDetail=jQuery.trim($("#bsSlaDetail").val());
	 if(bpmRoleName.length==0){
		 alert("กรุณากรอก Role Name.");
		 $("#bpmRoleName").focus();
		 return false;
	 }
	/*  if(bpmRoleDetail.length==0){
		 alert("กรุณากรอก Role Detail.");
		 $("#bpmRoleDetail").focus();
		 return false;
	 } */
	   var list_values=[];
		var values=[]; 
		values.push(bpmRoleName);
		values.push(bpmRoleDetail);
		list_values.push(values);
		
	var querys=[];
	var query="";
	if($("#mode").val()=='edit'){
		// query="update "+SCHEMA_G+".BPM_ROLE set BPM_ROLE_NAME='"+bpmRoleName+"', BPM_ROLE_DETAIL="+bpmRoleDetail+",BPM_ORDER='"+bsSlaDetail+"' where BPM_ROLE_ID=${bpmRoleId}";
		 query="update "+SCHEMA_G+".BPM_ROLE set BPM_ROLE_NAME=?, BPM_ROLE_DETAIL=?  where BPM_ROLE_ID=${bpmRoleId}";
		 querys.push(query);
		 executeRoleManagement(querys,list_values);
	}else{
		var pbmOrder=1;
		//var querys_max=[]; 
		var query_max="select max(BPM_ORDER)+1 FROM "+SCHEMA_G+".BPM_ROLE   "; 
		//querys_max.push(query_max); 
		alert(query_max);
		SynDomeBPMAjax.searchObject(query_max,{
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
				//alert(data);
				if(data!=null){
					alert(data);
					pbmOrder=data;
				}
				query="insert into "+SCHEMA_G+".BPM_ROLE set BPM_ROLE_NAME=?, BPM_ROLE_DETAIL=?,BPM_ORDER="+pbmOrder+"";
				 querys.push(query);
				executeRoleManagement(querys,list_values);
			}
		});
		
	}  
  }
 function executeRoleManagement(querys,list_values){
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
					loadDynamicPage("setting/page/role_search");
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
			 <input type="hidden" name="bpmRoleId" id="bpmRoleId"  value="${bpmRoleId}"/> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="role_title"></strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Role Name :</span></td>
    					<td width="75%" colspan="2"> 
    						<input type="text" name="bpmRoleName" id="bpmRoleName" style="height: 30;"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Role Detail :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="bpmRoleDetail" id="bpmRoleDetail" style="height: 30;"/>
    					</td>
    				</tr>  
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
						<a class="btn btn-info"  onclick="loadDynamicPage('setting/page/role_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doRoleAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
						</div>
			  </form>  
			
			</div>
</fieldset>