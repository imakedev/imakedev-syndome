 <%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/>  
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
 <sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/> 
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
 .aoe_small{width: 500px !important;margin-left:-250px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
</style>
 
<script>
var usernameG='${username}';
var rolesG='';
$(document).ready(function() {  
	$("#key_job").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     getMonitorJob("1");
		   } 
		});
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
	//$("#pageNo").val(document.getElementById("employeeWorkMappingPageSelect").value);
	checkWithSet("pageNo",$("#employeeWorkMappingPageSelect").val());
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
	checkWithSet("employeeWorkMappingPageSelect",$("#pageNo").val());
	//document.getElementById("employeeWorkMappingPageSelect").value=$("#pageNo").val();
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
function showReassign(btdl_ai,bccNo,BTDL_TYPE){
	bootbox.classes("aoe_small");
	bootbox.dialog("ต้องการ Reassign?",[{
	    "label" : "OK",
	    "class" : "btn-success",
	    "callback": function() {
	    	doReassign(btdl_ai,bccNo,BTDL_TYPE);
	    }
	},{
	    "label" : "Close",
	     "class" : "btn-danger"
	 }]);
}
function doReassign(btdl_ai,bccNo,BTDL_TYPE){
	bootbox.hideAll();
		var querys=[];
		
	//var query="DELETE FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='"+bccNo+"' and BTDL_TYPE='2' and BTDL_STATE='wait_for_operation_services' "+
 <%-- 
	var query="DELETE FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"'"+
	" and BTDL_REQUESTOR='${username}'"; 
	querys.push(query); 
	
	 query="UPDATE   "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='1' where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"' and BTDL_STATE='wait_for_assign_to_team' "+
		" and BTDL_OWNER='${username}'  and BTDL_OWNER_TYPE='1'"; 
		querys.push(query); 

	 query="UPDATE   "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_STATE='wait_for_assign_to_team' where BCC_NO='"+bccNo+"'  ";
		querys.push(query); 
		--%>
		if(BTDL_TYPE=='2'){
		var query="UPDATE   "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0' where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"'"+
		" and BTDL_REQUESTOR='${username}'"; 
		querys.push(query); 
	 query="UPDATE   "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='1' where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"'  "+
			"   and BTLD_AI="+btdl_ai; 
			querys.push(query); 
		 query="UPDATE   "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_STATE='wait_for_assign_to_team' where BCC_NO='"+bccNo+"'  ";
			querys.push(query); 
		}else if(BTDL_TYPE=='1'){
				 
			var query="UPDATE   "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0' where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"'"+
			" and BTDL_REQUESTOR='${username}' and BTLD_AI!="+btdl_ai;
			querys.push(query); 
			
		 query="UPDATE   "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='1' where BTDL_REF='"+bccNo+"' and BTDL_TYPE='"+BTDL_TYPE+"'  "+
				"   and BTLD_AI="+btdl_ai; 
				querys.push(query); 
			 
			 query="UPDATE   "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='wait_for_assign_to_team' where bso_id='"+bccNo+"'  ";
				querys.push(query); 
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
			
			if(data!=0){
				bootbox.dialog("Reassign เรียบร้อยแล้ว.",[{
				    "label" : "Close",
				     "class" : "btn-danger"
			 }]);
			
			}
		}
	});
}
function renderSaleOrderMonitor(service_type,status,_page){
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
	   <c:if test="${isKeyAccount}"> 
		   append_admin=' or true ';
	  </c:if>
	  var key_job=jQuery.trim($("#key_job").val().replace(/'/g,"''"));
		 var key_job_str="";
		 if(key_job.length>0)
			 key_job_str =" and sale_order.bso_type_no like '%"+key_job+"%' ";
		var query=" SELECT sale_order.bso_type_no as c0 ,sale_order.bso_state  as c1 , "+
		     " to_do_list.BTDL_CREATED_TIME  as c2, "+
		     " IFNULL(DATE_FORMAT(to_do_list.BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'')  as c3,"+   
		     " to_do_list.BTDL_OWNER  as c4 , "+
		     " sale_order.BSO_ID  as c5 ,"+ // 5
		     " sale_order.bso_status  as c6 ,  "+
		     " (select td.BTDL_OWNER FROM "+SCHEMA_G+".BPM_TO_DO_LIST td where td.btdl_type='"+service_type+"'  "+
		     "      and td.btdl_ref=to_do_list.btdl_ref and td.ref_no=to_do_list.ref_no order by td.btld_ai desc limit 1)  as c7"+
		    ", ifnull(param.VALUE,'')  as c8 "+
		    ", to_do_list.BTLD_AI AS c9 "+
			 " FROM " +SCHEMA_G+".BPM_TO_DO_LIST to_do_list left join  "+
			SCHEMA_G+".BPM_SALE_ORDER sale_order  "+
			" on (to_do_list.btdl_type='"+service_type+"' and sale_order.BSO_TYPE_NO=to_do_list.REF_NO "+
			"  ) "+
			" left join  "+SCHEMA_G+".BPM_SYSTEM_PARAM param on ( param.PARAM_NAME='STATE' and to_do_list.BTDL_STATE=param.key ) "+
			"	where ( to_do_list.btdl_owner='"+usernameG+"' "+append_admin+") "+status_str+"  and to_do_list.BTDL_TYPE='"+service_type+"' "+key_job_str+" group by sale_order.bso_type_no "+status_order;
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(query)
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
				        "    	<td style=\"text-align: left;\">"+data[i][8]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+status_inner_str+" ";
				        <c:if test="${!isQuotationAccount}">
				        str=str+ "<a class=\"btn btn-primary\" onclick=\"showReassign('"+data[i][9]+"','"+data[i][5]+"','1')\">Reassign</a> ";
				        </c:if>
				        str=str+ "    	</td> "+
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
			$("#search_section_monitor").html(str);
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
function renderServicesMonitor(service_type,status,_page){
	var status_str="";
	var status_order="";
	if(status.length>0){
		status_str="and services.BSJ_STATUS='"+status+"'";
	}else{
		status_order=" order by services.BSJ_STATUS asc "; 
	}
		 

	 var key_job=jQuery.trim($("#key_job").val().replace(/'/g,"''"));
	 var key_job_str="";
	 if(key_job.length>0)
		 key_job_str =" and call_center.BCC_NO like '%"+key_job+"%' ";
	//return false;
	   var append_admin="";
	   if('admin'=='${username}')
		   append_admin=' or true ';
	   <c:if test="${isKeyAccount}"> 
	   		append_admin=' or true ';
  		</c:if>
  		<c:if test="${isQuotationAccount}"> 
   		append_admin=' or true ';
		</c:if>
	   var query=" SELECT "+
	   " call_center.BCC_NO as c0,"+
		  " IFNULL(call_center.BCC_SERIAL,'') as c1,"+
		    " IFNULL(call_center.BCC_MODEL,'') as c2,"+
		    " IFNULL(call_center.BCC_CAUSE,'') as c3,"+
		    "  call_center.BCC_CREATED_TIME  as c4,"+ 
		    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c5,"+
		    " IFNULL(call_center.BCC_SLA,'') as c6,"+
		    " IFNULL(call_center.BCC_IS_MA ,'') as c7,"+
		    " IFNULL(call_center.BCC_MA_NO ,'') as c8,"+
		    " IFNULL(call_center.BCC_MA_START ,'') as c9,"+
		    " IFNULL(call_center.BCC_MA_END ,'') as c10,"+
		    " IFNULL(call_center.BCC_STATUS ,'') as c11,"+
		    " IFNULL(call_center.BCC_REMARK ,'') as c12,"+
		    " IFNULL(call_center.BCC_USER_CREATED ,'') as c13,"+
		    " IFNULL(call_center.BCC_DUE_DATE ,'') as c14,"+
		    " IFNULL(call_center.BCC_CONTACT ,'') as c15,"+
		    " IFNULL(call_center.BCC_TEL ,'') as c16,"+
		    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') as c17,"+ //17
		    " IFNULL(call_center.BCC_ADDR1 ,'') as c18,"+
		    " IFNULL(call_center.BCC_ADDR2 ,'') as c19,"+
		    " IFNULL(call_center.BCC_ADDR3 ,'') as c20,"+
		    " IFNULL(call_center.BCC_LOCATION ,'') as c21,"+
		    " IFNULL(call_center.BCC_PROVINCE ,'') as c22,"+
		    " IFNULL(call_center.BCC_ZIPCODE ,'') as c23,"+
		    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c24, "+ // 24
		    " IFNULL((select BTDL_STATE  FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+
		  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by btld_ai desc limit 1 ) ,'') as c25, "+
		  	 " IFNULL((select BTDL_OWNER  FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+
			  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by btld_ai desc limit 1 ) ,'') as c26, "+
			 " IFNULL(call_center.BCC_STATE ,'') as c27,  "+	
		 	 " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') as c28, "+
		 	 " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') as c29, " +
		" to_do_list.BTDL_REF as c30,"+ // 30
		" to_do_list.BTDL_TYPE as c31,"+
		" to_do_list.BTDL_STATE as c32,"+
		" to_do_list.BTDL_OWNER as c33,"+
		" to_do_list.BTDL_OWNER_TYPE as c34,"+
		" to_do_list.BTDL_MESSAGE as c35,"+
		" to_do_list.BTDL_SLA as c36,"+
		" IFNULL(DATE_FORMAT(to_do_list.BTDL_CREATED_TIME,'%Y-%m-%d %H:%i:%s'),'') as c37,"+
		" IFNULL(DATE_FORMAT(to_do_list.BTDL_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') as c38,"+ 
		" to_do_list.BTDL_HIDE as c39,"+
		" to_do_list.BTDL_REQUESTOR as c40,"+
		" to_do_list.REF_NO as c41, "+
		" to_do_list.BTDL_SLA_UNIT as c42 , "+   
		" IFNULL(DATE_FORMAT( BTDL_SLA_LIMIT_TIME,'%Y-%m-%d %H:%i:%s'),'') as c43, "+ 
		 "CASE "+
	     " WHEN (select to_do_list.btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " TIMESTAMPDIFF(MINUTE,now(),to_do_list.btdl_sla_limit_time) "+ 
	     " ELSE "+
	     " TIMESTAMPDIFF(MINUTE,to_do_list.btdl_action_time,to_do_list.btdl_sla_limit_time) "+ 
	     " END as c44 ," +
	     " services.BSJ_STATUS as c45, "+
	     " services.BSJ_STATE as c46, "+ // 46
	     " (select td.BTDL_OWNER FROM "+SCHEMA_G+".BPM_TO_DO_LIST td where td.btdl_type='"+service_type+"'  "+
	     "      and td.btdl_ref=to_do_list.btdl_ref and td.ref_no=to_do_list.ref_no order by td.btld_ai desc limit 1) as c47 ,"+
	     " (select  IFNULL(DATE_FORMAT(td.BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'') FROM "+SCHEMA_G+".BPM_TO_DO_LIST td where td.btdl_type='"+service_type+"'  "+
	     "      and td.btdl_ref=to_do_list.btdl_ref and td.ref_no=to_do_list.ref_no order by td.btld_ai desc limit 1) as c48,"+
	     " param.VALUE as c49, "+
	     " to_do_list.BTLD_AI as c50 "+ 
	     " FROM " +SCHEMA_G+".BPM_TO_DO_LIST to_do_list left join  "+
			SCHEMA_G+".BPM_CALL_CENTER call_center "+
			 " on (to_do_list.BTDL_REF=call_center.BCC_NO and to_do_list.btdl_type='"+service_type+"' )   "+    
			 "left join " +SCHEMA_G+".BPM_SERVICE_JOB services on (call_center.BCC_NO=services.BCC_NO) "+ 
				" left join  "+SCHEMA_G+".BPM_SYSTEM_PARAM param on ( param.PARAM_NAME='STATE' and to_do_list.BTDL_STATE=param.key ) "+
			"	where ( (to_do_list.btdl_owner='"+usernameG+"' and to_do_list.btdl_owner_type='1' ) "+append_admin+" or (to_do_list.btdl_owner in "+rolesG+" and to_do_list.btdl_owner_type='2'  ) ) "+status_str+" and to_do_list.BTDL_TYPE='"+service_type+"' "+key_job_str+" group by to_do_list.BTDL_REF "+status_order;
	   /*
		var query=" SELECT call_center.BCC_NO,call_center.BCC_STATE , "+
		     " to_do_list.BTDL_CREATED_TIME, "+
		     " IFNULL(DATE_FORMAT(to_do_list.BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'') ,"+   
		     " to_do_list.BTDL_OWNER , "+
		     " call_center.BCC_NO as bccNo,"+ // 5
		     " services.BSJ_STATUS ,  "+
		     " (select td.BTDL_OWNER FROM "+SCHEMA_G+".BPM_TO_DO_LIST td where td.btdl_type='"+service_type+"'  "+
		     "      and td.btdl_ref=to_do_list.btdl_ref and td.ref_no=to_do_list.ref_no order by td.btdl_created_time desc limit 1) "+
		    
			 " FROM " +SCHEMA_G+".BPM_TO_DO_LIST to_do_list left join  "+
			SCHEMA_G+".BPM_CALL_CENTER call_center "+
			 " on (to_do_list.BTDL_REF=call_center.BCC_NO and to_do_list.btdl_type='"+service_type+"' )   "+    
			 "left join " +SCHEMA_G+".BPM_SERVICE_JOB services on (call_center.BCC_NO=services.BCC_NO) "+
			"	where ( to_do_list.btdl_owner='"+usernameG+"' "+append_admin+") "+status_str+" and to_do_list.BTDL_TYPE='"+service_type+"'  group by to_do_list.BTDL_REF "+status_order;
		*/
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(rolesG)
	//alert(query)
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
			//alert(data);
			//return false;
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			 
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
        "	<thead> 	"+
        "  		<tr> "+
        "  		<th width=\"7%\"><div class=\"th_class\">เลขที่แจ้งซ่อม</div></th> "+
        "  		<th width=\"15%\"><div class=\"th_class\">หมายเลขเคร่ือง/Model</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">อาการเสีย</div></th> "+  
        "  		<th width=\"23%\"><div class=\"th_class\">สถานที่ซ่อม</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">ผู้ติดต่อ</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">วันที่เปิดเอกสาร</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">Action by</div></th> "+  
        "  		<th width=\"5%\"><div class=\"th_class\">Action date</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">State</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">Status</div></th> "+
        " 		</tr>"+
        "	</thead>"+
        "	<tbody>   ";
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   var status_inner_str="&nbsp;";
						  var status_inner= data[i][45];
						  if(status_inner=='0')
							  status_inner_str="Pending";
						  else  if(status_inner=='1')
							  status_inner_str="Closed";
						  else 
							  status_inner_str="Complete"; 
						
					    var BCC_STATE=data[i][27];
				        if(BCC_STATE!='cancel')
				        	BCC_STATE=data[i][25]; 
				       str=str+ "  	<tr style=\"cursor: pointer;\">"+  
						   "  		<td onclick=\"showApplicationLog('"+data[i][0]+"','2','"+data[i][0]+"')\" style=\"text-align: left;text-decoration: underline;cursor: pointer;\">"+data[i][0]+"</td>"+     
						   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
						   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+     
					        "    	<td style=\"text-align: left;\">"+data[i][21]+" "+data[i][18]+" "+data[i][19]+" "+data[i][20]+" "+data[i][22]+" "+data[i][23]+" "+data[i][15]+" "+data[i][16]+"</td>  "+  
					        "    	<td style=\"text-align: left;\">"+data[i][15]+" "+data[i][16]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][24]+" "+data[i][28]+"-"+data[i][29]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+ 
					        "    	<td style=\"text-align: left;\">"+data[i][47]+"</td>  "+ 
					        "    	<td style=\"text-align: left;\">"+data[i][48]+"</td>  "+ 
					        "    	<td style=\"text-align: left;\">"+data[i][49]+"</td>  "+ 
					        "    	<td style=\"text-align: center;\">"+ 
					        status_inner_str;
					        <c:if test="${!isQuotationAccount}">
					        str=str+ "<a class=\"btn btn-primary\" onclick=\"showReassign('"+data[i][50]+"','"+data[i][0]+"','2')\">Reassign</a> ";
					        </c:if>
					        str=str+ "    	</td> "+
					        "  	</tr>  ";
				   }
			   }else{
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"9\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section_monitor").html(str);
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
function getMonitorJob(_page){  
	
	var status =$("#status").val();
	var service_type=$("#service_type").val();  
	$("#pageNo").val(_page);
	if(service_type=='1'){
		renderSaleOrderMonitor(service_type,status,_page);
	}else if(service_type=='2'){
		renderServicesMonitor(service_type,status,_page);
	}
	
} 
function showApplicationLog(BTDL_REF,BTDL_TYPE,REF_NO){
	
	var query=" SELECT "+
		" BTDL_REF as c0 ,"+
		" BTDL_TYPE as c1 ,"+
		" BTDL_STATE as c2,"+
		" BTDL_OWNER as c3,"+
		" BTDL_OWNER_TYPE as c4,"+
		" BTDL_MESSAGE as c5,"+
		" BTDL_SLA as c6,"+
		" BTDL_CREATED_TIME as c7 ,"+
		" BTDL_DUE_DATE as c8,"+
		" BTDL_HIDE as c9,"+
		" BTDL_REQUESTOR as c10,"+
		" REF_NO as c11,"+
		" BTDL_SLA_UNIT as c12 ,"+
		" BTDL_SLA_LIMIT_TIME as c13, "+
		" IFNULL(DATE_FORMAT(BTDL_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c14, "+ 
		" IFNULL(DATE_FORMAT(BTDL_SLA_LIMIT_TIME,'%d/%m/%Y %H:%i'),'') as c15, "+
		" IFNULL(DATE_FORMAT(BTDL_ACTION_TIME,'%d/%m/%Y %H:%i'),'') as c16, "+ 
		 "CASE "+
	     " WHEN (select btdl_action_time IS NULL) "+ 
	     " THEN  "+
	     " TIMESTAMPDIFF(MINUTE,now(),btdl_sla_limit_time) "+ 
	     " ELSE "+
	     " TIMESTAMPDIFF(MINUTE,btdl_action_time,btdl_sla_limit_time) "+ 
	     " END  as c17 ," +
	     " ifnull(param.VALUE,'') as c18"+
		" FROM BPM_TO_DO_LIST  "+
		" left join  "+SCHEMA_G+".BPM_SYSTEM_PARAM param on ( param.PARAM_NAME='STATE' and BTDL_STATE=param.key ) "+
		" where BTDL_REF="+BTDL_REF+" and BTDL_TYPE='"+BTDL_TYPE+"' and REF_NO='"+REF_NO+"'"+ 
		//" order by BTDL_CREATED_TIME , btdl_hide ASC   ";
		" order by btld_ai   ASC   "; 
	 //alert(query)
	//return false;
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
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-family: tohoma;font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">State</div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Owner</div></th> "+ 
			   // "  		<th width=\"20%\"><div class=\"th_class\">Date</div></th> "+
			    "  		<th width=\"12%\"><div class=\"th_class\">Action Time</div></th> "+
			    //"  		<th width=\"12%\"><div class=\"th_class\">End</div></th> "+
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
					   "  		<td style=\"text-align: left;\"> "+data[i][18]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][14]!=null)?data[i][14]:"")+"</td>  "+
				     //   "    	<td style=\"text-align: left;\">"+((data[i][16]!=null)?data[i][16]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;"+sla_alert+"\">"+((data[i][15]!=null)?data[i][15]:"")+"</td>  "+
				       
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";
				  // " <a class=\"btn btn-primary\" onclick=\"\">View Detail</a>  ";
				   bootbox.classes("aoe_width");
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
	    					 <select id="service_type" style="width: 115px" onchange="getMonitorJob('1')">
	    					 	<option value="1">Sale Order</option>
	    					 	<option value="2">แจ้งซ่อม</option>
	    					 	<option value="3">PM/MA</option>
	    					 </select>&nbsp;&nbsp;
	    					  <strong>Status : </strong>
	    					 <select id="status" style="width: 100px" onchange="getMonitorJob('1')">
	    					 	<option value="">All</option>
	    					 	<option value="0">Pending</option>
	    					 	<option value="3">Complete</option> 
	    					 	<option value="1">Closed</option> 
	    					 </select>
	    					<%-- <a class="btn" style="margin-top:-10px" onclick="getMonitorJob('1')"><i class="icon-search"></i>&nbsp;<span style="">Search</span></a>  --%>
	    					 </span>
	    					  <span style="padding-left:20px"><strong>Job No.</strong></span>
	    					  <span style="padding-left:5px" id="job_no_elment"> 
	    					    <input type="text" id="key_job" style="height: 30px;">
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
	    					<div  id="search_section_monitor"> 
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