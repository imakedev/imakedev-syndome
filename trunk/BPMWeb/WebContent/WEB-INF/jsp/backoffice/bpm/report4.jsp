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
	  $("#START_DATE_PICKER" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	  $("#END_DATE_PICKER" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	  initDeptCenter();
});
function initDeptCenter(){
	var query=" select u.username,'1',dept.bdept_id,dept.bdept_detail "+ 
		" from BPM_DEPARTMENT dept left join user u on dept.bdept_hdo_user_id=u.id "+
		" where dept.bdept_id not in (3,10) "+
		" union all  "+
		" SELECT u.username,'2',u.id,center.BC_NAME "+ 
		" FROM SYNDOME_BPM_DB.BPM_CENTER center left join SYNDOME_BPM_DB.user u on center.uid=u.id "+ 
		" where center.bc_id not in (1,12,13)  "+
		" union all  "+
		" SELECT username,'3',u.id,concat(u.firstname,' ',u.lastname) FROM  BPM_DEPARTMENT_USER dept_user left join  user u   "+
		"  on dept_user.USER_ID=u.id  where dept_user.bdept_id not in (3,10) and u.username!='RFE'  "+ //-- not in SC,PM MA
		" and not exists ( SELECT u.username   "+
		" FROM SYNDOME_BPM_DB.BPM_CENTER center left join SYNDOME_BPM_DB.user u_inner on center.uid=u_inner.id "+ 
		" where center.bc_id not in (1,12,13) and u_inner.id = u.id "+
		" ) ";
	 SynDomeBPMAjax.searchObject(query,{ 
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
					  if(data!=null && data.length>0){
						   var data_size=data.length; 
						   var dept_element_str="<select style=\"width:150px\" id=\"dep_select_id\">";
						   dept_element_str=dept_element_str+"<option value=\"0,0_0\"> ALL </option>"; 
						   for(var i=0;i<data_size;i++){ 
							   dept_element_str=dept_element_str+"<option value=\""+data[i][0]+","+data[i][1]+"_"+data[i][2]+"\">"+data[i][3]+"</option>";
						   }
						   dept_element_str=dept_element_str+"</select>";
						   $("#dept_element").html(dept_element_str);
						   var viewReport_element="<a class=\"btn\" style=\"margin-top: -10px;\" onclick=\"viewReport()\">&nbsp;View&nbsp;</a>";
						   $("#viewReport_element").html(viewReport_element); 
					  }
				}});
}
function viewReport(){ 
	 var load_str="<fieldset style=\"font-family: sans-serif;padding-top:5px\">"+    
	 "<div style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 10px\"> <img src='${url}resources/images/loading.gif' /></div></fieldset>";
$("#search_section").html(load_str);  
  var dep_select_array=$("#dep_select_id").val().split(",");
  var dep_select_id_array=dep_select_array[1].split("_");
  var sub_query="";
if(dep_select_array[0]!='0'){
  if(dep_select_id_array[0]=='1'){
	  sub_query= " and  exists (SELECT username FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+SCHEMA_G+".user u  "+ 
	  " on dept_user.USER_ID=u.id where dept_user.BDEPT_ID="+dep_select_id_array[1]+" and u.username= todo_list.btdl_owner )    ";
  }else if(dep_select_id_array[0]=='2'){
	  sub_query=" and exists (SELECT u.username FROM SYNDOME_BPM_DB.BPM_CENTER center left join SYNDOME_BPM_DB.user u "+
		  " on center.uid=u.id where center.bc_id not in (1,12,13) and u.id="+dep_select_id_array[1]+" and u.username= todo_list.btdl_owner) ";
  }else{
	  sub_query=" and todo_list.btdl_owner='"+dep_select_array[0]+"'  ";
  }
}
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val();
	     if(START_DATE_PICKER_values.length>0 && END_DATE_PICKER_values.length>0){
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/"); 
	    	 
	    	 var query=" select "+
	    		" todo_list.btdl_owner as c0,concat(user_outer.firstname,' ',user_outer.lastname) as c1, "+
	    		" ifnull(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c2, "+
	    		" ifnull(DATE_FORMAT(todo_list.btdl_action_time,'%d/%m/%Y'),'') as c3, "+
	    		" ifnull(DATE_FORMAT(todo_list.btdl_sla_limit_time,'%d/%m/%Y'),'') as c4, "+
	    		" CASE  "+ 
	    		"      WHEN (select call_center.BCC_DUE_DATE IS NULL) "+ 
	    		"        THEN   "+
	    		"       ifnull(DATE_FORMAT(todo_list.btdl_sla_limit_time ,'%d/%m/%Y'),'') "+
	    		"      ELSE  "+
	    		"       ifnull(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') "+
	    		"       END   as c5 , "+//sla_limit ,  "+
	    		" CASE  "+ 
	    		"      WHEN (select call_center.BCC_DUE_DATE IS NULL) "+ 
	    		"        THEN   "+
	    		"       TIMESTAMPDIFF(day,todo_list.btdl_sla_limit_time,now()) "+   
	    		"       WHEN (select todo_list.btdl_action_time IS NULL)  "+
	    		" 	THEN "+
	    		"       TIMESTAMPDIFF(day,call_center.BCC_DUE_DATE,now()) "+ 
	    		"       else "+
	    		" 	TIMESTAMPDIFF(day,call_center.BCC_DUE_DATE,todo_list.btdl_action_time) "+ 
	    		"       END as c6 ,  "+
	    		" concat(ifnull(call_center.BCC_SERIAL,''),'/',ifnull(call_center.bcc_model,''))  as c7 , "+
	    		" concat(ifnull(call_center.bcc_location,''),' ', "+
	    		" ifnull(call_center.bcc_addr1,''),' ',ifnull(call_center.bcc_addr2,''),' ', "+
				" ifnull(call_center.bcc_addr3,''),' ',ifnull(call_center.bcc_province,''),' ', "+
				" ifnull(call_center.bcc_zipcode,'')) as c8 ,"+ 
				" call_center.BCC_NO as c9 ,"+
				" concat( ifnull(call_center.bcc_contact,''),'/',ifnull(call_center.bcc_tel,'')) as c10  "+
	    		// call_center.BCC_DUE_DATE_START,
	    		//call_center.BCC_DUE_DATE_END, 
	    		//todo_list.BTDL_CREATED_TIME,

	    		//todo_list.* 
	    		 " from "+SCHEMA_G+".BPM_TO_DO_LIST todo_list left join  "+
	    		 " "+SCHEMA_G+".BPM_SERVICE_JOB sv  on( todo_list.BTDL_REF=sv.bcc_no   and todo_list.btdl_type=2) "+
	    		 " left join "+SCHEMA_G+".BPM_CALL_CENTER call_center on (call_center.BCC_NO=sv.BCC_NO) "+
	    		 " left join "+SCHEMA_G+".user user_outer on user_outer.username=todo_list.btdl_owner "+
	    		// " where    todo_list.BTDL_CREATED_TIME between DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 00:00:00') and "+ 
	    		// " DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+ 
	    		 " where    todo_list.BTDL_CREATED_TIME between  '"+START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0]+" 00:00:00' and '"+END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]+" 23:59:59' "+
	    		 " and todo_list.btdl_state like 'wait_for_oper%' "+
	    		 " and todo_list.btdl_type=2  "+
	    		// -- and sv.SBJ_JOB_STATUS=4 and todo_list.btdl_hide='1' 
	    		 sub_query+
	    		  " group by todo_list.btdl_owner, DATE_FORMAT(todo_list.BTDL_CREATED_TIME,'%Y-%m-%d 00:00:00')  "+
	    		  " order by todo_list.btdl_owner,todo_list.BTDL_CREATED_TIME ";
	    	   SynDomeBPMAjax.searchObject(query,{ 
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
							var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
					        "	<thead> 	"+
					        "  		<tr> "+
					        "  		<th width=\"20%\"><div class=\"th_class\">ผู้ปฏิบัติงาน</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">เลขที่ job</div></th> "+
					        "  		<th width=\"10%\"><div class=\"th_class\">รุ่น/model</div></th> "+
					        "  		<th width=\"20%\"><div class=\"th_class\">สถานที่</div></th> "+
					        "  		<th width=\"20%\"><div class=\"th_class\">ผู้ติดต่อ/เบอร์โทร</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">วันนัดหมาย</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">วันปฏิบัติงาน</div></th> "+
					      //  "  		<th width=\"5%\"><div class=\"th_class\">SLA Limit</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">SLA</div></th> "+
					        //"  		<th width=\"5%\"><div class=\"th_class\">จำนวนวันที่เกิน</div></th> "+   
					        " 		</tr>"+
					        "	</thead>"+
					        "	<tbody>   ";  
							 var name_compare="";
							 var sum=0;
							 var sum_all=0;
							 var name_show="";
							 var job_in_time_count=0;
							 var job_out_time_count=0;
							 var job_in_all_time_count=0;
							 var job_out_all_time_count=0;
							 var maxtime=0;
							 var mintime=1;
							   if(data!=null && data.length>0){
								   var data_size=data.length; 
								   for(var i=0;i<data_size;i++){ 
									   name_show=data[i][1]+"     ["+data[i][0]+"]";
									   if(data[i][6]>0){
									   		sum_all=sum_all+data[i][6];
									   		sum=sum+data[i][6];
									   	 job_out_time_count=job_out_time_count+1;
									   	job_out_all_time_count=job_out_all_time_count+1; 
									   	 
									   }else{
										   job_in_time_count=job_in_time_count+1
										   job_in_all_time_count=job_in_all_time_count+1;
									   }
									   if(i==0){
										   maxtime=data[i][6]<0?1:data[i][6]+1;
										   mintime=data[i][6]<0?1:data[i][6]+1;
									   }else{
										  
									   }
									  
									   if(name_compare==data[i][0]){
										   name_show=""; 
										   
									   } 
									    
									   if(name_compare!=data[i][0] && i!=0){
										   if(data[i][6]>0){
										   		sum=sum-data[i][6];
										   	
											 job_out_time_count=job_out_time_count-1;
										   }else{
											   job_in_time_count=job_in_time_count-1
										   }
											   
									        str=str+"<tr>"+
										           "  <th><div class=\"th_class\"></div></th>"+
										           "  <th><div class=\"th_class\"></div></th>"+
										           "  <th><div class=\"th_class\"></div></th>"+
										          // "  <th style=\"text-align: center;background-color:#DCDF9C\"><div class=\"th_class\">สรุป</div></th>"+
										           "  <th align=\"right\" style=\"text-align: right;background-color:#DCDF9C\" colspan=\"5\"><div class=\"th_class\">"+
										           "สรุป ทั้งหมด[ "+(job_out_time_count+job_in_time_count)+" ]"+ 
										           ", ภายใน 1 วัน[ "+(job_in_time_count)+" --> "+((job_in_time_count*100)/(job_out_time_count+job_in_time_count)).toFixed(2)+"% ]"+
										           ", เกิน 1 วัน[ "+(job_out_time_count)+" --> "+((job_out_time_count*100)/(job_out_time_count+job_in_time_count)).toFixed(2)+"% ]"+
										           ", Max Time[ "+(maxtime)+" --> "+((sum>0)?(((maxtime*100)/sum).toFixed(2)+"%"):"0.00%")+"]"+
										           ", Min Time[ "+(mintime)+" ]"+
										           //", จำนวนวันที่เกิน[ "+sum+" ]"+
										           "</div></th>";
											        str=str+ "</tr>"; 
											 sum=0;
											 job_out_time_count=0;
											 job_in_time_count=0;
											 	if(data[i][6]>0){
											 		sum=sum+data[i][6];
											 		 job_out_time_count=job_out_time_count+1;
												   }else{
													   job_in_time_count=job_in_time_count+1
												   }
											 	
											 	 maxtime=data[i][6]<0?1:data[i][6]+1;
												 mintime=data[i][6]<0?1:data[i][6]+1;
									    }else{
									    	 if((data[i][6]+1)>maxtime)
												   maxtime=data[i][6]+1;
											   if((data[i][6]+1)<mintime && data[i][6]>0)
												   mintime=data[i][6]+1;
											   else
												   mintime=1;
									    }
										
									   str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span>"+name_show+"</span>"; 
								           str=str+ " </td>"+
										 
										   "  		<td style=\"text-align: left;\">"+data[i][9]+"</td>"+   
										   "  		<td style=\"text-align: left;\">"+data[i][7]+"</td>"+   
										   "  		<td style=\"text-align: left;\">"+data[i][8]+"</td>"+   
										   "  		<td style=\"text-align: left;\">"+data[i][10]+"</td>"+   
										   "  		<td style=\"text-align: left;\">"+data[i][5]+"</td>"+   
										   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+    
										   //"  		<td style=\"text-align: left;\">"+data[i][5]+"</td>";
										   "  		<td style=\"text-align: center;\">"+((data[i][6]>0)?data[i][6]+1:1)+"</td>";
									        str=str+ "  	</tr>  "; 
									        
									   if(i==data_size-1){
											        str=str+"<tr>"+
											        "  <th><div class=\"th_class\"></div></th>"+
											           "  <th><div class=\"th_class\"></div></th>"+
											           "  <th><div class=\"th_class\"></div></th>"+
											           // "  <th style=\"text-align: center;background-color:#DCDF9C\"><div class=\"th_class\">สรุป</div></th>"+
											           "  <th align=\"right\" style=\"text-align: right;background-color:#DCDF9C\" colspan=\"5\"><div class=\"th_class\">"+
											           "สรุป  ทั้งหมด[ "+(job_out_time_count+job_in_time_count)+" ]"+ 
											           ", ภายใน 1 วัน[ "+(job_in_time_count)+" --> "+((job_in_time_count*100)/(job_out_time_count+job_in_time_count)).toFixed(2)+"% ]"+
											           ", เกิน 1 วัน[ "+(job_out_time_count)+" --> "+((job_out_time_count*100)/(job_out_time_count+job_in_time_count)).toFixed(2)+"% ]"+
											           ", Max Time[ "+(maxtime)+" --> "+((sum>0)?(((maxtime*100)/sum).toFixed(2)+"%"):"0.00%")+"]"+
											           ", Min Time[ "+(mintime)+" ]"+
											           //", จำนวนวันที่เกิน[ "+sum+" ]"+
											          // ", SLA[ "+(sum)+" ]"+
											           "</div></th>";
													        str=str+ "</tr>"; 
													        str=str+"<tr>"+
													        "  <th><div class=\"th_class\"></div></th>"+
													           "  <th><div class=\"th_class\"></div></th>"+
													           "  <th><div class=\"th_class\"></div></th>"+
															   //"  		<th style=\"text-align: left;background-color:#DCDF9C\"><div class=\"th_class\">สรุปทั้งหมด</div></th>"+   
													           "  <th align=\"right\" style=\"text-align: right;background-color:#DCDF9C\" colspan=\"5\"><div class=\"th_class\">"+
													           "สรุปรวม ทั้งหมด[ "+(job_out_all_time_count+job_in_all_time_count)+" ]"+ 
													           ", ภายใน 1 วัน[ "+(job_in_all_time_count)+" --> "+((job_in_all_time_count*100)/(job_out_all_time_count+job_in_all_time_count)).toFixed(2)+"% ]"+
													           ", เกิน 1 วัน[ "+(job_out_all_time_count)+" --> "+((job_out_all_time_count*100)/(job_out_all_time_count+job_in_all_time_count)).toFixed(2)+"% ]"+
													           //", จำนวนวันที่เกิน[ "+sum_all+" ]"+
													           //", SLA[ "+sum_all+" ]"+
													           "</div></th>";
														        str=str+ "</tr>"; 
													
										 }
											   name_compare=data[i][0];
								   }
							   }else{
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

	     }else{
	    	 alert("กรุณาใส่เวลา.");
	    	 $("#search_section").html("");
	     }
	    
}

function exportReport4(){  
	  var dep_select_array=$("#dep_select_id").val().split(",");
	  var dep_select_id_array=dep_select_array[1].split("_");
	  
	
    var START_DATE_PICKER_array=$("#START_DATE_PICKER").val().split("/");
    var END_DATE_PICKER_array=$("#END_DATE_PICKER").val().split("/");
    var start_date=START_DATE_PICKER_array[0]+"_"+START_DATE_PICKER_array[1]+"_"+START_DATE_PICKER_array[2];
    var end_date=END_DATE_PICKER_array[0]+"_"+END_DATE_PICKER_array[1]+"_"+END_DATE_PICKER_array[2];
    var btdl_owner=dep_select_array[0];
    var type_id=dep_select_id_array[0]; 
    var BDEPT_ID=dep_select_id_array[1];
   
    //<option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
	var src = "report/exportReport4/"+start_date+"/"+end_date+"/"+btdl_owner+"/"+type_id+"/"+BDEPT_ID;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
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
	    					<span><strong>รายงาน SLA</strong></span>
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
								<td> <span style="padding-left: 20px;font-size: 13px;">Start Date</span> 
									<span style="padding: 5px;">
										<input id="START_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 <span style="padding-left: 20px;font-size: 13px;">End Date</span> 
									<span style="padding: 5px;">
										<input id="END_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
								  <span style="padding-left: 20px;font-size: 13px;">แผนก/ศูนย์</span> 
								<span id="dept_element" style="padding: 5px;">
								<%-- 
								<select style="width:150px" id="dep_select_id"> 
										 <option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
										 <option value="siwaporn,1_5">ฝ่าย IT ภูมิภาค</option>
										 <option value="maytazzawan,1_8">ฝ่ายขนส่ง กทม ปริฯ</option>
										 <option value="regent_admin,1_9">ฝ่ายขนส่ง ภูมิภาค</option>  
										 <option value="satsin,2_119">ศูนย์ เชียงใหม่</option> 
										 <option value="thienchai,2_115">ศูนย์ นครสวรรค์</option> 
										 <option value="narong,2_112">ศูนย์ อุบลราชธานี</option> 
										 <option value="suranop,2_110">ศูนย์ นครราชสีมา</option> 
										 <option value="wirat,2_118">ศูนย์ สุราษฎร์ธานี</option> 
										 <option value="jirawat,2_116">ศูนย์ ภูเก็ต</option> 
										 <option value="somluk,2_109">ศูนย์ พิษณุโลก</option> 
										 <option value="methee,2_114">ศูนย์ ขอนแก่น</option> 
										 <option value="wiroj,2_117">ศูนย์ ระยอง</option> 
										 <option value="paitoon,2_113">ศูนย์ สงขลา</option> 
										 </select>
										 --%>
										 </span> 
										 <span id="viewReport_element" style="padding-left: 10px;">
										 <%-- 
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
									   --%>
										</span>
										 <span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport4()">&nbsp;Export&nbsp;</a>
									    
										</span>
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	    					</td>
	    					</tr>
	    					
	    					</tbody></table>   <div  id="search_section"> 
    						</div>
      </div>
      </fieldset> 