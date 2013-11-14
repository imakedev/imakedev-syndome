<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
var megEmptyIdG;;
var meNameG; 
var questionCountEmptyG;
var choiceCountEmptyG;

$(document).ready(function() {
	renderPageSelect();
	/*  $("input[id=msSeriesName],[id=msUnitCost]").keypress(function(event) {
	 	  if ( event.which == 13 ) {
	 	     event.preventDefault();
	 	    	doAction('search','0');
	 	   }
	 });
	  */
	megEmptyIdG= $( "#megEmptyId" );
	meNameG= $( "#meName" );
	questionCountEmptyG= $( "#questionCountEmpty" );
	choiceCountEmptyG= $( "#choiceCountEmpty" );
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
	$("#pageNo").val(document.getElementById("testPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	var pageStr="<select name=\"testPageSelect\" id=\"testPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("testPageSelect").value=$("#pageNo").val();
}
function toggleCheckbox(){
	var _check=document.getElementById("meIdCheckboxAll").checked;
	var meIdCheckbox=document.getElementsByName("meIdCheckbox"); 
	for(var i=0;i<meIdCheckbox.length;i++){ 
			meIdCheckbox[i].checked=_check;
	}
}
function loadDialogcreateEmpty(){
	 $( "#dialog-createEmpty" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 	
					$(this).dialog( "close" );
					doCreateEmpty();
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
}
function doCreateEmpty(){
	//alert($("#megEmptyId").val()+",meName="+$("#meName").val()+",questionCountEmpty="+$("#questionCountEmpty").val()+",choiceCountEmpty="+$("#choiceCountEmpty").val())
	//alert(document.getElementById("meName").value)
	 var data= { 
		megEmptyId:megEmptyIdG.val(),
		meName: meNameG.val(),
		questionCountEmpty: questionCountEmptyG.val(),
		choiceCountEmpty: choiceCountEmptyG.val()
		};
//	alert();	
	 $.post("test/createEmpty", data,  function(data) {
			
		    appendContent(data);
		}); 
	// $( "#dialog-createEmpty" ).dialog( "close" );
	/*  $.post("test/createEmpty", 
			  $("#testFormEmpty").serialize(), function(data) {
		    appendContent(data);
		}); */
}
function doDeleteItems(){
	var meIdCheckbox=document.getElementsByName("meIdCheckbox");
	//alert(meIdCheckbox.length);
	var meIds="";
	for(var i=0;i<meIdCheckbox.length;i++){
		 if(meIdCheckbox[i].checked)
			 meIds=meIds+meIdCheckbox[i].value+",";
	}
	 
	meIds=meIds.substring(0, meIds.length-1);
	if(meIds.length>0){
		//alert(meIds);
		$( "#dialog-confirmDelete" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doAction("deleteItems",meIds);
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	}
// 	alert(meIds)
	/*   $("#meId").val(id);
	$.post("series/search",$("#testForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		}); */
}
function copyTest(id){	 
	 $( "#dialog-confirmCopy" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doCopyTest(id);
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
 }
 function doCopyTest(id){
		$.get("test/copy/"+id, function(data) {
			  // alert(data);
			    appendContent(data);
			  // alert($("#_content").html());
			});
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
		$("#meIdArray").val(id);
	}else if(mode!='search'){
		$("#meId").val(id);
	}else {
		$("#meId").val("0");
	}
	$.post("test/search",$("#testForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
/* function doSearch(){
	$("#mode").val("search");
	$("#mode").val("edit");
	$.post("series/search",$("#testForm").serialize(), function(data) {
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
 <div id="dialog-confirmDelete" title="Delete Test" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Test ?
</div>
 <div id="dialog-confirmCopy" title="Copy Test" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to copy Test ?
</div>
 <div id="dialog-createEmpty" title="Create Empty Test" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	 <%-- <form:form  id="testFormEmpty" name="testFormEmpty" modelAttribute="testForm" cssClass="well" cssStyle="border:2px solid #DDD" method="post" action="">
	 	 Group :<form:select path="megEmptyId">
	    					 	 <form:option  value="0" label="-- Select --"></form:option>
	    					 	 <form:options itemLabel="megName" items="${missExamGroups}" itemValue="megId"/>
	    </form:select><br/>
	    Test Name:<form:input path="missExam.meName" id="meName"/><br/>
	    Question count:<form:input path="missExam.questionCountEmpty" id="questionCountEmpty"/><br/>
	    Choice count:<form:input path="missExam.choiceCountEmpty" id="choiceCountEmpty"/>	  
	 </form:form> --%>
	 <form id="testFormEmpty"   style="border:2px solid #DDD">
	 	Group :<select id="megEmptyId">
	 		 <c:forEach items="${missExamGroups}" var="missExamGroup" varStatus="loop"> 
	    					 			 <option value="<c:out value="${missExamGroup.megId}"></c:out>"><c:out value="${missExamGroup.megName}"></c:out></option>
	         </c:forEach>
	 	</select>
	 	Test Name:<input type="text" id="meName"/><br/>
	    Question count:<input type="text" id="questionCountEmpty"/><br/>
	    Choice count:<input type="text" id="choiceCountEmpty"/>	  
	 </form>
</div>
	    <fieldset style="font-family: sans-serif;">  
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
          <!-- <form class="well" style="border:2px solid #DDD"> -->
           <form:form  id="testForm" name="testForm" modelAttribute="testForm" cssClass="well" cssStyle="border:2px solid ${UserMissContact.missTheme.mtBgColor};background: url('/MISSExamBackOffice/resources/images/${UserMissContact.missTheme.mtWaterWall}') no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}" method="post" action="">
            <form:hidden path="mode"/>
            <form:hidden path="missExam.meId" id="meId"/>
            <form:hidden path="meIdArray" id="meIdArray"/>
            <form:hidden path="paging.pageNo" id="pageNo"/>
            <form:hidden path="paging.pageSize" id="pageSize"/> 
            <form:hidden path="pageCount" id="pageCount"/> 
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong>Test Search</strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="center" width="17%" colspan="6">&nbsp;Group : 
	    					 <form:select path="megId">
	    					 	 <form:option  value="0" label="-- Select --"></form:option>
	    					 	 <form:options itemLabel="megName" items="${missExamGroups}" itemValue="megId"/>
	    					  </form:select>
	    					<%--  <select name="bpsGroupId" id="bpgGroupId"> 
	    					 <option value="0">-- Select --</option>
	    					 <c:forEach items="${missExamGroups}" var="missExamGroup" varStatus="loop">  
	    					 		<option value="<c:out value="${missExamGroup.megId}"/>"><c:out value="${missExamGroup.megName}"/></option>
	    					 </c:forEach>												
	    					</select> --%>
	    					</td>
	    					</tr>
	    					</table> 
	    					</form:form>
	    					<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('test/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<a class="btn btn-primary" onclick="loadDialogcreateEmpty()"><i class="icon-plus-sign icon-white"></i>&nbsp;Create Test Empty</a>&nbsp;
	    					<a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a></td>
	    					
	    					<td align="right" width="50%">
	    					
	    					<a onclick="goPrev()"><spring:message code='page_prev'/></a>&nbsp;|&nbsp;<span id="pageElement"></span>&nbsp;|&nbsp;<a onclick="goNext()"><spring:message code='page_next'/></a>&nbsp;<a  class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;<spring:message code='button_search'/></a></td>
	    					</tr>
	    					</table> 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox" id="meIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="85%"><div class="th_class">Test</div></th> 
            		<th width="10%"><div class="th_class">Action</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
          <c:if test="${not empty missExams}"> 
        	 <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" name="meIdCheckbox" value="${missExam.meId}"/></td> 
            	<td>&nbsp;${missExam.meName}</td>
            	<td style="text-align: center;">
            	<img onclick="copyTest('${missExam.meId}')" src="<c:url value='/resources/images/glyphicons_153_more_windows.png'/>" title="Copy" style="cursor: pointer;width: 14px;height: 14px"/>&nbsp;&nbsp;
            	<i title="Edit" onclick="loadDynamicPage('test/exam/${missExam.meId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	<i title="Delete" onclick="confirmDelete('delete','${missExam.meId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td> 
          	</tr>
          	</c:forEach>
          </c:if>
          <c:if test="${empty missExams}"> 
          	<tr> 
          		<td colspan="3" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if> 
        	</tbody>
      </table>
      
</fieldset>