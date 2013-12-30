<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
   //alert("${bsId}");
   getSLA();
});
function goBackBreakdown(){
 
	  $.ajax({
		  type: "get",
		  url: "breakdown/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function getSLA(){ 
	//alert("${mode}")
	var isEdit=false;
	var function_message="Add";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#sla_title").html("SLA Management ("+function_message+")");
  if(isEdit){
	var query="SELECT BS_ID,BS_NAME,BS_SLA_LIMIT,BS_SLA_DETAIL FROM "+SCHEMA_G+".BPM_SLA where BS_ID=${bsId}";
	SynDomeBPMAjax.searchObject(query,{
		callback:function(data){ 
			if(data!=null && data.length>0){
				//alert(data)
				$("#bsName").val(data[0][1]);
				$("#bsSlaLimit").val(data[0][2]);
				$("#bsSlaDetail").val(data[0][3]); 
			}else{
				
			}
		}
 	  });
  }
}
function doSLAAction(){
	var bsName=jQuery.trim($("#bsName").val());
	var bsSlaLimit= jQuery.trim($("#bsSlaLimit").val()); 
	//var bsSlaDetail=$("#bsSlaDetail").val().replace(/'/g,"\\'"); 
	var bsSlaDetail=jQuery.trim($("#bsSlaDetail").val());
	 if(bsName.length==0){
		 alert("กรุณากรอก Name.");
		 $("#bsName").focus();
		 return false;
	 }
	 if(bsSlaLimit.length==0){
		 alert("กรุณากรอก SLA Limit/Day.");
		 $("#bsSlaLimit").focus();
		 return false;
	 }
	 var isNumber=checkNumberDecimal(jQuery.trim($("#bsSlaLimit").val())); 
	 if(isNumber){  
		 alert('กรุณากรอก  SLA Limit/Day เป็นตัวเลขจำนวนเต็ม.');  
		 $("#bsSlaLimit").focus(); 
		 return false;	  
	 }
	var querys=[];
	var query="insert into "+SCHEMA_G+".BPM_SLA set BS_NAME='"+bsName+"', BS_SLA_LIMIT="+bsSlaLimit+",BS_SLA_DETAIL=? ";
	if($("#mode").val()=='edit'){
		// query="update "+SCHEMA_G+".BPM_SLA set BS_NAME='"+bsName+"', BS_SLA_LIMIT="+bsSlaLimit+",BS_SLA_DETAIL='"+bsSlaDetail+"' where BS_ID=${bsId}";
		 query="update "+SCHEMA_G+".BPM_SLA set BS_NAME='"+bsName+"', BS_SLA_LIMIT="+bsSlaLimit+",BS_SLA_DETAIL=? where BS_ID=${bsId}";
	}
	querys.push(query);
	
	 //alert(query);
	// alert(encodeURIComponent(bsSlaDetail))
	 // return false;
	var list_values=[];
		var values=[];
		values.push(bsSlaDetail);
		list_values.push(values);
	SynDomeBPMAjax.executeQueryWithValues(querys,list_values,{
			callback:function(data){ 
				if(data!=0){
					loadDynamicPage("setting/page/setting_sla");
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
			 <input type="hidden" name="bsId" id="bsId"  value="${bsId}"/> 
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
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Name :</span></td>
    					<td width="75%" colspan="2"> 
    						<input type="text" name="bsName" id="bsName" style="height: 30;width:80px"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">SLA Limit/Day :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="bsSlaLimit" id="bsSlaLimit" style="height: 30;width:80px"/>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Detail :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="bsSlaDetail" id="bsSlaDetail" style="height: 30;"/>
    					</td>
    				</tr> 
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
						<a class="btn btn-info"  onclick="loadDynamicPage('setting/page/setting_sla')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doSLAAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
						</div>
			  </form>  
			
			</div>
</fieldset>