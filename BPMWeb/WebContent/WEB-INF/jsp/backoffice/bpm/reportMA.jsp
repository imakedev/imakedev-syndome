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
  var viewSelect=$("#viewSelect").val();
  var title=""; 
  if(viewSelect=='1')
	  title="จังหวัด";
  if(viewSelect=='2')
	  title="ลูกค้า";
  if(viewSelect=='3')
	  title="รุ่น";
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	    
	    	 var start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 var end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	    var query="SELECT u.id,concat(bc_name,'[', u.firstName,' ',u.lastName,']') FROM "+SCHEMA_G+".BPM_CENTER center left join "+SCHEMA_G+".user u "+ 
	    	" on center.uid=u.id  ";
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
					var str_column="";
					   var data_size=0;
					   var sum_array=[];
					   var center_array=[];
					 if(data!=null && data.length>0){
						     data_size=data.length;   
						   for(var i=0;i<data_size;i++){ 
							   str_column=str_column+"<th width=\"10%\"><div class=\"th_class\">"+data[i][1]+"</div></th>"; 
							   sum_array[i]=0;
							   center_array[i]=data[i][0];
						   }
					 }
					  SynDomeBPMAjax.getReportPMMA(start_date,end_date,viewSelect,{
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
							        "  		<th width=\"10%\"><div class=\"th_class\">"+title+"</div></th> "+
							        "  		<th width=\"7%\"><div class=\"th_class\">วันที่นัดหมาย</div></th> "+
							        str_column+    
							        " 		</tr>"+
							        "	</thead>"+
							        "	<tbody>   ";
							        
									 var name_compare="";
									 var sum=0;
									 var sum_all=0;
									 var name_show="";
									 
									   if(data!=null && data.length>0){
										   var  size=data.length; 
										 
										   for(var i=0;i<size;i++){ 
											   name_show=data[i][0]; 
											   if(name_compare==data[i][0]){
												   name_show=""; 
											   }  
											   var created_time=data[i][data_size+2];
											   str=str+ "  	<tr >"+
										       "  <td style=\"text-align: center;\"><span> "+name_show+"</span></td>"+
												   "  <td style=\"text-align: center;\">"+data[i][1]+"</td>";   
												 for(var j=0;j<data_size;j++){
													 var onclick_str=$.formatNumber(data[i][j+2]+"", {format:"#,###.##", locale:"us"});
													 if(data[i][j+2]>0)
														 onclick_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail('"+created_time+"','"+viewSelect+"','"+data[i][0]+"','"+center_array[j]+"')\">"+$.formatNumber(data[i][j+2]+"", {format:"#,###.##", locale:"us"})+"</span>";
													 str=str+ "<td style=\"text-align: center;\">"+onclick_str+"</td>";
													 sum_array[j]=sum_array[j]+data[i][j+2];
													// alert(data[i][j+2])
												 } 
												 str=str+ " </tr>  "; 
												  name_compare=data[i][0];
										   }
										   str=str+ "   		<tr> "+
									        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\"></div></th> "+
									        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">รวม</div></th> ";
									        for(var j=0;j<data_size;j++){
									        	
									        	 var onclick_sum_str=$.formatNumber(sum_array[j]+"", {format:"#,###.##", locale:"us"});
												 if(sum_array[j]>0)
													 onclick_sum_str="<span style=\"text-decoration: underline;cursor: pointer;\" onclick=\"showPopupDetail_sum('"+center_array[j]+"')\">"+$.formatNumber(sum_array[j]+"", {format:"#,###.##", locale:"us"})+"</span>";
												
									        	str=str+ " <th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+onclick_sum_str+"</div></th> ";
									        }
									       
									        str=str+ " </tr>";
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
				}
			});
	    	  
}

function showPopupDetail_sum(bpmj_center){
	   var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val(); 
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/");
	   var created_time_start= START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	   var created_time_end=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	   var created_time=created_time_start+"_"+created_time_end;
	   showPopupDetail(created_time,'','',bpmj_center);
}

