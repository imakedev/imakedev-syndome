<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<sec:authorize access="hasAnyRole('ROLE_ADMIN')" var="isManageMC"/>
<script>
$(document).ready(function() {
	//renderPageSelect();
<%-- <c:if test="${not isManageMC}">	 --%>
<c:if test="${false}">
	  new AjaxUpload('doc_file', {
	       action: 'upload/attachManual/${seriesForm.missSery.msId}',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(pdf|PDF)$/.test(ext)){
					/* Setting data */
					this.setData({
					});					
				//$('#contact_photo').attr('src', _path+"resources/images/ui-anim_basic_16x16.gif");
				//$('#contact_photo').attr('src', _path+"resources/images/loading.gif");
				} else {					
					// extension is not allowed
					alert('Error: only pdf are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				/*
				//alert(file+","+obj.hotlink);
				var path_file='getFileAttached("getfile/attachManual/${seriesForm.missSery.msId}/'+obj.hotlink+'")';
				$('#doc_file_attached').attr('onclick',path_file);
				$('#doc_file_attached').html(file);
				$('#doc_file_attached').attr('style','cursor: pointer;');
				//$('#example2 .text').text('Uploaded ' + file);	
				*/
			}		
		});
	</c:if>
});
function confirmDelete(mode,id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				//doAction(mode,id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
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
	$("#pageNo").val(document.getElementById("testPageSelect").value);
	doAction('search','0');
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
  <div id="dialog-confirmDelete" title="Delete Document" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Document ?
</div>
	    <fieldset style="font-family: sans-serif;">  
	    <c:if test="${false}">	
	     <table border="0" width="100%">
	     	<tr>
	     		<td align="right">
	     			<span ><a class="btn" id="doc_file"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a></span>
	     		</td>
	     	</tr>
	     </table>
	     </c:if>
		 <table class="table table-striped table-bordered table-condensed"  border="1" style="font-size: 12px;width: 100%;"> 
		<!-- <table  border="1" style="font-size: 12px;width: 100%;"> -->
        	<thead>
          		<tr>
            		<th width="100%"><div class="th_class">Document Download</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${missDocs}" var="missDoc" varStatus="loop"> 
          	<tr> 
            	<td>&nbsp;<span style="cursor: pointer;" onclick="getFileAttached('getfile/doc/${missDoc.mdId}/xxx')">${missDoc.mdDocFileName}</span>&nbsp;
            	<c:if test="${false}">	
            		<i title="Delete" onclick="confirmDelete('delete','${missDoc.mdId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</c:if>
            	</td>
          	</tr>
          	</c:forEach>
        	</tbody>
      </table>
</fieldset>