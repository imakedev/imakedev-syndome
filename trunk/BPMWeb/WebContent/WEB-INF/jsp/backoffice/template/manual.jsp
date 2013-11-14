<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	//renderPageSelect();
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
function getFileAttached(path){
	// alert(path)
    var div = document.createElement("div");
    document.body.appendChild(div);
    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + path + "'></iframe>";
	  // Create an IFRAME.
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
 
	    <fieldset style="font-family: sans-serif;">  
		 <table class="table table-striped table-bordered table-condensed"  border="1" style="font-size: 12px;width: 100%;"> 
		<!-- <table  border="1" style="font-size: 12px;width: 100%;"> -->
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">Manual Series</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${missManuals}" var="missManual" varStatus="loop"> 
          	<tr> 
            	<td>&nbsp;<span style="cursor: pointer;" onclick="getFileAttached('getfile/attachManual/10/${missManual.mmHotlink}')">${missManual.mmFileName}</span>&nbsp;(Series&nbsp;:&nbsp;${missManual.missSery.msSeriesName})</td>
          	</tr>
          	</c:forEach>
        	</tbody>
      </table>
      
</fieldset>