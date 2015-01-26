<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authorize access="hasAnyRole('ROLE_MANAGE_PM_MA')" var="isManagePMMA"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STOCK_ACCOUNT')" var="isStockAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_OPERATION')" var="isOperationAccount"/>  
<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  }
table > thead > tr > th
{
background	:#e5e5e5;
}
</style>
<script type="text/javascript">
$(document).ready(function() { 
   getPMMA(); 
}); 
function bsoTypeCheck(type){ 
	 //alert($("#bsoTypeCheck_"+type).prop("checked"));
	 if($("#bsoTypeCheck_"+type).prop("checked"))
		 $("#bsoType_"+type).slideDown(1000);
	 else
		 $("#bsoType_"+type).slideUp(1000); 
}
function assignUser(type){
	//var str="";
	var function_str="assignUserToDept()";
	var label_str="Assign to Department";
	var input_id="user_input";
	var input_hidden_id="bdeptUserId";
	var query="SELECT username,firstName,id  FROM "+SCHEMA_G+".user "+	
	  " where not exists ( "+	
	  " select * from "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user where dept_user.user_id=user.id "+	 
	  " and dept_user.bdept_id=${bpmmaId} "+	
	  " )and not exists ( "+
	  " SELECT * FROM "+SCHEMA_G+".BPM_DEPARTMENT  where bdept_hdo_user_id=user.id "+
	  ") and username like ";
	if(type=='hod'){
		// str="";
		function_str="assignHOD()";
		label_str="Assign to HOD";
		input_id="hod_input";
		input_hidden_id="bdeptHOD";
		query="SELECT username,firstName,id  FROM "+SCHEMA_G+".user "+	
		  " where not exists ( "+	
		  " select * from "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user where dept_user.user_id=user.id "+	 
		  " and dept_user.bdept_id=${bpmmaId} "+	
		  " ) and username like ";
	}
	var bt= "<span>&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
	 bootbox.dialog("<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+bt+"</span>",[{
		    "label" : "Cancel",
		    "class" : "btn-danger"
	 }]);
	 /*
	 , [{
		    "label" : "Success!",
		    "class" : "btn-success",
		    "callback": function() {
		        Example.show("great success");
		    }
		}]);
		*/
	 $("#"+input_id+"" ).autocomplete({
		  source: function( request, response ) {    
			  //$("#pjCustomerNo").val(ui.item.label); 
			  var queryiner=query+" '%"+request.term+"%' ";
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
					        	  label: item[0],
					        	  value: item[0] ,
					        	  id: item[2]
					          }
					        }));
						}else{
							var xx=[]; 
							response( $.map(xx));
						}
					}
			 });		  
		  },
		  minLength: 1,
		  select: function( event, ui ) { 
			  this.value = ui.item.label;
			  $("#"+input_hidden_id+"").val(ui.item.id); 
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		}); 
}
function assignHOD(){
	//alert( $("#bdeptHOD").val());
	var bdeptHOD=jQuery.trim($("#bdeptHOD").val());
	//alert(bdeptHOD.length);
	 if(bdeptHOD.length>0){
		var querys=[];  
		var query="update "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_HDO_USER_ID="+bdeptHOD+" where BDEPT_ID=${bpmmaId}"; 
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
					loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId=${bpmmaId}&mode=edit');
				}
			}
		});
	}
	bootbox.hideAll();
}
function assignUserToDept(){
	//alert( $("#bdeptUserId").val());
	var bdeptUserId=jQuery.trim($("#bdeptUserId").val());
	//alert(bdeptUserId.length);
	 if(bdeptUserId.length>0){
		var querys=[];
		var query="insert into "+SCHEMA_G+".BPM_DEPARTMENT_USER set USER_ID="+bdeptUserId+",BDEPT_ID=${bpmmaId}";
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
	bootbox.hideAll();
}
function getPMMA(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#pm_ma_title").html("Job PM/MA ("+function_message+")");
  if(isEdit){  
	  var query=" SELECT "+
		" BPMMA_ID,"+
		" BPMMA_NAME,"+
		" BPMMA_NO,"+
		" BPMMA_STATE,"+
		" BSO_TYPE_NO,"+
		" BPMMA_CREATE_DATE,"+
		" BPMMA_UPDATE_DATE,"+
		" BPMMA_DUE_DATE,"+
		" BPMMA_STATUS"+
		" FROM "+SCHEMA_G+".BPM_PM_MA   where BPMMA_ID=${bpmmaId}"; 
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
					$("#bpmmaNo").val(data[0][2])
					$("#bdeptName").val(data[0][1]);
					$("#bdeptDetail").val(data[0][2]);
					$("#bdeptHOD").val(data[0][3]);   
					if(data[0][3]!=null){ 
						 $("#hodElement").html("<strong>"+data[0][4]+"</strong>"); 
						 $("#hodElement").css("cursor","pointer");   
					}else{
						$("#hodElement").html("Not set");
						$("#hodElement").css("color","red");
						$("#hodElement").css("cursor","pointer");  
					}
				}else{
					
				} 
				//searchItemList("1");
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("PM_MA","ymd","5",{ 
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
					$("#bpmmaNo").val(data);
					var querys=[];  
					var query="insert into "+SCHEMA_G+".BPM_PM_MA set BPMMA_NO='"+data+"'";
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
								   " BPMMA_ID , BPMMA_NO FROM "+SCHEMA_G+".BPM_PM_MA where BPMMA_NO='"+$("#bpmmaNo").val()+"'";
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
											loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId='+data2[0][0]+'&mode=edit');
										}
								  }); 
								//searchDeliveryInstallation("1"); 
							}
						}
					});
					//alert(data)	
				}else{
					
				} 
			}
	 	  }); 
	  $("#hodElement").html("Not set");
	  $("#hodElement").css("color","red");
	  $("#hodElement").css("cursor","pointer"); 
	 var str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		"<thead>"+
		"<tr> "+
		"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
		"</tr>"+
		"</thead>"+
		"<tbody></table> ";    
	//$("#item_section").html(str);
   }
}
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		//searchItemList(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		//searchItemList(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	//searchItemList($("#pageNo").val());
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
	document.getElementById("pageSelect").value=$("#pageNo").val();
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
function doAction(id){
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER where user_id="+id+" and BDEPT_ID=${bpmmaId}"; 
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
				//searchItemList("1"); 
			}
		}
	});
} 
function searchItemList(_page){  
	$("#pageNo").val(_page); 
	var query="SELECT "+
		"BPMMA_ID, "+
		"CUSCOD, "+
		"MODEL, "+
		"SERIAL, "+
		"AMOUNT, "+
		"PRICE "+
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM where BPMMA_ID=${bpmmaId}";
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">รหัสสินค้า</div></th> "+
			        "  		<th width=\"11%\"><div class=\"th_class\">สินค้า</div></th> "+
			        "  		<th width=\"9%\"><div class=\"th_class\">จำนวน</div></th> "+  
			        "  		<th width=\"15%\"><div class=\"th_class\">ราคาต่อหน่วย</div></th> "+
			        "  		<th width=\"24%\"><div class=\"th_class\">จำนวนเงิน</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+data[i][2]+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+   
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#item_section").html(str);
		}
	}); 
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
			 if(data==0) 
				 data=1;
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
} 
function showTeam(){
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
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
			    "  		<th width=\"65%\"><div class=\"th_class\">Name</div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){
					  /*  role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   } */
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeam()\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a></div>";
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
function doAssignTeam(){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	doUpdateState('3','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Job PM/MA wait for Operation','1',true);
}
//1(type จัดส่ง),wait_for_create_to_express,ROLE_QUOTATION_ACCOUNT,2(role),ข้อมูล ถูก update เรียบร้อยแล้ว
function doUpdateJob(btdl_type,btdl_state,owner,owner_type,message){
	var querys=[]; 
	var query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bpmmaId}' and "+
	"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
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
					 querys=[];  
					 query="update "+SCHEMA_G+".BPM_PM_MA set BPMMA_STATE='"+btdl_state+"' where BPMMA_ID=${bpmmaId}";
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
								showDialog(message);
							}
						}
					});
					  
				}else{
					showDialog(message);
				} 
			}});
}
function doSendToSupervisor(){
	var selectValue=$("select[id=supervisor_select] option:selected").val();
	 doUpdateState('3','wait_for_assign_to_team',selectValue,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor เรียบร้อยแล้ว','Job PM/MA wait for assign to Team','1',true);
	//doUpdateState();
}
function showDialog(messaage){
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary"
	 }]);
}
// 1(type จัดส่ง),wait_for_create_to_express,ROLE_QUOTATION_ACCOUNT,2(role),ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว,ข้อมูลถูกส่งไปฝ่าย บัญชี เรียบร้อยแล้ว,Job PM/MA Created,1(show,0=hide)
function doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bpmmaId}' and "+
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
					 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR) VALUES "+
							"('${bpmmaId}','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}') ";
					 if('${state}'!='' && is_hide_todolist){
					  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bpmmaId}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
					 querys.push(query2); 
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
								showDialog(message_created);
							}
						}
					});
				} 
			}});
	
}
function doSaveDraftAction(){  
	loadDynamicPage('dispatcher/page/pm_ma_search');
   <%-- 
	 var bdeptName=jQuery.trim($("#bdeptName").val());
	 var bdeptDetail=jQuery.trim($("#bdeptDetail").val());
	 var bdeptHOD=jQuery.trim($("#bdeptHOD").val());  
	 var bdeptHOD_str="null";
	// var position=jQuery.trim($("#position").val());
	 
	 if(bdeptName.length==0){
		 alert("กรุณากรอก Name.");
		 $("#bdeptName").focus();
		 return false;
	 } 
	 <c:if test="${mode=='edit'}">
	  if(bdeptHOD.length==0){
		 alert("กรุณากำหนด HOD.");
		// $("#bdeptHOD").focus();
		 return false;
	 }
	  bdeptHOD_str=bdeptHOD;   
	  </c:if>
	
	var querys=[]; 
	var query="insert into "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str;
	if($("#mode").val()=='edit'){
		 query="update "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str+" where BDEPT_ID=${bpmmaId}";
	}
	querys.push(query); 
	var list_values=[];
		var values=[];
		values.push(bdeptName);
		values.push(bdeptDetail); 
		//values.push(position);
		
		list_values.push(values);
	SynDomeBPMAjax.executeQueryWithValues(querys,list_values,{
			callback:function(data){ 
				if(data!=0){
					loadDynamicPage("dispatcher/page/pm_ma_search");
				}
			}
		});
	--%> 
  }

 
