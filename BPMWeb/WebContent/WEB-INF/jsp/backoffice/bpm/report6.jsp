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
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val();
	     if(START_DATE_PICKER_values.length>0 && END_DATE_PICKER_values.length>0){
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	    	/*
	    	 var query="SELECT  DATE_FORMAT(sv.BSJ_CREATED_TIME,'%d/%m/%Y'), "+
	    	 "  ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 "  "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	  ) as job_all , "+ // 1
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no  "+ 
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_DEPT_ID=2) as st_1, "+ // 2
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no  "+ 
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_DEPT_ID=3) as st_2, "+// 3
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+   
	    	 " 	 and sv_inner.SBJ_DEPT_ID=4) as st_3 , "+// 4
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_DEPT_ID=5) as st_4 , "+// 5
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_DEPT_ID=1) as st_5, "+ // sc // 6
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 		 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_JOB_STATUS=2) as st_6  , "+ // sale 1 // 7
	    	 " 		 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_JOB_STATUS=3) as st_7 ,  "+ // sale 2 // 8
	    	 " 		 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59')  "+
	    	 " 	 and sv_inner.SBJ_JOB_STATUS=6) as st_8 ,  "+ // check docs // 9
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    	 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    	 " 	 where    "+
	    	 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    	 " 	 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59') and sv_inner.SBJ_JOB_STATUS=7  "+
	    	 " 	  ) as job_commplete ,  "+  // 10
	    	 " 	 ( SELECT COUNT(*) FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv_inner left join  "+
	    					 " 	 "+SCHEMA_G+".BPM_CALL_CENTER call_center_inner on sv_inner.bcc_no=call_center_inner.bcc_no   "+
	    					 " 	 where    "+
	    					 " 	  sv_inner.BSJ_CREATED_TIME between DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00') and  "+
	    					 " 		 DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 23:59:59') and sv_inner.SBJ_JOB_STATUS!=7  "+
	    					 " 		  ) as job_not_commplete  "+  // 11
	    					 " 	   FROM "+SCHEMA_G+".BPM_SERVICE_JOB sv left join  "+
	    					 " 		 "+SCHEMA_G+".BPM_CALL_CENTER call_center on sv.bcc_no=call_center.bcc_no "+ 
	    					 " 		 where  sv.BSJ_CREATED_TIME between '"+START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0]+" 00:00:00' and '"+END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0]+" 23:59:59' "+ 
	    			" group by DATE_FORMAT(sv.BSJ_CREATED_TIME,'%Y-%m-%d 00:00:00')  ";
      */
	    	 var start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 var end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	    	   SynDomeBPMAjax.getReportDeptStatus(start_date,end_date,{  
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
					        "  		<th width=\"7%\"><div class=\"th_class\">วันที่</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">Job ทั้งหมด</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">เสร็จ/ไม่เสร็จ</div></th> "+   
					        "  		<th width=\"5%\"><div class=\"th_class\">รับเครื่อง/เช็คไซต์ [IT กทม ปริฯ]</div></th> "+ 
					        "  		<th width=\"5%\"><div class=\"th_class\">รับเครื่อง/เช็คไซต์ [IT ภูมิภาค]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ขนส่ง กทม ปริฯ</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ขนส่ง ภูมิภาค</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">ซ่อม [SC]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">เสนอราคา [Sale]</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">รออนุมัติซ่อม [Sale]</div></th> "+   
					        "  		<th width=\"5%\"><div class=\"th_class\">ตรวจสอบเอกสาร [AdminCenter]</div></th> "+ 
					        " 		</tr>"+
					        "	</thead>"+
					        "	<tbody>   ";  
							 
							   if(data!=null && data.length>0){
								   var job_all=0;
								   var job_complete=0;
								   var job_not_complete=0;
								   var job_1=0;
								   var job_2=0;
								   var job_3=0;
								   var job_4=0;
								   var job_5=0;
								   var job_6=0;
								   var job_7=0;
								   var job_8=0;
								   
								   var job_all_str="";
								   var job_complete_str="";
								   var job_not_complete_str="";
								   var job_1_str="";
								   var job_2_str="";
								   var job_3_str="";
								   var job_4_str="";
								   var job_5_str="";
								   var job_6_str="";
								   var job_7_str="";
								   var job_8_str="";
								   
								   var job_all_str_sum="0";
								   var job_complete_str_sum="";
								   var job_not_complete_str_sum="";
								   var job_1_str_sum="";
								   var job_2_str_sum="";
								   var job_3_str_sum="";
								   var job_4_str_sum="";
								   var job_5_str_sum="";
								   var job_6_str_sum="";
								   var job_7_str_sum="";
								   var job_8_str_sum="";
								   for(var i=0;i<data.length;i++){ 
									   job_all=job_all+data[i][1];
									   job_complete=job_complete+data[i][10];
									   job_not_complete=job_not_complete+data[i][11];
									   job_1=job_1+data[i][2];
									   job_2=job_2+data[i][3];
									   job_3=job_3+data[i][4];
									   job_4=job_4+data[i][5];
									   job_5=job_5+data[i][6];
									   job_6=job_6+data[i][7];
									   job_7=job_7+data[i][8];
									   job_8=job_8+data[i][9];
									   
									   job_all_str=data[i][1];
									   job_complete_str=data[i][10];
									   job_not_complete_str=data[i][11];
									   job_1_str=data[i][2];
									   job_2_str=data[i][3];
									   job_3_str=data[i][4];
									   job_4_str=data[i][5];
									   job_5_str=data[i][6];
									   job_6_str=data[i][7];
									   job_7_str=data[i][8];
									   job_8_str=data[i][9];
									   //function showPopupDetail(created_time,SBJ_DEPT_ID,SBJ_JOB_STATUS){
									   if(data[i][1]>0)
										   job_all_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','')\">"+data[i][1]+"</span>";
										     
									   if(data[i][10]>0) 
										   job_complete_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','SBJ_JOB_STATUS=7')\">"+data[i][10]+"</span>";
										
									   if(data[i][11]>0)
										   job_not_complete_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','SBJ_JOB_STATUS!=7')\">"+data[i][11]+"</span>";
										    
							   	   if(data[i][2]>0)
										  job_1_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','SBJ_DEPT_ID=2','')\">"+data[i][2]+"</span>";
									if(data[i][3]>0)
										  job_2_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','SBJ_DEPT_ID=3','')\">"+data[i][3]+"</span>";
									if(data[i][4]>0)
										job_3_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','SBJ_DEPT_ID=4','')\">"+data[i][4]+"</span>";
								    if(data[i][5]>0)
										job_4_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','SBJ_DEPT_ID=5','')\">"+data[i][5]+"</span>";
									if(data[i][6]>0)
										job_5_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','SBJ_DEPT_ID=1','')\">"+data[i][6]+"</span>";
									if(data[i][7]>0)
										job_6_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','SBJ_JOB_STATUS=2')\">"+data[i][7]+"</span>";
									if(data[i][8]>0)
										job_7_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','SBJ_JOB_STATUS=3')\">"+data[i][8]+"</span>";
									if(data[i][9]>0)
										job_8_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+data[i][12]+"','','SBJ_JOB_STATUS=6')\">"+data[i][9]+"</span>";
																		  
									str=str+ "  	<tr >"+ 
								       "  <td style=\"text-align: center;\"><span> "+data[i][0]+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: center;\">"+job_all_str+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+job_complete_str+"/"+job_not_complete_str+"</td>"+    
										   "  		<td style=\"text-align: center;\">"+job_1_str+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+job_2_str+ "</td>"+    
										   "  		<td style=\"text-align: center;\">"+job_3_str+"</td>"+  
									        "    	<td style=\"text-align: center;\">"+job_4_str+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+job_5_str+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+job_6_str+"</td>  "+
									        "    	<td style=\"text-align: center;\">"+job_7_str+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+job_8_str+"</td>  "; 
									        str=str+ "  	</tr>  "; 
								   }
								   if(job_all>0)
									   job_all_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','')\">"+$.formatNumber(job_all+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_not_complete>0)
										job_not_complete_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','SBJ_JOB_STATUS!=7')\">"+$.formatNumber(job_not_complete+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_complete>0)
										job_complete_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','SBJ_JOB_STATUS=7')\">"+$.formatNumber(job_complete+"", {format:"#,###.##", locale:"us"})+"</span>";
										
									if(job_1>0)
										job_1_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('SBJ_DEPT_ID=2','')\">"+$.formatNumber(job_1+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_2>0)
										job_2_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('SBJ_DEPT_ID=3','')\">"+$.formatNumber(job_2+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_3>0)
										job_3_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('SBJ_DEPT_ID=4','')\">"+$.formatNumber(job_3+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_4>0)
										job_4_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('SBJ_DEPT_ID=5','')\">"+$.formatNumber(job_4+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_5>0)
										job_5_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('SBJ_DEPT_ID=1','')\">"+$.formatNumber(job_5+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_6>0)
										job_6_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','SBJ_JOB_STATUS=2')\">"+$.formatNumber(job_6+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_7>0)
										job_7_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','SBJ_JOB_STATUS=3')\">"+$.formatNumber(job_7+"", {format:"#,###.##", locale:"us"})+"</span>";
									if(job_8>0)
										job_8_str_sum="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('','SBJ_JOB_STATUS=6')\">"+$.formatNumber(job_7+"", {format:"#,###.##", locale:"us"})+"</span>";
																		   
									   str=str+ "   		<tr> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">รวม</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_all_str_sum+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_complete_str_sum+"/"+job_not_complete_str_sum+"</div></th> "+   
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_1_str_sum+"</div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_2_str_sum+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_3_str_sum+"</div></th> "+  
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_4_str_sum+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_5_str_sum+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_6_str_sum+"</div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_7_str_sum+"</div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+job_8_str_sum+"</div></th> "+  
							        " 		</tr>";
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
							$("#search_section").html(str);
						}
					});

	     }else{
	    	 alert("กรุณาใส่เวลา.");
	    	 $("#search_section").html("");
	     }
	    
} 
function showPopupDetail_sum( SBJ_DEPT_ID,SBJ_JOB_STATUS){
	   var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	   var created_time_start= START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	   var created_time_end=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	   showPopupDetail(created_time_start+"_"+created_time_end,SBJ_DEPT_ID,SBJ_JOB_STATUS);
}
//sv.SBJ_JOB_STATUS=2
//sv.SBJ_DEPT_ID=5
function showPopupDetail(created_time,SBJ_DEPT_ID,SBJ_JOB_STATUS){
	var created_time_array=created_time.split("_");
	var created_time_start=created_time_array[0];
	var created_time_end=created_time_array[1];
	//alert(created_time_start)
	var query_dept="";
	var query_status="";
	if(SBJ_DEPT_ID!=''){
		//query_dept=" and   sv.SBJ_DEPT_ID="+SBJ_DEPT_ID;
		query_dept=" and   sv."+SBJ_DEPT_ID;
	}
	if(SBJ_JOB_STATUS!=''){
		//query_status=" and  sv.SBJ_JOB_STATUS="+SBJ_JOB_STATUS
		query_status=" and  sv."+SBJ_JOB_STATUS;
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

	 	//" from "+SCHEMA_G+".BPM_TO_DO_LIST todo_list  left join  "+
	 	" from "+SCHEMA_G+".BPM_SERVICE_JOB sv  "+
	 	" left join "+SCHEMA_G+".BPM_CALL_CENTER call_center on call_center.bcc_no=sv.bcc_no  "+
	 	" where    sv.BSJ_CREATED_TIME between '"+created_time_start+" 00:00:00' and '"+created_time_end+" 23:59:59'  "+
	 	//" and todo_list.btdl_owner='"+btdl_owner+"' "+
	 	query_status+query_dept+
	 //	" and todo_list.btdl_hide='1' "+query_dept;
	    " order by  call_center.BCC_CREATED_TIME desc limit 100 ";
	 
	//  alert(query)   
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
function exportReport6(){   
	  var START_DATE_PICKER_array=$("#START_DATE_PICKER").val().split("/");
	    var END_DATE_PICKER_array=$("#END_DATE_PICKER").val().split("/");
	    var start_date=START_DATE_PICKER_array[0]+"_"+START_DATE_PICKER_array[1]+"_"+START_DATE_PICKER_array[2];
	    var end_date=END_DATE_PICKER_array[0]+"_"+END_DATE_PICKER_array[1]+"_"+END_DATE_PICKER_array[2]; 
	var src = "report/exportReport6/"+start_date+"/"+end_date;
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
	    					<span><strong>รายงาน สถานะงานตามแผนก</strong></span>
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
										<input id="START_DATE_PICKER" value="${time}"  readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 <span style="padding-left: 20px;font-size: 13px;">End Date</span> 
									<span style="padding: 5px;">
										<input id="END_DATE_PICKER" value="${time}"  readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
										</span>
									 <span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport6()">&nbsp;Export&nbsp;</a>
									    
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
	    					
	    					</tbody></table>  
	    					<div  id="search_section"> 
    						</div>
      </div>
      </fieldset>