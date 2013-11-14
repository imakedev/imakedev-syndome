<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
	$("#prpTaxDate" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	$("#prpExpireDate2" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	
});
function goBackRoadPump(){
 
	  $.ajax({
		  type: "get",
		  url: "roadpump/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doRoadPumpAction(action,mode,id){
	 
	$("#prpDetail").val(CKEDITOR.instances["prpDetail"].getData());
	var target="roadpump"; 
 	$.post(target+"/action/roadpump",$("#roadPumpForm").serialize(), function(data) {
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
	    <form:form id="roadPumpForm" name="roadPumpForm" modelAttribute="roadPumpForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${roadPumpForm.pstRoadPump.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${roadPumpForm.pstRoadPump.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstRoadPump.prpId" id="prpId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Road pump</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    					 
    				</tr>
    				<tr valign="middle">
    					<td width="30%" align="right">
    					<span style="font-size: 13px;padding: 15px">หมายเลข :</span>
    					<form:input path="pstRoadPump.prpNo" id="prpNo" cssStyle="height: 30;width:80px"/>
    					</td>
    					<td width="40%" align="center">
    						<span style="font-size: 13px;padding: 15px">ทะเบียนรถ :</span>
    						<form:input path="pstRoadPump.prpRegister" id="prpRegister" cssStyle="height: 30;width:80px"/>
    					</td> 
    					<td width="30%" align="left">
    						<span style="font-size: 13px;padding: 15px">สถานะปัจจุบัน :</span> 
    						 <form:select path="pstRoadPump.pstRoadPumpStatus.prpsId" cssStyle="width:130px">
    						 	<form:option value="0">---</form:option>
    						 	<form:options items="${pstRoadPumpStatusList}" itemLabel="prpsName" itemValue="prpsId"></form:options> 
    						 </form:select> 
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="30%" align="right">
    					<span style="font-size: 13px;padding: 15px">หมายเลขตัวถัง :</span>
    					<form:input path="pstRoadPump.prpCarNo" id="prpCarNo" cssStyle="height: 30;width:80px"/>
    					</td>
    					<td width="40%" align="center"> 
    					<span style="font-size: 13px;padding: 15px">รถยี่ห้อ :</span>
    						<form:select path="pstRoadPump.pstBrandRoad.pbId" cssStyle="width:130px">
    						 	<form:option value="0">---</form:option>
    						 	<form:options items="${pstBrandRoadList}" itemLabel="pbName" itemValue="pbId"></form:options> 
    						 </form:select> 
    					</td> 
    					<td width="30%" align="left">
    					<span style="font-size: 13px;padding: 15px">รุ่นรถ :</span>
    						<form:select path="pstRoadPump.pstModelRoad.pmId"  cssStyle="width:130px">
    						 	<form:option value="0">---</form:option>
    						 	<form:options items="${pstModelRoadList}" itemLabel="pmName" itemValue="pmId"></form:options> 
    						 </form:select> 
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="30%" align="right">
    					<span style="font-size: 13px;padding: 15px">สีรถปั๊ม :</span>
    					<form:input path="pstRoadPump.prpColor" id="prpColor" cssStyle="height: 30;width:130px"/>
    					</td>
    					<td width="40%" align="center"> 
    					<span style="font-size: 13px;padding: 15px">หมายเลขเครื่องยนต์ :</span>
    					<form:input path="pstRoadPump.prpMachineNo" id="prpMachineNo" cssStyle="height: 30;width:80px"/>
    					</td>
    					<td width="30%" align="left">
    					<span style="font-size: 13px;padding: 15px">ประเภท :</span>
    						<form:select path="pstRoadPump.pstRoadPumpType.prptId" cssStyle="width:130px">
    						 	<%-- <form:option value="0">---</form:option> --%>
    						 	<form:options items="${pstRoadPumpTypeList}" itemLabel="prptName" itemValue="prptId"></form:options> 
    						 </form:select> 
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="30%" align="right"><span style="font-size: 13px;padding: 15px">ปั๊มยี่ห้อ :</span>
    						<form:select path="pstRoadPump.pstBrandPump.pbId" cssStyle="width:130px">
    						 	<form:option value="0">---</form:option>
    						 	<form:options items="${pstBrandPumpList}" itemLabel="pbName" itemValue="pbId"></form:options> 
    						 </form:select> 
    					</td> 
    					<td width="40%" align="center"> 
    					<span style="font-size: 13px;padding: 15px">รุ่นปั๊ม :</span>
    						<form:select path="pstRoadPump.pstModelPump.pmId" cssStyle="width:130px">
    						 	<form:option value="0">---</form:option>
    						 	<form:options items="${pstModelPumpList}" itemLabel="pmName" itemValue="pmId"></form:options> 
    						 </form:select> 
    					</td>
    					<td width="30%" align="left">
    					<span style="font-size: 13px;padding: 15px">หมายเลขกรมธรรม์ :</span>
    					<form:input path="pstRoadPump.prpInsuranceNo" id="prpInsuranceNo" cssStyle="height: 30;width:80px"/>
    					 
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="30%" align="right" valign="top">
    					<span style="font-size: 13px;padding: 10px">วันต่อภาษีรถประจำปี :</span>
    					<form:input path="pstRoadPump.prpTaxDate" id="prpTaxDate" cssStyle="height: 30;width:85px"/>
    					</td> 
    					<td width="40%" align="center" valign="top">
    					<span style="font-size: 13px;padding: 10px">วันหมดอายุ :</span>
    					<form:input path="pstRoadPump.prpExpireDate2" id="prpExpireDate2" cssStyle="height: 30;width:85px"/>
    					</td>
    					<td width="30%" align="left" valign="top">
    				
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="100%" align="left" colspan="3" valign="top">
    					<span style="font-size: 13px;padding: 15px">รายละเอียด :</span>
    					<form:textarea path="pstRoadPump.prpDetail" id="prpDetail" rows="4" cols="4"></form:textarea>
    					<script>
    					if (CKEDITOR.instances['prpDetail']) {
    			            CKEDITOR.remove(CKEDITOR.instances['prpDetail']);
    			         }
    					CKEDITOR.replace( 'prpDetail',
    						    { 
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    				<%-- 	<form:input path="pstRoadPump.prpDetail" id="prpDetail" cssStyle="height: 30;width:450px"/> --%>
    					</td> 
    				</tr>
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackRoadPump()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doRoadPumpAction('action','${roadPumpForm.mode}','${roadPumpForm.pstRoadPump.prpId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>