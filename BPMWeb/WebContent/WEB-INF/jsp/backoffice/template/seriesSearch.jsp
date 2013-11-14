<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	renderPageSelect();
	var idArray=$("#meIdArray").val();
//	 alert(idArray);
	 if(idArray.length>0){
		 var idSplit=idArray.split(",");
//		 alert(" split size="+idSplit.length)
		 var missExam_selectboxes=document.getElementsByName("missExam_selectbox");
		 for(var i=0;i<missExam_selectboxes.length;i++){
			 for(var j =0;j<idSplit.length;j++){
				 if(missExam_selectboxes[i].value==idSplit[j]){
					 missExam_selectboxes[i].checked=true;
					 break;
				 }
			 }
		 }
	 }
	 $("input[id=msSeriesName],[id=msUnitCost]").keypress(function(event) {
	 	  if ( event.which == 13 ) {
	 	     event.preventDefault();
	 	    	doAction('search','0');
	 	   }
	 });
	/*  $("input[id=msSeriesName],[id=msUnitCost]").each(function(){
	        $(this).keypress(function(event) {
	  	 	  if ( event.which == 13 ) {
	 	 	     event.preventDefault();
	 	 	    	doAction('search','0');
	 	 	   }
	 	 });
	 }); */

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
	$("#pageNo").val(document.getElementById("seriesPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	var pageStr="<select name=\"seriesPageSelect\" id=\"seriesPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("seriesPageSelect").value=$("#pageNo").val();
}
function toggleCheckbox(){
	var _check=document.getElementById("msIdCheckboxAll").checked;
	var msIdCheckbox=document.getElementsByName("msIdCheckbox"); 
	for(var i=0;i<msIdCheckbox.length;i++){ 
			msIdCheckbox[i].checked=_check;
	}
}

function doDeleteItems(){
	var msIdCheckbox=document.getElementsByName("msIdCheckbox");
	//alert(msIdCheckbox.length);
	var msIds="";
	for(var i=0;i<msIdCheckbox.length;i++){
		 if(msIdCheckbox[i].checked)
			 msIds=msIds+msIdCheckbox[i].value+",";
	}
	 
	msIds=msIds.substring(0, msIds.length-1);
	if(msIds.length>0){
		//alert(msIds);
		$( "#dialog-confirmDelete" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doAction("deleteItems",msIds);
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	}
// 	alert(msIds)
	/*   $("#msId").val(id);
	$.post("series/search",$("#seriesForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		}); */
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
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#msIdArray").val(id);
	}else if(mode!='search'){
		$("#msId").val(id);
	}else {
		$("#msId").val("0");
	}
	$.post("series/search",$("#seriesForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
/* function doSearch(){
	$("#mode").val("search");
	$("#mode").val("edit");
	$.post("series/search",$("#seriesForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
	
} */

</script> 
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
</style>
 <div id="dialog-confirmDelete" title="Delete Series" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Series ?
</div>
	    <fieldset style="font-family: sans-serif;">  
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
      <!--   <form class="well" style="border:2px solid #DDD"> -->
          <form:form  id="seriesForm" name="seriesForm" modelAttribute="seriesForm" cssClass="well" cssStyle="border:2px solid ${UserMissContact.missTheme.mtBgColor};background: url('/MISSExamBackOffice/resources/images/${UserMissContact.missTheme.mtWaterWall}') no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}" method="post" action="">
           
            <form:hidden path="mode"/>
            <form:hidden path="missSery.msId" id="msId"/>
            <form:hidden path="msIdArray" id="msIdArray"/>
            <form:hidden path="paging.pageNo" id="pageNo"/>
            <form:hidden path="paging.pageSize" id="pageSize"/> 
            <form:hidden path="pageCount" id="pageCount"/> 
            
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong>Series Search</strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="right" width="17%">Series Name:</td>
	    					 <td align="left" width="17%">    					
	    						<!-- <input type="text"/>  -->
	    						<%-- <form:input path="missSery.msSeriesName" id="msSeriesName"/>  --%>
	    						 <form:input path="msSeriesName" id="msSeriesName"/> 
	    					 </td>
	    					<td align="right" width="17%">Unit Cost:</td>
	    					<td align="left" width="17%">
							<form:input path="msUnitCost" id="msUnitCost" cssStyle="width:50px"/>
	    					<%--  <form:input path="missSery.msUnitCost" id="msUnitCost" cssStyle="width:50px"/>
	    					--%>
	    					<!-- <input type="text" name="registerNo" class="height_input"/> -->
	    					</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" colspan="5">Included Test:</td> 
	    					</tr>
	    					<tr>
	    					 <td align="left" colspan="6">
	    					   <span style="display: block;">
	    					<%--  <form:checkboxes path="missExam_selectbox" items="${missExams}" itemValue="meId" itemLabel="meName" cssStyle="display:block" />  --%>
	    					  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 <input type="checkbox" value="<c:out value="${missExam.meId}"></c:out>" name="missExam_selectbox"/><c:out value="${missExam.meName}"></c:out>&nbsp;&nbsp;
	    					 </c:forEach>
	    					  </span>
	    					  <input type="hidden" id="meIdArray" value="${meIdArray}">
	    					  </td>
	    					</tr>
	    					</table> 
	    					</form:form>
	    				<!-- </form> -->
	    					<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('series/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a></td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()"><spring:message code='page_prev'/></a>&nbsp;|&nbsp;<span id="pageElement"></span>&nbsp;|&nbsp;<a onclick="goNext()"><spring:message code='page_next'/></a>&nbsp;<a  class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;<spring:message code='button_search'/></a></td>
	    					</tr>
	    					</table> 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox" id="msIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="20%"><div class="th_class">Name</div></th> 
            		<th width="5%"><div class="th_class">Unit</div></th>
            		<th width="60%"><div class="th_class">Test</div></th> 
            		<th width="10%"><div class="th_class">Action</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
           <c:if test="${not empty missSeries}"> 
        	 <c:forEach items="${missSeries}" var="missSery" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" name="msIdCheckbox" value="${missSery.msId}"/></td>
            	<td>${missSery.msSeriesName}</td>
            	<td>${missSery.msUnitCost}</td>
            	<td>&nbsp;${missSery.testStr}</td>
            	<td style="text-align: center;">
            	
            	<%-- <a onclick="loadDynamicPage('series/item/${missSery.msId}')">Edit</a>&nbsp;<a onclick="confirmDelete('delete','${missSery.msId}')">Delete</a> --%>
            	<i title="Edit" onclick="loadDynamicPage('series/item/${missSery.msId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	<i title="Delete" onclick="confirmDelete('delete','${missSery.msId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td> 
          	</tr>
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty missSeries}"> 
          	<tr> 
          		<td colspan="5" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if> 
        	</tbody>
      </table>
      
</fieldset>