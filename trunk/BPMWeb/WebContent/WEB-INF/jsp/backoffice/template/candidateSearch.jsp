<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
	    <!--Body content-->
<script type="text/javascript">
$(document).ready(function() {
	renderPageSelect();
/* 	var idArray=$("#meIdArray").val();
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
		 */
	/*  $("#maRegisterFrom" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" 
		});
	 $("#maRegisterTo" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" 
		}); */
	/*  $("input[id=msSeriesName],[id=msUnitCost]").keypress(function(event) {
	 	  if ( event.which == 13 ) {
	 	     event.preventDefault();
	 	    	doAction('search','0');
	 	   }
	 }); */
	/* $(document).keypress(function(event){
		 
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == '13'){
			//alert('You pressed a "enter" key in somewhere');	
			doSearch('search','0');
		} 
	}); */
	 $("input[id=mcaUsername],[id=mcaPassword],[id=mcaCompanyName]").keypress(function(event) {
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
	$("#pageNo").val(document.getElementById("candidatePageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	var pageStr="<select name=\"candidatePageSelect\" id=\"candidatePageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("candidatePageSelect").value=$("#pageNo").val();
}
function toggleCheckbox(){
	var _check=document.getElementById("mcaIdCheckboxAll").checked;
	var mcaIdCheckbox=document.getElementsByName("mcaIdCheckbox"); 
	for(var i=0;i<mcaIdCheckbox.length;i++){ 
		mcaIdCheckbox[i].checked=_check;
	}
}

function exportCandidat(){
	var src = "candidate/export";
	//alert(src)
	var mcaIdCheckbox=document.getElementsByName("mcaIdCheckbox");
	//alert(mcaIdCheckbox.length);
	var mcaIds="";
	for(var i=0;i<mcaIdCheckbox.length;i++){
		 if(mcaIdCheckbox[i].checked)
			 mcaIds=mcaIds+mcaIdCheckbox[i].value+",";
	}
	 
	mcaIds=mcaIds.substring(0, mcaIds.length-1);
	if(!(mcaIds.length>0)){
		//alert(mcaIds);dialog-empty
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
		src=src+"?id="+mcaIds;
	     var div = document.createElement("div");
	    document.body.appendChild(div);
	    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
	}
	
    
}
function doDeleteItems(){
	var mcaIdCheckbox=document.getElementsByName("mcaIdCheckbox");
	//alert(mcaIdCheckbox.length);
	var mcaIds="";
	for(var i=0;i<mcaIdCheckbox.length;i++){
		 if(mcaIdCheckbox[i].checked)
			 mcaIds=mcaIds+mcaIdCheckbox[i].value+",";
	}
	 
	mcaIds=mcaIds.substring(0, mcaIds.length-1);
	if(mcaIds.length>0){
		//alert(mcaIds);
		$( "#dialog-confirmDelete" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doAction("deleteItems",mcaIds);
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
// 	alert(mcaIds)
	  /*  $("#mcaId").val(id);
	$.post("candidate/search",$("#candidateForm").serialize(), function(data) {
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
function doSearch(mode,id){
	$("#pageNo").val("1");
	doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#mcaIdArray").val(id);
	}else if(mode!='search'){
		$("#mcaId").val(id);
	}else {
		$("#mcaId").val("0");
	}
	$.post("candidate/search",$("#candidateForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
/* tr:nth-child(odd) {background: #e0e0e0} */
</style>
<div id="dialog-confirmDelete" title="Delete Candidate" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Candidate ?
</div>
<div id="dialog-empty" title="Empty Candidate" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Please select  Candidate
</div>
<fieldset style="font-family: sans-serif;">
	     <%-- <fieldset style="font-family: sans-serif;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}"> --%>    
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
           <%--  <pre  class="prettyprint"  style="font-family: sans-serif;font-size:12px;margin-top: 0px;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}"> --%>
             
            <form:form  id="candidateForm" name="candidateForm" modelAttribute="candidateForm" 
           cssClass="well" cssStyle="border:2px solid ${UserMissContact.missTheme.mtBgColor};background: url(/MISSExamBackOffice/resources/images/${UserMissContact.missTheme.mtWaterWall}) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}"
              method="post" action="">
               
             <form:hidden path="mode"/>
            <form:hidden path="missCandidate.mcaId" id="mcaId"/>
            <form:hidden path="mcaIdArray" id="mcaIdArray"/>
            <form:hidden path="paging.pageNo" id="pageNo"/>
            <form:hidden path="paging.pageSize" id="pageSize"/> 
            <form:hidden path="pageCount" id="pageCount"/> 
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="17%" colspan="6"><strong>Candidate Search</strong></td>
	    					
	    					</tr>
	    					<!-- private String mcaStatus;
	private String mcaSeries;
	private String mcaUsername;
	private String mcaPassword;
	private String mcaCompanyName; -->
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Status:</td>
	    					 <td align="left" width="17%">    	
	    					    <form:select path="mcaStatus">
	    					      <form:option value="-1">-- Select Status --</form:option>
	    					      <form:option value="1">Used</form:option>
	    					      <form:option value="2">Available</form:option>
	    					    </form:select>				
	    						<!-- <select name="bpsGroupId2" id="bpgGroupId2" style="width: 100px"> 
											 <option value="0">1</option>
											 <option value="20">20</option>
											 <option value="300">300</option>
												
	    						</select> -->
	    					 </td>
	    					<td align="left" width="17%">Series:</td>
	    					<td align="left" width="17%">
	    					 <form:select path="mcaSeries">
	    					      <form:option value="-1">-- Select Series --</form:option>
	    					      <form:options itemValue="msId" itemLabel="msSeriesName" items="${missSeries}"/>
	    					      <%--
	    					      <c:forEach items="${missSeries}" var="missSery" varStatus="loop"> 
	    					 			 <option value="<c:out value="${missSery.msId}"></c:out>"><c:out value="${missSery.msSeriesName}"></c:out></option>
	    					 	 </c:forEach>
	    					 	  --%>
	    					    </form:select>		
	    					    
	    					<!-- <select name="bpsGroupId2" id="bpgGroupId2"> 
											 <option value="0">1</option>
											 <option value="20">20</option>
											 <option value="300">300</option>
												
	    						</select> -->
	    						</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Username:</td>
	    					 <td align="left" width="17%">
	    					 <form:input path="mcaUsername"/>
	    					 <!--  <input type="text" name="registerNo"/>   	 -->				
	    						
	    					 </td>
	    					<td align="left" width="17%">Password:</td>
	    					<td align="left" width="17%">
	    					 <form:input path="mcaPassword"/>
	    						<!-- <input type="text" name="registerNo"/> -->
	    					</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<c:if test="${UserMissContact.isMC=='1'}">
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Company Name:</td>
	    					 <td align="left" colspan="3" width="51%">    
	    					 		
	    					  <form:input path="mcaCompanyName" cssStyle="width:100%"/>		
	    						<!-- <input type="text" name="registerNo"  style="width: 100%"/> -->
	    					 </td> 
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					</c:if>
	    					
	    				
	    					</table> 
	    					</form:form>
	    				<!-- 	</fieldset> -->
	    					<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="50%">
	    					
	    					<!-- <a class="btn btn-primary" onclick="loadDynamicPage('candidate/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp; -->
	    					<a class="btn btn-info" onclick="exportCandidat()"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Export</a>&nbsp;
	    					<a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a>&nbsp;
	    					
	    					<td align="right" width="50%">
	    					
	    					<a onclick="goPrev()"><spring:message code='page_prev'/></a>&nbsp;|&nbsp;<span id="pageElement"></span>&nbsp;|&nbsp;<a onclick="goNext()"><spring:message code='page_next'/></a>&nbsp;<a  class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;<spring:message code='button_search'/></a></td>
	    					</tr>
	    					</table>  
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="7%"><div class="th_class"><input type="checkbox" id="mcaIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="17%"><div class="th_class">Username/Password</div></th> 
            		<!-- <th width="10%"><div class="th_class">Password</div></th> -->
            		<th width="35%"><div class="th_class">Company [Total/Available Unit]</div></th> 
            		<th width="20%"><div class="th_class">Series [Available Unit]</div></th>
            		<th width="10%"><div class="th_class">Last Login</div></th> 
            		<th width="5%"><div class="th_class">Status</div></th>
            		<th width="6%"><div class="th_class">Action</div></th>  
          		</tr>
        	</thead>
        	<tbody>
        	<c:if test="${not empty missCandidates}"> 
        	 <c:forEach items="${missCandidates}" var="missCandidate" varStatus="loop"> 
          	<tr> 
            
            	<td><input type="checkbox" name="mcaIdCheckbox"  value="${missCandidate.mcaId}"/>&nbsp;&nbsp;${(candidateForm.paging.pageNo-1)*candidateForm.paging.pageSize+(loop.index+1)}.</td>
            	<td>&nbsp;${missCandidate.mcaUsername}&nbsp;/&nbsp;${missCandidate.mcaPassword}</td>
            	<%-- <td>&nbsp;${missCandidate.mcaPassword}</td> --%>
            	<td>&nbsp;${missCandidate.missAccount.maName}&nbsp;[${missCandidate.missAccount.maTotalUnit}/${missCandidate.missAccount.maTotalUnit-missCandidate.missAccount.maUsedUnit}]</td>
            	<td>&nbsp;${missCandidate.missSery.msSeriesName}&nbsp;[${missCandidate.masmAvailable}]</td>
            	<td>&nbsp;${missCandidate.lastLogin}</td>
            	<td>
            	<c:if test="${missCandidate.mcaStatus=='1'}">
            	Used
            	</c:if>
            	<c:if test="${missCandidate.mcaStatus=='2'}">
            	Available
            	</c:if>  
            	</td>
            	<td style="text-align: center;">
            	<i title="Edit" onclick="loadDynamicPage('candidate/item/${missCandidate.mcaId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	<i title="Delete" onclick="confirmDelete('delete','${missCandidate.mcaId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
            	 
          	</tr>
          	</c:forEach>
          </c:if>
          <c:if test="${empty missCandidates}"> 
          	<tr>
          		<td colspan="7" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
         <!--  <tr>
            	<td><input type="checkbox" /></td>
            	<td>Company</td>
            	<td>Company A chatchai pimtun co.th make dev aoe</td>
            	<td>0848810484</td>
            	<td>M000000</td>
            	<td>D/M/Y h:m</td>
            	<td>300</td>
            	<td>xx</td>
            	<td><a onclick="loadDynamicPage('candidate/account/2')">xx</a></td>
            	<td>xx</td> 
          	</tr><tr>
            	<td><input type="checkbox" /></td>
            	<td>Company</td>
            	<td>Company A</td>
            	<td>0848810484</td>
            	<td>M000000</td>
            	<td>D/M/Y h:m</td>
            	<td>300</td>
            	<td>xx</td>
            	<td><a onclick="loadDynamicPage('candidate/account/3')">xx</a></td>
            	<td>xx</td> 
          	</tr> -->
        	</tbody>
      </table>
     <!--  </pre> -->
      </fieldset> 
  