function showPopupDetail(created_time,viewBySelect,viewByValue,bpmj_center){
	var created_time_array=created_time.split("_");
	var created_time_start=created_time_array[0];
	var created_time_end=created_time_array[1];
	var viewByWhere="";  
	 if(viewBySelect=='1')
		 viewByWhere=" and so.BSO_INSTALLATION_PROVINCE='"+viewByValue+"'";
	  if(viewBySelect=='2')
		  viewByWhere=" and pmma.BPMJ_CUST_NAME='"+viewByValue+"'";
	  if(viewBySelect=='3')
		  viewByWhere=" and pmma.BPMJ_UPS_MODEL='"+viewByValue+"'";
	
	var query=" select  ifnull(pmma.bpmj_so_no,'') as c0,ifnull(pmma.bpmj_serail,'') as c1, ifnull(pmma.bpmj_ups_model,'') as c2"+ 
		 " , concat(ifnull(pmma.bpmj_cust_name,''),' ',ifnull(pmma.bpmj_contact_name,''),' ', "+
			"	 ifnull(pmma.bpmj_addr1,''),' ',ifnull(pmma.bpmj_addr2,''),' ',ifnull(pmma.bpmj_addr3,''), "+
			"	 ' ',ifnull(pmma.bpmj_province,''),' ',ifnull(pmma.bpmj_zipcode,''),' ',ifnull(pmma.bpmj_tel_fax,'')) as c3 "+
			"	 ,IFNULL(DATE_FORMAT(pmma.bpmj_duedate,'%d/%m/%Y'),'')  as c4 ,pmma.bpmj_order  as c5, "+
			"	 (select count(*) from "+SCHEMA_G+".BPM_PM_MA_JOB pmma_inner where pmma_inner.bpmj_no=pmma.bpmj_no and pmma_inner.bpmj_serail=pmma.bpmj_serail ) as c6"+
			"	 from "+SCHEMA_G+".BPM_PM_MA_JOB pmma  "+
			" left join "+SCHEMA_G+".BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+
			"	 where pmma.bpmj_job_status=1    "+
			"	 		   and pmma.BPMJ_DUEDATE   "+
			"	 		     	 between '"+created_time_start+" 00:00:00'  and '"+created_time_end+" 23:59:59'   "+
			viewByWhere+
			"	 		   and pmma.bpmj_center='"+bpmj_center+"' order by   pmma.BPMJ_DUEDATE" ;

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
			       // "  		<th width=\"7%\"><div class=\"th_class\">เลขที่ Job</div></th> "+
			        "  		<th width=\"15%\"><div class=\"th_class\">หมายเลขเครื่อง/Model</div></th> "+ 
			        "  		<th width=\"68%\"><div class=\"th_class\">ชื่อลูกค้า/ที่อยู่</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+  
			        "  		<th width=\"10%\"><div class=\"th_class\">ครั้งที่ PM/MA</div></th> "+  
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){  
				       str=str+ "  	<tr style=\"cursor: pointer;\">"+  
						  // "  		<td style=\"text-align: left;\">"+data[i][0]+"</span></td>"+     
						   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
					        "    	<td style=\"text-align: left;\">"+data[i][3]+"</td>  "+  
					        "    	<td style=\"text-align: left;\">"+data[i][4]+"</td>  "+
					        "  		<td style=\"text-align: center;\">"+data[i][5]+"/"+data[i][6]+"</span></td>"+
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
function exportReportMA(){   
	var START_DATE_PICKER_array=$("#START_DATE_PICKER").val().split("/");
	var END_DATE_PICKER_array=$("#END_DATE_PICKER").val().split("/");
	var start_date=START_DATE_PICKER_array[0]+"_"+START_DATE_PICKER_array[1]+"_"+START_DATE_PICKER_array[2];
	var end_date=END_DATE_PICKER_array[0]+"_"+END_DATE_PICKER_array[1]+"_"+END_DATE_PICKER_array[2]; 
	    
	var viewSelect=$("#viewSelect").val();
	var viewJobSelect=$("#viewJobSelect").val();
	var src = "report/exportReportMA/"+start_date+"/"+end_date+"/"+viewSelect+"/"+viewJobSelect;
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
	    					<span><strong>รายงาน แจ้งซ่อม MA</strong></span>
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
									 <span style="padding-left:20px"> 
	 									 แยกตามลูกค้า : 
	 									 <select name="viewSelect" style="width:200px" id="viewSelect"> 
	 									 	<option value="ALL">ALL</option>
	 									 	<option value="0">นอกประกัน</option>
	 									 	<option value="1">ในประกัน</option>
	 									 	<option value="2">ในประกัน MA</option>
	 									 </select>
	 								  </span> 
	 								  
	 								  <span style="padding-left:20px"> 
	 									 ประเภทงาน : 
	 									 <select name="viewJobSelect" style="width:200px" id="viewJobSelect"> 
	 									 	<option value="ALL">ALL</option>
	 									 	<option value="PENDING">งานค้าง</option>
	 									 </select>
	 								  </span>
									<!-- <span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
										</span>  -->
										<span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReportMA()">&nbsp;Export&nbsp;</a>
									    
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