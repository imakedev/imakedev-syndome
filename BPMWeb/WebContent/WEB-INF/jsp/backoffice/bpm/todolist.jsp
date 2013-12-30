 <%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/>  
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
var usernameG='${username}';
var rolesG='';
$(document).ready(function() { 
	$.get("dispatcher/roles", function(data) {
		   //alert(data.length);
		   //alert('${username}');
		   var sql_inner="("; 
		   for(var i=0;i<data.length;i++){
			   sql_inner=sql_inner+"'"+data[i]+"'";
			   if(i!=(data.length-1)){
				   sql_inner=sql_inner+",";
			   }
		   }
		   sql_inner=sql_inner+")"; 
		   rolesG=sql_inner;
		  // $("#_content").html(data);
		 // alert(sql_inner)
		   getTodolist("1");
		});
	
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		getTodolist(prev)
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		getTodolist(next)
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("employeeWorkMappingPageSelect").value);
//	doAction('search','0');
	getTodolist($("#pageNo").val())
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
				getTodolist("1");
				//loadDynamicPage("setting/page/setting_sla");
			}
		}
	});
} 
function loadFlow(ref,type,state,requestor){
	//alert(state)
	if(type=='1'){
		if(state=='wait_for_stock'){
			loadDynamicPage('dispatcher/page/delivery_install_store?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_create_to_express'){
			loadDynamicPage('dispatcher/page/delivery_install_express?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_assign_to_team'){
			loadDynamicPage('dispatcher/page/delivery_install_supervisor?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		} else if(state=='wait_for_operation_install' || state=='wait_for_operation_delivery'){
			loadDynamicPage('dispatcher/page/delivery_operation?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_supervisor_delivery_close' || state=='wait_for_supervisor_install_close'){ 
			loadDynamicPage('dispatcher/page/delivery_install_wait_for_close?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else  
			loadDynamicPage('dispatcher/page/delivery_install_management?bsoId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
	else if(type=='2'){
		loadDynamicPage('dispatcher/page/service_management?brId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
	else if(type=='3'){
		loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
}
function getTodolist(_page){  
	$("#pageNo").val(_page); 
		var query=" SELECT param.value ,"+ 
		" todo.BTDL_REF,"+
		" todo.BTDL_TYPE,"+
		" todo.BTDL_STATE,"+
		" todo.BTDL_OWNER,"+
		" todo.BTDL_OWNER_TYPE,"+
		" todo.BTDL_MESSAGE,"+
		" todo.BTDL_SLA,"+
		" IFNULL(DATE_FORMAT(todo.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') ,"+
		" IFNULL(DATE_FORMAT(todo.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') ,"+ 
		" todo.BTDL_HIDE,"+
		" todo.BTDL_REQUESTOR,"+
		" todo.REF_NO , "+
		" todo.BTDL_SLA_UNIT , "+  
	//	" IFNULL(DATE_FORMAT( ADDTIME(todo.btdl_created_time,SEC_TO_TIME(todo.btdl_sla*todo.btdl_sla_unit)),'%Y-%m-%d %H:%i:%s'),'') "+
		" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%Y-%m-%d %H:%i:%s'),'') , "+ 
		 "CASE "+
	     " WHEN (select todo.btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " TIMESTAMPDIFF(MINUTE,now(),todo.btdl_sla_limit_time) "+ 
	     " ELSE "+
	     " TIMESTAMPDIFF(MINUTE,todo.btdl_action_time,todo.btdl_sla_limit_time) "+ 
	     " END as xx " +
		" FROM "+SCHEMA_G+".BPM_TO_DO_LIST todo left join "+SCHEMA_G+".BPM_SYSTEM_PARAM param "+
		"on (param.param_name='FLOW_NAME' and param.key=todo.btdl_type)  where "+
		" ( ( todo.BTDL_OWNER in "+rolesG+" and todo.BTDL_OWNER_TYPE='2' )  "+
		" OR ( todo.BTDL_OWNER='"+usernameG+"' and todo.BTDL_OWNER_TYPE='1' ) )  and todo.BTDL_HIDE='1' ";
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(query);
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
			        "  		<th width=\"10%\"><div class=\"th_class\">Ref No.</div></th> "+
			        "  		<th width=\"32%\"><div class=\"th_class\">Task</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Process Name</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">Date Created</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">Due Date</div></th> "+
			        "  		<th width=\"7%\"><div class=\"th_class\">Requestor</div></th> "+ 
			        "  		<th width=\"9%\"><div class=\"th_class\">SLA Standard</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">SLA Limit</div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					  // var dateFormat = $.datepicker.formatDate('dd/mm/yy HH:ss', new Date(data[i][8]));
					   var date_created = (data[i][8]!=null && data[i][8].length>0)? $.format.date(data[i][8], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					   
					   var due_date = (data[i][9]!=null && data[i][9].length>0)? $.format.date(data[i][9], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					   var sla_limit = (data[i][14]!=null && data[i][14].length>0)? $.format.date(data[i][14], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					  // alert(dateFormat)
					  var sla="";
					  if(data[i][13]==60)
						  sla="นาที";
				      else if(data[i][13]==3600)
					     sla="ช.ม.";
					  
					  var sla_alert="";
					    if(data[i][15]!=null){
					    	if(data[i][15]<=0)
					    		sla_alert="background-color:red;";
					    /* 	else if(data[i][17]<=(5*60))
					    		sla_alert="background-color:yellow;"; */
					    }
					    
					   str=str+ "  	<tr>"+
					   "  		<td   onclick=\"loadFlow('"+data[i][1]+"','"+data[i][2]+"','"+data[i][3]+"','"+data[i][11]+"')\"  style=\"text-align: left;text-decoration: underline;cursor: pointer;\"> "+data[i][12]+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][6]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+data[i][0]+"</td>  "+  
				        "    	<td style=\"text-align: center;\">"+date_created+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+due_date+"</td>  "+  
				       // "    	<td style=\"text-align: center;\">22/12/2013 18:02</td>  "+  
				        "    	<td style=\"text-align: center;\">"+data[i][11]+"</td>  "+  
				        "    	<td style=\"text-align: center;\">"+ 
				        "&nbsp;"+data[i][7]+""+" "+(sla)+""+
				        "    	</td> "+
				        "    	<td style=\"text-align: center;"+sla_alert+"\">"+ 
				        ""+sla_limit+""+
				       // "22/12/2013 18:02"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
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
	    					 <span><strong>To-do-list</strong></span>
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