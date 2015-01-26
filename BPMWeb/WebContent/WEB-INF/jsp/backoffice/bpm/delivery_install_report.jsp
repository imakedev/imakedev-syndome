<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/>  
<jsp:useBean id="date" class="java.util.Date"/>
<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	$("#keyword_search").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     viewDailyReport();
		   } 
		});
	  $("#DUE_DATE_START_PICKER").datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	  $("#DUE_DATE_END_PICKER").datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		}); 
		 
});
function viewDailyReport(){
	var duedate_start=jQuery.trim($("#DUE_DATE_START_PICKER").val());
	if(!duedate_start.length>0){
		  alert("กรุณาใส่ Due Date Start");
		  $("#DUE_DATE_START_PICKER").focus();
		  return false;
   }
	var duedate_end=jQuery.trim($("#DUE_DATE_END_PICKER").val());
	if(!duedate_end.length>0){
		  alert("กรุณาใส่ Due Date End");
		  $("#DUE_DATE_END_PICKER").focus();
		  return false;
   }
	var emp=$("#EMP").val();
	//var emp_name=$("#emp_name").html(); 
	var emp_query="";
	if(emp.length>0)
		emp_query=" and lower(to_do.BTDL_OWNER)=lower('"+emp+"') ";
	
	var query_where="";
	var keyword_search=jQuery.trim($("#keyword_search").val());
	if(keyword_search.length>0)
		query_where=" where concat(c1,c2,c3,c4,c5,c6,c7) like '%"+keyword_search+"%'"; 
	var duedate_start_array=duedate_start.split("/");
	var duedate_end_array=duedate_end.split("/");
	var year_from=duedate_start_array[2];
	var month_from=duedate_start_array[1];
	var day_from=duedate_start_array[0];
	
	var year_end=duedate_end_array[2];
	var month_end=duedate_end_array[1];
	var day_end=duedate_end_array[0];
	var query_so="SELECT concat(u.firstName,\" \",u.lastName )   as c0," +
//	" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y'),'')  as c1 ," +
	 "  CASE  "+
	 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
	 "         THEN   "+ 
	 "  ifnull(so.BSO_DELIVERY_LOCATION,'')  " +
	 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
	 "         THEN   "+
	 "  ifnull(so.BSO_INSTALLATION_SITE_LOCATION,'')  " +
	 "         ELSE "+
     "  			 ''"+
	 "        END as c1, "+ 
	 "  CASE  "+
	 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
	 "         THEN   "+ 
	" concat(ifnull(so.BSO_DELIVERY_ADDR1,''),\" \",ifnull(so.BSO_DELIVERY_ADDR2,''),\" \",ifnull(so.BSO_DELIVERY_ADDR3,''),\" \",ifnull(so.BSO_DELIVERY_PROVINCE,'')) " +
	 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
	 "         THEN   "+
	 " concat(ifnull(so.BSO_INSTALLATION_ADDR1,''),\" \",ifnull(so.BSO_INSTALLATION_ADDR2,''),\" \",ifnull(so.BSO_INSTALLATION_ADDR3,''),\" \",ifnull(so.BSO_INSTALLATION_PROVINCE,'')) " +
	 "         ELSE "+
     "  			 ''"+
	 "        END as c2, "+ 

" ifnull(status_job.BJS_STATUS,'')  as c3," +
	" so.BSO_TYPE_NO  as c4," +
	" \"\"  as c5, "+
	" \"\"  as c6, "+
	 "  CASE  "+
	 "    WHEN (select so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )   "+
	 "         THEN   "+ 
	 " concat(ifnull(so.BSO_DELIVERY_CONTACT,''),\" \",ifnull(so.BSO_DELIVERY_TEL_FAX,''))  " +
	 "       WHEN (select so.BSO_IS_INSTALLATION='1')   "+
	 "         THEN   "+
	 " concat(ifnull(so.BSO_INSTALLATION_CONTACT,''),\" \",ifnull(so.BSO_INSTALLATION_TEL_FAX,''))  " +
	 "         ELSE "+
     "  			 ''"+
	 "        END as c7, "+ 
	//" \"\"  as c9, "+
	//" \"\"  as c10, "+
 "  CASE  "+
 "    WHEN (select ( so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1' )  and DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i') !='00:00' )  "+
 "         THEN   "+
 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+ 
 " WHEN (select (so.BSO_IS_DELIVERY='1'  or so.BSO_IS_DELIVERY_INSTALLATION='1') and DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i') ='00:00' ) "+   
 "   THEN    "+
 " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') "+  
 "       WHEN (select so.BSO_IS_INSTALLATION='1' and DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i') !='00:00' )   "+
 "         THEN   "+
 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y %H:%i'),'')  "+
 " WHEN (select so.BSO_IS_INSTALLATION='1' and DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i') ='00:00' )   "+
  " THEN   "+
 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') "+  
 "         ELSE "+
 "  			 ''"+
 "        END as c8, "+  
	" so.BSO_TYPE_NO as c9, "+
	 " concat(so.BSO_ID,'') as c10 , "+
	 " to_do.BTDL_TYPE as c11 "+
	" FROM "+SCHEMA_G+".BPM_TO_DO_LIST to_do left join " +
	" "+SCHEMA_G+".user u on to_do.BTDL_OWNER=u.username  left join "+SCHEMA_G+".BPM_SALE_ORDER so" +
	" on (to_do.REF_NO=so.BSO_TYPE_NO)" +
	 " left join  "+SCHEMA_G+".BPM_JOB_STATUS status_job  on " +
		" ( status_job.BJS_TYPE=1 and so.BSO_JOB_STATUS=status_job.BJS_ID)  " +
" where ( to_do.BTDL_STATE like 'wait_for_operation%' )" +
	" and to_do.BTDL_OWNER_TYPE='1'" +
	"   and CASE  " +
	"   WHEN (select so.BSO_IS_DELIVERY='1' or so.BSO_IS_DELIVERY_INSTALLATION='1')    " +
	"	       THEN    " +
	"		   so.BSO_DELIVERY_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
	"	    WHEN (select so.BSO_IS_INSTALLATION='1')   " +
	"	        THEN   " +
   " so.BSO_INSTALLATION_DUE_DATE between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
   " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " +
	" END  " + 
	// " and lower(to_do.BTDL_OWNER)=lower('"+username+"') " +
	emp_query+
	" and to_do.btdl_hide='1' and to_do.BTDL_TYPE='1'  ";
var query_services="SELECT concat(u.firstName,\" \",u.lastName )   as c0," +
	//" IFNULL(DATE_FORMAT(to_do.BTDL_DUE_DATE,'%d/%m/%Y'),'')  as c1 ," +
	" call_center.BCC_LOCATION  as c1," +
	" concat(call_center.BCC_ADDR1,\" \",call_center.BCC_ADDR2,\" \",call_center.BCC_ADDR2,\" \",call_center.BCC_ADDR3,\" \",call_center.BCC_PROVINCE) as c2," +
	" ifnull(status_job.BJS_STATUS,'')  as c3," +
	" call_center.BCC_NO  as c4," +
	" "+
	" case when call_center.bcc_is_ma='0' "+
	" then concat(ifnull(call_center.BCC_MODEL,''),' [นอกประกัน]')		 "+
	" when call_center.bcc_is_ma='1' "+
	"  then concat(ifnull(call_center.BCC_MODEL,''),' [ในประกัน]') "+
	" when call_center.bcc_is_ma='2' "+
	"  then  concat(ifnull(call_center.BCC_MODEL,''),' ','[MA',' ',ifnull(call_center.bcc_ma_no,''),']') "+
	" else "+
	"  ifnull(call_center.BCC_MODEL,'') "+
	" end as c5,"+
	" ifnull(BCC_SERIAL,'') as c6, "+
	" concat(call_center.BCC_CONTACT,\" \",call_center.BCC_TEL)  as c7 ," +
	//" \"\"  as c9, "+
	//" \"\"  as c10, "+
"  case when call_center.BCC_DUE_DATE_START is null && call_center.BCC_DUE_DATE_end is null "+
"   then IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'')  "+
"  when call_center.BCC_DUE_DATE_START is not  null && call_center.BCC_DUE_DATE_end is  null "+
"  then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),'',DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i')) "+
"  when call_center.BCC_DUE_DATE_START is    null && call_center.BCC_DUE_DATE_end is not null "+
"  then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),'-',DATE_FORMAT(call_center.BCC_DUE_DATE_end,'%H:%i')) "+
"  when call_center.BCC_DUE_DATE_START is  not  null && call_center.BCC_DUE_DATE_end is not null "+
" then concat(IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),''),' ',DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'-',DATE_FORMAT(call_center.BCC_DUE_DATE_end,'%H:%i'))  "+
"  end "+
 "         as c8, "+ 
	" call_center.BCC_NO as c9 ,"+
    " call_center.BCC_NO as c10 , "+
    "  to_do.BTDL_TYPE as c11 "+
	" FROM "+SCHEMA_G+".BPM_TO_DO_LIST to_do left join " +
	" "+SCHEMA_G+".user u on to_do.BTDL_OWNER=u.username  left join "+SCHEMA_G+".BPM_CALL_CENTER call_center" +
	" on (to_do.REF_NO=call_center.BCC_NO)" +
	" left join  "+SCHEMA_G+".BPM_SERVICE_JOB service_job on  " +
	" (to_do.REF_NO=service_job.BCC_NO) " +
	 " left join  "+SCHEMA_G+".BPM_JOB_STATUS status_job  on " +
	" ( status_job.BJS_TYPE=2 and service_job.SBJ_JOB_STATUS=status_job.BJS_ID)  " +
	" where ( to_do.BTDL_STATE like 'wait_for_operation%'" +
	 " )" +
	" and to_do.BTDL_OWNER_TYPE='1'" +
	"   and   " +
	"		   call_center.BCC_DUE_DATE  between '"+year_from+"-"+month_from+"-"+day_from+" 00:00:00' " +
    " and '"+year_end+"-"+month_end+"-"+day_end+" 23:59:59' " + 
	//" and lower(to_do.BTDL_OWNER)=lower('"+username+"') " +
	emp_query+
	" and to_do.btdl_hide='1' and to_do.BTDL_TYPE='2'  ";

var query=" select c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11 from ( "+query_so+" union all "+query_services+" ) as syndome "+query_where;
//$("#query").html(query)
SynDomeBPMAjax.searchObject(query,{  
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
	        "	<thead> 	"+
	        "  		<tr> "+
	        "  		<th width=\"5%\"><div class=\"th_class\">#</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">ช่างเทคนิค</div></th> "+
	        "  		<th width=\"15%\"><div class=\"th_class\">ชื่อบริษัท/หน่วยงาน</div></th> "+   
	        "  		<th width=\"15%\"><div class=\"th_class\">สถานที่</div></th> "+ 
	        "  		<th width=\"10%\"><div class=\"th_class\">Service</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">เลขที่เอกสาร</div></th> "+  
	        "  		<th width=\"5%\"><div class=\"th_class\">รายละเอียดเพิ่มเติม</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">หมายเลขเครื่อง</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">เบอร์ติดต่อ</div></th> "+ 
	        "  		<th width=\"10%\"><div class=\"th_class\">Due Date</div></th> "+  
	        " 		</tr>"+
	        "	</thead>"+
	        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){ 
				       str=str+ "  	<tr style=\"cursor: pointer;\">"+
				       "  <td> <span style=\"text-align: left;cursor: pointer;\">"+(i+1)+".</span>";
				        	  
				           str=str+ " </td>"+
						   "  		<td style=\"text-align: left;\">"+data[i][0]+"</td>"+   
						   "  		<td style=\"text-align: center;\">"+data[i][1]+"</td>"+    
						   "  		<td style=\"text-align: center;\">"+data[i][2]+"</td>"+   
						   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+    
						   "  		<td style=\"text-align: left;\">"+data[i][4]+"</td>"+     
					        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][6]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][7]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][8]+"</td>  "; 
					        str=str+ "  	</tr>  "; 
				   }
			   }else{
				 str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"10\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section_install").html(str);
		}});
}
function exportDailyReport(){ 
	 
	var usr=jQuery.trim($("#EMP").val());
    if(!usr.length>0){
			  alert("กรุณาใส่ ชื่อพนักงาน");
			  $("#EMP").focus();
			  return false;
	}
	var duedate_start=jQuery.trim($("#DUE_DATE_START_PICKER").val());
	if(!duedate_start.length>0){
		  alert("กรุณาใส่ Due Date Start");
		  $("#DUE_DATE_START_PICKER").focus();
		  return false;
   }
	var duedate_end=jQuery.trim($("#DUE_DATE_END_PICKER").val());
	if(!duedate_end.length>0){
		  alert("กรุณาใส่ Due Date End");
		  $("#DUE_DATE_END_PICKER").focus();
		  return false;
   }
	var bcr_id=jQuery.trim($("#bcr_id").val());
	var bcp_id=jQuery.trim($("#bcp_id").val());
	if(bcr_id.length==0)
		bcr_id="0";
	if(bcp_id.length==0)
		bcp_id="0";
	//alert(bcr_id+","+bcr_id) 
	var duedate_start_array=duedate_start.split("/");
	var duedate_end_array=duedate_end.split("/");
		var src = "report/dailyReport/"+usr+"/"+duedate_start_array[0]+"_"+duedate_start_array[1]+"_"+duedate_start_array[2]+"/"+duedate_end_array[0]+"_"+duedate_end_array[1]+"_"+duedate_end_array[2]+"/"+bcp_id+"/"+bcr_id;
		// alert(src)
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
		  
}
function showBCP(){
	$("#bcp_id").val("");
	$("#bcp_name").html(""); 
	 
	var query="  "+
		" SELECT bcp_id, concat(BCP_FIRST_NAME,' ',bcp_sure_name) FROM "+SCHEMA_G+".BPM_CAR_PERSON  ";
		
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
			    "  		<th width=\"95%\"><div class=\"th_class\">พนักงานขับรถ</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){  
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" onclick=\"doSelectBCP()\" value=\""+data[i][0]+"\"  name=\"usernameIdCheckbox_radio\">"+
					   " <input type=\"hidden\" value=\""+(data[i][1])+"\"  name=\"emp_name_select\"> "+
					   "</td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+     
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   "</div>"; 
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger" 
				 }]);
			   }
		}
	});
}
function doSelectBCP(){
	var username_team=""; 
	var emp_name_select="";
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	var emp_name_select_list=document.getElementsByName("emp_name_select");
	
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			emp_name_select=emp_name_select_list[j].value;
			break;	
		}
	} 
	//alert(username_team);
	$("#bcp_id").val(username_team);
	$("#bcp_name").html("["+emp_name_select+"]"); 
	bootbox.hideAll();
}
function showBCR(){
	$("#bcr_id").val("");
	$("#bcr_name").html(""); 
	 
	var query="  "+
		" SELECT BCR_ID,BCR_NAME FROM "+SCHEMA_G+".BPM_CAR_REGISTRATION ";
		 
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
			    "  		<th width=\"95%\"><div class=\"th_class\">ทะเบียนรถ</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){ 
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]"; 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" onclick=\"doSelectBCR()\" value=\""+data[i][0]+"\"  name=\"usernameIdCheckbox_radio\">"+
					   " <input type=\"hidden\" value=\""+(data[i][1])+"\"  name=\"emp_name_select\"> "+
					   "</td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+   
					   "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   "</div>"; 
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger" 
				 }]);
			   }
		}
	});
}
function doSelectBCR(){
	var username_team=""; 
	var emp_name_select="";
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	var emp_name_select_list=document.getElementsByName("emp_name_select");
	
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			emp_name_select=emp_name_select_list[j].value;
			break;	
		}
	} 
	//alert(username_team);
	$("#bcr_id").val(username_team);
	$("#bcr_name").html("["+emp_name_select+"]"); 
	bootbox.hideAll();
} 

