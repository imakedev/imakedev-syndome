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
	$("#pageNo").val(document.getElementById("costPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"costPageSelect\" id=\"costPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("costPageSelect").value=$("#pageNo").val();
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
		$("#pcIdArray").val(id);
	}else if(mode!='search'){
		$("#pcId").val(id);
	}else {
		$("#pcId").val("0");
	}
	$.post("costs/search",$("#costForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<div id="dialog-confirmDelete" title="Delete Costs" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Costs ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">  
           <form:form id="costForm" name="costForm" modelAttribute="costForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
            <form:hidden path="mode"/>
            <form:hidden path="pcIdArray"/>
             <form:hidden path="pstCost.pcId" id="pcId"/>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
            
            <div align="left">
            <strong>Costs</strong>
            </div>
            <div align="center" style="padding: 10px 1px">
            	<span style="font-size: 13px;">รหัสรายการ</span> 
            	<span style="padding: 20px">
            	<form:input path="pstCost.pcUid" cssStyle="height: 30;width:80px"/>
            	<!-- <input type="text" style="height: 30;width:80px">  -->
            	</span>  
	    		<span style="font-size: 13px;">รายละเอียด</span> 
            	<span style="padding: 20px">
            	<form:input path="pstCost.pcName" cssStyle="height: 30;"/>
            	<!-- <input type="text" style="height: 30;">  -->
            	</span>
            	<span style="font-size: 13px;">ประเภท</span> 
            	<span style="padding: 20px">
            <%-- 	<form:input path="" cssStyle="height: 30;"/> --%>
            	<form:select path="pstCost.pcType" cssStyle="width:100px">
            		<form:option value="1">ปั๊มลาก</form:option>
            		<form:option value="2">ปั๊มบูม</form:option>
            	</form:select>
            	<!-- <input type="text" style="height: 30;">  -->
            	</span>  
            	<a class="btn btn-primary" style="margin-top: -10px" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a>
            </div>
             
	    					</form:form> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('costs/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="costPageSelect" id="costPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
	   					 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">รหัสการจ่าย</div></th>
            		<th width="58%"><div class="th_class">รายละเอียด</div></th>
            		<th width="8%"><div class="th_class">ประเภท</div></th>   
            		<th width="8%"><div class="th_class">ตัวคูณ</div></th> 
            		<th width="8%"><div class="th_class">หน่วย</div></th>
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstCosts}"> 
        	 <c:forEach items="${pstCosts}" var="pstCost" varStatus="loop"> 
          	<tr>  
            	<td>${pstCost.pcUid}</td>
            	<td>${pstCost.pcName}</td>
            	<td> 
            		<c:if test="${pstCost.pcType=='1'}">
            		ปั๊มลาก
            		</c:if>
            		<c:if test="${pstCost.pcType=='2'}">
            		ปั๊มบูม
            		</c:if> 
            	</td> 
            	<td style="text-align: right;"><fmt:formatNumber  pattern="#,###,###,###.##"  
     value="${pstCost.pcAmount}"/></td>
            	<td>${pstCost.pcUnit}</td>
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('costs/item/${pstCost.pcId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstCost.pcId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstCosts}"> 
          	<tr>
          		<td colspan="6" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          	</c:if> 
        	</tbody>
      </table> 
      </fieldset> 