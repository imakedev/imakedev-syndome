<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	renderPageSelect();
	$("#testFrom" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" 
	});
	$("#testTo" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" 
	}); 
	$("input[id=mcaUsername],[id=mcaFirstName],[id=mcaLastName],[id=mcaPosition],[id=mcaDepartment],[id=mcaCompanyName]").keypress(function(event) {
		// $(document).keypress(function(event) {
		 	  if ( event.which == 13 ) {
		 	     event.preventDefault();
		 	    	doAction('search','0');
		 	   }
		 }); 
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
	if(mode=='deleteItems' ||mode=='ignoreItems' ){
		$("#mtrIdArray").val(id);
	}else if(mode!='search'){
		$("#mtrId").val(id);
	}
	else {
		$("#mtrId").val("0");
	}
	$.post("result/search",$("#resultForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
function toggleCheckbox(){
	var _check=document.getElementById("mtrIdCheckboxAll").checked;
	var mtrIdCheckbox=document.getElementsByName("mtrIdCheckbox"); 
	for(var i=0;i<mtrIdCheckbox.length;i++){ 
		mtrIdCheckbox[i].checked=_check;
	}
}
function exportTest(){
	var src = "result/export";
	//alert(src)
	var mtrIdCheckbox=document.getElementsByName("mtrIdCheckbox");
	//alert(mtrIdCheckbox.length);
	var mtrIds="";
	for(var i=0;i<mtrIdCheckbox.length;i++){
		 if(mtrIdCheckbox[i].checked)
			 mtrIds=mtrIds+mtrIdCheckbox[i].value+",";
	}
	 
	mtrIds=mtrIds.substring(0, mtrIds.length-1);
	if(!(mtrIds.length>0)){
		//alert(mtrIds);dialog-empty
		$( "#dialog-empty" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Ok": function() { 
					$( this ).dialog( "close" );
				} 
			}
		});
	}else{
		src=src+"?id="+mtrIds+"&mcaSeries="+$("#mcaSeries").val();
	     var div = document.createElement("div");
	    document.body.appendChild(div);
	    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
	}
	
}
function setIgnore(){
	var mtrIdCheckbox=document.getElementsByName("mtrIdCheckbox");
	//alert(mtrIdCheckbox.length);
	var mtrIds="";
	for(var i=0;i<mtrIdCheckbox.length;i++){
		 if(mtrIdCheckbox[i].checked)
			 mtrIds=mtrIds+mtrIdCheckbox[i].value+",";
	} 
	mtrIds=mtrIds.substring(0, mtrIds.length-1);
	if(mtrIds.length>0){
		//alert(mtrIds);
		$( "#dialog-confirmIgnore" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doAction("ignoreItems",mtrIds);
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	}else{
		$( "#dialog-empty" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Ok": function() { 
					$( this ).dialog( "close" );
				} 
			}
		});
	} 
}
</script>

