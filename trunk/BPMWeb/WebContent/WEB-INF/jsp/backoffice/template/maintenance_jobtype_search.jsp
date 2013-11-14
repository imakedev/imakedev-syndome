<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	/* renderPageSelect();
	if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 } */
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		//doAction('search','0');
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		//doAction('search','0');
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("breakdownPageSelect").value);
	//doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"breakdownPageSelect\" id=\"breakdownPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("breakdownPageSelect").value=$("#pageNo").val();
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
	//doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#pbdIdArray").val(id);
	}else if(mode!='search'){
		$("#pbdId").val(id);
	}else {
		$("#pbdId").val("0");
	}
	$.post("breakdown/search",$("#breakdownForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<div id="dialog-confirmDelete" title="Delete Breakdown" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Breakdown ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px"> 
            <form id="breakdownForm" name="breakdownForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post"> 
           <%--  <form:form id="breakdownForm" name="breakdownForm" modelAttribute="breakdownForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post"> --%>
            <input type="hidden" id="mode"/>
            <input type="hidden" id="pbdIdArray"/>
            <input type="hidden" id="pbdId"/>
            <input type="hidden" id="pageNo"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount"/>
           
            <!-- <input id="mode" name="mode" type="hidden" value="">
            <input id="mcaId" name="missCandidate.mcaId" type="hidden" value="">
            <input id="mcaIdArray" name="mcaIdArray" type="hidden" value="">
            <input id="pageNo" name="paging.pageNo" type="hidden" value="1">
            <input id="pageSize" name="paging.pageSize" type="hidden" value="20"> 
            <input id="pageCount" name="pageCount" type="hidden" value="8">  -->
            <div align="left">
            <strong>จัดการประเภทงาน</strong>
            </div>
            <div align="left" style="padding: 10px 60px">
            	<span style="font-size: 13px;">รายการ</span> 
            	<span style="padding: 20px">
            	<%-- <form:input path="pstBreakDown.pbdUid" cssStyle="height: 30;width:80px"/> --%>
            	 <input type="text" id="pdName" style="height: 30;width:300px">  
            	</span>  
	    		 <span style="font-size: 13px;">แผนก</span> 
            	<span style="padding: 20px"> 
            	  <input type="text" style="height: 30;"> 
            	</span>   
            </div>
			</form>
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary"  ><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="breakdownPageSelect" id="breakdownPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;<a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a></td>
	    					</tr>
	    					</tbody></table>
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">ลำดับ</div></th>
            		<th width="27%"><div class="th_class">รายการตรวจเช็ค</div></th>
            		<th width="20%"><div class="th_class">แผนก</div></th> 
            		<th width="10%"><div class="th_class">ระยะเวลา(วัน)</div></th> 
            		<th width="5%"><div class="th_class">คอนกรีต(คิว)</div></th> 
            		<th width="10%"><div class="th_class">เลขไมค์(กม)</div></th> 
            		<th width="10%"><div class="th_class">ชม.การทำงาน(ชม)</div></th>  
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstBreakDowns}"> 
        	 <c:forEach items="${pstBreakDowns}" var="pstBreakDown" varStatus="loop"> 
          	<tr> 
            	<td>${pstBreakDown.pbdUid}</td>
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('breakdown/item/${pstBreakDown.pbdId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstBreakDown.pbdId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstBreakDowns}"> 
          	<tr>
          		<td colspan="8" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
        	</tbody>
      </table> 
      </fieldset> 