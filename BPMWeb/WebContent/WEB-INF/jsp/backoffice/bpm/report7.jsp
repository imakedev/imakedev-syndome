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
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:500px}
 .modal.fade.in{top:1%}
 .aoe_small{width: 500px !important;margin-left:-250px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
</style>
 
<script>
$(document).ready(function() { 
	  $("#START_DATE_PICKER" ).datepicker({
			showOn: "button",
		//	minDate: new Date(2014, 5-1, 1),
		//	maxDate: new Date(2014, 5-1, 31),
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
	 
});
function viewReport(){ 
	 var load_str="<fieldset style=\"font-family: sans-serif;padding-top:5px\">"+    
	 "<div style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 10px\"> <img src='${url}resources/images/loading.gif' /></div></fieldset>";
$("#search_section").html(load_str);  
   var dep_select_array=$("#dep_select_id").val().split(",");
   var dep_select_id_array=dep_select_array[1].split("_");
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val();
	     if(START_DATE_PICKER_values.length>0 && END_DATE_PICKER_values.length>0){
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	    	 var BDEPT_ID_QUERY="  u.username= todo_list.btdl_owner";
	    	 if(dep_select_id_array[1]!='-1'){
	    		 BDEPT_ID_QUERY=" dept_user.BDEPT_ID="+dep_select_id_array[1]+" and u.username= todo_list.btdl_owner";
	    	 }
	    	 var query="select DATE_FORMAT(sv.BSJ_CREATED_TIME,'%d/%m/%Y'),todo_list.btdl_owner,count(*) , concat(user_outer.firstname,' ',user_outer.lastname) ,DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d') "+
	    	  " from "+SCHEMA_G+".BPM_TO_DO_LIST todo_list left join  "+
	    	  "  "+SCHEMA_G+".BPM_SERVICE_JOB sv  on( todo_list.BTDL_REF=sv.bcc_no and todo_list.btdl_type=2) "+ 
	    	  "  left join "+SCHEMA_G+".user user_outer on user_outer.username=todo_list.btdl_owner "+
	    	  " 	 where    sv.BSJ_CREATED_TIME between '"+START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0]+" 00:00:00' and '"+END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]+" 23:59:59'  "+ 
	    	
	    	  " and todo_list.btdl_hide='1'   and  exists (SELECT username FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+SCHEMA_G+".user u  "+
	    	  "  on dept_user.USER_ID=u.id where "+BDEPT_ID_QUERY+" "+
	    	 
	    	  ")    "+
	    	  "  group by todo_list.btdl_owner , DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00')  "+
	    		" order by btdl_owner, sv.BSJ_CREATED_TIME limit 1000 ";
	    		 
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
					        "  		<th width=\"10%\"><div class=\"th_class\">ผู้ปฏิบัติงาน</div></th> "+
					        "  		<th width=\"7%\"><div class=\"th_class\">วันที่</div></th> "+
					        "  		<th width=\"10%\"><div class=\"th_class\">จำนวนงานค้าง</div></th> "+    
					        " 		</tr>"+
					        "	</thead>"+
					        "	<tbody>   ";  
							 var name_compare="";
							 var sum=0;
							 var sum_all=0;
							 var name_show="";
							   if(data!=null && data.length>0){
								   var data_size=data.length; 
								   for(var i=0;i<data_size;i++){ 
									   name_show=data[i][3]+"     ["+data[i][1]+"]";
									   sum_all=sum_all+data[i][2];
									   sum=sum+data[i][2];
									   if(name_compare==data[i][1]){
										   name_show=""; 
										   
									   } 
									
									   if(name_compare!=data[i][1] && i!=0){
										   sum=sum-data[i][2];
									        str=str+"<tr>"+
										           "  <th><div class=\"th_class\"></div></th>"+
												   "  		<th style=\"text-align: left;background-color:#DCDF9C\"><div class=\"th_class\">รวม</div></th>"+    
												   "  		<th style=\"text-align: center;background-color:#DCDF9C\"><div class=\"th_class\"><span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('"+data[i-1][1]+"')\">"+sum+"</span></div></th>";
											        str=str+ "</tr>"; 
											 sum=0;
											 sum=sum+data[i][2];
									    }
										  
									   str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span>"+name_show+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: left;\">"+data[i][0]+"</td>"+    
										   "  		<td style=\"text-align: center;\"><span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][1]+"','"+data[i][4]+"','"+data[i][4]+"','')\">"+data[i][2]+"</span></td>";
									        str=str+ "  	</tr>  "; 
									        
									   if(i==data_size-1){
												 //  sum=sum-data[i][2];
											        str=str+"<tr>"+
												           "  <th><div class=\"th_class\"></div></th>"+
														   "  		<th style=\"text-align: left;background-color:#DCDF9C\"><div class=\"th_class\">รวม</div></th>"+    
														   "  		<th style=\"text-align: center;background-color:#DCDF9C\"><div class=\"th_class\"><span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('"+data[i][1]+"')\">"+sum+"</span></div></th>";
													        str=str+ "</tr>"; 
													        str=str+"<tr>"+
													           "  <th><div class=\"th_class\"></div></th>"+
															   "  		<th style=\"text-align: left;background-color:#DCDF9C\"><div class=\"th_class\">รวมทั้งหมด</div></th>"+    
															   "  		<th style=\"text-align: center;background-color:#DCDF9C\"><div class=\"th_class\"><span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sumAll()\">"+sum_all+"</span></div></th>";
														        str=str+ "</tr>"; 
													
										 }
											   name_compare=data[i][1];
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
function showPopupDetail_sumAll(){
	  var dep_select_array=$("#dep_select_id").val().split(",");
	   var dep_select_id_array=dep_select_array[1].split("_"); 
	  var dep_id=dep_select_id_array[1];
	var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
    var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
   	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
   	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
  var created_time_start= START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
  var created_time_end=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
  showPopupDetail('',created_time_start,created_time_end,dep_id);
}
function showPopupDetail_sum(btdl_owner){
	   var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	   var created_time_start= START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	   var created_time_end=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	   showPopupDetail(btdl_owner,created_time_start,created_time_end,'');
}
function showPopupDetail(btdl_owner,created_time_start,created_time_end,dept_id){
	var query_dept="";
	var query_owner="";
	var dept_id_query="  u.username= todo_list.btdl_owner";
	if(dept_id!='-1'){
		dept_id_query=" dept_user.BDEPT_ID="+dept_id+" and u.username= todo_list.btdl_owner ";
	}
	if(dept_id!=''){
		query_dept=" and  exists (SELECT username FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+SCHEMA_G+".user u  "+
		    	  "  on dept_user.USER_ID=u.id where "+dept_id_query+" "+
		    	//  " or todo_list.btdl_owner='"+dep_select_array[0]+"' "+
		    	  ")    ";
	}
	if(btdl_owner!=''){
		query_owner=" and todo_list.btdl_owner='"+btdl_owner+"' ";
	}
	var query=" SELECT "+
	  " call_center.BCC_NO as c0,"+
	  " IFNULL(call_center.BCC_SERIAL,'')  as c1,"+
	    " IFNULL(call_center.BCC_MODEL,'') as c2,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') as c3,"+
	    " IFNULL(call_center.BCC_TEL ,'') as c4 ,"+
	    " IFNULL(call_center.BCC_ADDR1 ,'') as c5,"+
	    " IFNULL(call_center.BCC_ADDR2 ,'') as c6,"+
	    " IFNULL(call_center.BCC_ADDR3 ,'') as c7,"+
	    " IFNULL(call_center.BCC_LOCATION ,'') as c8,"+
	    " IFNULL(call_center.BCC_PROVINCE ,'') as c9,"+
	    " IFNULL(call_center.BCC_ZIPCODE ,'') as c10,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c11 , "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') as c12 , "+
	 	 " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'')  as c13 "+  

	 	" from "+SCHEMA_G+".BPM_TO_DO_LIST todo_list  left join  "+
	 	" "+SCHEMA_G+".BPM_SERVICE_JOB sv on( todo_list.BTDL_REF=sv.bcc_no   and todo_list.btdl_type=2) "+
	 	" left join "+SCHEMA_G+".BPM_CALL_CENTER call_center on call_center.bcc_no=sv.bcc_no  "+
	 	" where    sv.BSJ_CREATED_TIME between '"+created_time_start+" 00:00:00' and '"+created_time_end+" 23:59:59'  "+
	 	//" and todo_list.btdl_owner='"+btdl_owner+"' "+
	 	query_owner+
	 	" and todo_list.btdl_hide='1' "+query_dept;
	    "order by  call_center.BCC_CREATED_TIME desc ";
	 
	 // alert(query)   
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px;\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"7%\"><div class=\"th_class\">เลขที่ Job</div></th> "+
			        "  		<th width=\"15%\"><div class=\"th_class\">หมายเลขเครื่อง/Model</div></th> "+ 
			        "  		<th width=\"68%\"><div class=\"th_class\">ชื่อลูกค้า/ที่อยู่</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+  
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){  
				       str=str+ "  	<tr style=\"cursor: pointer;\">"+  
						   "  		<td style=\"text-align: left;\">"+data[i][0]+"</span></td>"+     
						   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
					        "    	<td style=\"text-align: left;\">"+data[i][8]+" "+data[i][5]+" "+data[i][6]+" "+data[i][7]+" "+data[i][9]+" "+data[i][10]+" "+data[i][3]+" "+data[i][4]+"</td>  "+  
					        "    	<td style=\"text-align: left;\">"+data[i][11]+" "+data[i][12]+"-"+data[i][13]+"</td>  "+
					        "  	</tr>  ";
				   }
			   }else{
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
					   bootbox.classes("aoe_width");
					   bootbox.dialog(str,[{
						    "label" : "Cancel",
						     "class" : "btn-danger"
						    //	"class" : "class-with-width"
					 }]);
		 
		}
	});  
}
function exportReport7(){   
	  var START_DATE_PICKER_array=$("#START_DATE_PICKER").val().split("/");
	    var END_DATE_PICKER_array=$("#END_DATE_PICKER").val().split("/");
	    var start_date=START_DATE_PICKER_array[0]+"_"+START_DATE_PICKER_array[1]+"_"+START_DATE_PICKER_array[2];
	    var end_date=END_DATE_PICKER_array[0]+"_"+END_DATE_PICKER_array[1]+"_"+END_DATE_PICKER_array[2]; 
	    
	    var dep_select_array=$("#dep_select_id").val().split(",");
		   var dep_select_id_array=dep_select_array[1].split("_"); 
		 // var dep_id=dep_select_id_array[1];
		  var _username=dep_select_array[0];
		  var _deptType=dep_select_id_array[0];
		  var _deptId=dep_select_id_array[1];
		<%--	
		 <option value="-1,-1_-1"> ALL </option> 
										 <option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
										 <option value="siwaporn,1_5">ฝ่าย IT ภูมิภาค</option>
										 <option value="maytazzawan,5_8">ฝ่ายขนส่ง กทม ปริฯ</option>
										 <option value="regent_admin,5_9">ฝ่ายขนส่ง ภูมิภาค</option>
										 <option value="numfon,4_3">ฝ่าย SC</option> 
										  --%> 
	var src = "report/exportReport7/"+start_date+"/"+end_date+"/"+_username+"/"+_deptType+"/"+_deptId;
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
	    					<span><strong>รายงาน สถานะงานตาม Line Operation</strong></span>
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
									<span style="padding-left: 20px;font-size: 13px;">Start Date</span> 
									<span style="padding: 5px;">
										<input id="START_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 <span style="padding-left: 20px;font-size: 13px;">End Date</span> 
									<span style="padding: 5px;">
										<input id="END_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									  <span style="padding-left: 20px;font-size: 13px;">แผนก</span> 
								<span style="padding: 5px;">
								<select style="width:150px" id="dep_select_id"> 
										 <option value="-1,-1_-1"> ALL </option> 
										 <option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
										 <option value="siwaporn,1_5">ฝ่าย IT ภูมิภาค</option>
										 <option value="maytazzawan,5_8">ฝ่ายขนส่ง กทม ปริฯ</option>
										 <option value="regent_admin,5_9">ฝ่ายขนส่ง ภูมิภาค</option>
										 <option value="numfon,4_3">ฝ่าย SC</option> 
										 </select>
										 </span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
										</span>
										 <span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport7()">&nbsp;Export&nbsp;</a>
									    
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
	    					
	    					</tbody></table>  <div  id="search_section"> 
    						</div>
      </div>
      </fieldset> 