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
function goBackEmployee(){
	 
	  $.ajax({
		  type: "get",
		  url: "employeeWorkMapping/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
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
	$("#pageNo").val(document.getElementById("workTypePageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"workTypePageSelect\" id=\"workTypePageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("workTypePageSelect").value=$("#pageNo").val();
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
		$("#pwtIdArray").val(id);
	}else if(mode!='search'){
		$("#pwtId").val(id);
	}else {
		$("#pwtId").val("0");
	}
	$.post("workType/search",$("#workTypeForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<div id="dialog-confirmDelete" title="Delete ประเภทงาน" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete ประเภทงาน ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="workType:relative;right:-94%;">  </div> --> 
         
             
            <form:form id="workTypeForm" name="workTypeForm" modelAttribute="workTypeForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
            <form:hidden path="mode"/>
           <%--  <form:hidden path="pwtIdArray"/> --%>
             <form:hidden path="pstWorkType.pwtId" id="pwtId"/>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
            <div align="left">
            <strong>จัดการประเภทงาน</strong>
            </div>
           
            <div align="center" style="padding: 10px 60px">
            	<span style="font-size: 13px;">รายการ</span> 
            	<span style="padding: 20px">
            	<form:input path="pstWorkType.pwtName" cssStyle="height: 30;width:300px"/>
            	<!-- <input type="text" style="height: 30;width:80px">  -->
            	</span>  
	    		<span style="font-size: 13px;">แผนก</span> 
            	<span style="padding: 20px">
            	<form:select path="pstWorkType.pstDepartment.pdId" cssStyle="width:120px">
    						 	<form:option value="-1">---</form:option> 
    						 	<form:options items="${pstDepartments}" itemLabel="pdName" itemValue="pdId"></form:options> 
    						 </form:select> 
            	</span>  
            	<a class="btn btn-primary" style="margin-top: -10px" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a>
            </div>
           
			</form:form> 
			
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('workType/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="workTypePageSelect" id="workTypePageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">ลำดับ</div></th>
            		<th width="32%"><div class="th_class">รายการตรวจเช็ค</div></th>
            		<th width="25%"><div class="th_class">แผนก</div></th>  
            		<th width="10%"><div class="th_class">ระยะเวลา(วัน)</div></th> 
            		<th width="10%"><div class="th_class">คอนกรีต(คิว)</div></th> 
            		<th width="10%"><div class="th_class">เลขไมค์(กม)</div></th> 
            		<th width="10%"><div class="th_class">ชม.การทำงาน(ชม.)</div></th>  
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody>  
        	<c:if test="${not empty pstWorkTypes}"> 
        	 <c:forEach items="${pstWorkTypes}" var="pstWorkType" varStatus="loop"> 
          	<tr> 
            	<td>${(workTypeForm.paging.pageNo-1)*workTypeForm.paging.pageSize+(loop.index+1)}.</td>
            	<td>&nbsp;${pstWorkType.pwtName}</td>   
            	<td>&nbsp;${pstWorkType.pstDepartment.pdName}</td>  
            	<td>&nbsp;<fmt:formatNumber  pattern="###.##"  
     value="${pstWorkType.pwtPeriod}" /></td>  
            	<td>&nbsp;<fmt:formatNumber  pattern="###.##"  
     value="${pstWorkType.pwtConcrete}" /></td>  
            	<td>&nbsp;<fmt:formatNumber  pattern="###.##"  
     value="${pstWorkType.pwtMile}" /></td>  
            	<td>&nbsp;<fmt:formatNumber  pattern="###.##"  
     value="${pstWorkType.pwtHoursOfWork}" /></td>   
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('workType/item/${pstWorkType.pwtId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstWorkType.pwtId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstWorkTypes}"> 
          	<tr>
          		<td colspan="8" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
        	</tbody>
      </table> 
      <!-- <div align="left">
			<a class="btn btn-info"  onclick="goBackEmployee()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
    			
	 </div> -->
      </fieldset> 