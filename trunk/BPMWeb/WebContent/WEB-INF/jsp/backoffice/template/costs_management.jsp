<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackCost(){
 
	  $.ajax({
		  type: "get",
		  url: "costs/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doCostAction(action,mode,id){
	var pcUid=jQuery.trim($("#pcUid").val());
	if(pcUid.length==0){
		 alert('กรุณากรอก รหัสรายการ');  
		 $("#pcUid").focus();
	        return false;
	    } 
	var pcName=jQuery.trim($("#pcName").val());
	if(pcName.length==0){
		 alert('กรุณากรอก รายละเอียด');  
		 $("#pcName").focus();
	        return false;
	    } 
	var pcAmount=jQuery.trim($("#pcAmount").val());
	 if(!(intRegex.test(pcAmount) || floatRegex.test(pcAmount))) {
	        alert('Please fill Number !!!'); 
	        $("#pcAmount").focus();
	        return false;
	     } 
	var pcUnit=jQuery.trim($("#pcUnit").val());
	if(pcUnit.length==0){
		 alert('กรุณากรอก หน่วย');  
		 $("#pcUnit").focus();
	        return false;
	    } 
	var target="costs"; 
 	$.post(target+"/action/cost",$("#costForm").serialize(), function(data) {
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
	    <form:form id="costForm" name="costForm" modelAttribute="costForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${costForm.pstCost.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${costForm.pstCost.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstCost.pcId" id="pcId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Costs</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รหัสรายการ :</span></td>
    					<td width="75%" colspan="2">
    						<form:input path="pstCost.pcUid" id="pcUid" cssStyle="height: 30;width:80px"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ประเภท :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:select path="pstCost.pcType" cssStyle="width:100px">
            				<form:option value="1">ปั๊มลาก</form:option>
            				<form:option value="2">ปั๊มบูม</form:option>
            			</form:select>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รายละเอียด :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:input path="pstCost.pcName" id="pcName" cssStyle="height: 30;"/>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ตัวคูณ :</span></td>
    					<td width="75%" colspan="2"> 
    					<fmt:formatNumber pattern="###.##"  
     value="${costForm.pstCost.pcAmount}"  var="pstCost_pcAmount_formated"/>
    						
    					<form:input path="pstCost.pcAmount" id="pcAmount" value="${pstCost_pcAmount_formated}"  cssStyle="height: 30;"/>
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">หน่วย :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:input path="pstCost.pcUnit" id="pcUnit" cssStyle="height: 30;"/>
    					</td>
    				</tr>
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackCost()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doCostAction('action','${costForm.mode}','${costForm.pstCost.pcId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>