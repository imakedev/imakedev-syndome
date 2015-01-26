 <%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/>  
 <sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
 <sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isInvoiceAccount"/>
 <sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
  <sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrderAccount"/>
<jsp:useBean id="date" class="java.util.Date"/>
<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/> 
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
var service_statusG=[];
$(document).ready(function() { 
	$("#key_job").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     getTodolist('1');
		   } 
		});
	 <c:if test="${isSupervisorAccount}">
	
	$("#BTDL_CREATED_TIME_START").datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	$("#BTDL_CREATED_TIME_END").datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	
	 </c:if>
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
		   // alert(rolesG)
		  // $("#_content").html(data);
		 // alert(sql_inner)
		   //getTodolist("1");
		   initTodoListStatus();
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
	//$("#pageNo").val(document.getElementById("employeeWorkMappingPageSelect").value);
	//$("#pageNo").val($("#employeeWorkMappingPageSelect").val());
	checkWithSet("pageNo",$("#employeeWorkMappingPageSelect").val());
//	doAction('search','0');
	getTodolist($("#pageNo").val())
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"employeeWorkMappingPageSelect\" id=\"employeeWorkMappingPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val(); 
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
		if(i==30)
			break;
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
				getTodolist("1");
				//loadDynamicPage("setting/page/setting_sla");
			}
		}
	});
} 
function openInnerServiceJob(){
	loadDynamicPage('dispatcher/page/service_inner_management?requestor='+usernameG);
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
		//wait_for_assign_to_team
		//wait_for_quotation
		//wait_for_send_to_supervisor  --> key account
		//wait_for_supervisor_services_close
		//wait_for_operation_services
		//alert(state)
		loadDynamicPage('dispatcher/page/service_supervisor?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		/*
		if(state=='wait_for_assign_to_team'){
			loadDynamicPage('dispatcher/page/service_supervisor?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_quotation'){
			loadDynamicPage('dispatcher/page/service_quotation?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_supervisor_services_close'){
			loadDynamicPage('dispatcher/page/service_wait_for_close?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else if(state=='wait_for_operation_services'){
			loadDynamicPage('dispatcher/page/service_operation?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		}else 
			loadDynamicPage('dispatcher/page/service_management?bccNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
		*/
	}
	else if(type=='3'){
		loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}else if(type=='4'){ 
		loadDynamicPage('dispatcher/page/service_inner_management?bisjNo='+ref+'&mode=edit&state='+state+'&requestor='+requestor);
	}
}
function renderAllServices(service_type,service_status,_page){
 
var isStore="0";
<c:if test="${isStoreAccount}"> 
		isStore="1";
</c:if>
// var queryCount=" select count(*) from (  "+queryall+" ) as x"; 
//var key_job=jQuery.trim($("#key_job").val().replace(/'/g,"\\'"));
var key_job=jQuery.trim($("#key_job").val().replace(/'/g,"''"));
//alert(key_job)

var BTDL_CREATED_TIME="";
<c:if test="${isSupervisorAccount}">
var BTDL_CREATED_TIME_START_array=$("#BTDL_CREATED_TIME_START").val().split("/");
var BTDL_CREATED_TIME_END_array=$("#BTDL_CREATED_TIME_END").val().split("/");
 BTDL_CREATED_TIME=BTDL_CREATED_TIME_START_array[0]+"_"+BTDL_CREATED_TIME_START_array[1]+"_"+BTDL_CREATED_TIME_START_array[2]+"-"+BTDL_CREATED_TIME_END_array[0]+"_"+BTDL_CREATED_TIME_END_array[1]+"_"+BTDL_CREATED_TIME_END_array[2];
</c:if>
//alert(BTDL_CREATED_TIME);
SynDomeBPMAjax.searchTodoList(service_type,service_status,usernameG,rolesG,_page+"",_perpageG+"",isStore,"1",key_job,BTDL_CREATED_TIME,{ 
//SynDomeBPMAjax.searchObject(queryObject,{
	callback:function(data){
		if(data.resultMessage.msgCode=='ok'){
			data=data.resultListObj;
		}else{// Error Code
			//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
			  bootbox.dialog(data.resultMessage.msgDesc,[{
				    "label" : "Close",
				     "class" : "btn-danger"
				    //	"class" : "class-with-width"
			 }]);
			 return false;
		}
		
		var sla_column="SLA Limit";
		var is_supervisor=false;
		var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
        "	<thead> 	"+
        "  		<tr> "+
        "  		<th width=\"7%\"><div class=\"th_class\">เลขที่เอกสาร</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">สถานะงาน</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">Service Type</div></th> "+   
        "  		<th width=\"5%\"><div class=\"th_class\">State</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">Status MA</div></th> "+ 
        "  		<th width=\"12%\"><div class=\"th_class\">หมายเลขเครื่อง/Model</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">อาการเสีย</div></th> "+  
        "  		<th width=\"16%\"><div class=\"th_class\">สถานที่</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">ผู้ติดต่อ</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">วันที่เปิดเอกสาร</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">Requestor</div></th> "+  
        "  		<th width=\"5%\"><div class=\"th_class\">SLA Standard</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">SLA Limit</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
        " 		</tr>"+
        "	</thead>"+
        "	<tbody>   ";  
		  
		   if(data!=null && data.length>0){
			   for(var i=0;i<data.length;i++){ 
				   // var date_created = (data[i][8]!=null && data[i][8].length>0)? $.format.date(data[i][8], "dd/MM/yyyy  HH:mm"):"&nbsp;"; 
				    // var due_date = (data[i][9]!=null && data[i][9].length>0)? $.format.date(data[i][9], "dd/MM/yyyy  HH:mm"):"&nbsp;";
				   var sla_limit = (data[i][14]!=null && data[i][14].length>0 && data[i][14]!='-')? $.format.date(data[i][14], "dd/MM/yyyy  HH:mm"):"&nbsp;"; 
				 
				  var sla="";
				  if(data[i][13]==60)
					  sla="นาที";
			      else if(data[i][13]==3600)
				     sla="ช.ม.";
				  
				  var sla_alert="";
				    if(data[i][15]!=null){
				    	if(data[i][15]<=0)
				    		sla_alert="background-color:red;"; 
				    } 
				    
				    if(service_type=='2' && is_supervisor){
				    	sla_alert="";
				    	sla_limit="<a class=\"btn btn-primary\" onclick=\"showTeam('"+data[i][1]+"')\">Assign to Team</a>";
				    	sla_limit=sla_limit+"<br/>";
				    	sla_limit=sla_limit+"<a class=\"btn\" onclick=\"\">เบิกอะไหล่</a>";
				    	sla_limit=sla_limit+"<a class=\"btn\" onclick=\"\">บันทึกหมายเหตุ</a>";
				    	sla_limit=sla_limit+"<a class=\"btn\" onclick=\"\">บันทึกความพึงใจของลูกค้า</a>";
				    }
						   
				    var store_update="";
				    var BCC_STATE=data[i][27];
			        if(BCC_STATE!='cancel')
			        	BCC_STATE=data[i][25]; 
 					var bccNo=data[i][0];
 					
			       str=str+ "  	<tr style=\"cursor: pointer;\">"+
			       "  <td> <span onclick=\"loadFlow('"+data[i][31]+"','"+data[i][32]+"','"+data[i][33]+"','"+data[i][41]+"')\"  style=\"text-align: left;text-decoration: underline;cursor: pointer;\">"+data[i][0]+"</span>";
			        	   if(isStore=='1' && data[i][52]>0){
			        		   str=str+"<span style=\"padding-left:5px;color:red\">(จัดของครั้งที่ "+(data[i][52]+1)+")</span>";
			        	   }
			        	 //  alert(data[i][48]);
			           str=str+ " </td>"+
					   "  		<td style=\"text-align: left;\">"+data[i][46]+"</td>"+   
					   "  		<td style=\"text-align: center;\">"+data[i][30]+"</td>"+    
					   "  		<td style=\"text-align: center;\">"+data[i][48]+"</td>"+   
					   "  		<td style=\"text-align: center;\">ในประกัน</td>"+   
					   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
					   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+     
				       // "    	<td style=\"text-align: left;\">"+data[i][21]+" "+data[i][18]+" "+data[i][19]+" "+data[i][20]+" "+data[i][22]+" "+data[i][23]+" "+data[i][15]+" "+data[i][16]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][21]+"</td>  "+
				       // "    	<td style=\"text-align: left;\">"+data[i][15]+" "+data[i][16]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][15]+"</td>  "+
				       // "    	<td style=\"text-align: left;\">"+data[i][24]+" "+data[i][28]+"-"+data[i][29]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][24]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+ 
				        "    	<td style=\"text-align: left;\">"+data[i][41]+"</td>  "+ 
				        "    	<td style=\"text-align: left;\">"+data[i][43]+" </td>  "+ 
				        "    	<td style=\"text-align: left;\">"+data[i][44]+" </td>  "+  
				        "    	<td style=\"text-align: center;\">"; 
				        <c:if test="${isSupervisorAccount && !isQuotationAccount}">
				        if( data[i][32]=='2' || data[i][32]=='3'
				        		|| ( data[i][32]=='1' && data[i][33]!='wait_for_supervisor_install_close' 
				        				&& data[i][33]!='wait_for_supervisor_delivery_close') ){ 
				        	 str=str+ " <ul class=\"nav nav-pills\"> "+
				       "  <li class=\"dropdown\">"+
				       "   <a class=\"dropdown-toggle\" "+
				       "      data-toggle=\"dropdown\""+
				       "  href=\"#\">Action"+ 
				        "<b class=\"caret\"></b>"+
				        "</a>"+
				         "  <ul class=\"dropdown-menu pull-right\">"; 
				          if(data[i][32]=='2' && data[i][47]=='1'){ 
					        	 str=str+ "<li><a onclick=\"addItemAndRemark('"+bccNo+"')\">เบิกอะไหล่/บันทึกหมายเหตุ</a></li> ";
				          }
				         if(data[i][32]=='2'  ){ 
				        	 str=str+ " <li><a onclick=\"showTeam('"+bccNo+"')\">Assign to Team</a></li> ";
				         } 
				         if( data[i][32]=='3'){ 
				        	 str=str+ " <li><a onclick=\"showTeamPM('"+data[i][49]+"')\">Assign to Team</a></li> ";
				         }
				         if(data[i][32]=='1' &&  data[i][33]!='wait_for_supervisor_install_close'){ 
				        	 str=str+ " <li><a onclick=\"showTeamIT('"+data[i][31]+"','"+data[i][33]+"','"+data[i][0]+"')\">Assign to Team</a></li> ";
				         }
				         if(data[i][32]=='2' && data[i][47]=='1'){ 
				        	 str=str+ " <li><a onclick=\"showFeedBack('"+bccNo+"')\">บันทึกความพึงใจของลูกค้า</a></li> ";
				         }
				         str=str+ "   </ul>"+
				        " </li>"+
				         "  </ul>";
				        }else if(data[i][32]=='2'){ 
				        
				        
				        }
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
		$("#search_section_todolist").html(str);
	}
});

//alert(service_type+","+usernameG+","+rolesG+","+_page+","+_perpageG+","+isStore)
/*
SynDomeBPMAjax.searchTodoList(service_type,service_status,usernameG,rolesG,_page+"",_perpageG+"",isStore,"2",key_job,BTDL_CREATED_TIME,{
//SynDomeBPMAjax.searchObject(queryCount,{
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
		//alert(calculatePage(_perpageG,data))
		var pageCount=calculatePage(_perpageG,data);
		checkWithSet("pageCount",pageCount);
		//$("#pageCount").val(pageCount);
		renderPageSelect();
	}
});
*/
} 
  
function renderServiceType(type){
	var service_status_str="<select name=\"service_status\" id=\"service_status\" style=\"width:200px\" onchange=\"getTodolist('1')\" class=\"span2\">";
	service_status_str=service_status_str+"<option value=\"-1,"+type+"\">All</option>";
	//alert("xxtype="+type)
	//alert(service_statusG.length)
	if(service_statusG.length>0){
		
		for(var i=0;i<service_statusG.length;i++){ 
			var service_status_obj=service_statusG[i]; 
			if(service_status_obj.bjsType==type || type=='-1' )
				service_status_str=service_status_str+"<option value=\""+service_status_obj.bjsId+","+service_status_obj.bjsType+"\">"+service_status_obj.bjsStatus+"</option>"; 
		}
	}
	service_status_str=service_status_str+"</select>";
	$("#service_status_element").html(service_status_str);
}
function initTodoListStatus(){
	
	var query=" SELECT param.KEY,param.VALUE FROM "+SCHEMA_G+".BPM_SYSTEM_PARAM param "+
	" where param.PARAM_NAME='FLOW_NAME' order by param.KEY  "; 

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
		var service_type_str="<select name=\"service_type\" style=\"width:101px\" id=\"service_type\" onchange=\"changeType('1')\" class=\"span2\">";
		service_type_str=service_type_str+"<option value=\"-1\">All</option>";
		if(data!=null && data.length>0){
			for(var i=0;i<data.length;i++){
				service_type_str=service_type_str+"<option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
			}
		}
		service_type_str=service_type_str+"</select>";
		$("#service_type_element").html(service_type_str);
		var query=" SELECT BJS_ID,BJS_STATUS ,BJS_TYPE FROM "+SCHEMA_G+".BPM_JOB_STATUS order by bjs_type,BJS_ORDER "; 
	//alert(query)
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
			var service_status_str="<select name=\"service_status\" id=\"service_status\" style=\"width:200px\" onchange=\"getTodolist('1')\" class=\"span2\">";
			service_status_str=service_status_str+"<option value=\"-1,-1\">All</option>";
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					var service_status_obj={
								bjsId:data[i][0],
								bjsStatus:data[i][1],
								bjsType:data[i][2]
								};
					service_statusG.push(service_status_obj);
					service_status_str=service_status_str+"<option value=\""+data[i][0]+","+data[i][2]+"\">"+data[i][1]+"</option>";
				}
			}
			service_status_str=service_status_str+"</select>";
			$("#service_status_element").html(service_status_str);
			getTodolist('1');
		}}); 
	}}); 
 
}
function changeType(_page){ 
	var service_type=$("#service_type").val();
	renderServiceType(service_type);
	getTodolist(_page);
}
function getTodolist(_page){  
	
	//var service_type=$("#service_type").val();
	var service_status_array=$("#service_status").val();
	service_status_array=service_status_array.split(",");
	var service_status=service_status_array[0];
	var service_type=service_status_array[1];
 	$("#service_type").val(service_type);
	// alert(service_type);
	checkWithSet("pageNo",_page);
	 
	//$("#pageNo").val(_page);  
	 //alert(service_type+","+service_status)
	 renderAllServices(service_type,service_status,_page);
	 /*
	if(service_type=='1'){
		renderSaleOrder(service_type,_page);
	}else if(service_type=='2'){
		renderServices(service_type,_page);
	} 
	 */
} 
function saveFeedBackAction(bccNo){
	var querys=[]; 
	var BSJ_RECOMMEND=jQuery.trim($("#BSJ_RECOMMEND").val());
	var query="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_RECOMMEND='"+BSJ_RECOMMEND+"' where BCC_NO='"+bccNo+"'";  
	querys.push(query); 
	 query="DELETE FROM "+SCHEMA_G+".BPM_SERVICE_FEEDBACK_MAP WHERE BCC_NO='"+bccNo+"'"; 
	 querys.push(query);  
	 $('input[name^="feedBackCheckbox_radio_"]' ).each( function( index, el ) { 
	     
	     if($( el).prop("checked")){
	    	 
	    	 var names=$( el).prop("name").split("_");
	    	   query="INSERT INTO "+SCHEMA_G+".BPM_SERVICE_FEEDBACK_MAP "+
	    		   " (BCC_NO,BF_ID, BF_SCORE) VALUES ('"+bccNo+"','"+names[2]+"','"+$( el).val()+"'); ";
	    	   querys.push(query);     
	     }
	 });
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
			hideAllDialog(); 
		}
	});
}
function showFeedBack(bccNo){
	bootbox.hideAll();
	var query=" SELECT feedback.BF_ID,feedback.BF_NAME , "+
		"  IFNULL((SELECT BF_SCORE FROM "+SCHEMA_G+".BPM_SERVICE_FEEDBACK_MAP map "+
		"		 where map.BCC_NO='"+bccNo+"' and map.BF_ID=feedback.BF_ID),'') ,  "+
		" IFNULL((SELECT  BSJ_RECOMMEND FROM "+SCHEMA_G+".BPM_SERVICE_JOB job where job.BCC_NO='"+bccNo+"'),'')"+
		"		FROM "+SCHEMA_G+".BPM_FEEDBACK feedback  ";
	//alert(query)
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
			if(data!=null && data.length>0){
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"75%\"><div class=\"th_class\">รายละเอียด</div></th> "+
			    "  		<th width=\"20%\"><div class=\"th_class\">  </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";  
			    var BSJ_RECOMMEND="";
				   for(var i=0;i<data.length;i++){  
					   var value1=""
					   var value0="";
					   if(data[i][2]=='0')
						   value0="checked";
					   if(data[i][2]=='1')
						   value1="checked";
					   BSJ_RECOMMEND=data[i][3]
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\">"+(i+1)+"</td>"+     
					   "  		<td style=\"text-align: left;\">"+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+
				        " <input type=\"radio\" value=\"1\" "+value1+"  name=\"feedBackCheckbox_radio_"+data[i][0]+"\">มี&nbsp;&nbsp;"+
				        " <input type=\"radio\" value=\"0\" "+value0+"   name=\"feedBackCheckbox_radio_"+data[i][0]+"\">ไม่มี"+
				        "</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				    
				  str=str+"<div align=\"left\">ความคิดเห็นเพิ่มเติม:</div><textarea  id=\"BSJ_RECOMMEND\" cols=\"100\" rows=\"3\" class=\"span7\">"+BSJ_RECOMMEND+"</textarea>";
				 
				   str=str+"<div style=\"align: right;margin-left:370px\"> <a class=\"btn btn-primary\"  style=\"margin-top: 10px;\" onclick=\"saveFeedBackAction('"+bccNo+"')\"><span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
	                  "<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\"><span style=\"color: white;font-weight: bold;\">Cancel</span></a>"+
				//   "&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\"  onclick=\"doSendTo('"+bdept_id+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+send_to_str+"</span></a>"+
				   "</div>";
				// alert(str)
				   bootbox.dialog(str);
			   }
		}
	});
}
function saveRemarkAction(bccNo){
	var querys=[]; 
	var BSJ_REMARK=jQuery.trim($("#BSJ_REMARK").val());
	var query="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_REMARK='"+BSJ_REMARK+"' where BCC_NO='"+bccNo+"'"; 
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
			hideAllDialog(); 
		}
	});
}
function addItemToList(bccNo){
    //alert(bccNo)
	//alert( $("#bdeptUserId").val());
	/*
	var input_str= "<span>รหัส&nbsp;&nbsp;&nbsp;<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+ 
						            "<input type=\"hidden\" id=\"BSIM_PRICE\" name=\"BSIM_PRICE\" style=\"height: 30;\" /></span>"+  
					 				"<span style=\"padding-left:10px\">คลัง&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_STORE\" name=\"BSIM_STORE\" style=\"height: 30;width:50px\" /></span>"+
					 				"<span style=\"padding-left:10px\">จำนวน&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_AMOUNT\" name=\"BSIM_AMOUNT\" style=\"height: 30;width:50px\" /></span>";
					 var  item_section_str="<div  id=\"item_section\"></div>";
				
					 */
	  var IMA_ItemID=jQuery.trim($("#IMA_ItemID").val()); 
					// alert(IMA_ItemID)
	  // var IMA_ItemID=jQuery.trim($("#ima_item_id").val()); 				 
	var BSIM_PRICE=jQuery.trim($("#BSIM_PRICE").val());
	var BSIM_AMOUNT=jQuery.trim($("#BSIM_AMOUNT").val());
	var BSIM_STORE=jQuery.trim($("#BSIM_STORE").val()); 
	if(!IMA_ItemID.length>0){
		 alert('กรุณากรอก รหัสให้ถูกต้อง.');  
		 $("#ima_item_id").focus(); 
		 $("#ima_item_id").val(""); 
		 $("#IMA_ItemID").val(""); 
		 $("#IMA_ItemID").focus(); 
		 return false;	
	}
	if(!BSIM_STORE.length>0){
		 alert('กรุณากรอก ข้อมูล.');  
		 $("#BSIM_STORE").focus(); 
		 return false;	
	}
	 var  isNumber=checkNumber(jQuery.trim($("#BSIM_AMOUNT").val())); 
	 if(isNumber){  
		 alert('กรุณากรอก  จำนวน เป็นตัวเลข.');  
		 $("#BSIM_AMOUNT").val(""); 
		 $("#BSIM_AMOUNT").focus(); 
		 return false;	  
	 } 
	  
	var getAutoK="SELECT count(*) FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING where "+
		" BCC_NO='"+bccNo+"'  and IMA_ITEMID='"+IMA_ItemID+"'";
	 SynDomeBPMAjax.searchObject(getAutoK,{
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
			    var max_auto=1;
				if(data>0){ 
					bootbox.dialog("ข้อมูลถูกเพิ่มไปก่อนหน้านี้แล้ว",[{
					    "label" : "Close",
					     "class" : "btn-danger"
				   }]);
				 return false;
				}else{
					
				}
				var querys=[]; 
				var query="INSERT INTO "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING (BCC_NO,IMA_ItemID,BSIM_STORE,BSIM_AMOUNT,BSIM_TYPE,BSIM_PRICE) "+
				          " VALUES('"+bccNo+"','"+IMA_ItemID+"','"+BSIM_STORE+"','"+BSIM_AMOUNT+"','1','"+BSIM_PRICE+"'); ";
				 
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
							 renderItemList(bccNo);
							//bootbox.hideAll();
						}
					},errorHandler:function(errorString, exception) { 
						alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
					}
				});
		 }
	 });
	
}
function addItemAndRemark(bccNo){
	//var str="";	 
	bootbox.hideAll();
	var query=" SELECT   BCC_NO ,IFNULL(BSJ_REMARK,'')  "+
		" FROM "+SCHEMA_G+".BPM_SERVICE_JOB where BCC_NO='"+bccNo+"'"; 
	//alert(query)
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
			if(data!=null && data.length>0){
				 
				 var BSJ_REMARK=data[0][1];  
					   var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"saveRemarkAction('"+bccNo+"')\"><span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		                  "<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\"><span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
						// bootbox.dialog();
		                var remark_str="<div>บันทึกหมายเหตุ</div><textarea  id=\"BSJ_REMARK\" cols=\"100\" rows=\"3\" class=\"span7\">"+BSJ_REMARK+"</textarea><div align=\"right\" style=\"\">"+button_cancel+"</div>" ;
						var function_str="addItemToList('"+bccNo+"')";
						var label_str="Add Item";
						var input_id="ima_item_id";
						var input_hidden_id="IMA_ItemID"; 
						var query="SELECT IMA_ItemID,IMA_ItemName,LocQty,ROUND(AcctValAmt,2),CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name  FROM "+SCHEMA_G+".BPM_PRODUCT "+	
						  " where  CONCAT(IMA_ItemID, ' ', IMA_ItemName) like ";
						
						var bt= "<span style=\"padding-left:10px\"><a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
						var input_str= "<span>รหัส&nbsp;&nbsp;&nbsp;<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+ 
							            "<input type=\"hidden\" id=\"IMA_ItemID\" /><input type=\"hidden\" id=\"BSIM_PRICE\" name=\"BSIM_PRICE\" style=\"height: 30;\" /></span>"+  
						 				"<span style=\"padding-left:10px\">คลัง&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_STORE\" name=\"BSIM_STORE\" style=\"height: 30;width:50px\" /></span>"+
						 				"<span style=\"padding-left:10px\">จำนวน&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_AMOUNT\" name=\"BSIM_AMOUNT\" style=\"height: 30;width:50px\" /></span>";
						 var  item_section_str="<div  id=\"item_section\"></div>";
						 bootbox.classes("aoe_width");
						 bootbox.dialog(input_str+bt+"</span><br/><span id=\"item_name\"></span>"+item_section_str+remark_str);
						//  alert(input_id)
						 $("#"+input_id+"" ).autocomplete({
							  source: function( request, response ) {    
								  //$("#pjCustomerNo").val(ui.item.label); 
								   $("#IMA_ItemID").val(""); 
								  var queryiner=query+" '%"+request.term+"%' limit 15 ";
									SynDomeBPMAjax.searchObject(queryiner,{
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
											if(data!=null && data.length>0){
												response( $.map( data, function( item ) {
										          return {
										        	  label: item[0]+" "+item[1]+" ["+item[2]+"]",
										        	  value: item[0] ,
										        	//  IMA_ItemID,IMA_ItemName,LocQty,LastCostAmt,CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name 
										        	  id: item[0],
										        	  IMA_ItemID:item[0] ,
										        	  IMA_ItemName:item[1] ,
										        	  LocQty:item[2] ,
										        	  Price:item[3] ,
										        	  name:item[4] 
										          }
										        }));
											}else{
												var xx=[]; 
												response( $.map(xx));
											}
										}
										,errorHandler:function(errorString, exception) { 
											alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
										}
								 });		  
							  },
							  minLength: 1,
							  select: function( event, ui ) { 
								  this.value = ui.item.value;
								  $("#"+input_hidden_id+"").val(ui.item.id);   
									//alert(input_hidden_id)
							 //alert($("#"+input_hidden_id+"").val())
								  document.getElementById("BSIM_PRICE").value=ui.item.Price; 
								  $("#item_name").html(ui.item.IMA_ItemName+" ["+ui.item.LocQty+"]"); 
							      return false;
							  },
							  open: function() {
							    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
							  },
							  close: function() {
							    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
							  }
							}); 
						 renderItemList(bccNo);
			  
		}
		}
	});
	//	}
	
	
} 
function doDeleteItem(bccNo,itemId){
	var querys=[]; 
	var query=" DELETE FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING WHERE BCC_NO='"+bccNo+"' and IMA_ItemID='"+itemId+"' "; 
	 
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
				 renderItemList(bccNo);
				//bootbox.hideAll();
			}
		},errorHandler:function(errorString, exception) { 
			alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
		}
	});
}
function renderItemList(bccNo){
	// alert(BSJ_REMARK) 
	var query_common=" SELECT  mapping.BCC_NO,mapping.IMA_ItemID,product.IMA_ItemName, mapping.BSIM_AMOUNT "+
		 					",mapping.BSIM_STORE,mapping.BSIM_TYPE "+  
"FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING  mapping left join "+SCHEMA_G+".BPM_PRODUCT product "+
" on mapping.IMA_ItemID=product.IMA_ItemID  where mapping.BSIM_TYPE='1' AND mapping.BCC_NO='"+bccNo+"'"; 
var query= query_common;



//var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
var queryObject="  "+query;//+"   limit "+limitRow+", "+_perpageG;
var queryCount=" select count(*) from (  "+query+" ) as x";
//alert(queryObject)
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
	        "  		<th width=\"5%\"><div class=\"th_class\">#</div></th> "+
	        "  		<th width=\"20%\"><div class=\"th_class\">รหัส</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">คลัง</div></th> "+
	        "  		<th width=\"55%\"><div class=\"th_class\">รายการ</div></th> "+
	        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+   
	        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+  
	        " 		</tr>"+
	        "	</thead>"+
	        "	<tbody>   ";  
	   if(data!=null && data.length>0){ 
		   
		   for(var i=0;i<data.length;i++){  
			 
			   str=str+ "  	<tr style=\"cursor: pointer;\">"+
			   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
			   "  		<td style=\"text-align: left;\"> "+data[i][1]+"</td>"+    
		        "    	<td style=\"text-align: left;\">"+data[i][4]+"</td>  "+  
		        "    	<td style=\"text-align: left;\">"+data[i][2]+"</td>  "+  
		        "    	<td style=\"text-align: center;\">"+data[i][3]+"</td>  "+   
		        "    	<td style=\"text-align: center;\"> <i title=\"Delete\" onclick=\"doDeleteItem('"+data[i][0]+"','"+data[i][1]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i> </td>  "+  
		        "  	</tr>  ";
		   } 
	   }else{
		   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
	    /* str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
    		"<thead>"+
    		"<tr> "+
  			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
  		"</tr>"+
	"</thead>"+
	"<tbody>"; 
	*/
	   }
	  
	   str=str+  " </tbody>"+
	   "</table> "; 
	   
	 $("#item_section").html(str);
}
});
}
function showRemark(bccNo){
	bootbox.hideAll();
	var query=" SELECT   BCC_NO ,IFNULL(BSJ_REMARK,'')  "+
		" FROM "+SCHEMA_G+".BPM_SERVICE_JOB where BCC_NO='"+bccNo+"'"; 
	//alert(query)
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
			if(data!=null && data.length>0){
				 
				 var BSJ_REMARK=data[0][1]; 
				// alert(BSJ_REMARK)
					   var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"saveRemarkAction('"+bccNo+"')\"><span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		                  "<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\"><span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
						bootbox.dialog("<div>บันทึกหมายเหตุ</div><textarea  id=\"BSJ_REMARK\" cols=\"100\" rows=\"3\" class=\"span7\">"+BSJ_REMARK+"</textarea><div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
		
				 
				  
			   }
		}
	});
}
function showTeamPM(BTLD_AI){
 
	bootbox.hideAll();
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod ,dept.bdept_id , "+
		" (SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST  where btdl_owner=user.username and btdl_hide='1' ) "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where user_hod.username='${username}' "; 
	SynDomeBPMAjax.searchObject(query,{
		callback:function(data){
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			if(data!=null && data.length>0){
				
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Username</div></th> "+
			    "  		<th width=\"65%\"><div class=\"th_class\">Name </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
			    var bdept_id="";
				   for(var i=0;i<data.length;i++){
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]";
					   bdept_id=data[i][5];
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+pending_job+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeamPM('"+bdept_id+"','"+BTLD_AI+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a>"+
				   "</div>";
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
				 }]);
			   }
		}
	});
}
function doAssignTeamPM(bdept_id,BTLD_AI){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	var query="select BTDL_REF as c0,BTDL_TYPE as c1,BTDL_STATE as c2,BTDL_OWNER as c3,BTDL_OWNER_TYPE as c4,BTDL_MESSAGE as c5, "+
		" BTDL_SLA as c6,BTDL_SLA_UNIT as c7,BTDL_CREATED_TIME as c8,BTDL_DUE_DATE as c9,BTDL_HIDE as c10,BTDL_REQUESTOR as c11,REF_NO as c12,DATE_FORMAT(BTDL_SLA_LIMIT_TIME,'%Y-%m-%d %H:%i:%s') as c13 ,"+
		" DATE_FORMAT(BTDL_SLA_LIMIT_TIME,'%Y-%m-%d') as c14 "+
		" from BPM_TO_DO_LIST where BTLD_AI="+BTLD_AI; 
SynDomeBPMAjax.searchObject(query,{
	callback:function(data){
		if(data.resultMessage.msgCode=='ok'){
			data=data.resultListObj;
		}else{// Error Code
			  bootbox.dialog(data.resultMessage.msgDesc,[{
				    "label" : "Close",
				     "class" : "btn-danger"
			 }]);
			 return false;
		}
		if(data!=null && data.length>0){
			 var btdl_state='wait_for_operation_pmma';
			    var BTDL_SLA_LIMIT_TIME="'"+data[0][13]+"'";
			    var BTDL_DUE_DATE="'"+data[0][14]+"'";
			    var BTDL_REQUESTOR=data[0][11];
			    var REF_NO=data[0][12];
			    var spec_time="";
              var BTDL_REF=data[0][0];
				var btdl_type='3';
				var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
				var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='PM/MA wait for Operation';var hide_status='1';
				var is_hide_todolist=true;
				var querys=[];  
				 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
						"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
						"('"+BTDL_REF+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	"+BTDL_DUE_DATE+",'"+hide_status+"','"+BTDL_REQUESTOR+"','"+REF_NO+"',"+BTDL_SLA_LIMIT_TIME+" ) ";

				 // clear to-do-list
				// if('${state}'!='' && is_hide_todolist){
				  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTLD_AI="+BTLD_AI+" and "+
				  "BTDL_TYPE='"+btdl_type+"'   and BTDL_OWNER='${username}'  ";
				  
					// "BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
					//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
					 querys.push(query2); 
				// } 
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
							bootbox.dialog(message_created,[{
							    "label" : "Ok",
							    "class" : "btn-primary",
							    "callback": function() {
							    	loadDynamicPage('dispatcher/page/todolist')
							    }
							 }]);
						}
					}
				});
		}
	}});		
   

}
function showTeam(bccNo){
	
	bootbox.hideAll();
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod ,dept.bdept_id , "+
		" (SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST  where btdl_owner=user.username and btdl_hide='1' ) "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where user_hod.username='${username}' "; 
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
			if(data!=null && data.length>0){
				
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Username</div></th> "+
			    "  		<th width=\"65%\"><div class=\"th_class\">Name </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
			    var bdept_id="";
				   for(var i=0;i<data.length;i++){
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]";
					   bdept_id=data[i][5];
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+pending_job+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   
				 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeam('"+bdept_id+"','"+bccNo+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a>"+
				//   "&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\"  onclick=\"doSendTo('"+bdept_id+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+send_to_str+"</span></a>"+
				   "</div>";
				// alert(str)
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function doAssignTeam(bdept_id,bccNo){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
	//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
    var btdl_state='wait_for_operation_services';
    var BTDL_SLA_LIMIT_TIME="(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00')))";
    var BTDL_DUE_DATE="null";
    var spec_time="";
	
  //wait_for_assign_to_team
	//wait_for_quotation
	//wait_for_send_to_supervisor  --> key account
	//wait_for_supervisor_services_close
	//wait_for_operation_services

	var btdl_type='2';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='Job wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];  
	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('"+bccNo+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	"+BTDL_DUE_DATE+",'"+hide_status+"','${username}','"+bccNo+"',"+BTDL_SLA_LIMIT_TIME+" ) ";

	 // clear to-do-list
	// if('${state}'!='' && is_hide_todolist){
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='"+bccNo+"' and "+
	  "BTDL_TYPE='"+btdl_type+"'   and BTDL_OWNER='${username}' ";
		// "BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
		 querys.push(query2); 
	// } 
	 if( btdl_state=='wait_for_operation_services'   || btdl_state=='wait_for_supervisor_services_close'){
		 query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_STATE='"+btdl_state+"' where BCC_NO='"+bccNo+"'"; 
		  querys.push(query2); 
	 }
	 /*
	 if(username_team=='RFE'){
		 var BSO_RFE_NO =jQuery.trim($("#BSO_RFE_NO").val());
		 if(!BSO_RFE_NO.length>0){
			  alert("กรุณาใส่ RFE No.");
			  $("#BSO_RFE_NO").focus();
			  return false;
		  }
		  query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSO_RFE_NO='"+BSO_RFE_NO+"' where BSO_ID="+bccNo+""; 
		  querys.push(query2); 
	 }
	 */
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
				bootbox.dialog(message_created,[{
				    "label" : "Ok",
				    "class" : "btn-primary",
				    "callback": function() {
				    	loadDynamicPage('dispatcher/page/todolist')
				    }
				 }]);
			}
		}
	});

}
function showTeamIT(bccNo,_state,type_no){ 
	//alert('ss')
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod ,dept.bdept_id , "+
		" (SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST  where btdl_owner=user.username and btdl_hide='1' ) "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where user_hod.username='${username}' "; 
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
			if(data!=null && data.length>0){
				
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Username</div></th> "+
			    "  		<th width=\"65%\"><div class=\"th_class\">Name </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
			    var bdept_id="";
				   for(var i=0;i<data.length;i++){
					  /*  role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   } */
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]";
					   bdept_id=data[i][5];
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+pending_job+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   var send_to_str='ส่งต่อให้ Logistic';
					if(bdept_id=='8')
						send_to_str='ส่งต่อให้ IT';
				 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeamIT('"+bdept_id+"','"+bccNo+"','"+_state+"','"+type_no+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a>"+
				   "&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\"  onclick=\"doSendTo('"+bdept_id+"','"+bccNo+"','"+_state+"','"+type_no+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+send_to_str+"</span></a>";
				   if(bdept_id!='8')
					   str=str+"&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\"  onclick=\"doSendToReg('"+bdept_id+"','"+bccNo+"','"+_state+"','"+type_no+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">ส่งต่อให้ IT ภูมิภาค</span></a>";
					   
					   str=str+"</div>";
				// alert(str)
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
  
	function doSendToReg(bdept_id,bccNo,_state,type_no){
		 
		bootbox.hideAll();
		var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
        " on dept.bdept_hdo_user_id=user.id where bdept_id=5) as hod_it_reg,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic	FROM dual ";
		SynDomeBPMAjax.searchObject(query_search,{
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
				var querys=[];   
				if(data!=null && data.length>0){ 
					 	 // IT
					var	message_created="ข้อมูลถูกส่งไป IT ภูมิภาค เรียบร้อยแล้ว";
					 	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
								"('"+bccNo+"','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+type_no+"',null) ";
						 querys.push(query); 
					 
					var btdl_type='1'; 
					
					var is_hide_todolist=true;
					 
					 if(_state!='' && is_hide_todolist  ){
					  var query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='"+bccNo+"' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+_state+"' and BTDL_OWNER='${username}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
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
								bootbox.dialog(message_created,[{
								    "label" : "Ok",
								    "class" : "btn-primary",
								    "callback": function() {
								    	loadDynamicPage('dispatcher/page/todolist')
								    }
								 }]);
							}
						}
					});
				}
			}});
		//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
		//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
	    var btdl_state='wait_for_operation_install';
		if(bdept_id=='8'){
			btdl_state='wait_for_operation_delivery';
		}else{
			
		}
		

	}
	function doSendTo(bdept_id,bccNo,_state,type_no){
		 
		bootbox.hideAll();
		var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
        " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic	FROM dual ";
		SynDomeBPMAjax.searchObject(query_search,{
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
				var querys=[];   
				if(data!=null && data.length>0){
					var message_created='ข้อมูลถูกส่งไป Logistic เรียบร้อยแล้ว'; 
					if(bdept_id!='8'){// RFE
					 	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('"+bccNo+"','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+type_no+"',null) ";
						 querys.push(query); 
					}else {	 // IT
						message_created="ข้อมูลถูกส่งไป IT เรียบร้อยแล้ว";
					 	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
								"('"+bccNo+"','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+type_no+"',null) ";
						 querys.push(query); 
					}
					var btdl_type='1'; 
					
					var is_hide_todolist=true;
					 
					// if(_state!='' && is_hide_todolist && bdept_id=='8'){
						 if(_state!='' && is_hide_todolist ){
					  var query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='"+bccNo+"' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+_state+"' and BTDL_OWNER='${username}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
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
								bootbox.dialog(message_created,[{
								    "label" : "Ok",
								    "class" : "btn-primary",
								    "callback": function() {
								    	loadDynamicPage('dispatcher/page/todolist')
								    }
								 }]);
							}
						}
					});
				}
			}});
		//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
		//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
	    var btdl_state='wait_for_operation_install';
		if(bdept_id=='8'){
			btdl_state='wait_for_operation_delivery';
		}else{
			
		}
		

	}
