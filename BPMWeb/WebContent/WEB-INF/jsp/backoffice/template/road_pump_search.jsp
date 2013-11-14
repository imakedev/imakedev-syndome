<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	renderPageSelect();
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
	$("#pageNo").val(document.getElementById("roadpumpPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"roadpumpPageSelect\" id=\"roadpumpPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("roadpumpPageSelect").value=$("#pageNo").val();
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
	if(mode=='deleteItems'){
		$("#prpIdArray").val(id);
	}else if(mode!='search'){
		$("#prpId").val(id);
	}else {
		$("#prpId").val("0");
	}
	$.post("roadpump/search",$("#roadPumpForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<%--
<div style="${display};padding-top:10px">
 <div class="alert alert-success" style="${display}">    
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
  </div>
   --%>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<div id="dialog-confirmDelete" title="Delete Costs" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Road pump ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	       <form:form id="roadPumpForm" name="roadPumpForm" modelAttribute="roadPumpForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
            <form:hidden path="mode"/>
            <form:hidden path="prpIdArray"/>
             <form:hidden path="pstRoadPump.prpId" id="prpId"/>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
            <div align="left">
            <strong>Road pump</strong>
            </div>
            <div align="left" style="padding: 10px 10px">
            	<span style="font-size: 13px;">หมายเลข</span> 
            	<span style="padding: 20px">
            	<!-- <input type="text" style="height: 30;width:80px">  -->
            	<form:input path="pstRoadPump.prpNo" cssStyle="height: 30;width:80px"/>
            	</span>  
	    		<span style="font-size: 13px;">ทะเบียนรถ</span> 
            	<span style="padding: 20px">
            	<!-- <input type="text" style="height: 30;width: 100px;">  -->
            	<form:input path="pstRoadPump.prpRegister" cssStyle="height: 30;width:100px"/>
            	</span>  
            	<span style="font-size: 13px;">สถานะปัจจุบัน</span> 
            	<span style="padding-left: 10px">
            	<form:select path="pstRoadPump.pstRoadPumpStatus.prpsId">
    						 <form:option value="0">-- Select Status --</form:option>
    						 <form:options items="${pstRoadPumpStatuses}" itemLabel="prpsName" itemValue="prpsId"></form:options>
	    					     
    			</form:select>
            	<!-- <select id="mcaStatus" name="mcaStatus">
	    					      <option value="-1">-- เลือก --</option>
	    					      <option value="1">1</option>
	    					      <option value="2">2</option>
	    		</select> -->
            	</span>
            	<a class="btn btn-primary" style="margin-top: -10px" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> 
            </div>
	    					</form:form> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('roadpump/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;<span id="pageElement"><select name="roadpumpPageSelect" id="roadpumpPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select></span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="7%"><div class="th_class">หมายเลข</div></th>
            		<th width="7%"><div class="th_class">ทะเบียนรถ</div></th> 
            		<th width="20%"><div class="th_class">หมายเลขกรมธรรม์</div></th> 
            		<th width="8%"><div class="th_class">วันหมดอายุ</div></th>
            		<th width="10%"><div class="th_class">วันต่อภาษีรถประจำปี</div></th> 
            		<th width="10%"><div class="th_class">สถานะปัจจุบัน</div></th> 
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstRoadPumps}"> 
        	 <c:forEach items="${pstRoadPumps}" var="pstRoadPump" varStatus="loop"> 
          	<tr>  
            	<td>${pstRoadPump.prpNo}</td>
            	<td>${pstRoadPump.prpRegister}</td> 
            	<td>${pstRoadPump.prpInsuranceNo}</td>
            	<td>${pstRoadPump.prpExpireDate2}</td>
            	<td>${pstRoadPump.prpTaxDate}</td>
            	<td>${pstRoadPump.pstRoadPumpStatus.prpsName}</td>
            	 <td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('roadpump/item/${pstRoadPump.prpId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstRoadPump.prpId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          		</c:forEach>
          	</c:if>
          	<c:if test="${empty pstRoadPumps}"> 
          	<tr>
          		<td colspan="7" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          	</c:if>  
          </tbody>
      </table> 
      </fieldset> 