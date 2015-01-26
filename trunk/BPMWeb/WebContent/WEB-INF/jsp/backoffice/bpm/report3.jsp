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
	/*
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
	  */
	viewReport('1');
});
function viewReport(_page){
	var service_status='-1';//service_status_array[0];
	var service_type='-1';//service_status_array[1];
 	//$("#service_type").val(service_type);
	// alert(service_type);
	// checkWithSet("pageNo",_page);
	var _perpage='50';
//	var _page=$("#pageNo").val();
$("#pageNo").val(_page);
	var dep_select_values=$("#dep_select_id").val().split(",");
	if(dep_select_values[1]=='1'){
		var query=" SELECT role_type.bpm_role_type_id,role_type.bpm_role_type_name FROM "+SCHEMA_G+".BPM_ROLE_MAPPING mapping left join "+
		 SCHEMA_G+".BPM_ROLE_TYPE role_type on role_type.BPM_ROLE_TYPE_ID=mapping.BPM_ROLE_TYPE_ID "+
		" where mapping.BPM_ROLE_ID=(select bpm_role_id from "+SCHEMA_G+".user u where u.username='"+dep_select_values[0]+"') "; 
		 
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
			var roles="";
			if(data!=null && data.length>0){
				//alert(data[0][1])
				var sql_inner="("; 
				   for(var i=0;i<data.length;i++){
					   sql_inner=sql_inner+"'"+data[i][1]+"'";
					   if(i!=(data.length-1)){
						   sql_inner=sql_inner+",";
					   }
				   }
				   sql_inner=sql_inner+")"; 
				   roles=sql_inner;
			}
			 
			renderAllServices(service_type,service_status,dep_select_values[0],roles,_perpage,_page)
		}
	});
	}else{
		//alert(dep_select_values[0])
		renderAllServices(service_type,service_status,dep_select_values[0],"('"+dep_select_values[0]+"')",_perpage,_page)
	}
}
 
