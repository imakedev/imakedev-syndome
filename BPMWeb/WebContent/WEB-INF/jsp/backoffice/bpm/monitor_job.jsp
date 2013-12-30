 <%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/>  
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:1000px}
 .modal.fade.in{top:1%}
</style>
 
<script>
var usernameG='${username}';
var rolesG='';
$(document).ready(function() {  
	
	$.get("dispatcher/roles", function(data) { 
		   var sql_inner="("; 
		   for(var i=0;i<data.length;i++){
			   sql_inner=sql_inner+"'"+data[i]+"'";
			   if(i!=(data.length-1)){
				   sql_inner=sql_inner+",";
			   }
		   }
		   sql_inner=sql_inner+")"; 
		   rolesG=sql_inner; 
		   getMonitorJob("1");
		});
	
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		getMonitorJob(prev)
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		getMonitorJob(next)
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("employeeWorkMappingPageSelect").value);
//	doAction('search','0');
	getMonitorJob($("#pageNo").val())
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"employeeWorkMappingPageSelect\" id=\"employeeWorkMappingPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val(); 
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("employeeWorkMappingPageSelect").value=$("#pageNo").val();
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
function doSearch(mode,id){
	$("#pageNo").val("1");
	doAction(mode,id);
}
function doAction(id){
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_SLA where BS_ID="+id; 
	querys.push(query);
	//alert(query);
	//  return false;
	
	SynDomeBPMAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data!=0){
				getMonitorJob("1");
				//loadDynamicPage("setting/page/setting_sla");
			}
		}
	});
} 
function loadFlow(ref,type,state,requestor){
	if(type=='1'){
		loadDynamicPage('dispatcher/page/delivery_install_management?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
	else if(type=='2'){
		loadDynamicPage('dispatcher/page/service_management?brId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
	else if(type=='3'){
		loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
}
function getMonitorJob(_page){  
	
	var status =$("#status").val();
	var service_type=$("#service_type").val();  
	$("#pageNo").val(_page);
	var status_str="";
	var status_order="";
	if(status.length>0){
		status_str="and sale_order.bso_status='"+status+"'";
	}else{
		status_order=" order by sale_order.bso_status asc "; 
	}
		 
	//return false;
	   var append_admin="";
	   if('admin'=='${username}')
		   append_admin=' or true ';
		var query=" SELECT sale_order.bso_type_no,sale_order.bso_state , "+
		     " to_do_list.BTDL_CREATED_TIME, "+
		     " IFNULL(DATE_FORMAT(to_do_list.BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'') ,"+   
		     " to_do_list.BTDL_OWNER , "+
		     " sale_order.BSO_ID ,"+ // 5
		     " sale_order.bso_status ,  "+
		     " (select td.BTDL_OWNER FROM "+SCHEMA_G+".BPM_TO_DO_LIST td where td.btdl_type='1'  "+
		     "      and td.btdl_ref=to_do_list.btdl_ref and td.ref_no=to_do_list.ref_no order by td.btdl_created_time desc limit 1) "+
		    
			 " FROM " +SCHEMA_G+".BPM_TO_DO_LIST to_do_list left join  "+
			SCHEMA_G+".BPM_SALE_ORDER sale_order  "+
			" on (to_do_list.btdl_type='"+service_type+"' and sale_order.BSO_TYPE_NO=to_do_list.REF_NO "+
			"  ) "+
			"	where ( to_do_list.btdl_owner='"+usernameG+"' "+append_admin+") "+status_str+"  group by sale_order.bso_type_no "+status_order;
	//	alert(query)
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(query)
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	SynDomeBPMAjax.searchObject(queryObject,{
		callback:function(data){
			//alert(data);
			//return false;
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			 
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			        "  		<th width=\"30%\"><div class=\"th_class\">Ref No.</div></th> "+
			        "  		<th width=\"20%\"><div class=\"th_class\">Action by</div></th>"+
			        "  		<th width=\"10%\"><div class=\"th_class\">Action date</div></th> "+ 
			      //  "  		<th width=\"20%\"><div class=\"th_class\">State</div></th> "+  
			        "  		<th width=\"25%\"><div class=\"th_class\">State</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\">Status</div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					  // var dateFormat = $.datepicker.formatDate('dd/mm/yy HH:ss', new Date(data[i][8]));
					 //  var date_created = (data[i][8]!=null && data[i][8].length>0)? $.format.date(data[i][9], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					  // var due_date = (data[i][9]!=null && data[i][9].length>0)? $.format.date(data[i][9], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					  // alert(dateFormat)
					  var status_inner_str="&nbsp;";
					  var status_inner= data[i][6];
					  if(status_inner=='0')
						  status_inner_str="Pending";
					  else  if(status_inner=='1')
						  status_inner_str="Closed";
					  else 
						  status_inner_str="Complete"; 
					   str=str+ "  	<tr>"+ 
					   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
					   "  		<td  onclick=\"showApplicationLog('"+data[i][5]+"','1','"+data[i][0]+"')\"  style=\"text-align: left;text-decoration: underline;cursor: pointer;\"> "+data[i][0]+" </td>"+
					   "    	<td style=\"text-align: left;\">"+data[i][7]+"</td>  "+   
					   "    	<td style=\"text-align: left;\">"+data[i][3]+"</td>  "+  
				      //  "    	<td style=\"text-align: left;\"></td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][1]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+status_inner_str+"</td>  "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"3\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section").html(str);
		}
	}); 
	SynDomeBPMAjax.searchObject(queryCount,{
		callback:function(data){
			//alert(data)
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
} 
function showApplicationLog(BTDL_REF,BTDL_TYPE,REF_NO){
	
	var query=" SELECT "+
		" BTDL_REF ,"+
		" BTDL_TYPE ,"+
		" BTDL_STATE ,"+
		" BTDL_OWNER ,"+
		" BTDL_OWNER_TYPE ,"+
		" BTDL_MESSAGE ,"+
		" BTDL_SLA ,"+
		" BTDL_CREATED_TIME ,"+
		" BTDL_DUE_DATE ,"+
		" BTDL_HIDE ,"+
		" BTDL_REQUESTOR ,"+
		" REF_NO ,"+
		" BTDL_SLA_UNIT ,"+
		" BTDL_SLA_LIMIT_TIME , "+
		" IFNULL(DATE_FORMAT(BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'') , "+ 
		" IFNULL(DATE_FORMAT(BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i'),'') , "+
		" IFNULL(DATE_FORMAT(BTDL_ACTION_TIME,'%d/%m/%Y %H:%i'),'') , "+ 
		 "CASE "+
	     " WHEN (select btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " TIMESTAMPDIFF(MINUTE,now(),btdl_sla_limit_time) "+ 
	     " ELSE "+
	     " TIMESTAMPDIFF(MINUTE,btdl_action_time,btdl_sla_limit_time) "+ 
	     " END as xx " +
		" FROM BPM_TO_DO_LIST   where BTDL_REF="+BTDL_REF+" and BTDL_TYPE='"+BTDL_TYPE+"' and REF_NO='"+REF_NO+"'"+ 
		" order by BTDL_CREATED_TIME ASC  "; 
//	alert(query)
	//return false;
	SynDomeBPMAjax.searchObject(query,{
		callback:function(data){
			 role_ids=[];
			if(data!=null && data.length>0){
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-family: tohoma;font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">State</div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Owner</div></th> "+ 
			   // "  		<th width=\"20%\"><div class=\"th_class\">Date</div></th> "+
			    "  		<th width=\"12%\"><div class=\"th_class\">Start</div></th> "+
			    "  		<th width=\"12%\"><div class=\"th_class\">End</div></th> "+
			    "  		<th width=\"12%\"><div class=\"th_class\">SLA Limit</div></th> "+
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
			   
				   for(var i=0;i<data.length;i++){ 
					   var sla_alert="";
					    if(data[i][17]!=null){
					    	if(data[i][17]<=0)
					    		sla_alert="background-color:red;";
					    /* 	else if(data[i][17]<=(5*60))
					    		sla_alert="background-color:yellow;"; */
					    }
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][2]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][14]!=null)?data[i][14]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+((data[i][16]!=null)?data[i][16]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;"+sla_alert+"\">"+((data[i][15]!=null)?data[i][15]:"")+"</td>  "+
				       
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   //str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doUpdateRoleAction('"+bpmRoleID+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Update Role</span></a></div>";
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
</script>
<div id="dialog-confirmDelete" title="Delete SLA" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete SLA ?
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
	    					 <span>
	    					 <strong>Service Type : </strong>
	    					 <select id="service_type" style="width: 115px">
	    					 	<option value="1">Sale Order</option>
	    					 	<option value="2">แจ้งซ่อม</option>
	    					 	<option value="3">PM/MA</option>
	    					 </select>&nbsp;&nbsp;
	    					  <strong>Status : </strong>
	    					 <select id="status" style="width: 100px">
	    					 	<option value="">All</option>
	    					 	<option value="0">Pending</option>
	    					 	<option value="3">Complete</option> 
	    					 	<option value="1">Closed</option> 
	    					 </select>
	    					 <a class="btn" style="margin-top:-10px" onclick="getMonitorJob('1')"><i class="icon-search"></i>&nbsp;<span style="">Search</span></a>
	    					 </span>
	    					</td><td align="right" width="30%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="employeeWorkMappingPageSelect" id="employeeWorkMappingPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>  
	    					<div  id="search_section"> 
    						</div>
    						<%-- 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            	 	<th width="5%"><div class="th_class">No.</div></th>
            		<th width="15%"><div class="th_class">Name</div></th> 
            		<th width="15%"><div class="th_class">SLA Limit/Day</div></th>  
            		<th width="57%"><div class="th_class">Detail</div></th> 
            		<th width="8%"><div class="th_class"></div></th> 
            		 
          		</tr>
        	</thead>
        	<tbody> 
        	
          	<tr>  
            	<td>1. 	 
            	</td>
            	<td>1 วัน
            	</td> 
            	<td>1
            	</td>
            	<td>
            	 ภายใน กทม.</td>
            	 <td style="text-align: center;">
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=1&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				           	<i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				           	</td>
          	</tr> 
          	<tr>  
            	<td>2.
            	</td>
            	<td>2 วัน
            	</td> 
            	<td>2
            	</td>
            	<td>
            	ต่างจังหวัด</td>
            	<td style="text-align: center;"> 
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=2&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				        <i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				</td>
          	</tr> 
          	 
        	</tbody>
      </table> 
       --%>
      </div>
      </fieldset> 