<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
 
} 
/* tr:nth-child(odd) {background: #e0e0e0} */
</style>
<div id="dialog-confirmIgnore" title="Ignore Result" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to ignore Result ?
</div>
<div id="dialog-empty" title="Empty Result" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Please select  Result
</div>
	    <fieldset style="font-family: sans-serif;">  
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
         <!--  <form class="well" style="border:2px solid #DDD"> -->
             <form:form  id="resultForm" name="resultForm" modelAttribute="resultForm" cssClass="well" cssStyle="border:2px solid ${UserMissContact.missTheme.mtBgColor};background: url('/MISSExamBackOffice/resources/images/${UserMissContact.missTheme.mtWaterWall}') no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}" method="post" action="">
              
             <form:hidden path="mode"/>
            
            <form:hidden path="mtrIdArray" id="mtrIdArray"/>
            <form:hidden path="paging.pageNo" id="pageNo"/>
            <form:hidden path="paging.pageSize" id="pageSize"/> 
            <form:hidden path="pageCount" id="pageCount"/>
          
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong><spring:message code="page_testsearch_title"/></strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_series"/><font color="red">*</font>:</td>
	    					 <td align="left" width="17%">    					
	    					<!--  <select id="mcaSeries">
	    					      <option value="-1">-- Select Series --</option>
	    					      
	    					    </select>	 -->
	    					     <form:select path="mcaSeries">
	    					      <form:options itemValue="msId" itemLabel="msSeriesName" items="${missSeries}"/>
	    					    </form:select>		
	    					 </td>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_username"/>:</td>
	    					 <td align="left" width="17%">    					
	    					<form:input path="mcaUsername"/>
	    					 </td>
	    					<td align="left" width="17%">&nbsp;</td>
	    					<td align="left" width="17%">&nbsp;</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_firstname"/>:</td>
	    					 <td align="left" width="17%"> <form:input path="mcaFirstName" />
	    					 </td>
	    					<td align="left" width="17%"><spring:message code="page_testsearch_lastname"/>:</td>
	    					<td align="left" width="17%"><form:input path="mcaLastName" /></td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_position"/>:</td>
	    					 <td align="left" width="17%"> <form:input path="mcaPosition" />
	    					 </td>
	    					<td align="left" width="17%"><spring:message code="page_testsearch_department"/>:</td>
	    					<td align="left" width="17%"><form:input path="mcaDepartment"/></td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_testfrom"/>:</td>
	    					 <td align="left" width="17%">  <form:input path="testFrom" cssStyle="width:75px"/>
	    					 </td>
	    					<td align="left" width="17%"><spring:message code="page_testsearch_testto"/>:</td>
	    					<td align="left" width="17%"><form:input path="testTo" cssStyle="width:75px"/></td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%"><spring:message code="page_testsearch_companyname"/>:</td>
	    					 <td align="left" colspan="3" width="51%"> 
	    					 <form:input path="mcaCompanyName" cssStyle="width:100%"/>   					
	    					 </td> 
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					</table> 
	    					</form:form>
	    					<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="60%">
	    					
	    					<a class="btn btn-success"><i class="icon-pencil icon-white"></i>&nbsp;<spring:message code="page_testsearch_dopaper"/></a>&nbsp;
	    					<a class="btn btn-info" onclick="exportTest()"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;<spring:message code="page_testsearch_export"/></a>&nbsp;
	    					<a class="btn btn-info disabled"><i class="icon-list-alt icon-white"></i>&nbsp;<spring:message code="page_testsearch_summary"/></a>&nbsp;
	    					<a class="btn btn-danger" onclick="setIgnore()"><i class="icon-eject icon-white"></i>&nbsp;<spring:message code="page_testsearch_ignore"/></a></td>
	    					<td align="right" width="40%">
	    					<a onclick="goPrev()"><spring:message code='page_prev'/></a>&nbsp;|&nbsp;<span id="pageElement"></span>&nbsp;|&nbsp;<a onclick="goNext()"><spring:message code='page_next'/></a>&nbsp;<a  class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;<spring:message code='button_search'/></a>
	    					</td>
	    					</tr>
	    					</table> 
	    					<div id="_result_content" align="center">
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox" id="mtrIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="10%"><div class="th_class"><spring:message code="page_testsearch_username"/></div></th> 
            		<th width="15%"><div class="th_class"><spring:message code="page_testsearch_firstname"/></div></th>
            		<th width="10%"><div class="th_class"><spring:message code="page_testsearch_lastname"/></div></th> 
            		<th width="10%"><div class="th_class"><spring:message code="page_testsearch_position"/></div></th>
            		<th width="10%"><div class="th_class"><spring:message code="page_testsearch_department"/></div></th> 
            		<c:forEach items="${axisHeaders}" var="axisHeader" varStatus="loop">
            				<th width="5%"><div class="th_class">${axisHeader}</div></th>
            		</c:forEach>
            		<!-- <th width="5%"><div class="th_class">Fa</div></th>
            		<th width="5%"><div class="th_class">Im</div></th> 
            		<th width="5%"><div class="th_class">Pe</div></th>
            		<th width="5%"><div class="th_class">Ju</div></th>  -->
            		<th width="10%"><div class="th_class"><spring:message code="page_testsearch_testdate"/></div></th> 
            		<th width="5%"><div class="th_class"><spring:message code="page_testsearch_report"/></div></th>
            		<th width="5%"><div class="th_class"><spring:message code="page_testsearch_status"/></div></th>
            		<th width="5%"><div class="th_class"><spring:message code="page_testsearch_response"/></div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	<c:if test="${not empty missTestResults}">  
        	 <c:forEach items="${missTestResults}" var="missTestResult" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" name="mtrIdCheckbox" value="${missTestResult.mtrId}"/></td>
            	<td>
            	<a>${missTestResult.missCandidate.mcaUsername}</a>
            	</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaFirstName}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaLastName}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaPosition}</td>
            	<td>&nbsp;${missTestResult.missCandidate.mcaDepartment}</td>
            	<c:forEach items="${missTestResult.axisValues}" var="axisValue" varStatus="loop2">
            				<td>${axisValue}</td>
            	</c:forEach> 
            	<!-- <td>?</td>
            	<td>?</td>            	
            	<td>?</td> 
            	<td>?</td> -->
            	<td>&nbsp;<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${missTestResult.mtrStartTime}" /></td> 
            	<c:url value="/result/testPDF" var="downloadUrl">
            		<c:param name="mtrId" value="${missTestResult.mtrId}"></c:param>
            		<c:param name="meId" value="${missTestResult.meId}"></c:param>
            		<c:param name="msId" value="${missTestResult.msId}"></c:param>
            		<c:param name="mcaId" value="${missTestResult.missCandidate.mcaId}"></c:param>
            	</c:url>
            	<td>&nbsp;<a href="${downloadUrl}">${missTestResult.mtrResultCode}</a></td>            	
            	<td>
            	<c:if test="${missTestResult.mtrStatus=='0'}">Not finished</c:if>
            	<c:if test="${missTestResult.mtrStatus=='1'}">Finished</c:if>
            	<c:if test="${missTestResult.mtrStatus=='2'}">Responded</c:if>
            	</td>
            	<td>
            	<%-- <c:if test="${(missTestResult.mtrStatus=='1' || missTestResult.mtrStatus=='2') &&  missTestResult.mtrIgnored!='1'}">            	
            			<a onclick="loadDynamicPage('result/response/${missTestResult.mtrId}')">Email</a>
            	</c:if> --%>
            	<c:if test="${missTestResult.mtrRespondedStatus=='1' && missTestResult.mtrStatus!='0'}">            	
            			<a onclick="loadDynamicPage('result/response/${missTestResult.mtrId}')">Completed</a>
            	</c:if>
            	<c:if test="${missTestResult.mtrRespondedStatus=='0' && missTestResult.mtrStatus!='0'}">            	
            			<a onclick="loadDynamicPage('result/response/${missTestResult.mtrId}')">Pending</a>
            	</c:if>
            	<%-- <c:if test="${missTestResult.mtrRespondedStatus=='2' && missTestResult.mtrStatus!='0'}">    --%>
            	<c:if test="${missTestResult.mtrRespondedStatus=='2'}">         	
            			Ignored
            	</c:if>
            	<c:if test="${missTestResult.mtrStatus=='0'}">            	
            			&nbsp;
            	</c:if>
            	</td>
          	</tr>
          	</c:forEach>
          </c:if>
           <c:if test="${empty missTestResults}"> 
          	<tr> 
          		<td colspan="${fn:length(axisHeaders)+10}" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if> 
        	</tbody>
      </table>
      </div>
</fieldset>