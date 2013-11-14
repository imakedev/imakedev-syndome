<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackPosition(){
 
	  $.ajax({
		  type: "get",
		  url: "position/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
 
function doPositionAction(action,mode,id){
	var ppName=jQuery.trim($("#ppName").val());
	if(ppName.length==0){
		 alert('กรุณากรอก ตำแหน่ง');  
		 $("#ppName").focus();
	        return false;
	    } 
	
	var target="position"; 
 	$.post(target+"/action/position",$("#positionForm").serialize(), function(data) {
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
	    <form:form id="positionForm" name="positionForm" modelAttribute="positionForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${positionForm.pstPosition.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${positionForm.pstPosition.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstPosition.ppId" id="ppId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Position</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ตำแหน่ง :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstPosition.ppName" id="ppName" cssStyle="height: 30;"/>
    					</td> 
    				</tr>
				<%-- <tr valign="middle">
					<td width="25%" align="right"><span
						style="font-size: 13px; padding: 15px">อัตราค่าแรง(เท่า) :</span></td>
					<td width="75%" colspan="2"><form:input
							path="pstPosition.pesWageRate" id="pesWageRate"
							cssStyle="height: 30;width:80px" /></td>
				</tr> --%>
			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackPosition()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doPositionAction('action','${positionForm.mode}','${positionForm.pstPosition.ppId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>