function renderAllServices(service_type,service_status,username,roles,_perpageG,_page){ 
var key_job='';//jQuery.trim($("#key_job").val().replace(/'/g,"''"));
//alert(key_job)
var isStore="0";
var load_str="<fieldset style=\"font-family: sans-serif;padding-top:5px\">"+    
"<div style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 10px\"> <img src='${url}resources/images/loading.gif' /></div></fieldset>";
$("#search_section").html(load_str);
var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
SynDomeBPMAjax.searchTodoList(service_type,service_status,username,roles,_page+"",_perpageG+"",isStore,"1",key_job,'',{ 
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
        "  		<th width=\"3%\"><div class=\"th_class\">#</div></th> "+
        "  		<th width=\"7%\"><div class=\"th_class\">เลขที่เอกสาร</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">สถานะงาน</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">Service Type</div></th> "+   
        "  		<th width=\"5%\"><div class=\"th_class\">State</div></th> "+ 
        "  		<th width=\"12%\"><div class=\"th_class\">หมายเลขเครื่อง/Model</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">อาการเสีย</div></th> "+  
        "  		<th width=\"16%\"><div class=\"th_class\">สถานที่</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">ผู้ติดต่อ</div></th> "+
        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+ 
        "  		<th width=\"5%\"><div class=\"th_class\">วันที่เปิดเอกสาร</div></th> "+ 
        "  		<th width=\"3%\"><div class=\"th_class\">Requestor</div></th> "+  
        "  		<th width=\"5%\"><div class=\"th_class\">จำนวนวันค้าง</div></th> "+  
        /*
        "  		<th width=\"5%\"><div class=\"th_class\">SLA Standard</div></th> "+
        "  		<th width=\"5%\"><div class=\"th_class\">SLA Limit</div></th> "+ 
       
        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
        */
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
			       "  <td> <span style=\"text-align: left;cursor: pointer;\">"+$.formatNumber((limitRow+i+1)+"", {format:"#,###.##", locale:"us"})+"</span></td>"+
			       "  <td> <span style=\"text-align: left;cursor: pointer;\">"+data[i][0]+"</span>";
			        	  
			           str=str+ " </td>"+
					   "  		<td style=\"text-align: left;\">"+data[i][46]+"</td>"+   
					   "  		<td style=\"text-align: center;\">"+data[i][30]+"</td>"+    
					   "  		<td style=\"text-align: center;\">"+data[i][48]+"</td>"+   
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
				         "    	<td style=\"text-align: left;\">"+data[i][50]+"</td>  ";
				       // "    	<td style=\"text-align: left;\">"+data[i][43]+" </td>  "+ 
				      //  "    	<td style=\"text-align: left;\">"+data[i][44]+" </td>  "+  
				       // "    	<td style=\"text-align: center;\">"; 
				        
				       	//</td> "+
				        str=str+ "  	</tr>  "; 
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
		$("#search_section").html(str);
	}
}); 
//alert(service_type+","+usernameG+","+rolesG+","+_page+","+_perpageG+","+isStore)
SynDomeBPMAjax.searchTodoList(service_type,service_status,username,roles,_page+"",_perpageG+"",isStore,"2",key_job,'',{
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
		 
		var total_str="";
		if(data!=null && data.length>0)
			total_str="งานค้าง "+$.formatNumber(data+"", {format:"#,###.##", locale:"us"})+" jobs";
		 $("#total_record").html(total_str);
		var pageCount=calculatePage(_perpageG,data);
		checkWithSet("pageCount",pageCount);
		//$("#pageCount").val(pageCount);
		renderPageSelect();
	}
});
} 
function exportReport3(){   
	var dep_select_values=$("#dep_select_id").val().split(",");
  //<option value="sommai,1_4">ฝ่าย IT กทม ปริฯ</option> 
	var src = "report/exportReport3/"+dep_select_values[1]+"/"+dep_select_values[0];
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
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
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	$("#pageNo").val($("#pageSelect").val());
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	getTodolist($("#pageNo").val())
}
function getTodolist(_page){   
	/*
	var service_status_array=$("#service_status").val();
	service_status_array=service_status_array.split(",");
	*/
	var service_status='-1';//service_status_array[0];
	var service_type='-1';//service_status_array[1];
 	$("#service_type").val(service_type);
	// alert(service_type);
	checkWithSet("pageNo",_page);
	viewReport(_page);
	//renderAllServices(service_type,service_status,username,roles,_perpageG,_page);
	 //renderAllServices(service_type,service_status,_page);
	 
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
	$("#pageSelect").val($("#pageNo").val());
	//document.getElementById("pageSelect").value=$("#pageNo").val();
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
	    					<span><strong>รายงาน คงค้าง</strong></span>
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
								<td width="70%"> 
								   <span style="padding-left: 20px;font-size: 13px;">แผนก</span> 
									<span style="padding: 5px;">
									<select style="width:150px" id="dep_select_id"> 
										 <option value="sommai,1">ฝ่าย IT กทม ปริฯ</option> 
										 <option value="siwaporn,1">ฝ่าย IT ภูมิภาค</option>
										 <option value="maytazzawan,1">ฝ่ายขนส่ง กทม ปริฯ</option>
										 <option value="regent_admin,1">ฝ่ายขนส่ง ภูมิภาค</option>
										 <option value="numfon,1">ฝ่าย SC</option>
										<!--  <option value="pmma_admin,1">ฝ่าย PM/MA</option> -->
										 <option value="ROLE_QUOTATION_ACCOUNT,2">Sale</option> 
										 </select>
									</span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport('1')">&nbsp;View&nbsp;</a>
										</span> 
										 <span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport3()">&nbsp;Export&nbsp;</a>
									    
										</span>
								</td> 
								<td  align="right" width="30%">
								<span id="total_record" style="margin-right:15px"></span>
								<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="pageSelect" id="pageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
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