function showTeam(){
	$("#EMP").val("");
	$("#emp_name").html(""); 
	 
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
				   for(var i=0;i<data.length;i++){ 
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]"; 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" onclick=\"doSelectDept()\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\">"+
					   " <input type=\"hidden\" value=\""+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"\"  name=\"emp_name_select\"> "+
					   "</td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+pending_job+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   "</div>"; 
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger" 
				 }]);
			   }
		}
	});
}
function doSelectDept(){
	var username_team=""; 
	var emp_name_select="";
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	var emp_name_select_list=document.getElementsByName("emp_name_select");
	
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			emp_name_select=emp_name_select_list[j].value;
			break;	
		}
	} 
	//alert(username_team);
	$("#EMP").val(username_team);
	$("#emp_name").html("["+emp_name_select+"]"); 
	bootbox.hideAll();
}
</script>
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
	    					<span><strong>รายงานประจำวัน</strong></span>
	    					</td><td align="right" width="30%"> 
	    					</td>
	    					</tr>
	    					<tr>
	    					<td width="100%"  colspan="2">
	    					<div align="left" style="padding-left: 15px; padding-top: 10px">
			<table width="100%" border="0">
				<tr valign="top">
					<td width="25%">
						<table width="100%">
							<tr>
								<td>
								<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px"> 
									<span style="padding-left: 10px;font-size: 13px;"></span> 
									<span style="padding: 0px;">
									
									   <a class="btn" style="margin-top: -10px;" onclick="showTeam()">
									   <i class="icon-search"></i>&nbsp;<span style="">ชื่อพนักงาน<span id="emp_name"></span></span></a>
										<input id="EMP"  type="hidden" style="height: 30; width: 100px" />
									</span>
									<span style="padding: 0px;">
									
									   <a class="btn" style="margin-top: -10px;" onclick="showBCP()">
									   <i class="icon-search"></i>&nbsp;<span style="">ชื่อพนักงานขับรถ<span id="bcp_name"></span></span></a>
										<input id="bcp_id"  type="hidden" style="height: 30; width: 100px" />
									</span>
									<span style="padding: 0px;">
									
									   <a class="btn" style="margin-top: -10px;" onclick="showBCR()">
									   <i class="icon-search"></i>&nbsp;<span style="">ทะเบียนรถ<span id="bcr_name"></span></span></a>
										<input id="bcr_id"  type="hidden" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">Due Date</span> 
									<span style="padding: 0px;">
										<input id="DUE_DATE_START_PICKER"  value="${time}"  readonly="readonly" type="text" style="height: 30; width: 90px" />
									</span>
									 <span style="padding-left: 0px;font-size: 13px;">-</span> 
									<span style="padding: 0px;">
										<input id="DUE_DATE_END_PICKER"  value="${time}"  readonly="readonly" type="text" style="height: 30; width: 90px" />
									</span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="exportDailyReport()"><i
										class="icon-ok"></i>&nbsp;Export</a>
										</span>
										 
								</div>
								</td> 
							</tr>
							<tr>
								<td>
								<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">  
										<span style="padding-left: 20px;font-size: 13px;">Keyword : </span> 
										<span style="padding-left: 5px;">
										<input type="text" id="keyword_search" style="height: 30; width: 100px"/>
										</span>
										<span style="padding-left: 20px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewDailyReport()"><i
										class="icon-ok"></i>&nbsp;View</a>
										</span>
								</div>
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	    					</td>
	    					</tr>
	    					
	    					</tbody></table>  <div  id="search_section_install"> 
    						</div>
      </div>
      </fieldset> 