</script>  
<div id="dialog-confirmDelete" title="Delete User Mapping" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete User Mapping ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="bpmmaId" id="bpmmaId"  value="${bpmmaId}"/> 
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="pm_ma_title"></strong><input type="text" id="bpmmaNo" style="height: 30px;width: 147px" readonly="readonly"/> <br></br>
            	</div>
            	<%-- 
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="50%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อผู้ขาย
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;"/>
    					   			</span>
    					   			<span style="padding-left: 5px">
    					   				Code ลูกค้า
    					   			</span>
    					   			<span style="padding-left: 0px">
    					   				<input type="text" style="width:137px; height: 30px;"/>
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
    					   				<input type="text"  style="height: 30px;width: 320px"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อบริษัท
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ที่อยู่
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์โทร
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="checkbox" id="bsoTypeCheck_1" onclick="bsoTypeCheck('1')"/>ส่งเครื่องใหม่&nbsp;&nbsp;&nbsp;
    					   				<input type="checkbox" id="bsoTypeCheck_2" onclick="bsoTypeCheck('3')"/>ติดตั้ง
    					   			</span>
    					   		</td>
    					   	</tr>
    					   </table>
    					  </div>
    					  <div id="bsoType_1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					สถานที่ส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					ส่งของระบุเวลา	
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   </div>
    					   <div id="bsoType_2" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					ระบุชื่อ Site งาน
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					เบอร์โทร
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					ติดตั้งระบุเวลา	
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   </div>
    					  <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 1(ทั่วไป)
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 2(แน่นอนแต่ไม่รู้วัน)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 3
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 4(Project)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   	</div>
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   SLA
    					   				 </span>&nbsp;&nbsp;<select style="width: 75px;" ><option>24</option> </select>ช.ม.
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
    					   					<input type="text" style="width:100px; height: 30px;"/>
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					ประเภทลูกค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="radio" name="custType"/>Dealer&nbsp;&nbsp;&nbsp;<input type="radio" name="custType"/>User
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					PO เลขที่
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px; height: 30px;"/>
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					โปรดระบุ
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="radio" name="havePO"/>มี&nbsp;&nbsp;&nbsp;<input type="radio" name="havePO"/>ไม่มี
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
							<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="2" align="left">
    					   				<span style="text-decoration: underline;">
    					   					เงื่อนไขการชำระ
    					   				</span>
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="paymentTerm">เงินสด/เช็คเงินสด
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="paymentTerm">โอนเงิน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="paymentTerm">เช็คล่วงหน้า<input type="text" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="paymentTerm">เครดิต<input type="text" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   	</div> 
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   					ใบยืม
    					   				</span>
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">DEMO
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">เพื่อขาย
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">ฝากขาย
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">เปลี่ยน
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">สำรองใช้
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="borrowType">ลดหนี้
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%" colspan="3">
    					   				<span>
    					   					<input type="radio" name="borrowType">อื่นๆ<input type="text" style="width: 40px;height: 30px;"> ระยะประกัน<input type="text" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>    					   	
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   การรับประกัน	
    					   				</span>&nbsp;&nbsp;<input type="radio" name="isWarranty"> มี  <input type="radio" name="isWarranty"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="warrantyType">2 ปี(มาตรฐาน)
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="warrantyType">3 ปี
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="warrantyType">อื่นๆ<input type="text" style="width: 40px;height: 30px;"> ปี 
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   PM(เดือน / ครั้ง)	
    					   				</span>&nbsp;&nbsp;<input type="radio" name="isPM_MA"> มี  <input type="radio" name="isPM_MA"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="pmType">4 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="pmType">3 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" name="pmType">อื่นๆ<input type="text" style="width: 30px;height: 30px;"> เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px;height: 73px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   อุปกรณ์เสริม	
    					   				</span>&nbsp;&nbsp;<input type="radio"> สายไฟ
    					   		</td>
    					   		 
    					   	</tr>
    					   	</table>
    					   	</div>
    					   	</td>
    				</tr>
    			</table> 
    			 --%>
    			</fieldset> 
             <c:if test="${isManagePMMA}">
    			<div align="center" style="padding-top: 10px">
    			<table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/pm_ma_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">
    					 <a class="btn btn-primary"  onclick="doUpdateState('3','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Key Account เรียบร้อยแล้ว','Job PM/MA Created','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">ส่งไป Key Account</span></a>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
				 		</td>
				 	</tr>
				 </table> 
				</div>
				</c:if>
			<c:if test="${isKeyAccount && state=='wait_for_send_to_supervisor'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
				 		   Assign to Supervisor <select id="supervisor_select"	style="margin-top: 10px;width: 75px"> 
				 			<option value="sc_admin">SC</option>
				 			<option value="it_admin">IT</option>
				 			<option value="reg_admin">Reg</option>
				 			<option value="rfe_admin">RFE</option>
				 			<option value="local_admin">Local</option>
				 			</select>
    					  <a class="btn btn-primary"  onclick="doSendToSupervisor()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Send</span></a>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
				 		</td>
				 	</tr>
				 </table>
				  <%-- 
				  SELECT dept.*,user.* FROM SYNDOME_BPM_DB.BPM_DEPARTMENT dept left join 
				  SYNDOME_BPM_DB.user user on dept.BDEPT_HDO_USER_ID=user.id where dept.bdept_hdo_user_id is not null 
				   --%> 
				</div>
				</c:if>
			<c:if test="${isSupervisorAccount && state=='wait_for_assign_to_team'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
    					  <a class="btn btn-primary"  onclick="showTeam()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Assign to Team</span></a>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
				 		</td>
				 	</tr>
				 </table>
				</div>
			 </c:if>
			<c:if test="${isOperationAccount && state=='wait_for_operation'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateState('3','wait_for_supervisor_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job PM/MA wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			<c:if test="${isSupervisorAccount && state=='wait_for_supervisor_close'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateState('3','wait_for_keyaccount_close','ROLE_KEY_ACCOUNT','2','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Key Account  เรียบร้อยแล้ว','Job PM/MA wait for Key Account Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			<c:if test="${isKeyAccount && state=='wait_for_keyaccount_close'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateJob('3','wait_for_keyaccount_close','ROLE_KEY_ACCOUNT','2','Job PM/MA Closed')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			  </form>   
</fieldset>