function doAssignTeamIT(bdept_id,bccNo,_state,type_no){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
	//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
    var btdl_state='wait_for_operation_install';
    var BTDL_SLA_LIMIT_TIME="(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00')))";
    var BTDL_DUE_DATE="null";
    var spec_time="";
	if(bdept_id=='8'){
		btdl_state='wait_for_operation_delivery';
		var BSO_DELIVERY_DUE_DATE_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_PICKER").val());
		var BSO_DELIVERY_DUE_DATE_TIME_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val());
		var BSO_DELIVERY_DUE_DATE="";
		if(BSO_DELIVERY_DUE_DATE_PICKER.length>0){
			var BSO_DELIVERY_DUE_DATE_ARRAY=BSO_DELIVERY_DUE_DATE_PICKER.split("/");
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE_ARRAY[2]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[1]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[0];
			if(BSO_DELIVERY_DUE_DATE_TIME_PICKER.length>0){
				if(BSO_DELIVERY_DUE_DATE_TIME_PICKER=='00:00')					
					spec_time=BSO_DELIVERY_DUE_DATE+" 20:00:00"; 
				else
					spec_time=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
				BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
				
			}else{
				spec_time=BSO_DELIVERY_DUE_DATE+" 20:00:00"; 
				BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" 00:00:00";
				
			}
			 
		}

		if(BSO_DELIVERY_DUE_DATE.length>0){
			BTDL_SLA_LIMIT_TIME="'"+spec_time+"'";
			BTDL_DUE_DATE="'"+BSO_DELIVERY_DUE_DATE+"'";
		} 
	}else{
		var BSO_INSTALLATION_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_PICKER").val());
		var BSO_INSTALLATION_TIME_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_TIME_PICKER").val());
		var BSO_INSTALLATION_DUE_DATE="";
		if(BSO_INSTALLATION_TIME_PICKER.length>0){
			var BSO_INSTALLATION_DUE_DATE_ARRAY=BSO_INSTALLATION_TIME_PICKER.split("/");
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE_ARRAY[2]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[1]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[0];
			if(BSO_INSTALLATION_TIME_TIME_PICKER.length>0){
				if(BSO_INSTALLATION_TIME_TIME_PICKER=='00:00')		
					spec_time=BSO_INSTALLATION_DUE_DATE+" 20:00:00";
				else
					spec_time=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
				BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
				
			}else{
				spec_time=BSO_INSTALLATION_DUE_DATE+" 20:00:00"; 
				BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" 00:00:00";
				
			}
			 
		}
		if(BSO_INSTALLATION_DUE_DATE.length>0){
			BTDL_SLA_LIMIT_TIME="'"+spec_time+"'"; 
			BTDL_DUE_DATE="'"+BSO_INSTALLATION_DUE_DATE+"'";
		}
	}

	var btdl_type='1';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='Sale Order wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];  
	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('"+bccNo+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	"+BTDL_DUE_DATE+",'"+hide_status+"','${username}','"+type_no+"',"+BTDL_SLA_LIMIT_TIME+" ) ";
	 
	 if(_state!='' && is_hide_todolist){
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='"+bccNo+"' and "+
		"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+_state+"' and BTDL_OWNER='${username}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
	 
		 querys.push(query2); 
	 } 
	 if(btdl_state=='wait_for_operation_delivery' || btdl_state=='wait_for_operation_install'   || btdl_state=='wait_for_supervisor_close'){
		 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID="+bccNo+""; 
		  querys.push(query2); 
	 }
	 
	 if(username_team=='RFE'){
		 /*
		 var BSO_RFE_NO =jQuery.trim($("#BSO_RFE_NO").val());
		 if(!BSO_RFE_NO.length>0){
			  alert("กรุณาใส่ RFE Nos.");
			  $("#BSO_RFE_NO").focus();
			  return false;
		  }
		  query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_RFE_NO='"+BSO_RFE_NO+"' where BSO_ID="+bccNo+""; 
		  querys.push(query2); 
		  */
	 }
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
				bootbox.dialog(message_created,[{
				    "label" : "Ok",
				    "class" : "btn-primary",
				    "callback": function() {
				    	loadDynamicPage('dispatcher/page/todolist')
				    }
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
	    					 <%--
	    					  <span style="padding-left: 20px;font-size: 23;color: red"><strong>วันนี้เที่ยง 12:05 ขอ Down ระบบ ประมาณ 5 นาทีครับ เริ่มใช้งานได้ 12:15</strong></span>
	    					   --%>
	    					</td><td align="right" width="30%"> 
	    					Total 1,000 Records | <a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="employeeWorkMappingPageSelect" id="employeeWorkMappingPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					<tr>  
	    					<td align="left" colspan="2" width="100%">   
	    					 <span><strong>Service Type</strong></span>
	    					 <span style="padding-left:5px" id="service_type_element">
	    					  <select name="service_type" style="width:101px" id="service_type" onchange="changeType('1')" class="span2">
	    					  		<option value="0">All</option>
							        <option value="1">Sale Order</option>
							        <option value="2">แจ้งซ่อม</option>
							        <option value="3">PM/MA</option>
							        <option value="4">Service</option>
							      </select>
							   </span>
							  <span style="padding-left:20px"><strong>Service Status</strong></span>
	    					  <span style="padding-left:5px" id="service_status_element"><select name="service_status" id="service_status" onchange="getTodolist('1')"  class="span2">
	    					  		<option value="1">All</option>
							       <option value="1">รับเครื่อง/เช็คไซต์</option>
    						    				<option value="2">เสนอราคา</option>
    						    				<option value="3">รออนุมัติซ่อม</option>
    						    				<option value="4">ซ่อม</option>
    						    				<option value="5">ส่งเครื่อง</option>
    						    				<option value="6">ครวจสอบเอกสาร</option>
    						    				<option value="7">ปิดงานเรียบร้อย</option>
							      </select>
							   </span>
							   <span style="padding-left:20px"><strong>Job No.</strong></span>
	    					  <span style="padding-left:5px" id="job_no_elment"> 
	    					    <input type="text" id="key_job" style="height: 30px;width:80px">
							   </span>
							   <c:if test="${isSupervisorAccount}">
							    <span style="padding-left:5px">
							    <input   readonly="readonly" value="${time}" style="cursor:pointer;width:90px; height: 30px;" id="BTDL_CREATED_TIME_START" type="text">
							    </span>
							    <span><strong>-</strong></span>
							    <span style="padding-left:5px">
							    <input   readonly="readonly" value="${time}" style="cursor:pointer;width:90px; height: 30px;" id="BTDL_CREATED_TIME_END" type="text">
							   
							    </span>
							    <span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="getTodolist('1')"><i
										class="icon-search"></i>&nbsp;Search</a>
										</span>
							    </c:if>
	    					
	    					</tr> 
	    					<tr>  
	    						<td align="right" width="30%">  
	    						
	    						</td>
	    						<td align="right" width="70%">
	    						<c:if test="${isSupervisorAccount}">
	    							<a class="btn btn-primary" onclick="openInnerServiceJob()"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">เปิด job งานService</span></a>
	    						 </c:if>
	    						 <c:if test="${!isStoreAccount && !isInvoiceAccount && !isKeyAccount && !isQuotationAccount && !isSupervisorAccount}">
	    						    <a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/callcenter_job?bccNo=0&mode=add')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">เปิด job แจ้งซ่อม</span></a>
	    						</c:if>
	    						</td>
	    					</tr>
	    					 
	    					
	    					</tbody></table>  
	    					<div  id="search_section_todolist"> 
    						</div> 
      </div>
      </fieldset> 