<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	renderPageSelect();
	
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
	$("#pageNo").val(document.getElementById("resultPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	var pageStr="<select name=\"resultPageSelect\" id=\"resultPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("resultPageSelect").value=$("#pageNo").val();
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#mtrIdArray").val(id);
	}else if(mode!='search'){
		$("#mtrId").val(id);
	}else {
		$("#mtrId").val("0");
	}
	$.post("result/search",$("#resultForm").serialize(), function(data) {
		  // alert(data);
		  //  appendContent(data);
		    appendContentWithId(data,"_result_content");
		  // alert($("#_content").html());
		});
}

</script>
<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox"/></div></th>
            		<th width="10%"><div class="th_class">Username</div></th> 
            		<th width="15%"><div class="th_class">First Name</div></th>
            		<th width="10%"><div class="th_class">Last Name</div></th> 
            		<th width="10%"><div class="th_class">Position</div></th>
            		<th width="10%"><div class="th_class">Department</div></th> 
            		<th width="5%"><div class="th_class">Fa</div></th>
            		<th width="5%"><div class="th_class">Im</div></th> 
            		<th width="5%"><div class="th_class">Pe</div></th>
            		<th width="5%"><div class="th_class">Ju</div></th> 
            		<th width="10%"><div class="th_class">Test Date</div></th> 
            		<th width="5%"><div class="th_class">Report</div></th>
            		<th width="5%"><div class="th_class">Response</div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${missTestResults}" var="missTestResult" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" /></td>
            	<td>
            <!-- 	<a onclick="loadDynamicPage('result/viewAnswer/1')">
            	M000000</a> -->
            	<a>${missTestResult.missCandidate.mcaUsername}</a>
            	</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaFirstName}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaLastName}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaPosition}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaDepartment}</td>
            	<td>?</td>
            	<td>?</td>            	
            	<td>?</td> 
            	<td>?</td>
            	<td>&nbsp;<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${missTestResult.mtrStartTime}" /></td>
            	<td>&nbsp;<a onclick="loadDynamicPage('result/report/')">?</a></td>
            	<td>&nbsp;<a onclick="loadDynamicPage('result/response/1')">?</a></td>
          	</tr>
          	</c:forEach>
         
        	</tbody>
      </table>