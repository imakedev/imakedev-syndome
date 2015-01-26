<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
   //alert("${bsId}");
   getProblem();
}); 
function getProblem(){ 
	//alert("${mode}")
	var isEdit=false;
	var function_message="Add";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#sla_title").html(" Management ("+function_message+")");
  if(isEdit){
	var query="SELECT BPR_ID,BPR_NAME  FROM "+SCHEMA_G+".BPM_PROBLEM where BPR_ID=${bprId}";
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
				$("#bslName").val(data[0][1]); 
			}else{
				
			}
		}
 	  });
  }
}
function doProblemAction(){
	var bslName=jQuery.trim($("#bslName").val()); 
	 if(bslName.length==0){
		 alert("กรุณากรอก วิธีแก้ไข/ป้องกันปัญหา.");
		 $("#bslName").focus();
		 return false;
	 }
	 
	var querys=[];
	var query="insert into "+SCHEMA_G+".BPM_PROBLEM set BPR_NAME=?  ";
	if($("#mode").val()=='edit'){ 
		 query="update "+SCHEMA_G+".BPM_PROBLEM set BPR_NAME=? where BPR_ID=${bprId}";
	}
	querys.push(query);
	 
	var list_values=[];
		var values=[];
		values.push(bslName);
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
					loadDynamicPage("setting/page/problemType_search");
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
			 <input type="hidden" name="bsId" id="bsId"  value="${bprId}"/> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="sla_title"></strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ประเภทปัญหา :</span></td>
    					<td width="75%" colspan="2"> 
    						<input type="text" name="bslName" id="bslName" style="height: 30;"/>
    					</td> 
    				</tr> 
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
						<a class="btn btn-info"  onclick="loadDynamicPage('setting/page/problemType_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doProblemAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
						</div>
			  </form>  
			
			</div>
</fieldset>