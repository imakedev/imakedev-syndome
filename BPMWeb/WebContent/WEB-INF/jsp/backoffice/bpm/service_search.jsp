<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 

<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	searchService("1");
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchService(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchService(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchService($("#pageNo").val());
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"pageSelect\" id=\"pageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val(); 
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	checkWithSet("pageSelect",$("#pageNo").val());
}
function confirmDelete(id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
} 
function doAction(id){
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_REPAIRING where BR_ID="+id; 
	querys.push(query); 
	SynDomeBPMAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data.resultMessage.msgCode=='ok'){
				data=data.updateRecord;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			if(data!=0){
				searchService("1"); 
			}
		}
	});
} 
function searchService(_page){  
	$("#pageNo").val(_page); 
	var query=" SELECT "+
		" BR_ID,"+
		" BR_NAME,"+
		" BR_TICKET_NO,"+
		" CUSCOD,"+
		" BR_INFORMANT,"+
		" BCAUSE_ID,"+
		" BV_COD,"+
		" BR_INSTALLATION_LOCATION,"+
		" BR_INSTALLATION_CONTACT,"+
		" BR_INSTALLATION_TEL,"+
		" BR_INSTALLATION_FAX,"+
		" BP_PRO_COD,"+
		" BV_NAME,"+
		" BV_ADDR,"+
		" BV_CONTACT,"+
		" BV_TEL,"+
		" BV_FAX,"+
		" CUSNAM,"+
		" CUSADDR,"+
		" CUSCONTACT,"+
		" CUSTEL,"+
		" CUSFAX,"+
		" PRODUCT_SERIAL,"+
		" PRODUCT_CODE,"+
		" PRODUCT_MODEL,"+
		" PRODUCT_TYPE,"+
		" PRODUCT_DESC,"+
		" PRODUCT_VERSION_SOFTWARE,"+
		" PRODUCT_WORK_ORDER,"+
		" PRODUCT_IS_WARRANT,"+
		" PRODUCT_WARRANT_START,"+
		" PRODUCT_WARRANT_END,"+
		" PRODUCT_NC,"+
		" BR_INFO_INFORMANT,"+
		" BR_INFO_COMMENT,"+
		" BR_INFO_TEL,"+
		" BR_INFO_FAX,"+
		" BR_INFO_CAUSE,"+
		" BR_INFO_ACCEPT_BY,"+
		" BR_INFO_CREATED_DATE,"+
		" BR_INFO_WORKAROUNDS,"+
		" BR_INFO_BORROW_DATE,"+
		" BR_INFO_RETURN_DATE,"+
		" BR_INFO_MODEL_CHANGE,"+
		" BR_INFO_SERIAL_CHANGE,"+
		" BR_INFO_SC,"+
		" BR_INFO_AREA,"+
		" BR_REPAIR_SC,"+
		" BR_REPAIR_STATUS,"+
		" BR_REPAIR_CANCELED_DATE,"+
		" BR_REPAIR_CAUSE_GROUP,"+
		" BR_REPAIR_CAUSE_TYPE,"+
		" BR_REPAIR_AREA,"+
		" BR_REPAIR_CAUSE,"+
		" BR_REPAIR_SOLUTION,"+
		" BR_REPAIR_COMMENT,"+
		" BR_REPAIR_RECOMMEND_SCORE,"+
		" BR_REPAIR_RECOMMEND_ADDITION,"+
		" BR_REPAIR_RECOMMEND_REMARK,"+
		" SLA,"+
		" BR_CUSTOMER_CLOSE_DATE ,"+
		" BR_CLOSE_DATE ,"+
		" BR_NO "+
		" FROM "+SCHEMA_G+".BPM_REPAIRING ";
	 
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	SynDomeBPMAjax.searchObject(queryObject,{
		callback:function(data){
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Job No</div></th> "+
			        "  		<th width=\"25%\"><div class=\"th_class\">Customer Code</div></th> "+  
			        "  		<th width=\"50%\"><div class=\"th_class\">Customer Name</div></th> "+ 
			        "  		<th width=\"8%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][62]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][1]!=null)?data[i][1]:"&nbsp;")+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][1]!=null)?data[i][1]:"&nbsp;")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/service_management?brId="+data[i][0]+"&mode=edit')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section_service").html(str);
		}
	}); 
	/*
	SynDomeBPMAjax.searchObject(queryCount,{
		callback:function(data){
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
			//alert(data)
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
	*/
} 
</script>
<div id="dialog-confirmDelete" title="Delete Job" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Job ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
            <form id="slaForm" name="slaForm" style="display: none">
           <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            </form>
			   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px"> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody>
	    					<tr>
	    					<td align="left" width="70%">  
	    					<span><strong>แจ้งซ่อม</strong></span>
	    					</td><td align="right" width="30%"> 
	    					</td>
	    					</tr>
	    					<tr>
	    					<td align="left" width="70%">   
	    					<a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/service_management?brId=0&mode=add')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Create Job</span></a>
	    					</td><td align="right" width="30%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="pageSelect" id="pageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>  
	    					<div  id="search_section_service"> 
    						</div> 
      </div>
      </fieldset> 