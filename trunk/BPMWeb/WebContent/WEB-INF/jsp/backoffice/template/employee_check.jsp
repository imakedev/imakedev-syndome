<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 

<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() {
	renderPageSelect();

	$("#pewmDateTime" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 }
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		doAction('search','0');
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		doAction('search','0');
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("employeeWorkMappingPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"employeeWorkMappingPageSelect\" id=\"employeeWorkMappingPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("employeeWorkMappingPageSelect").value=$("#pageNo").val();
}
function confirmDelete(mode,id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(mode,id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
}
function doSearch(mode,id){
	$("#pageNo").val("1");
	doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	/* if(mode=='deleteItems'){
		$("#pbdIdArray").val(id);
	}else if(mode!='search'){
		$("#pbdId").val(id);
	}else {
		$("#pbdId").val("0");
	} */
	$.post("employeeWorkMapping/search",$("#employeeWorkMappingForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
function test(){
	var query="SELECT * FROM "+SCHEMA_G+".PST_BRAND";
	PSTAjax.searchObject(query,{ 
		callback:function(data){
			alert(data); 
			if(data!=null && data.length>0){
				
			}
		}
	});
/* 	PSTAjax.executeQuery(query,{
		callback:function(data){ 
			if(data!=0){
				distplayKPI(); 
				$( "#dialog-form" ).dialog("close");
			}
		}
	}); */
	   
}
</script>
 <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
           
             
            
            <form:form id="employeeWorkMappingForm" name="employeeWorkMappingForm" modelAttribute="employeeWorkMappingForm"  cssClass="well" cssStyle="border:2px solid #FFC299;background: #F9F9F9" action="" method="post">
              <form:hidden path="mode"/>
            <%--  <form:hidden path="pbdIdArray"/> --%>
            <%--  <form:hidden path="pstEmployeeWorkMapping.pbdId" id="pbdId"/> --%>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
            <div align="left">
            <strong>Employee</strong>
            </div>
            <div align="center" style="padding: 10px 60px">
            	<span style="font-size: 13px;">ประจำวัน</span> 
            	<span style="padding: 20px">
            		<form:input path="pewmDateTime" id="pewmDateTime" cssStyle="height: 30;width:85px" readonly="true"/>
            	</span>  
	    		<span style="font-size: 13px;">เลือกเบอร์รถ</span> 
            	<span style="padding: 20px">
            				<form:select path="pstEmployeeWorkMapping.prpNo" cssStyle="width:120px">
    						 	<form:option value="-1">---</form:option> 
    						 	<form:options items="${pstRoadPumpNos}" itemLabel="prpNo" itemValue="prpNo"></form:options> 
    						 </form:select> 
	    		</span> 
	    		 <a class="btn btn-primary" style="margin-top:-10px" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> 
	    		
            </div>
			   </form:form>
			   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="70%">  
	    					<a class="btn btn-info" onclick="loadDynamicPage('employee/init')"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage Employee</a>&nbsp;
	    					<a class="btn btn-info" onclick="loadDynamicPage('employeeStatus/init')"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage Status</a>&nbsp;
	    				<a class="btn btn-info" onclick="loadDynamicPage('position/init')"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage Position</a>&nbsp;
	    				  <!-- <a class="btn btn-info" onclick="test()"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Ajax</a>&nbsp; -->
	    					</td><td align="right" width="30%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="employeeWorkMappingPageSelect" id="employeeWorkMappingPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>  
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            	 	<th width="7%"><div class="th_class">รหัส</div></th>
            		<th width="20%"><div class="th_class">ชื่อ-นามสกุล</div></th> 
            		<th width="25%"><div class="th_class">ตำแหน่ง</div></th> 
            		<th width="12%"><div class="th_class">วันทำงานสะสม</div></th>
            		<th width="15%"><div class="th_class">เบอร์รถ</div></th> 
            		<th width="15%"><div class="th_class">สถานะการทำงาน</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstEmployeeWorkMappings}"> 
        	 <c:forEach items="${pstEmployeeWorkMappings}" var="pstEmployeeWorkMapping" varStatus="loop">  
          	<tr>  
            	<td>${pstEmployeeWorkMapping.pstEmployee.peUid}  	 
            	 <input type="hidden" name="peIds" value="${pstEmployeeWorkMapping.pstEmployee.peId}" />
            	</td>
            	<td>${pstEmployeeWorkMapping.pstEmployee.pstTitle.ptName}  ${pstEmployeeWorkMapping.pstEmployee.peFirstName} ${pstEmployeeWorkMapping.pstEmployee.peLastName}
            	
            	</td> 
            	<td>${pstEmployeeWorkMapping.pstEmployee.pstPosition.ppName}</td>
            	<td style="text-align: right;">${pstEmployeeWorkMapping.weekdayCollection}</td> 
            	<td>
            <%-- 	<form:select path="prpNos" cssStyle="width:80px"> --%>
            	<select name="prpNos" style="width:120px">
            		<option value="-1">---</option> 
            		<c:if test="${not empty pstEmployeeWorkMapping.prpNo}"> 
            	        <c:forEach items="${pstRoadPumpNos}" var="pstRoadPumpNo" varStatus="loop1">  
            		     <c:if test="${pstRoadPumpNo.prpNo==pstEmployeeWorkMapping.prpNo}">
            		 	 	<option value="${pstRoadPumpNo.prpNo}" selected="selected">${pstRoadPumpNo.prpNo}</option>
            		 	 </c:if>
            		 	 <c:if test="${pstRoadPumpNo.prpNo!=pstEmployeeWorkMapping.prpNo}">
            		 	 	<option value="${pstRoadPumpNo.prpNo}">${pstRoadPumpNo.prpNo}</option>
            		 	 </c:if>
            		 </c:forEach>
            	    </c:if>
            	    <c:if test="${empty pstEmployeeWorkMapping.prpNo}"> 
            	        <c:forEach items="${pstRoadPumpNos}" var="pstRoadPumpNo" varStatus="loop1">  
            		     <c:if test="${pstRoadPumpNo.prpNo==pstEmployeeWorkMapping.pstEmployee.pstRoadPump.prpNo}">
            		 	 	<option value="${pstRoadPumpNo.prpNo}" selected="selected">${pstRoadPumpNo.prpNo}</option>
            		 	 </c:if>
            		 	 <c:if test="${pstRoadPumpNo.prpNo!=pstEmployeeWorkMapping.pstEmployee.pstRoadPump.prpNo}">
            		 	 	<option value="${pstRoadPumpNo.prpNo}">${pstRoadPumpNo.prpNo}</option>
            		 	 </c:if>
            		 </c:forEach>
            	    </c:if>
            		 
    						  <%-- 	<form:option value="-1">---</form:option> 
    						 	<form:options items="${pstRoadPumpNos}" itemLabel="prpNo" itemValue="prpNo"></form:options>  --%>
    						 <%-- </form:select>  --%>
    			</select>
    						 </td>
            	<td>
            	<select  name="pesIds"  style="width:130px">
            		<option value="-1">---</option>
            		 <c:forEach items="${pstEmployeeStatuses}" var="pstEmployeeStatus" varStatus="loop2"> 
            		    <c:if test="${pstEmployeeStatus.pesId==pstEmployeeWorkMapping.pesId}">
            		    	<option value="${pstEmployeeStatus.pesId}" selected="selected">${pstEmployeeStatus.pesName}</option>
            		    </c:if> 
            		 	 <c:if test="${pstEmployeeStatus.pesId!=pstEmployeeWorkMapping.pesId}">
            		 	 	<option value="${pstEmployeeStatus.pesId}">${pstEmployeeStatus.pesName}</option>
            		 	 </c:if>
            		 </c:forEach> 
    			</select>
    			
            	<%-- <form:select path="pesIds" cssStyle="width:80px">
    						 	<form:option value="-1">---</form:option> 
    						 	<form:options items="${pstEmployeeStatuses}" itemLabel="pesId" itemValue="pesName"></form:options> 
    			</form:select>  --%>
            	</td> 
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstEmployeeWorkMappings}"> 
          	<tr>
          		<td colspan="6" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if> 
        	</tbody>
      </table> 
      <div align="center"><a class="btn btn-primary" onclick="doAction('edit','0')">&nbsp;save&nbsp;</a></div>
      </div>
      </fieldset> 