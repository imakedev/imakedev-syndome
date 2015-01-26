<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 

<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;

}
 .bootbox { width: 800px !important;}
 .modal{margin-left:-400px}
 .modal-body{max-height:500px}
 .modal.fade.in{top:1%}
 
</style>
 
<script>
var role_ids=[];
$(document).ready(function() { 
	searchRole("1");
});
function showRole(bpmRoleID){
	
	var query=" select "+ 
			  " role_type.BPM_ROLE_TYPE_ID, role_type.BPM_ROLE_TYPE_NAME, "+
			  " role_type.BPM_ROLE_TYPE_DESC,role_type.BPM_ROLE_TYPE_ORDER, "+
			  " (select count(*) FROM "+SCHEMA_G+".BPM_ROLE_MAPPING role_mapping where  "+
			  " role_mapping.bpm_role_type_id=role_type.bpm_role_type_id  "+
			  " and role_mapping.bpm_role_id="+bpmRoleID+") as count "+
			  " from   "+SCHEMA_G+".BPM_ROLE_TYPE role_type   "+
			  " order  by role_type.BPM_ROLE_TYPE_ORDER  "; 
	SynDomeBPMAjax.searchObject(query,{
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
			role_ids=[];
			if(data!=null && data.length>0){
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Role</div></th> "+
			    "  		<th width=\"53%\"><div class=\"th_class\">Description</div></th> "+ 
			    "  		<th width=\"12%\"><div class=\"th_class\">Permission</div></th> "+
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){
					   role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   }
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"</td>  "+  
				    //    "    	<td style=\"text-align: left;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+   
				        " <input type=\"radio\" value=\""+data[i][0]+"\" "+check_selected+" name=\"rtIdCheckbox_radio_"+data[i][0]+"\"> "+
				 		"<img src=\""+_path+"/resources/images/Select.png\"/>&nbsp; "+
						"<input type=\"radio\" value=\"0\" "+unCheck_selected+" name=\"rtIdCheckbox_radio_"+data[i][0]+"\">  "+
						"<img src=\""+_path+"/resources/images/deSelect.png\"/> "+
				        "    	</td> "+
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doUpdateRoleAction('"+bpmRoleID+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Update Role</span></a></div>";
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function doUpdateRoleAction(bpmRoleID){
	/* alert(role_ids.length);
	var rtIdCheckbox_radio=document.getElementsByName("rtIdCheckbox_radio_6");
	alert(rtIdCheckbox_radio.length)
   */
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_ROLE_MAPPING where bpm_role_id="+bpmRoleID; 
	querys.push(query);
	for(var i=0;i<role_ids.length;i++){
		var rtIdCheckbox_radio=document.getElementsByName("rtIdCheckbox_radio_"+role_ids[i]);
		// var index=0;
		for(var j=0;j<rtIdCheckbox_radio.length;j++){
			if(rtIdCheckbox_radio[j].checked && j==0){
				query="INSERT INTO "+SCHEMA_G+".BPM_ROLE_MAPPING (BPM_ROLE_ID,BPM_ROLE_TYPE_ID) VALUES "+
				" ("+bpmRoleID+","+role_ids[i]+")";
				querys.push(query);		
			}
		} 
	}
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
			bootbox.hideAll();
		}
	});
}
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchRole(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchRole(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchRole($("#pageNo").val());
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
	var query="DELETE FROM "+SCHEMA_G+".BPM_ROLE where bpm_role_id="+id; 
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
				searchRole("1"); 
			}
		}
	});
} 
function searchRole(_page){  
	$("#pageNo").val(_page); 
	var query="SELECT bpm_role_id,bpm_role_name,BPM_ROLE_DETAIL,bpm_order FROM "+SCHEMA_G+".BPM_ROLE order by bpm_order ";
	   
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
			        "  		<th width=\"25%\"><div class=\"th_class\">Role Name</div></th> "+
			        "  		<th width=\"60%\"><div class=\"th_class\">Role Detail</div></th> "+  
			        //"  		<th width=\"12%\"><div class=\"th_class\">HOD</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"&nbsp;")+"</td>  "+  
				    //    "    	<td style=\"text-align: left;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+   
				        "    	<i title=\"Role mapping\" onclick=\"showRole('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-cog\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/role_management?bpmRoleId="+data[i][0]+"&mode=edit')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"4\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
					
			$("#search_section_role").html(str);
		}
	}); 
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
} 
</script>
<div id="dialog-confirmDelete" title="Delete Role" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Role ?
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
	    					<span><strong>Role</strong></span>
	    					</td><td align="right" width="30%"> 
	    					</td>
	    					</tr>
	    					<tr>
	    					<td align="left" width="70%">   
	    					<a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/role_management?bpmRoleId=0&mode=add')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Add</span></a>
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
	    					<div id="search_section_role"> 
    						</div> 
      </div>
      </fieldset> 