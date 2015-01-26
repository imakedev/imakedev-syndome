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
	 $("#pdName").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchPstDepartMent();
		   } 
		});
	 searchPstDepartMent();
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
//	$("#pageNo").val(document.getElementById("breakdownPageSelect").value);
	checkWithSet("pageNo",$("#breakdownPageSelect").val());
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
	checkWithSet("pageSelect",$("#pageNo").val());
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
function loadDynamicPageWithMode(mode,page,id){
	
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
function searchPstDepartMent(){
	var pdName =jQuery.trim($("#pdName").val());
	var pdNameWhere="";
	if(pdName.length>0)
		pdNameWhere=" where lower(pd_name) like lower('%"+pdName+"%')";
	var query="SELECT pd_id,pd_name FROM "+SCHEMA_G+".PST_DEPARTMENT "+pdNameWhere; 
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        " 			<th width=\"10%\"><div class=\"th_class\">รหัส</div></th>"+
			        "   		<th width=\"82%\"><div class=\"th_class\">แผนก</div></th>"+ 
			        "    		<th width=\"8%\"><div class=\"th_class\"></div></th>     "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				        "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+data[i][1]+"</td>  "+   
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPageWithMode('edit','maintenance/page/maintenance_dept_management','"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    var str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"3\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section_dept").html(str);
		}
	}); 
}
</script>
<div id="dialog-confirmDelete" title="Delete Breakdown" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Department ?
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
            <strong>จัดการแผนก</strong>
            </div>
            <div align="left" style="padding: 10px 60px">
            	<span style="font-size: 13px;">แผนก</span> 
            	<span style="padding: 20px">
            	<%-- <form:input path="pstBreakDown.pbdUid" cssStyle="height: 30;width:80px"/> --%>
            	 <input type="text" id="pdName" style="height: 30;width:300px">  
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
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;<a class="btn btn-primary" onclick="searchPstDepartMent()"><i class="icon-search icon-white"></i>&nbsp;Search</a></td>
	    					</tr>
	    					</tbody></table>
	    					<div  id="search_section_dept">
	 							 
    						</div>
		
      </fieldset>
      <fieldset style="font-family: sans-serif;padding-top:5px;display: none" >
	    <form id="form2" name="form2" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			<input type="hidden" id="mode"/> 
            <input type="hidden" id="pbdId"/>  
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Break down</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รหัสรายการ :</span></td>
    					<td width="75%" colspan="2"> 
    						<%-- <form:input path="pstBreakDown.pbdUid" id="pbdUid" cssStyle="height: 30;width:80px"/> --%>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รายละเอียด :</span></td>
    					<td width="75%" colspan="2"> 
    					<%-- <form:input path="pstBreakDown.pbdName" id="pbdName" cssStyle="height: 30;"/> --%>
    					</td>
    				</tr> 
    			</table> 
    			</fieldset> 
	   </form>
			<div align="center">
			<a class="btn btn-info"  onclick="goBackBreakdown()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doBreakdownAction('action','mode','pbdId')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset> 