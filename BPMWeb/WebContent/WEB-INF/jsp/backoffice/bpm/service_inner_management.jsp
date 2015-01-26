<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
table > thead > tr > th
{
background	:#e5e5e5;
}
/*   .ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
.ui-timepicker-div dl { text-align: left; }
.ui-timepicker-div dl dt { float: left; clear:left; padding: 0 0 0 5px; }
.ui-timepicker-div dl dd { margin: 0 10px 10px 40%; }
.ui-timepicker-div td { font-size: 90%; }
.ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }

.ui-timepicker-rtl{ direction: rtl; }
.ui-timepicker-rtl dl { text-align: right; padding: 0 5px 0 0; }
.ui-timepicker-rtl dl dt{ float: right; clear: right; }
.ui-timepicker-rtl dl dd { margin: 0 40% 10px 10px; }   */
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 var usernameG='${username}';
   getInnerServices(); 
   autoProvince("BISJ_PROVINCE")
   $("#BISJ_DELIVERY_DUEDATE" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
  
  
	 
	 $('#BISJ_DELIVERY_DUEDATE_TIME').timepicker({
		    showPeriodLabels: false
	 });
		  
}); 
function getInnerServices(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	//$("#delivery_install_title").html("Sale Order ("+function_message+")");
//	$("#delivery_install_title").html("Sale Order ");
  if(isEdit){  
	  var query=" SELECT "+
	    " service_job.BISJ_NO as c0,"+
	    " IFNULL(service_job.BISJ_IS_INSTALLATION,'') as c1,"+
	    " IFNULL(service_job.BISJ_IS_SERWAY_SITE,'') as c2,"+
	    " IFNULL(service_job.BISJ_IS_SEND_UPS,'') as c3,"+
	    " IFNULL(service_job.BISJ_IS_EXT,'') as c4,"+
	    " IFNULL(service_job.BISJ_EXT,'') as c5,"+
	    " IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE,'%d/%m/%Y'),'') as c6,"+
	    " IFNULL(DATE_FORMAT(service_job.BISJ_DELIVERY_DUEDATE_TIME,'%H:%i'),'') as c7,"+
	 //   " IFNULL(service_job.BISJ_DELIVERY_DUEDATE,'') as c6,"+
	 //   " IFNULL(service_job.BISJ_DELIVERY_DUEDATE_TIME,'') as c7,"+
	    " IFNULL(service_job.BISJ_CONTACT,'') as c8,"+
	    " IFNULL(service_job.BISJ_INSTALLATION_LOCATION,'') as c9,"+
	    " IFNULL(service_job.BISJ_ADDR1,'') as c10,"+
	    " IFNULL(service_job.BISJ_ADDR2,'') as c11,"+
	    " IFNULL(service_job.BISJ_ADDR3,'') as c12,"+
	    " IFNULL(service_job.BISJ_PROVINCE,'') as c13,"+
	    " IFNULL(service_job.BISJ_ZIPCODE,'') as c14,"+
	    " IFNULL(service_job.BISJ_TEL_FAX,'') as c15,"+
	    " IFNULL(service_job.BISJ_REMARK,'') as c16,"+ 
	    " IFNULL(DATE_FORMAT(service_job.BISJ_CREATED_DATE,'%Y/%m/%d'),'') as c17,"+
	    " IFNULL(service_job.BISJ_CODE_NO,'') as c18,"+
	    " IFNULL(service_job.BISJ_SALE_ORDER_NO,'') as c19,"+
	    " IFNULL(service_job.BISJ_IS_WARRANTY,'') as c20,"+
	    " IFNULL(service_job.BISJ_WARRANTY,'') as c21,"+
	    " IFNULL(service_job.BISJ_IS_PM_MA,'') as c22,"+
	    " IFNULL(service_job.BISJ_PM_MA,'') as c23,"+
	    " IFNULL(service_job.BISJ_IS_OPTION,'') as c24,"+
	    " IFNULL(service_job.BISJ_IS_BATTERY,'') as c25,"+
	    " IFNULL(service_job.BISJ_BATTERY_AMOUNT,'') as c26,"+
	    " IFNULL(service_job.BISJ_IS_CABLE,'') as c27,"+
	    " IFNULL(service_job.BISJ_IS_EXT_OPTION,'') as c28,"+
	    " IFNULL(service_job.BISJ_EXT_OPTION,'') as c29,"+
	    " IFNULL(service_job.BISJ_STATUS,'') as c30,"+
	    " IFNULL(service_job.BISJ_STATE,'') as c31,"+
	    " IFNULL(service_job.BISJ_JOB_STATUS ,'') as c32 ,"+
	    " IFNULL(service_job.BISJ_PM_MA_EXT ,'') as c33 "+
	    
	   " FROM "+SCHEMA_G+".BPM_INNER_SERVICE_JOB service_job  "+
	   " where service_job.BISJ_NO=${bisjNo}";
	   
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
					    var BISJ_NO=data[0][0]; $("#BISJ_NO").val(BISJ_NO);
					    var BISJ_IS_INSTALLATION=data[0][1];
					    var BISJ_IS_SERWAY_SITE=data[0][2];
					    var BISJ_IS_SEND_UPS=data[0][3]; 
					    var BISJ_IS_EXT=data[0][4]; 
					    var BISJ_EXT=data[0][5]; $("#BISJ_EXT").val(BISJ_EXT); 
					    var BISJ_DELIVERY_DUEDATE=data[0][6]; $("#BISJ_DELIVERY_DUEDATE").val(BISJ_DELIVERY_DUEDATE); 
					    var BISJ_DELIVERY_DUEDATE_TIME=data[0][7]; $("#BISJ_DELIVERY_DUEDATE_TIME").val(BISJ_DELIVERY_DUEDATE_TIME); 
					    var BISJ_CONTACT=data[0][8]; $("#BISJ_CONTACT").val(BISJ_CONTACT); 
					    var BISJ_INSTALLATION_LOCATION=data[0][9]; $("#BISJ_INSTALLATION_LOCATION").val(BISJ_INSTALLATION_LOCATION); 
					    var BISJ_ADDR1=data[0][10]; $("#BISJ_ADDR1").val(BISJ_ADDR1); 
					    var BISJ_ADDR2=data[0][11]; $("#BISJ_ADDR2").val(BISJ_ADDR2);
					    var BISJ_ADDR3=data[0][12]; $("#BISJ_ADDR3").val(BISJ_ADDR3);
					    var BISJ_PROVINCE=data[0][13]; $("#BISJ_PROVINCE").val(BISJ_PROVINCE); 
					    var BISJ_ZIPCODE=data[0][14]; $("#BISJ_ZIPCODE").val(BISJ_ZIPCODE); 
					    var BISJ_TEL_FAX=data[0][15]; $("#BISJ_TEL_FAX").val(BISJ_TEL_FAX); 
					    var BISJ_REMARK=data[0][16]; $("#BISJ_REMARK").val(BISJ_REMARK); 
					    var BISJ_CREATED_DATE=data[0][17]; $("#BISJ_CREATED_DATE").val(BISJ_CREATED_DATE); 
					    var BISJ_CODE_NO=data[0][18]; $("#BISJ_CODE_NO").val(BISJ_CODE_NO); 
					    var BISJ_SALE_ORDER_NO=data[0][19]; $("#BISJ_SALE_ORDER_NO").val(BISJ_SALE_ORDER_NO); 
					    var BISJ_IS_WARRANTY=data[0][20]; 
					    var BISJ_WARRANTY=data[0][21]; 
					    var BISJ_IS_PM_MA=data[0][22]; 
					    var BISJ_PM_MA=data[0][23]; 
					    var BISJ_IS_OPTION=data[0][24]; 
					    var BISJ_IS_BATTERY=data[0][25]; 
					    var BISJ_BATTERY_AMOUNT=data[0][26]; $("#BISJ_BATTERY_AMOUNT").val(BISJ_BATTERY_AMOUNT); 
					    var BISJ_IS_CABLE=data[0][27]; $("#BISJ_IS_CABLE").val(BISJ_IS_CABLE); 
					    var BISJ_IS_EXT_OPTION=data[0][28]; $("#BISJ_IS_EXT_OPTION").val(BISJ_IS_EXT_OPTION); 
					    var BISJ_EXT_OPTION=data[0][29]; $("#BISJ_EXT_OPTION").val(BISJ_EXT_OPTION); 
					    var BISJ_STATUS=data[0][30]; $("#BISJ_STATUS").val(BISJ_STATUS); 
					    var BISJ_STATE=data[0][31]; $("#BISJ_STATE").val(BISJ_STATE); 
					    var BISJ_JOB_STATUS =data[0][32]; $("#BISJ_JOB_STATUS").val(BISJ_JOB_STATUS); 
					    var BISJ_PM_MA_EXT =data[0][33]; $("#BISJ_PM_MA_EXT").val(BISJ_PM_MA_EXT); 
					    
					    if(BISJ_IS_INSTALLATION=='1'){
					    	$('input[id="BISJ_IS_INSTALLATION"][value="' + BISJ_IS_INSTALLATION + '"]').prop('checked', true);
					    }
					    if(BISJ_IS_SERWAY_SITE=='1'){
					    	$('input[id="BISJ_IS_SERWAY_SITE"][value="' + BISJ_IS_SERWAY_SITE + '"]').prop('checked', true);
					    } 
					    if(BISJ_IS_SEND_UPS=='1'){
					    	$('input[id="BISJ_IS_SEND_UPS"][value="' + BISJ_IS_SEND_UPS + '"]').prop('checked', true);
					    } 
					    if(BISJ_IS_EXT=='1'){
					    	$('input[id="BISJ_IS_EXT"][value="' + BISJ_IS_EXT + '"]').prop('checked', true);
					    }  
					    $('input[name="BISJ_IS_PM_MA"][value="' + BISJ_IS_PM_MA + '"]').prop('checked', true); 
					    $('input[name="BISJ_IS_WARRANTY"][value="' + BISJ_IS_WARRANTY + '"]').prop('checked', true); 
					    $('input[name="BISJ_WARRANTY"][value="' + BISJ_WARRANTY + '"]').prop('checked', true); 
					    $('input[name="BISJ_PM_MA"][value="' + BISJ_PM_MA + '"]').prop('checked', true);  
					    
					    $('input[name="BISJ_IS_OPTION"][value="' + BISJ_IS_OPTION + '"]').prop('checked', true); 
						$('input[name="BISJ_IS_BATTERY"][value="' + BISJ_IS_BATTERY + '"]').prop('checked', true);
						$('input[name="BISJ_IS_CABLE"][value="' + BISJ_IS_CABLE + '"]').prop('checked', true);
						$('input[name="BISJ_IS_EXT_OPTION"][value="' + BISJ_IS_EXT_OPTION + '"]').prop('checked', true);
						 
				}else{
					
				} 
				searchItemList("1");
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("INNER_SERVICES","y","5","th",{
			callback:function(data){  
				if(data.resultMessage.msgCode=='ok'){
					data=data.resultMessage.msgDesc;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=null && data.length>0){
					$("#BISJ_NO").val(data);
					var querys=[];  
					var query="insert into "+SCHEMA_G+".BPM_INNER_SERVICE_JOB set BISJ_NO='"+data+"' ,BISJ_STATE='Services Created' ,BISJ_CREATED_BY='${username}' ,"+
					  " BISJ_CREATED_DATE=now()";
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
								query=" SELECT "+
								   " BISJ_NO , BISJ_IS_INSTALLATION FROM "+SCHEMA_G+".BPM_INNER_SERVICE_JOB where BISJ_NO='"+$("#BISJ_NO").val()+"'";
								  SynDomeBPMAjax.searchObject(query,{
										callback:function(data2){ 
											if(data2.resultMessage.msgCode=='ok'){
												data2=data2.resultListObj;
											}else{// Error Code
												//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
												  bootbox.dialog(data2.resultMessage.msgDesc,[{
													    "label" : "Close",
													     "class" : "btn-danger"
												 }]);
												 return false;
											}
											loadDynamicPage('dispatcher/page/service_inner_management?bisjNo='+data2[0][0]+'&mode=edit');
										},errorHandler:function(errorString, exception) { 
											alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
										}
								  }); 
								//searchDeliveryInstallation("1"); 
							}
						}
					});
					//alert(data)	
				}else{
					
				} 
			},errorHandler:function(errorString, exception) { 
				alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
			}
	 	  }); 
   }
}
function addItem(){
	//var str="";	 
	var function_str="addItemToList()";
	var label_str="Add Item";
	var input_id="ima_item_id";
	var input_hidden_id="IMA_ItemID"; 
	 
	var bt= "<span>&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
	var input_str= "หมายเลขเครื่อง <input type=\"text\" id=\"serail_popup\" name=\"serail_popup\" style=\"height: 30;\" />"+ 
	 				"<br/>Model (รุ่น) <input type=\"text\" id=\"model_popup\" name=\"model_popup\" style=\"height: 30;\" />"+
	 				"<br/>จำนวน <input type=\"text\" id=\"amount_popup\" name=\"amount_popup\" style=\"height: 30;\" />"; 
	 				
	 bootbox.dialog(input_str+bt+"</span>",[{
		    "label" : "Cancel",
		    "class" : "btn-danger"
	 }]); 
} 
function addItemToList(){
	//alert( $("#bdeptUserId").val());
	var serail_popup=jQuery.trim($("#serail_popup").val());
	var model_popup=jQuery.trim($("#model_popup").val());
	var amount_popup=jQuery.trim($("#amount_popup").val());
	
	if(!serail_popup.length>0){
		 alert('กรุณากรอก ข้อมูล.');  
		 $("#serail_popup").focus(); 
		 return false;	
	}
	if(!model_popup.length>0){
		 alert('กรุณากรอก ข้อมูล.');  
		 $("#model_popup").focus(); 
		 return false;	
	}
	 
	 var isNumber=checkNumber(jQuery.trim($("#amount_popup").val())); 
	 if(isNumber){  
		 alert('กรุณากรอก จำนวน เป็นตัวเลข.');  
		 $("#amount_popup").val("");
		 $("#amount_popup").focus(); 
		 return false;	  
	 }
	 
  
	var getAutoK="SELECT count(*) FROM "+SCHEMA_G+".BPM_INNER_SERVICE_JOB_MAPPING "+
	 " WHERE BISJ_NO='${bisjNo}' and SERIAL='"+serail_popup+"' " ;
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
				}  
				var querys=[];
				var query="INSERT INTO "+SCHEMA_G+".BPM_INNER_SERVICE_JOB_MAPPING (BISJ_NO,SERIAL,MODEL,AMOUNT) "+
				          " VALUES('${bisjNo}','"+serail_popup+"','"+model_popup+"',"+amount_popup+")";
				//alert(query)
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
							searchItemList("1");
							bootbox.hideAll();
						}
					},errorHandler:function(errorString, exception) { 
						alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
					}
				});
		 }
	 });
	
}
function searchItemList(_page){ 
    
	$("#pageNo").val(_page);   
	var query_common=" SELECT  IFNULL(item.SERIAL,'') ,IFNULL(item.MODEL,'') ,IFNULL(item.AMOUNT,''),IFNULL(item.IMA_ITEMID,'') "+ 
	"FROM "+SCHEMA_G+".BPM_INNER_SERVICE_JOB_MAPPING item   where item.BISJ_NO=${bisjNo} ";
var query=query_common
	 
	 
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"width:500px;font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"56%\"><div class=\"th_class\">หมายเลขเครื่อง</div></th> "+
			        "  		<th width=\"34%\"><div class=\"th_class\">Model (รุ่น)</div></th> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+  
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   var total=0;
				   var vat=0;
				   var grand_total=0;
				   var colspan_str="4";
				   //alert(usernameG=="admin")
				   if(usernameG=="admin")
					   colspan_str='6';
				   
				   for(var i=0;i<data.length;i++){ 
					   
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+       
				        "    	<td style=\"text-align: center;\">"+data[i][2]+" </td>"+   
				        "    	<td style=\"text-align: center;\">"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('${bisjNo}','"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"width:500px;font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"4\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			   str=str+  " </tbody>"+
			   "</table> "; 
	   $("#item_section").html(str);
		}
	}); 
} 
function confirmDelete(bisjNo,SERIAL){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(bisjNo,SERIAL);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
} 
function doAction(bisjNo,SERIAL){
	var querys=[];  
	var query="DELETE FROM "+SCHEMA_G+".BPM_INNER_SERVICE_JOB_MAPPING where BISJ_NO='"+bisjNo+"' and SERIAL='"+SERIAL+"' ";
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
				searchItemList("1"); 
			}
		}
	});
} 
function doAssignInnerServiceJob(jobNo){
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
				   
				 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeam('"+bdept_id+"','"+jobNo+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a>"+
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
function doAssignTeam(bdept_id,jobNo){

	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	var btdl_state='wait_for_operation_inner_services';
    var BTDL_SLA_LIMIT_TIME="(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00')))";
    var BTDL_DUE_DATE="null";
    var spec_time="";
	
  //wait_for_assign_to_team
	//wait_for_quotation
	//wait_for_send_to_supervisor  --> key account
	//wait_for_supervisor_services_close
	//wait_for_operation_services

	var btdl_type='4';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='Job wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];   
	var query_update =doUpdateInnerServices();
	 
	 if(query_update!=false){ 
	   }else
	   	   return false;
	 querys.push(query_update)
	 
	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('"+jobNo+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	"+BTDL_DUE_DATE+",'"+hide_status+"','${username}','"+jobNo+"',"+BTDL_SLA_LIMIT_TIME+" ) ";

	 // clear to-do-list 
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='"+jobNo+"' and "+
	  "BTDL_TYPE='"+btdl_type+"'   and BTDL_OWNER='${username}' ";
		// "BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
		 querys.push(query2); 
		 query2="update "+SCHEMA_G+".BPM_INNER_SERVICE_JOB set BISJ_JOB_STATUS=1 where BISJ_NO='"+jobNo+"'"; 
		  querys.push(query2);
	 
	 if( btdl_state=='wait_for_operation_services'   || btdl_state=='wait_for_supervisor_services_close'){
		 query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BISJ_STATE='"+btdl_state+"' where BCC_NO='"+jobNo+"'"; 
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
		  query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSO_RFE_NO='"+BSO_RFE_NO+"' where BISJ_NO="+jobNo+""; 
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
function doUpdateInnerServices(){
	var BISJ_IS_INSTALLATION='0'; 
	if($("#BISJ_IS_INSTALLATION").prop( "checked" )){
		BISJ_IS_INSTALLATION="1";
	} 
	
	var BISJ_IS_SERWAY_SITE ='0';
	if($("#BISJ_IS_SERWAY_SITE").prop( "checked" )){
		BISJ_IS_SERWAY_SITE="1";
	} 
	var BISJ_IS_SEND_UPS ='0';
	if($("#BISJ_IS_SEND_UPS").prop( "checked" )){
		BISJ_IS_SEND_UPS="1";
	}
	var BISJ_IS_EXT ='0';
	if($("#BISJ_IS_EXT").prop( "checked" )){
		BISJ_IS_EXT="1";
	} 
	 
	
	var BISJ_EXT =jQuery.trim($("#BISJ_EXT").val());
	var BISJ_DELIVERY_DUEDATE_PICKER =jQuery.trim($("#BISJ_DELIVERY_DUEDATE").val());
	var BISJ_DELIVERY_DUEDATE_TIME =jQuery.trim($("#BISJ_DELIVERY_DUEDATE_TIME").val());
	 
	var BISJ_DELIVERY_DUEDATE="";
	if(BISJ_DELIVERY_DUEDATE_PICKER.length>0){
		var BISJ_DELIVERY_DUEDATE_ARRAY=BISJ_DELIVERY_DUEDATE_PICKER.split("/");
		BISJ_DELIVERY_DUEDATE=BISJ_DELIVERY_DUEDATE_ARRAY[2]+"-"+BISJ_DELIVERY_DUEDATE_ARRAY[1]+"-"+BISJ_DELIVERY_DUEDATE_ARRAY[0]; 
		BISJ_DELIVERY_DUEDATE=BISJ_DELIVERY_DUEDATE+" 00:00:00"; 
	}
	 
	
	var BISJ_CONTACT =jQuery.trim($("#BISJ_CONTACT").val());
	var BISJ_INSTALLATION_LOCATION =jQuery.trim($("#BISJ_INSTALLATION_LOCATION").val());
	var BISJ_ADDR1 =jQuery.trim($("#BISJ_ADDR1").val());
	var BISJ_ADDR2 =jQuery.trim($("#BISJ_ADDR2").val());
	var BISJ_ADDR3 =jQuery.trim($("#BISJ_ADDR3").val());
	var BISJ_PROVINCE =jQuery.trim($("#BISJ_PROVINCE").val());
	var BISJ_ZIPCODE =jQuery.trim($("#BISJ_ZIPCODE").val());
	var BISJ_TEL_FAX =jQuery.trim($("#BISJ_TEL_FAX").val());
	var BISJ_REMARK =jQuery.trim($("#BISJ_REMARK").val());
	//var BISJ_CREATED_DATE =jQuery.trim($("#BISJ_CREATED_DATE").val());
	var BISJ_CODE_NO =jQuery.trim($("#BISJ_CODE_NO").val());
	var BISJ_SALE_ORDER_NO =jQuery.trim($("#BISJ_SALE_ORDER_NO").val());
	var BISJ_PM_MA_EXT=jQuery.trim($("#BISJ_PM_MA_EXT").val());
	var BISJ_IS_WARRANTY ='0';//jQuery.trim($("#BISJ_IS_WARRANTY").val());
	if($('input[name="BISJ_IS_WARRANTY"][value="1"]').prop('checked')){
		BISJ_IS_WARRANTY="1";
	}
	var BISJ_WARRANTY =jQuery.trim($("#BISJ_WARRANTY").val());
	var BISJ_IS_PM_MA ='0';
	if($('input[name="BISJ_IS_PM_MA"][value="1"]').prop('checked')){
		BISJ_IS_PM_MA="1";
	}
	var BISJ_PM_MA =jQuery.trim($("#BISJ_PM_MA").val());
	var BISJ_IS_OPTION ='0';
	if($('input[name="BISJ_IS_OPTION"][value="1"]').prop('checked')){
		BISJ_IS_OPTION="1";
	}
	var BISJ_IS_BATTERY ='0';
	if($('input[name="BISJ_IS_BATTERY"][value="1"]').prop('checked')){
		BISJ_IS_BATTERY="1";
	}
	var BISJ_BATTERY_AMOUNT =jQuery.trim($("#BISJ_BATTERY_AMOUNT").val());
	var BISJ_IS_CABLE ='0';
	if($('input[name="BISJ_IS_CABLE"][value="1"]').prop('checked')){
		BISJ_IS_CABLE="1";
	}
	var BISJ_IS_EXT_OPTION ='0';
	if($('input[name="BISJ_IS_EXT_OPTION"][value="1"]').prop('checked')){
		BISJ_IS_EXT_OPTION="1";
	}
	var BISJ_EXT_OPTION =jQuery.trim($("#BISJ_EXT_OPTION").val());
	var BISJ_STATUS =jQuery.trim($("#BISJ_STATUS").val());
	var BISJ_STATE ='Services Wait for Assign';
	//var BISJ_JOB_STATUS ='1';
	var BISJ_CREATED_BY =jQuery.trim($("#BISJ_CREATED_BY").val());
	
	 
		var query=" UPDATE "+SCHEMA_G+".BPM_INNER_SERVICE_JOB SET "+ 
		//" BISJ_NO ='"+BISJ_NO+"' , "+
		" BISJ_IS_INSTALLATION ='"+BISJ_IS_INSTALLATION+"' , "+
		" BISJ_IS_SERWAY_SITE ='"+BISJ_IS_SERWAY_SITE+"' , "+
		" BISJ_IS_SEND_UPS ='"+BISJ_IS_SEND_UPS+"' , "+
		" BISJ_IS_EXT ='"+BISJ_IS_EXT+"' , "+
		" BISJ_EXT ='"+BISJ_EXT+"' , ";
		if(BISJ_DELIVERY_DUEDATE.length>0){
			query=query+" BISJ_DELIVERY_DUEDATE='"+BISJ_DELIVERY_DUEDATE+"' , ";
		}else
			query=query+" BISJ_DELIVERY_DUEDATE=null  , ";
		
		if(BISJ_DELIVERY_DUEDATE_TIME.length>0){
			query=query+" BISJ_DELIVERY_DUEDATE_TIME='"+BISJ_DELIVERY_DUEDATE_TIME+"' , ";
		}else
			query=query+" BISJ_DELIVERY_DUEDATE_TIME=null  , ";
		// " BISJ_DELIVERY_DUEDATE ='"+BISJ_DELIVERY_DUEDATE+"' , "+
		// " BISJ_DELIVERY_DUEDATE_TIME ='"+BISJ_DELIVERY_DUEDATE_TIME+"' , "+
		query=query+" BISJ_CONTACT ='"+BISJ_CONTACT+"' , "+
		" BISJ_INSTALLATION_LOCATION ='"+BISJ_INSTALLATION_LOCATION+"' , "+
		" BISJ_ADDR1 ='"+BISJ_ADDR1+"' , "+
		" BISJ_ADDR2 ='"+BISJ_ADDR2+"' , "+
		" BISJ_ADDR3 ='"+BISJ_ADDR3+"' , "+
		" BISJ_PROVINCE ='"+BISJ_PROVINCE+"' , "+
		" BISJ_ZIPCODE ='"+BISJ_ZIPCODE+"' , "+
		" BISJ_TEL_FAX ='"+BISJ_TEL_FAX+"' , "+
		" BISJ_REMARK ='"+BISJ_REMARK+"' , "+
	//	" BISJ_CREATED_DATE ='"+BISJ_CREATED_DATE+"' , "+
		" BISJ_CODE_NO ='"+BISJ_CODE_NO+"' , "+
		" BISJ_SALE_ORDER_NO ='"+BISJ_SALE_ORDER_NO+"' , "+
		" BISJ_IS_WARRANTY ='"+BISJ_IS_WARRANTY+"' , "+
		" BISJ_WARRANTY ='"+BISJ_WARRANTY+"' , "+
		" BISJ_IS_PM_MA ='"+BISJ_IS_PM_MA+"' , "+
		" BISJ_PM_MA ='"+BISJ_PM_MA+"' , "+
		" BISJ_IS_OPTION ='"+BISJ_IS_OPTION+"' , "+
		" BISJ_IS_BATTERY ='"+BISJ_IS_BATTERY+"' , "+
		" BISJ_BATTERY_AMOUNT ='"+BISJ_BATTERY_AMOUNT+"' , "+
		" BISJ_IS_CABLE ='"+BISJ_IS_CABLE+"' , "+
		" BISJ_IS_EXT_OPTION ='"+BISJ_IS_EXT_OPTION+"' , "+
		" BISJ_EXT_OPTION ='"+BISJ_EXT_OPTION+"' , "+
		" BISJ_PM_MA_EXT ='"+BISJ_PM_MA_EXT+"' , "+
		" BISJ_STATUS ='"+BISJ_STATUS+"' , "+
		" BISJ_STATE ='"+BISJ_STATE+"' "+
		// " BISJ_JOB_STATUS ='"+BISJ_JOB_STATUS+"'  "+
		// " BISJ_CREATED_BY ='"+BISJ_CREATED_BY+"'  "+
		" WHERE BISJ_NO = '${bisjNo}'"; 
 
	// alert(query)
	  return query;
}
function doCloseServicesJob(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bisjNo}' and "+
	"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";
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
					showDialog(message_duplicate);
				}else{
					var querys=[];  
					var btdl_state_update='wait_for_supervisor_inner_services_close';
					 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
							"('${bisjNo}','"+btdl_type+"','"+btdl_state_update+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','${bisjNo}') ";
					 if('${state}'!='' && is_hide_todolist){
					  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bisjNo}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
					 } 
					  query2="update "+SCHEMA_G+".BPM_INNER_SERVICE_JOB set BISJ_JOB_STATUS=2 where BISJ_NO=${bisjNo}"; 
					   querys.push(query2); 
					 if(btdl_state=='wait_for_supervisor_services_close'){
						// query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BISJ_STATE='"+btdl_state+"' where BCC_NO=${bisjNo}"; 
						 // querys.push(query2); 
					 }
				  
						var query_update =doUpdateInnerServices();
						//alert(query_update);
						 if(query_update!=false){
							// return false;
						   }else
						   	   return false;
					 querys.push(query_update);
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

function doCloseJob(btdl_type,btdl_state,owner,owner_type,message){
	   /*  alert($("#BSO_IS_DELIVERY").val());
	    alert($("#BSO_IS_INSTALLATION").val()) */; 
	    
	    var querys=[];  
		var query_update =doUpdateInnerServices();
		//alert(query_update);
		 if(query_update!=false){
			// return false;
		   }else
		   	   return false;
		 querys.push(query_update); 
			 query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bisjNo}' and "+
				"BTDL_TYPE='4' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
				  
		 	querys.push(query2); 
		 	
		 	  
		 	 query2="update "+SCHEMA_G+".BPM_INNER_SERVICE_JOB set BISJ_STATE='Services Closed' , BISJ_JOB_STATUS=3 where BISJ_NO=${bisjNo}"; 
			  querys.push(query2)
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
						bootbox.dialog("Closed Job.",[{
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
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="bisjNo" id="bisjNo"  value="${bisjNo}"/> 
			 <input type="hidden" name="BSO_IS_DELIVERY" id="BSO_IS_DELIVERY" />
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
            <input type="hidden" id="IMA_ItemID" name="IMA_ItemID"/>
			  <fieldset style="font-family: sans-serif;">   
			  <div align="left">
           	

  	  	  	  
           	 <strong id="delivery_install_title">Job No</strong><input type="text" id="BISJ_NO" style="height: 30px;width: 125px"/> 
           	<span style="padding-left:10px"><input type="checkbox" value="1" id="BISJ_IS_INSTALLATION" ></span>
           	<span style="padding-left:0px">ติดตั้ง</span> 
           	<span style="padding-left:20px"><input type="checkbox" value="1" id="BISJ_IS_SERWAY_SITE" ></span>
           	<span style="padding-left:0px">Serway Site</span> 
           	<span style="padding-left:20px"><input type="checkbox" value="1" id="BISJ_IS_SEND_UPS" ></span>
           	<span style="padding-left:0px">ส่ง UPS</span> 
           	<span style="padding-left:20px"><input type="checkbox" value="1" id="BISJ_IS_EXT" ></span>
           	<span style="padding-left:0px">อื่นๆ </span> 
           	 <span style="padding-left:10px"><input type="text" id="BISJ_EXT" style="height: 30px;width: 125px" /> </span> 
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="50%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;" >
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BISJ_DELIVERY_DUEDATE" />
    					   			 
    					   			 <i class="icon-refresh" onclick="clearElementValue('BISJ_DELIVERY_DUEDATE')"></i>
    					   			</span>
    					   			<span style="padding-left: 5px">ระบุเวลา
    					   				<input type="text" readonly="readonly" style="cursor:pointer; width:50px; height: 30px;" id="BISJ_DELIVERY_DUEDATE_TIME" />
    					   			<i class="icon-refresh" onclick="clearElementValue('BISJ_DELIVERY_DUEDATE_TIME')"></i>
    					   			</span>
    					   			
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="BISJ_CONTACT" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					สถานที่ส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="BISJ_INSTALLATION_LOCATION" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					ที่อยู่
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BISJ_ADDR1" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					แขวง/ตำบล
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BISJ_ADDR2" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					เขต/อำเภอ
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BISJ_ADDR3" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					จังหวัด
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BISJ_PROVINCE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   		<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					รหัสไปรษณีย์
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BISJ_ZIPCODE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์โทร/แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   			<input type="text"  style="height: 30px;width: 320px" id="BISJ_TEL_FAX" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   </div>
    					 
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   		 <div>
    					   		 รายละเอียดอื่นๆ
    					   		 </div>
    					   		 <div>
    					   		   <textarea style="width:568px" name="BISJ_REMARK" id="BISJ_REMARK" cols="100" rows="3" ></textarea>
    					   		 </div> 
    					   		</td>
    					   		 
    					   	</tr>
    					   	</table>
    					   	</div>
    					</td>
    					<td width="50%" valign="top">
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px">
    					   	<table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					วันที่เปิดเอกสาร
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
    					   					<input type="text" readonly="readonly" value="${time}" style="width:100px; height: 30px;" id="BISJ_CREATED_DATE" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					Code No.
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px; height: 30px;" id="BISJ_CODE_NO" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					Sale Order No.
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px; height: 30px;" id="BISJ_SALE_ORDER_NO" />
    					   				</span>
    					   		</td>
    					   	</tr>  
    					   	</table>
    					   	</div> 
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="color: red;font-size: 20;"><strong></strong></span>
    					   				<span style="text-decoration: underline;">
    					   				   การรับประกัน	
    					   				</span>&nbsp;&nbsp;<input type="radio" value="1" name="BISJ_IS_WARRANTY"> มี  <input type="radio" value="0" name="BISJ_IS_WARRANTY"  onclick="clearSelect('BISJ_WARRANTY')"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="100%"  colspan="3" >
    					   				<span>
    					   					<input type="radio" value="1" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">1 ปี
    					   				</span> 
    					   				<span style="padding-left:40px">
    					   					<input type="radio" value="2" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">2 ปี(มาตรฐาน)
    					   				</span> 
    					   				<span  style="padding-left:40px">
    					   					<input type="radio" value="3" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">3 ปี
    					   				</span>
    					   				<span  style="padding-left:40px">
    					   					<input type="radio" value="4" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">4 ปี
    					   				</span> 
    					   		        <span  style="padding-left:40px">
    					   					<input type="radio" value="5" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">5 ปี
    					   				</span>
    					   				 <span  style="padding-left:40px">
    					   					<input type="radio" value="0" onclick="getSelectEle('BISJ_IS_WARRANTY','1')" name="BISJ_WARRANTY">ตลอดชีพ
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="color: red;font-size: 20;"><strong></strong></span>
    					   				<span style="text-decoration: underline;">
    					   				   PM(กทม/ตจว.) 	
    					   				</span>&nbsp;&nbsp;<input type="radio" value="1" name="BISJ_IS_PM_MA"> มี  <input type="radio" value="0" name="BISJ_IS_PM_MA" onclick="clearSelect('BISJ_PM_MA')"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="4" onclick="getSelectEle('BISJ_IS_PM_MA','1')" name="BISJ_PM_MA">4 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="3" onclick="getSelectEle('BISJ_IS_PM_MA','1')" name="BISJ_PM_MA">3 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="0" onclick="getSelectEle('BISJ_IS_PM_MA','1')" name="BISJ_PM_MA">อื่นๆ<input type="text" id="BISJ_PM_MA_EXT" style="width: 30px;height: 30px;"> เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px;height: 73px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="color: red;font-size: 20;"><strong></strong></span>
    					   				<span style="text-decoration: underline;">
    					   				  อุปกรณ์เสริม
    					   				</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" value="1" name="BISJ_IS_OPTION"> มี  <input type="radio" value="0" name="BISJ_IS_OPTION" > ไม่มี
    					   				
    					   		</td>
    					   		 
    					   	</tr>
    					   		<tr style="height: 30px;">
    					   		<td width="100%">
    					   				<span>
    					   					<input type="checkbox" value="1" onclick="getSelectEle('BISJ_IS_OPTION','1')" name="BISJ_IS_BATTERY"> Battery
    					   				</span>
    					   				<span style="padding-left:10px">
    					   					<input type="text" id="BISJ_BATTERY_AMOUNT" style="width: 30px;height: 30px;"> ลูก
    					   				</span> 
    					   				<span style="padding-left:10px">
    					   					<input type="checkbox" value="1" onclick="getSelectEle('BISJ_IS_OPTION','1')" name="BISJ_IS_CABLE"> สายไฟ
    					   				</span>
    					   				<span style="padding-left:10px">
    					   					<input type="checkbox" value="1" onclick="getSelectEle('BISJ_IS_OPTION','1')" name="BISJ_IS_EXT_OPTION"> อื่นๆ
    					   				</span>
    					   				<span style="padding-left:10px">
    					   					<input type="text" id="BISJ_EXT_OPTION" style="width: 30px;height: 30px;"> ลูก
    					   				</span> 
    					   		</td>    
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	</td>
    				</tr>
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
    			<table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%" align="center">
				 		 <c:if test="${isSupervisorAccount && state!='wait_for_supervisor_inner_services_close'}">
				 		  <span id="button_created"> 
				 		 <a class="btn btn-primary"  onclick="doAssignInnerServiceJob('${bisjNo}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Assign to Team</span></a>
    					  </span>
    					  </c:if>
    					  <c:if test="${isOperationAccount && state=='wait_for_operation_inner_services'}">
    					   	<span id="button_send">
    					   	 <a class="btn btn-primary"  onclick="doCloseServicesJob('4','wait_for_supervisor_inner_services_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Job</span></a>
    					  	 <%--	<a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update</span></a>  --%>
    						 </span>
    					  </c:if>
    					   <c:if test="${isSupervisorAccount && state=='wait_for_supervisor_inner_services_close'}">
    					   	<span id="button_send2">
    					   	<a id="close_job_element" style="" class="btn btn-primary"  onclick="doCloseJob('4','wait_for_supervisor_inner_services_close','${username}','1','Services Closed')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a>
    					 
    					  	   </span>
    					  </c:if>
    					
				 		</td>
				 	</tr>
				 </table> 
				</div>
			  </form>   
			   <div  class="well">
			  <table border="0" width="500px" style="font-size: 13px">
	    					<tbody> 
	    					<tr>
	    					<td align="left" width="70%">  
	    					<span><strong>Item List</strong></span>
	    					</td>
	    					<td align="right" width="30%"> 
	    						
	    					</td>
	    					</tr>
	    					<tr>
	    					<td align="left" width="70%">  
	    						<a class="btn btn-primary"  onclick="addItem()"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Add</span></a>
	    					</td><td align="right" width="30%"> 
	    					
	    					</td>
	    					</tr>
	    					</tbody></table> 
						 <div  id="item_section"> 
    		 </div> 
			</div>
</fieldset>