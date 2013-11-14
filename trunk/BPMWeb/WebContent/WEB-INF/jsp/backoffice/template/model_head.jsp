<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	//renderPageSelect();
	/* if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 } */
	 var pmType=$('input:radio[name=pstModel\\.pmType]:checked').val();
	//alert(pmType);
	getModel(pmType);
});
function goBackRoadpump(){
	 
	  $.ajax({
		  type: "get",
		  url: "roadpump/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
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
/* function doSearch(mode,id){
	$("#pageNo").val("1");
	doAction(mode,id);
} */
/*
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#pmIdArray").val(id);
	}else if(mode!='search'){
		$("#pmId").val(id);
	}else {
		$("#pmId").val("0");
	}
	$.post("model/search",$("#modelForm").serialize(), function(data) {
		  // alert(data);
		  //  appendContent(data);
		    appendContentWithId(data,"model_section");
		  // alert($("#_content").html());
		});
}
*/
function getModel(id){ 
	$.post("model/search/"+id,$("#modelHeadForm").serialize(), function(data) {
		  // alert(data);
		    //appendContent(data);
		    appendContentWithId(data,"model_section");
		  // alert($("#_content").html());
	});
}
</script>
<div id="dialog-confirmDelete" title="Delete Model" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Model ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="model:relative;right:-94%;">  </div> --> 
         
             
            <form:form id="modelHeadForm" name="modelHeadForm" modelAttribute="modelForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
           
            <div align="left">
            <strong>จัดการ รุ่นรถ/รุ่นปั๊ม</strong>
            </div>
            <div align="left" style="padding: 10px 60px">
            	<span style="font-size: 13px;">จัดการตาม: </span> 
            	<span style="padding: 20px">
            	<form:radiobutton path="pstModel.pmType" value="1" onclick="getModel('1')"/>&nbsp;รุ่นรถ&nbsp;&nbsp;/
            	<form:radiobutton path="pstModel.pmType" value="2" onclick="getModel('2')"/>&nbsp;รุ่นปั๊ม
            	<!--  <input type="radio" value="1" checked="checked" name="checkname" onclick="getModel('1')"/>&nbsp;รุ่นรถ&nbsp;&nbsp;/
            	 <input type="radio" value="2"  name="checkname" onclick="getModel('2')"/>&nbsp;รุ่นปั๊ม -->
            	</span>   
            </div>
			</form:form> 
			<!-- 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('model/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					 
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="modelPageSelect" id="modelPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;</td>
	    					</tr>
	    					</tbody></table> -->
	    					<div id="model_section"></div>
		<%-- <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">ลำดับ</div></th>
            		<th width="82%"><div class="th_class">รุ่นรถ/รุ่นปั๊ม</div></th>
            		<!-- <th width="15%"><div class="th_class">อัตราค่าแรง(เท่า)</div></th>   -->
            		<th width="8%"><div class="th_class"></div></th> 
          		</tr>
        	</thead>
        	<tbody>  
        	<c:if test="${not empty pstModels}"> 
        	 <c:forEach items="${pstModels}" var="pstModel" varStatus="loop"> 
          	<tr> 
            	<td>${(modelForm.paging.pageNo-1)*modelForm.paging.pageSize+(loop.index+1)}.</td>
            	<td>${pstModel.pmName}</td>  
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('model/item/${pstModel.pmId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstModel.pmId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstModels}"> 
          	<tr>
          		<td colspan="4" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
        	</tbody>
      </table> 
      <div align="left">
			<a class="btn btn-info"  onclick="goBackRoadpump()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
    			
	 </div> --%>
      </fieldset> 