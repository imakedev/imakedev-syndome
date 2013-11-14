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
function goBackJob(){
	 
	  $.ajax({
		  type: "get",
		  url: "job/init",
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
	$("#pageNo").val(document.getElementById("customerPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"customerPageSelect\" id=\"customerPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("customerPageSelect").value=$("#pageNo").val();
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
		$("#pcIdArray").val(id);
	}else */ if(mode!='search'){
		$("#pcId").val(id);
	}else {
		$("#pcId").val("0");
	}
	$.post("customer/search",$("#customerForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<div id="dialog-confirmDelete" title="Delete Customer" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Customer ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
            <form:form id="customerForm" name="customerForm" modelAttribute="customerForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
            <form:hidden path="mode"/>
            <%-- <form:hidden path="pcIdArray"/> --%>
             <form:hidden path="pstCustomer.pcId" id="pcId"/>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
           
            <div align="left">
            <strong>ลูกค้า</strong>
            </div>
            <div align="center" style="padding: 10px 60px">
            	<span style="font-size: 13px;">รหัสลูกค้า</span> 
            	<span style="padding: 20px">
            	<form:input path="pstCustomer.pcNo" cssStyle="height: 30;width:80px"/>
            	<!-- <input type="text" style="height: 30;width:80px">  -->
            	</span>  
	    		<span style="font-size: 13px;">ชื่อลูกค้า</span> 
            	<span style="padding: 20px">
            	<form:input path="pstCustomer.pcName" cssStyle="height: 30;"/>
            	<!-- <input type="text" style="height: 30;">  -->
            	</span>  
            	  <a class="btn btn-primary" style="margin-top: -10px" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> 
            </div>
			</form:form> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('customer/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="customerPageSelect" id="customerPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">รหัสลูกค้า</div></th>
            		<th width="74%"><div class="th_class">ชื่อลูกค้า</div></th> 
            		<th width="8%"><div class="th_class"></div></th> 
            		<th width="8%"><div class="th_class"></div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstCustomers}"> 
        	 <c:forEach items="${pstCustomers}" var="pstCustomer" varStatus="loop"> 
          	<tr> 
            	<td>${pstCustomer.pcNo}</td>
            	<td>${pstCustomer.pcName}</td> 
            	<td style="text-decoration: underline;cursor: pointer;" onclick="loadDynamicPage('customer/division/init/${pstCustomer.pcId}')">หน่วยงาน</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('customer/item/${pstCustomer.pcId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstCustomer.pcId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstCustomers}"> 
          	<tr>
          		<td colspan="4" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
        	</tbody>
      </table> 
      <div align="left">
			<a class="btn btn-info"  onclick="goBackJob()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					
			</div>	
      </fieldset> 