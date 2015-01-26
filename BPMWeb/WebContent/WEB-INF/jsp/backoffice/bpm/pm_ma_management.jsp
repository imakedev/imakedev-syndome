<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authorize access="hasAnyRole('ROLE_MANAGE_PM_MA')" var="isPMMAAccount"/>  
<%-- 
<script src="<c:url value='/resources/js/bootstrap-datepicker.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/bootstrap-timepicker.js'/>" type="text/javascript"></script> 
<link rel="stylesheet" href="<c:url value='/resources/css/datepicker.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap-timepicker.css'/>">
 --%> 
<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  }  
table > thead > tr > th
{
background	:#e5e5e5;
} 
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:550px}
 .modal.fade.in{top:1%}
  .aoe_small{width: 594px !important;margin-left:-290px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
</style>
<script type="text/javascript">
$(document).ready(function() {  
	autoProvince("BPMJ_PROVINCE");
	autoAmphur("BPMJ_ADDR3");
	autoPMMACustomer("BPMJ_CUST_NAME");
	autoPMMALocation("BPMJ_LOCATION");
   getPMMA(); 
   
  
    $("#BPMJ_WORK_DATE" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	 
	 $('#BPMJ_WORK_TIME').timepicker({
		    showPeriodLabels: false
	 });
	  
					  for(var i=1 ;i<=6;i++){
							new AjaxUpload('BPMJ_DOC_ATTACH_'+i, { 
						        action: 'upload/PMMA/${bpmmaId}_'+i,
								onSubmit : function(file , ext){
						            // Allow only images. You should add security check on the server-side.
								if (ext && /^(jpg|png|jpeg|gif|xls|xlsx|XLS|XLSX|pdf|PDF|docx|doc|DOCX|DOC)$/.test(ext)){
										/* Setting data */
										this.setData({
											'key': 'This string will be send with the file',
											'test':'chatchai'
										});					 
									//$('#candidate_photo').attr('src', _path+"resources/images/loading.gif");
									} else {					
										// extension is not allowed
										alert('Error: only images are allowed') ;
										// cancel upload
										return false;				
									}		
								},
								onComplete : function(file, response){ 
									var obj = jQuery.parseJSON(response);
									//alert(obj.filename)  
									 //alert(obj.id)
									$("#BPMJ_DOC_ATTACH_"+obj.id+"_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
									$("#BPMJ_DOC_ATTACH_"+obj.id+"_SRC").html(obj.filename);
								     $("#BPMJ_DOC_ATTACH_"+obj.id+"_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_"+obj.id+"/"+obj.hotlink+"')");
								     //alert($("#SBJ_DOC_ATTACH_"+i+"_SRC").html())
								       
								}		
							}); 
						}				 
				 
}); 

function autoPMMALocation(dealer_element_id){   
	   var query="SELECT  BPMJ_LOCATION  FROM "+SCHEMA_G+".BPM_PM_MA_JOB where BPMJ_LOCATION is not null and BPMJ_LOCATION like "; 
	   $("#"+dealer_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by BPMJ_LOCATION  order by BPMJ_LOCATION limit 15";
				 // alert(queryiner)
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
						        	  label: item,
						        	  value: item ,
						        	  location: item
						          };
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
				  $("#"+dealer_element_id).val(ui.item.location);  
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
function autoPMMACustomer(dealer_element_id){   
	   var query="SELECT  BPMJ_CUST_NAME  FROM "+SCHEMA_G+".BPM_PM_MA_JOB where BPMJ_CUST_NAME is not null and BPMJ_CUST_NAME like "; 
	   $("#"+dealer_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by BPMJ_CUST_NAME  order by BPMJ_CUST_NAME limit 15";
				 // alert(queryiner)
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
						        	  label: item,
						        	  value: item ,
						        	  location: item
						          };
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
				  $("#"+dealer_element_id).val(ui.item.location);  
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
 function getPMMA(){ 
	 var   bpmmaIds=  '${bpmmaId}'.split("_");
	  //alert(bpmmaIds);
	  
	  var query= " select pmma.BPMJ_NO as c0 , "+
	   // " pmma.BPMJ_CREATED_DATE as c1, "+
	     " IFNULL(DATE_FORMAT(pmma.BPMJ_CREATED_DATE,'%d/%m/%Y'),'') as c1 ,"+
	     " IFNULL(DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y'),'') as c2 ,"+
	     " IFNULL(DATE_FORMAT(pmma.BPMJ_DUEDATE_START_TIME,'%H:%i'),'') as c3 ,"+
	   
	    " IFNULL(pmma.BPMJ_CUST_CODE,'') as c4 ,"+ 
	   " IFNULL(pmma.BPMJ_CUST_NAME,'') as c5 ,"+
	   //  " IFNULL(armas.CUSCOD,'') as c5 ,"+ 
	    " IFNULL(pmma.BPMJ_LOCATION,'') as c6 ,"+
	    " IFNULL(pmma.BPMJ_ADDR1,'') as c7 ,"+
	    " IFNULL(pmma.BPMJ_ADDR2,'') as c8 ,"+
	    " IFNULL(pmma.BPMJ_ADDR3,'') as c9 ,"+
	    " IFNULL(pmma.BPMJ_PROVINCE,'') as c10 ,"+
	    " IFNULL(pmma.BPMJ_ZIPCODE,'') as c11 ,"+
	    " IFNULL(pmma.BPMJ_TEL_FAX,'') as c12 ,"+
	    " IFNULL(pmma.BPMJ_CONTACT_NAME,'') as c13 ,"+
	    " IFNULL(pmma.BPMJ_CONTACT_SURNAME,'') as c14 ,"+
	    " IFNULL(pmma.BPMJ_CONTACT_POSITION,'') as c15 ,"+
	    " IFNULL(pmma.BPMJ_CONTACT_MOBILE,'') as c16 ,"+
	    " IFNULL(pmma.BPMJ_UPS_MODEL,'') as c17 ,"+
	    " IFNULL(pmma.BPMJ_SERAIL,'') as c18 ,"+
	    " IFNULL(pmma.BPMJ_VOTE,'') as c19 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST1_IS_PASS,'') as c20 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST1_NOTE,'') as c21 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST2_IS_PASS,'') as c22 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST2_NOTE,'') as c23 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST3_IS_PASS,'') as c24 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST3_NOTE,'') as c25 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST4_IS_PASS,'') as c26 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST4_NOTE,'') as c27 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST5_IS_PASS,'') as c28 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST5_NOTE,'') as c29 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST6_IS_PASS,'') as c30 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST6_NOTE,'') as c31 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST7_IS_PASS,'') as c32 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST7_NOTE,'') as c33 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST8_IS_PASS,'') as c34 ,"+
	    " IFNULL(pmma.BPMJ_UPS_TEST8_NOTE,'') as c35 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_CURRENT_IN,'') as c36 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_CURRENT_OUT,'') as c37 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_VOLTAGE_IN,'') as c38 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_VOLTAGE_OUT,'') as c39 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_VERIFICATION_IN,'') as c40 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV_VERIFICATION_OUT,'') as c41 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_INV__PERCENT_LOAD,'') as c42 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_CURRENT_IN,'') as c43 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT,'') as c44 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN,'') as c45 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT,'') as c46 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN,'') as c47 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT,'') as c48 ,"+
	    " IFNULL(pmma.BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD,'') as c49 ,"+
	    " IFNULL(pmma.BPMJ_BATTERY_BACKUP_TIME,'') as c50 ,"+
	    " IFNULL(pmma.BPMJ_BATTERY_CHARGE_ON,'') as c51 ,"+
	    " IFNULL(pmma.BPMJ_BATTERY_CHARGE_OFF,'') as c52 ,"+
	    " IFNULL(pmma.BPMJ_BATTERY_CABLE_STATUS,'') as c53 ,"+
	    " IFNULL(pmma.BPMJ_BATTERY_EXTERNAL_STATUS,'') as c54 ,"+
	    " IFNULL(pmma.BPMJ_BREAKER_AMOUNT,'') as c55 ,"+
	    " IFNULL(pmma.BPMJ_BREAKER_SIZE_1,'') as c56 ,"+
	    " IFNULL(pmma.BPMJ_BREAKER_SIZE_2,'') as c57,"+
	    " IFNULL(pmma.BPMJ_IS_MAINTAIN1,'') as c58 ,"+
	    " IFNULL(pmma.BPMJ_IS_MAINTAIN2,'') as c59 ,"+
	    " IFNULL(pmma.BPMJ_NOTE,'') as c60 ,"+
	    " IFNULL(pmma.BPMJ_IS_RECOMMEND1,'') as c61 ,"+
	    " IFNULL(pmma.BPMJ_IS_RECOMMEND2,'') as c62 ,"+
	    " IFNULL(DATE_FORMAT(pmma.BPMJ_WORK_DATE,'%d/%m/%Y'),'') as c63,"+
	    " IFNULL(DATE_FORMAT(pmma.BPMJ_WORK_TIME,'%H:%i'),'') as c64,"+
	   // " IFNULL(pmma.BPMJ_WORK_DATE,'') as c63 ,"+
	    //" IFNULL(pmma.BPMJ_WORK_TIME,'') as c64 ,"+
	    " IFNULL(pmma.BPMJ_STAFF_USERNAME,'') as c65 ,"+
	    " IFNULL(pmma.BPMJ_STAFF_FIRST_NAME,'') as c66 ,"+
	    " IFNULL(pmma.BPMJ_STAFF_LAST_NAME,'') as c67 ,"+
	    " IFNULL(pmma.BPMJ_STAFF_POSITION,'') as c68 ,"+
	    " IFNULL(pmma.BPMJ_CUSTOMER_FIRST_NAME,'') as c69 ,"+
	    " IFNULL(pmma.BPMJ_CUSTOMER_LAST_NAME,'') as c70 ,"+
	    " IFNULL(pmma.BPMJ_CUSTOMER_POSITION,'') as c71 ,"+ 
	    " IFNULL(DATE_FORMAT(pmma.BPMJ_DUEDATE_END_TIME,'%H:%i'),'') as c72 ,"+
	    " IFNULL(pmma.BPMJ_ORDER,'') as c73 ,"+
	    " IFNULL(pmma.BPMJ_JOB_STATUS,'') as c74 ,"+
	    " IFNULL(pmma.BPMJ_CENTER,'') as c75 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_1,'') as c76 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_2,'') as c77 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_3,'') as c78 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_4,'') as c79 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_5,'') as c80 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_NAME_6,'') as c81 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_1,'') as c82 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_2,'') as c83 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_3,'') as c84 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_4,'') as c85 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_5,'') as c86 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_PATH_6,'') as c87 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_1,'') as c88 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_2,'') as c89 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_3,'') as c90 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_4,'') as c91 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_5,'') as c92 ,"+
	    " IFNULL(pmma.BPMJ_DOC_ATTACH_HOTLINK_6,'')  as c93 , "+
	    " IFNULL(pmma.BPMJ_SO_NO,'')  as c94 "+
	    " FROM "+SCHEMA_G+".BPM_PM_MA_JOB pmma "+
	    " 	left join "+SCHEMA_G+".BPM_ARMAS armas on armas.CUSCOD=pmma.BPMJ_CUST_CODE "+
	     " where   pmma.BPMJ_NO='"+bpmmaIds[0]+"' and  pmma.BPMJ_ORDER="+bpmmaIds[2]+""; 
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
					//alert(data)
					 
					 var BPMJ_NO=data[0][94]; $("#BPMJ_NO").val(BPMJ_NO); 
					 var BPMJ_CREATED_DATE=data[0][1]; $("#BPMJ_CREATED_DATE").val(BPMJ_CREATED_DATE); 
					 var BPMJ_DUEDATE=data[0][2]; $("#BPMJ_DUEDATE").val(BPMJ_DUEDATE); 
					 var BPMJ_DUEDATE_START_TIME=data[0][3]; $("#BPMJ_DUEDATE_START_TIME").val(BPMJ_DUEDATE_START_TIME); 
					 var BPMJ_CUST_CODE=data[0][4]; $("#BPMJ_CUST_CODE").val(BPMJ_CUST_CODE);  
					 var BPMJ_CUST_NAME=data[0][5]; $("#BPMJ_CUST_NAME").val(BPMJ_CUST_NAME); 
					 var BPMJ_LOCATION=data[0][6]; $("#BPMJ_LOCATION").val(BPMJ_LOCATION);
					 var BPMJ_ADDR1=data[0][7]; $("#BPMJ_ADDR1").val(BPMJ_ADDR1); 
					 var BPMJ_ADDR2=data[0][8]; $("#BPMJ_ADDR2").val(BPMJ_ADDR2); 
					 var BPMJ_ADDR3=data[0][9]; $("#BPMJ_ADDR3").val(BPMJ_ADDR3);  
					 var BPMJ_PROVINCE=data[0][10]; $("#BPMJ_PROVINCE").val(BPMJ_PROVINCE); 
					
					 var BPMJ_ZIPCODE=data[0][11]; $("#BPMJ_ZIPCODE").val(BPMJ_ZIPCODE); 
					 var BPMJ_TEL_FAX=data[0][12]; $("#BPMJ_TEL_FAX").val(BPMJ_TEL_FAX); 
					 var BPMJ_CONTACT_NAME=data[0][13]; $("#BPMJ_CONTACT_NAME").val(BPMJ_CONTACT_NAME); 
					 var BPMJ_CONTACT_SURNAME=data[0][14]; $("#BPMJ_CONTACT_SURNAME").val(BPMJ_CONTACT_SURNAME); 
					 var BPMJ_CONTACT_POSITION=data[0][15]; $("#BPMJ_CONTACT_POSITION").val(BPMJ_CONTACT_POSITION); 
					 var BPMJ_CONTACT_MOBILE=data[0][16]; $("#BPMJ_CONTACT_MOBILE").val(BPMJ_CONTACT_MOBILE); 
					 var BPMJ_UPS_MODEL=data[0][17]; $("#BPMJ_UPS_MODEL").val(BPMJ_UPS_MODEL); 
					 var BPMJ_SERAIL=data[0][18]; $("#BPMJ_SERAIL").val(BPMJ_SERAIL); 
					 var BPMJ_VOTE=data[0][19]; $("#BPMJ_VOTE").val(BPMJ_VOTE);  
					
					 var BPMJ_UPS_TEST1_IS_PASS=data[0][20]; //$("#BPMJ_UPS_TEST1_IS_PASS").val(BPMJ_UPS_TEST1_IS_PASS); 
					 $('input[name="BPMJ_UPS_TEST1_IS_PASS"][value="' + BPMJ_UPS_TEST1_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST1_NOTE=data[0][21]; $("#BPMJ_UPS_TEST1_NOTE").val(BPMJ_UPS_TEST1_NOTE); 
					
					 var BPMJ_UPS_TEST2_IS_PASS=data[0][22];  
					 $('input[name="BPMJ_UPS_TEST2_IS_PASS"][value="' + BPMJ_UPS_TEST2_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST2_NOTE=data[0][23]; $("#BPMJ_UPS_TEST2_NOTE").val(BPMJ_UPS_TEST2_NOTE); 
					 
					 var BPMJ_UPS_TEST3_IS_PASS=data[0][24];
					 $('input[name="BPMJ_UPS_TEST3_IS_PASS"][value="' + BPMJ_UPS_TEST3_IS_PASS + '"]').prop('checked', true);
					 
					 var BPMJ_UPS_TEST3_NOTE=data[0][25]; $("#BPMJ_UPS_TEST3_NOTE").val(BPMJ_UPS_TEST3_NOTE); 
					 var BPMJ_UPS_TEST4_IS_PASS=data[0][26];
					 $('input[name="BPMJ_UPS_TEST4_IS_PASS"][value="' + BPMJ_UPS_TEST4_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST4_NOTE=data[0][27]; $("#BPMJ_UPS_TEST4_NOTE").val(BPMJ_UPS_TEST4_NOTE); 
					 var BPMJ_UPS_TEST5_IS_PASS=data[0][28]; 
					 $('input[name="BPMJ_UPS_TEST5_IS_PASS"][value="' + BPMJ_UPS_TEST5_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST5_NOTE=data[0][29]; $("#BPMJ_UPS_TEST5_NOTE").val(BPMJ_UPS_TEST5_NOTE); 
					 var BPMJ_UPS_TEST6_IS_PASS=data[0][30]; 
					 $('input[name="BPMJ_UPS_TEST6_IS_PASS"][value="' + BPMJ_UPS_TEST6_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST6_NOTE=data[0][31]; $("#BPMJ_UPS_TEST6_NOTE").val(BPMJ_UPS_TEST6_NOTE); 
					 var BPMJ_UPS_TEST7_IS_PASS=data[0][32]; 
					 $('input[name="BPMJ_UPS_TEST7_IS_PASS"][value="' + BPMJ_UPS_TEST7_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST7_NOTE=data[0][33]; $("#BPMJ_UPS_TEST7_NOTE").val(BPMJ_UPS_TEST7_NOTE); 
					 var BPMJ_UPS_TEST8_IS_PASS=data[0][34];
					 $('input[name="BPMJ_UPS_TEST8_IS_PASS"][value="' + BPMJ_UPS_TEST8_IS_PASS + '"]').prop('checked', true);
					 var BPMJ_UPS_TEST8_NOTE=data[0][35]; $("#BPMJ_UPS_TEST8_NOTE").val(BPMJ_UPS_TEST8_NOTE); 
					 var BPMJ_WORK_LOAD_INV_CURRENT_IN=data[0][36]; $("#BPMJ_WORK_LOAD_INV_CURRENT_IN").val(BPMJ_WORK_LOAD_INV_CURRENT_IN); 
					 var BPMJ_WORK_LOAD_INV_CURRENT_OUT=data[0][37]; $("#BPMJ_WORK_LOAD_INV_CURRENT_OUT").val(BPMJ_WORK_LOAD_INV_CURRENT_OUT); 
					 var BPMJ_WORK_LOAD_INV_VOLTAGE_IN=data[0][38];  $("#BPMJ_WORK_LOAD_INV_VOLTAGE_IN").val(BPMJ_WORK_LOAD_INV_VOLTAGE_IN); 
					 
					 var BPMJ_WORK_LOAD_INV_VOLTAGE_OUT=data[0][39]; $("#BPMJ_WORK_LOAD_INV_VOLTAGE_OUT").val(BPMJ_WORK_LOAD_INV_VOLTAGE_OUT); 
					 var BPMJ_WORK_LOAD_INV_VERIFICATION_IN=data[0][40];
					 $('input[name="BPMJ_WORK_LOAD_INV_VERIFICATION_IN"][value="' + BPMJ_WORK_LOAD_INV_VERIFICATION_IN + '"]').prop('checked', true); 
					 var BPMJ_WORK_LOAD_INV_VERIFICATION_OUT=data[0][41]; 
					 $('input[name="BPMJ_WORK_LOAD_INV_VERIFICATION_OUT"][value="' + BPMJ_WORK_LOAD_INV_VERIFICATION_OUT + '"]').prop('checked', true); 
					 var BPMJ_WORK_LOAD_INV__PERCENT_LOAD=data[0][42]; $("#BPMJ_WORK_LOAD_INV__PERCENT_LOAD").val(BPMJ_WORK_LOAD_INV__PERCENT_LOAD); 
					 
					 var BPMJ_WORK_LOAD_BYPASS_CURRENT_IN=data[0][43]; $("#BPMJ_WORK_LOAD_BYPASS_CURRENT_IN").val(BPMJ_WORK_LOAD_BYPASS_CURRENT_IN); 
					 var BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT=data[0][44]; $("#BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT").val(BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT); 
					 var BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN=data[0][45]; $("#BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN").val(BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN); 
					 var BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT=data[0][46]; $("#BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT").val(BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT); 
					 var BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN=data[0][47];
					 $('input[name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN"][value="' + BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN + '"]').prop('checked', true); 
					  
					 var BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT=data[0][48];
					 $('input[name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT"][value="' + BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT + '"]').prop('checked', true); 
					  var BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD=data[0][49]; $("#BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD").val(BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD); 
					 var BPMJ_BATTERY_BACKUP_TIME=data[0][50]; $("#BPMJ_BATTERY_BACKUP_TIME").val(BPMJ_BATTERY_BACKUP_TIME); 
					 var BPMJ_BATTERY_CHARGE_ON=data[0][51]; $("#BPMJ_BATTERY_CHARGE_ON").val(BPMJ_BATTERY_CHARGE_ON); 
					 var BPMJ_BATTERY_CHARGE_OFF=data[0][52]; $("#BPMJ_BATTERY_CHARGE_OFF").val(BPMJ_BATTERY_CHARGE_OFF); 
					 var BPMJ_BATTERY_CABLE_STATUS=data[0][53];  
					 $('input[name="BPMJ_BATTERY_CABLE_STATUS"][value="' + BPMJ_BATTERY_CABLE_STATUS + '"]').prop('checked', true);
					 var BPMJ_BATTERY_EXTERNAL_STATUS=data[0][54];  
					 $('input[name="BPMJ_BATTERY_EXTERNAL_STATUS"][value="' + BPMJ_BATTERY_EXTERNAL_STATUS + '"]').prop('checked', true);
					 var BPMJ_BREAKER_AMOUNT=data[0][55]; $("#BPMJ_BREAKER_AMOUNT").val(BPMJ_BREAKER_AMOUNT); 
					 var BPMJ_BREAKER_SIZE_1=data[0][56]; $("#BPMJ_BREAKER_SIZE_1").val(BPMJ_BREAKER_SIZE_1); 
					 var BPMJ_BREAKER_SIZE_2=data[0][57]; $("#BPMJ_BREAKER_SIZE_2").val(BPMJ_BREAKER_SIZE_2); 
					 var BPMJ_IS_MAINTAIN1=data[0][58];  
					 $('input[id="BPMJ_IS_MAINTAIN1"][value="' + BPMJ_IS_MAINTAIN1 + '"]').prop('checked', true);
					 var BPMJ_IS_MAINTAIN2=data[0][59];  
					 $('input[id="BPMJ_IS_MAINTAIN2"][value="' + BPMJ_IS_MAINTAIN2 + '"]').prop('checked', true);
					 var BPMJ_NOTE=data[0][60]; $("#BPMJ_NOTE").val(BPMJ_NOTE); 
					 var BPMJ_IS_RECOMMEND1=data[0][61]; 
					 $('input[id="BPMJ_IS_RECOMMEND1"][value="' + BPMJ_IS_RECOMMEND1 + '"]').prop('checked', true);
					 var BPMJ_IS_RECOMMEND2=data[0][62]; 
					 $('input[id="BPMJ_IS_RECOMMEND2"][value="' + BPMJ_IS_RECOMMEND2 + '"]').prop('checked', true); 
					 var BPMJ_WORK_DATE=data[0][63]; $("#BPMJ_WORK_DATE").val(BPMJ_WORK_DATE); 
					 var BPMJ_WORK_TIME=data[0][64]; $("#BPMJ_WORK_TIME").val(BPMJ_WORK_TIME); 
					 var BPMJ_STAFF_USERNAME=data[0][65]; $("#BPMJ_STAFF_USERNAME").val(BPMJ_STAFF_USERNAME); 
					 var BPMJ_STAFF_FIRST_NAME=data[0][66]; $("#BPMJ_STAFF_FIRST_NAME").val(BPMJ_STAFF_FIRST_NAME); 
					 var BPMJ_STAFF_LAST_NAME=data[0][67]; $("#BPMJ_STAFF_LAST_NAME").val(BPMJ_STAFF_LAST_NAME); 
					 var BPMJ_STAFF_POSITION=data[0][68]; $("#BPMJ_STAFF_POSITION").val(BPMJ_STAFF_POSITION); 
					 var BPMJ_CUSTOMER_FIRST_NAME=data[0][69]; $("#BPMJ_CUSTOMER_FIRST_NAME").val(BPMJ_CUSTOMER_FIRST_NAME); 
					 var BPMJ_CUSTOMER_LAST_NAME=data[0][70]; $("#BPMJ_CUSTOMER_LAST_NAME").val(BPMJ_CUSTOMER_LAST_NAME); 
					 var BPMJ_CUSTOMER_POSITION =data[0][71]; $("#BPMJ_CUSTOMER_POSITION").val(BPMJ_CUSTOMER_POSITION);  
					 var BPMJ_DUEDATE_END_TIME =data[0][72]; $("#BPMJ_DUEDATE_END_TIME").val(BPMJ_DUEDATE_END_TIME); 
					    var BPMJ_ORDER=data[0][73]; $("#BPMJ_ORDER").val(BPMJ_ORDER); 
					    var BPMJ_JOB_STATUS=data[0][74]; $("#BPMJ_JOB_STATUS").val(BPMJ_JOB_STATUS);
					    //alert(BPMJ_JOB_STATUS)
					    if(BPMJ_JOB_STATUS=='3'){
					        $("#close_job_element").show();
					        $("#back_job_element").show();
				        }
					   
					    var BPMJ_CENTER=data[0][75]; $("#BPMJ_CENTER").val(BPMJ_CENTER); 
					    var BPMJ_DOC_ATTACH_NAME_1=data[0][76]; $("#BPMJ_DOC_ATTACH_NAME_1").val(BPMJ_DOC_ATTACH_NAME_1); 
					    var BPMJ_DOC_ATTACH_NAME_2=data[0][77]; $("#BPMJ_DOC_ATTACH_NAME_2").val(BPMJ_DOC_ATTACH_NAME_2); 
					    var BPMJ_DOC_ATTACH_NAME_3=data[0][78]; $("#BPMJ_DOC_ATTACH_NAME_3").val(BPMJ_DOC_ATTACH_NAME_3); 
					    var BPMJ_DOC_ATTACH_NAME_4=data[0][79]; $("#BPMJ_DOC_ATTACH_NAME_4").val(BPMJ_DOC_ATTACH_NAME_4); 
					    var BPMJ_DOC_ATTACH_NAME_5=data[0][80]; $("#BPMJ_DOC_ATTACH_NAME_5").val(BPMJ_DOC_ATTACH_NAME_5); 
					    var BPMJ_DOC_ATTACH_NAME_6=data[0][81]; $("#BPMJ_DOC_ATTACH_NAME_6").val(BPMJ_DOC_ATTACH_NAME_6);  
					    
					    var BPMJ_DOC_ATTACH_PATH_1=data[0][82]; $("#BPMJ_DOC_ATTACH_PATH_1").val(BPMJ_DOC_ATTACH_PATH_1); 
					    var BPMJ_DOC_ATTACH_PATH_2=data[0][83]; $("#BPMJ_DOC_ATTACH_PATH_2").val(BPMJ_DOC_ATTACH_PATH_2); 
					    var BPMJ_DOC_ATTACH_PATH_3=data[0][84]; $("#BPMJ_DOC_ATTACH_PATH_3").val(BPMJ_DOC_ATTACH_PATH_3); 
					    var BPMJ_DOC_ATTACH_PATH_4=data[0][85]; $("#BPMJ_DOC_ATTACH_PATH_4").val(BPMJ_DOC_ATTACH_PATH_4); 
					    var BPMJ_DOC_ATTACH_PATH_5=data[0][86]; $("#BPMJ_DOC_ATTACH_PATH_5").val(BPMJ_DOC_ATTACH_PATH_5); 
					    var BPMJ_DOC_ATTACH_PATH_6=data[0][87]; $("#BPMJ_DOC_ATTACH_PATH_6").val(BPMJ_DOC_ATTACH_PATH_6); 
					    
					    var BPMJ_DOC_ATTACH_HOTLINK_1=data[0][88]; $("#BPMJ_DOC_ATTACH_HOTLINK_1").val(BPMJ_DOC_ATTACH_HOTLINK_1); 
					    var BPMJ_DOC_ATTACH_HOTLINK_2=data[0][89]; $("#BPMJ_DOC_ATTACH_HOTLINK_2").val(BPMJ_DOC_ATTACH_HOTLINK_2); 
					    var BPMJ_DOC_ATTACH_HOTLINK_3=data[0][90]; $("#BPMJ_DOC_ATTACH_HOTLINK_3").val(BPMJ_DOC_ATTACH_HOTLINK_3); 
					    var BPMJ_DOC_ATTACH_HOTLINK_4=data[0][91]; $("#BPMJ_DOC_ATTACH_HOTLINK_4").val(BPMJ_DOC_ATTACH_HOTLINK_4);  
					    var BPMJ_DOC_ATTACH_HOTLINK_5=data[0][92]; $("#BPMJ_DOC_ATTACH_HOTLINK_5").val(BPMJ_DOC_ATTACH_HOTLINK_5); 
					    var BPMJ_DOC_ATTACH_HOTLINK_6=data[0][93]; $("#BPMJ_DOC_ATTACH_HOTLINK_6").val(BPMJ_DOC_ATTACH_HOTLINK_6);  
					    
					    $("#BPMJ_DOC_ATTACH_1_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_1_SRC").html(BPMJ_DOC_ATTACH_NAME_1);
						$("#BPMJ_DOC_ATTACH_1_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_1/"+BPMJ_DOC_ATTACH_HOTLINK_1+"')")
						
						$("#BPMJ_DOC_ATTACH_2_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_2_SRC").html(BPMJ_DOC_ATTACH_NAME_2);
						$("#BPMJ_DOC_ATTACH_2_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_2/"+BPMJ_DOC_ATTACH_HOTLINK_2+"')")
						
						$("#BPMJ_DOC_ATTACH_3_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_3_SRC").html(BPMJ_DOC_ATTACH_NAME_3);
						$("#BPMJ_DOC_ATTACH_3_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_3/"+BPMJ_DOC_ATTACH_HOTLINK_3+"')")
						
						$("#BPMJ_DOC_ATTACH_4_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_4_SRC").html(BPMJ_DOC_ATTACH_NAME_4);
						$("#BPMJ_DOC_ATTACH_4_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_4/"+BPMJ_DOC_ATTACH_HOTLINK_4+"')")
						
						$("#BPMJ_DOC_ATTACH_5_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_5_SRC").html(BPMJ_DOC_ATTACH_NAME_5);
						$("#BPMJ_DOC_ATTACH_5_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_5/"+BPMJ_DOC_ATTACH_HOTLINK_5+"')")
						
						$("#BPMJ_DOC_ATTACH_6_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
						$("#BPMJ_DOC_ATTACH_6_SRC").html(BPMJ_DOC_ATTACH_NAME_6);
						$("#BPMJ_DOC_ATTACH_6_SRC").attr("onclick","loadFile('getfile/PMMA/${bpmmaId}_6/"+BPMJ_DOC_ATTACH_HOTLINK_6+"')")
					    /* */
				}
			}});
 }
 function doUpdatePMMAJob(mode){ 
	 var   bpmmaIds=  '${bpmmaId}'.split("_");
		 var BPMJ_NO = jQuery.trim($("#BPMJ_NO").val()); 
		  var BPMJ_CREATED_DATE = jQuery.trim($("#BPMJ_CREATED_DATE").val());
		  var BPMJ_DUEDATE = jQuery.trim($("#BPMJ_DUEDATE").val());
		  var BPMJ_DUEDATE_START_TIME = jQuery.trim($("#BPMJ_DUEDATE_START_TIME").val());
		   
		  var BPMJ_CUST_CODE = jQuery.trim($("#BPMJ_CUST_CODE").val()); 
		  var BPMJ_CUST_NAME = jQuery.trim($("#BPMJ_CUST_NAME").val());  
		  var BPMJ_LOCATION = jQuery.trim($("#BPMJ_LOCATION").val());  
		  var BPMJ_ADDR1 = jQuery.trim($("#BPMJ_ADDR1").val());  
		  var BPMJ_ADDR2 = jQuery.trim($("#BPMJ_ADDR2").val());  
		  var BPMJ_ADDR3 = jQuery.trim($("#BPMJ_ADDR3").val()); 
		  var BPMJ_PROVINCE = jQuery.trim($("#BPMJ_PROVINCE").val()); 
		  var BPMJ_ZIPCODE = jQuery.trim($("#BPMJ_ZIPCODE").val()); 
		  var BPMJ_TEL_FAX = jQuery.trim($("#BPMJ_TEL_FAX").val());  
		  var BPMJ_CONTACT_NAME = jQuery.trim($("#BPMJ_CONTACT_NAME").val());  
		  var BPMJ_CONTACT_SURNAME = jQuery.trim($("#BPMJ_CONTACT_SURNAME").val()); 
		  var BPMJ_CONTACT_POSITION = jQuery.trim($("#BPMJ_CONTACT_POSITION").val()); 
		  var BPMJ_CONTACT_MOBILE = jQuery.trim($("#BPMJ_CONTACT_MOBILE").val()); 
		  var BPMJ_UPS_MODEL = jQuery.trim($("#BPMJ_UPS_MODEL").val());  
		  var BPMJ_SERAIL = jQuery.trim($("#BPMJ_SERAIL").val());  
		  var BPMJ_VOTE = jQuery.trim($("#BPMJ_VOTE").val()); 
		 // var BPMJ_UPS_TEST1_IS_PASS = jQuery.trim($("#BPMJ_UPS_TEST1_IS_PASS").val());
		  var BPMJ_UPS_TEST1_IS_PASS =jQuery.trim($("input[name=BPMJ_UPS_TEST1_IS_PASS]:checked" ).val()); 
		   
		  var BPMJ_UPS_TEST1_NOTE = jQuery.trim($("#BPMJ_UPS_TEST1_NOTE").val()); 
		  var BPMJ_UPS_TEST2_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST2_IS_PASS]:checked" ).val());   
		    var BPMJ_UPS_TEST2_NOTE = jQuery.trim($("#BPMJ_UPS_TEST2_NOTE").val());  
		    var BPMJ_UPS_TEST3_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST3_IS_PASS]:checked" ).val());  
		    var BPMJ_UPS_TEST3_NOTE = jQuery.trim($("#BPMJ_UPS_TEST3_NOTE").val());  
		    var BPMJ_UPS_TEST4_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST4_IS_PASS]:checked" ).val());  
		    var BPMJ_UPS_TEST4_NOTE = jQuery.trim($("#BPMJ_UPS_TEST4_NOTE").val());  
		    var BPMJ_UPS_TEST5_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST5_IS_PASS]:checked" ).val());  
		    var BPMJ_UPS_TEST5_NOTE = jQuery.trim($("#BPMJ_UPS_TEST5_NOTE").val()); 
		    var BPMJ_UPS_TEST6_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST6_IS_PASS]:checked" ).val());  
		    var BPMJ_UPS_TEST6_NOTE = jQuery.trim($("#BPMJ_UPS_TEST6_NOTE").val());  
		    var BPMJ_UPS_TEST7_IS_PASS = jQuery.trim($("input[name=BPMJ_UPS_TEST7_IS_PASS]:checked" ).val()); 
		    var BPMJ_UPS_TEST7_NOTE = jQuery.trim($("#BPMJ_UPS_TEST7_NOTE").val());  
		    var BPMJ_UPS_TEST8_IS_PASS =jQuery.trim($("input[name=BPMJ_UPS_TEST8_IS_PASS]:checked" ).val()); 
		    var BPMJ_UPS_TEST8_NOTE = jQuery.trim($("#BPMJ_UPS_TEST8_NOTE").val());  
		    var BPMJ_WORK_LOAD_INV_CURRENT_IN = jQuery.trim($("#BPMJ_WORK_LOAD_INV_CURRENT_IN").val()); 
		    var BPMJ_WORK_LOAD_INV_CURRENT_OUT = jQuery.trim($("#BPMJ_WORK_LOAD_INV_CURRENT_OUT").val());  
		    var BPMJ_WORK_LOAD_INV_VOLTAGE_IN = jQuery.trim($("#BPMJ_WORK_LOAD_INV_VOLTAGE_IN").val()); 
		    var BPMJ_WORK_LOAD_INV_VOLTAGE_OUT = jQuery.trim($("#BPMJ_WORK_LOAD_INV_VOLTAGE_OUT").val());  
		    var BPMJ_WORK_LOAD_INV_VERIFICATION_IN = jQuery.trim($("input[name=BPMJ_WORK_LOAD_INV_VERIFICATION_IN]:checked" ).val()); 
		    
		    var BPMJ_WORK_LOAD_INV_VERIFICATION_OUT =jQuery.trim($("input[name=BPMJ_WORK_LOAD_INV_VERIFICATION_OUT]:checked" ).val());
		    var BPMJ_WORK_LOAD_INV__PERCENT_LOAD = jQuery.trim($("#BPMJ_WORK_LOAD_INV__PERCENT_LOAD").val());  
		    var BPMJ_WORK_LOAD_BYPASS_CURRENT_IN = jQuery.trim($("#BPMJ_WORK_LOAD_BYPASS_CURRENT_IN").val());   
		    var BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT = jQuery.trim($("#BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT").val()); 
		    var BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN = jQuery.trim($("#BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN").val()); 
		    var BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT = jQuery.trim($("#BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT").val());  
		    var BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN = jQuery.trim($("input[name=BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN]:checked" ).val()); 
		    var BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT = jQuery.trim($("input[name=BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT]:checked" ).val());
		    var BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD = jQuery.trim($("#BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD").val());  
		    var BPMJ_BATTERY_BACKUP_TIME = jQuery.trim($("#BPMJ_BATTERY_BACKUP_TIME").val());  
		    var BPMJ_BATTERY_CHARGE_ON = jQuery.trim($("#BPMJ_BATTERY_CHARGE_ON").val());  
		    var BPMJ_BATTERY_CHARGE_OFF = jQuery.trim($("#BPMJ_BATTERY_CHARGE_OFF").val());  
		    var BPMJ_BATTERY_CABLE_STATUS = jQuery.trim($("input[name=BPMJ_BATTERY_CABLE_STATUS]:checked" ).val());
		    var BPMJ_BATTERY_EXTERNAL_STATUS = jQuery.trim($("input[name=BPMJ_BATTERY_EXTERNAL_STATUS]:checked" ).val());
		   
		    var BPMJ_BREAKER_AMOUNT = jQuery.trim($("#BPMJ_BREAKER_AMOUNT").val());  
		  //  BPMJ_BREAKER_AMOUNT
		    var BPMJ_BREAKER_SIZE_1 = jQuery.trim($("#BPMJ_BREAKER_SIZE_1").val()); 
		    var BPMJ_BREAKER_SIZE_2 = jQuery.trim($("#BPMJ_BREAKER_SIZE_2").val());  
		    var BPMJ_IS_MAINTAIN1 =  jQuery.trim($("input[id=BPMJ_IS_MAINTAIN1]:checked" ).val());   
		    var BPMJ_IS_MAINTAIN2 =  jQuery.trim($("input[id=BPMJ_IS_MAINTAIN2]:checked" ).val());
		    var BPMJ_NOTE = jQuery.trim($("#BPMJ_NOTE").val());  
		    var BPMJ_IS_RECOMMEND1 =jQuery.trim($("input[id=BPMJ_IS_RECOMMEND1]:checked" ).val());
		    var BPMJ_IS_RECOMMEND2 = jQuery.trim($("input[id=BPMJ_IS_RECOMMEND2]:checked" ).val());
		    var BPMJ_WORK_DATE  = jQuery.trim($("#BPMJ_WORK_DATE").val()); 
		    var BPMJ_WORK_TIME  = jQuery.trim($("#BPMJ_WORK_TIME").val());  
		    if(BPMJ_WORK_DATE.length>0){
		    	BPMJ_WORK_DATE=BPMJ_WORK_DATE.split("/");
		    	BPMJ_WORK_DATE="'"+BPMJ_WORK_DATE[2]+"-"+BPMJ_WORK_DATE[1]+"-"+BPMJ_WORK_DATE[0]+"'";
		    } 
		    else
		    		BPMJ_WORK_DATE="null";
		    if(BPMJ_WORK_TIME.length>0){
		    	BPMJ_WORK_TIME="'"+BPMJ_WORK_TIME+"'";
		    }else
		    	BPMJ_WORK_TIME=null;
		   //  var BPMJ_WORK_DATE = jQuery.trim($("#SBJ_ONSITE_DETECTED").val()); c63 ,"+
		    // var BPMJ_WORK_TIME = jQuery.trim($("#SBJ_ONSITE_DETECTED").val()); c64 ,"+
		     var BPMJ_STAFF_USERNAME = jQuery.trim($("#BPMJ_STAFF_USERNAME").val());  
		     var BPMJ_STAFF_FIRST_NAME = jQuery.trim($("#BPMJ_STAFF_FIRST_NAME").val()); 
		     var BPMJ_STAFF_LAST_NAME = jQuery.trim($("#BPMJ_STAFF_LAST_NAME").val());  
		     var BPMJ_STAFF_POSITION = jQuery.trim($("#BPMJ_STAFF_POSITION").val());  
		     var BPMJ_CUSTOMER_FIRST_NAME = jQuery.trim($("#BPMJ_CUSTOMER_FIRST_NAME").val()); 
		     var BPMJ_CUSTOMER_LAST_NAME = jQuery.trim($("#BPMJ_CUSTOMER_LAST_NAME").val());  
		     var BPMJ_CUSTOMER_POSITION = jQuery.trim($("#BPMJ_CUSTOMER_POSITION").val());  
		     var BPMJ_DUEDATE_END_TIME  = jQuery.trim($("#BPMJ_DUEDATE_END_TIME").val()); 
		    var BPMJ_ORDER = jQuery.trim($("#BPMJ_ORDER").val());  
		    var BPMJ_JOB_STATUS = jQuery.trim($("#BPMJ_JOB_STATUS").val());  
		    var BPMJ_CENTER = jQuery.trim($("#BPMJ_CENTER").val()); 
		    var BPMJ_DOC_ATTACH_NAME_1 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_1").val()); 
		    var BPMJ_DOC_ATTACH_NAME_2 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_2").val()); 
		    var BPMJ_DOC_ATTACH_NAME_3 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_3").val()); 
		    var BPMJ_DOC_ATTACH_NAME_4 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_4").val()); 
		    var BPMJ_DOC_ATTACH_NAME_5 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_5").val());  
		    var BPMJ_DOC_ATTACH_NAME_6 = jQuery.trim($("#BPMJ_DOC_ATTACH_NAME_6").val()); 
		    var BPMJ_DOC_ATTACH_PATH_1 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_1").val()); 
		    var BPMJ_DOC_ATTACH_PATH_2 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_2").val()); 
		    var BPMJ_DOC_ATTACH_PATH_3 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_3").val()); 
		    var BPMJ_DOC_ATTACH_PATH_4 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_4").val());  
		    var BPMJ_DOC_ATTACH_PATH_5 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_5").val());  
		    var BPMJ_DOC_ATTACH_PATH_6 = jQuery.trim($("#BPMJ_DOC_ATTACH_PATH_6").val());  
		    var BPMJ_DOC_ATTACH_HOTLINK_1 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_1").val());  
		    var BPMJ_DOC_ATTACH_HOTLINK_2 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_2").val()); 
		    var BPMJ_DOC_ATTACH_HOTLINK_3 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_3").val());  
		    var BPMJ_DOC_ATTACH_HOTLINK_4 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_4").val());  
		    var BPMJ_DOC_ATTACH_HOTLINK_5 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_5").val());  
		    var BPMJ_DOC_ATTACH_HOTLINK_6 = jQuery.trim($("#BPMJ_DOC_ATTACH_HOTLINK_6").val());
		  
		var query=" UPDATE "+SCHEMA_G+".BPM_PM_MA_JOB SET "+ 
		// On Site
		//" SBJ_ONSITE_DETECTED   = '"+SBJ_ONSITE_DETECTED+"' , "+ 
	//	 " BPMJ_CREATED_DATE = '"+BPMJ_CREATED_DATE+"' , "+ 
	//	 " BPMJ_DUEDATE = '"+BPMJ_DUEDATE+"' , "+ 
	//	 " BPMJ_DUEDATE_START_TIME = '"+BPMJ_DUEDATE_START_TIME+"' , "+ 
		   
		 " BPMJ_CUST_CODE = '"+BPMJ_CUST_CODE+"' , "+  
		  " BPMJ_CUST_NAME = '"+BPMJ_CUST_NAME+"' , "+   
		 " BPMJ_LOCATION = '"+BPMJ_LOCATION+"' , "+   
		 " BPMJ_ADDR1 = '"+BPMJ_ADDR1+"' , "+   
		 " BPMJ_ADDR2 = '"+BPMJ_ADDR2+"' , "+   
		 " BPMJ_ADDR3 = '"+BPMJ_ADDR3+"' , "+  
		 " BPMJ_PROVINCE = '"+BPMJ_PROVINCE+"' , "+  
		 " BPMJ_ZIPCODE = '"+BPMJ_ZIPCODE+"' , "+  
		 " BPMJ_TEL_FAX = '"+BPMJ_TEL_FAX+"' , "+   
		  " BPMJ_CONTACT_NAME = '"+BPMJ_CONTACT_NAME+"' , "+   
		  " BPMJ_CONTACT_SURNAME = '"+BPMJ_CONTACT_SURNAME+"' , "+  
		  " BPMJ_CONTACT_POSITION = '"+BPMJ_CONTACT_POSITION+"' , "+  
		  " BPMJ_CONTACT_MOBILE = '"+BPMJ_CONTACT_MOBILE+"' , "+  
		  " BPMJ_UPS_MODEL = '"+BPMJ_UPS_MODEL+"' , "+   
		  " BPMJ_SERAIL = '"+BPMJ_SERAIL+"' , "+   
		  " BPMJ_VOTE = '"+BPMJ_VOTE+"' , "+  
		  " BPMJ_UPS_TEST1_IS_PASS = '"+BPMJ_UPS_TEST1_IS_PASS+"' , "+  
		  " BPMJ_UPS_TEST1_NOTE = '"+BPMJ_UPS_TEST1_NOTE+"' , "+  
		  " BPMJ_UPS_TEST2_IS_PASS = '"+BPMJ_UPS_TEST2_IS_PASS+"' , "+   
		  " BPMJ_UPS_TEST2_NOTE = '"+BPMJ_UPS_TEST2_NOTE+"' , "+   
		    " BPMJ_UPS_TEST3_IS_PASS = '"+BPMJ_UPS_TEST3_IS_PASS+"' , "+   
		    " BPMJ_UPS_TEST3_NOTE = '"+BPMJ_UPS_TEST3_NOTE+"' , "+   
		    " BPMJ_UPS_TEST4_IS_PASS = '"+BPMJ_UPS_TEST4_IS_PASS+"' , "+   
		    " BPMJ_UPS_TEST4_NOTE = '"+BPMJ_UPS_TEST4_NOTE+"' , "+   
		    " BPMJ_UPS_TEST5_IS_PASS = '"+BPMJ_UPS_TEST5_IS_PASS+"' , "+   
		    " BPMJ_UPS_TEST5_NOTE = '"+BPMJ_UPS_TEST5_NOTE+"' , "+  
		    " BPMJ_UPS_TEST6_IS_PASS = '"+BPMJ_UPS_TEST6_IS_PASS+"' , "+   
		    " BPMJ_UPS_TEST6_NOTE = '"+BPMJ_UPS_TEST6_NOTE+"' , "+   
		    " BPMJ_UPS_TEST7_IS_PASS = '"+BPMJ_UPS_TEST7_IS_PASS+"' , "+   
		    " BPMJ_UPS_TEST7_NOTE = '"+BPMJ_UPS_TEST7_NOTE+"' , "+   
		    " BPMJ_UPS_TEST8_IS_PASS = '"+BPMJ_UPS_TEST8_IS_PASS+"' , "+  
		    " BPMJ_UPS_TEST8_NOTE = '"+BPMJ_UPS_TEST8_NOTE+"' , "+   
		    " BPMJ_WORK_LOAD_INV_CURRENT_IN = '"+BPMJ_WORK_LOAD_INV_CURRENT_IN+"' , "+  
		    " BPMJ_WORK_LOAD_INV_CURRENT_OUT = '"+BPMJ_WORK_LOAD_INV_CURRENT_OUT+"' , "+   
		    " BPMJ_WORK_LOAD_INV_VOLTAGE_IN = '"+BPMJ_WORK_LOAD_INV_VOLTAGE_IN+"' , "+  
		    " BPMJ_WORK_LOAD_INV_VOLTAGE_OUT = '"+BPMJ_WORK_LOAD_INV_VOLTAGE_OUT+"' , "+   
		    " BPMJ_WORK_LOAD_INV_VERIFICATION_IN = '"+BPMJ_WORK_LOAD_INV_VERIFICATION_IN+"' , "+   
		    " BPMJ_WORK_LOAD_INV_VERIFICATION_OUT = '"+BPMJ_WORK_LOAD_INV_VERIFICATION_OUT+"' , "+   
		    " BPMJ_WORK_LOAD_INV__PERCENT_LOAD = '"+BPMJ_WORK_LOAD_INV__PERCENT_LOAD+"' , "+   
		    " BPMJ_WORK_LOAD_BYPASS_CURRENT_IN = '"+BPMJ_WORK_LOAD_BYPASS_CURRENT_IN+"' , "+    
		    " BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT = '"+BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT+"' , "+  
		    " BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN = '"+BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN+"' , "+  
		    " BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT = '"+BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT+"' , "+   
		    " BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN = '"+BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN+"' , "+   
		    " BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT = '"+BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT+"' , "+   
		    " BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD = '"+BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD+"' , "+   
		    " BPMJ_BATTERY_BACKUP_TIME = '"+BPMJ_BATTERY_BACKUP_TIME+"' , "+   
		    " BPMJ_BATTERY_CHARGE_ON = '"+BPMJ_BATTERY_CHARGE_ON+"' , "+   
		    " BPMJ_BATTERY_CHARGE_OFF = '"+BPMJ_BATTERY_CHARGE_OFF+"' , "+   
		    " BPMJ_BATTERY_CABLE_STATUS = '"+BPMJ_BATTERY_CABLE_STATUS+"' , "+   
		    " BPMJ_BATTERY_EXTERNAL_STATUS = '"+BPMJ_BATTERY_EXTERNAL_STATUS+"' , "+   
		    " BPMJ_BREAKER_AMOUNT = '"+BPMJ_BREAKER_AMOUNT+"' , "+   
		    " BPMJ_BREAKER_SIZE_1 = '"+BPMJ_BREAKER_SIZE_1+"' , "+  
		    " BPMJ_BREAKER_SIZE_2 = '"+BPMJ_BREAKER_SIZE_2+"' , "+   
		    " BPMJ_IS_MAINTAIN1 = '"+BPMJ_IS_MAINTAIN1+"' , "+    
		    " BPMJ_IS_MAINTAIN2 = '"+BPMJ_IS_MAINTAIN2+"' , "+   
		    " BPMJ_NOTE = '"+BPMJ_NOTE+"' , "+   
		    " BPMJ_IS_RECOMMEND1 = '"+BPMJ_IS_RECOMMEND1+"' , "+   
		    " BPMJ_IS_RECOMMEND2 = '"+BPMJ_IS_RECOMMEND2+"' , "+   
		    " BPMJ_WORK_DATE  = "+BPMJ_WORK_DATE+", "+  
		    " BPMJ_WORK_TIME  = "+BPMJ_WORK_TIME+" , "+   
		   //  var BPMJ_WORK_DATE = '"+SBJ_ONSITE_DETECTED+"' , "+  c63 ,"+
		    // var BPMJ_WORK_TIME = '"+SBJ_ONSITE_DETECTED+"' , "+  c64 ,"+
		    " BPMJ_STAFF_USERNAME = '"+BPMJ_STAFF_USERNAME+"' , "+   
		    " BPMJ_STAFF_FIRST_NAME = '"+BPMJ_STAFF_FIRST_NAME+"' , "+  
		    " BPMJ_STAFF_LAST_NAME = '"+BPMJ_STAFF_LAST_NAME+"' , "+   
		    " BPMJ_STAFF_POSITION = '"+BPMJ_STAFF_POSITION+"' , "+   
		    " BPMJ_CUSTOMER_FIRST_NAME = '"+BPMJ_CUSTOMER_FIRST_NAME+"' , "+  
		    " BPMJ_CUSTOMER_LAST_NAME = '"+BPMJ_CUSTOMER_LAST_NAME+"' , "+   
		    " BPMJ_CUSTOMER_POSITION = '"+BPMJ_CUSTOMER_POSITION+"' , "+   
		    " BPMJ_DUEDATE_END_TIME  = '"+BPMJ_DUEDATE_END_TIME+"' , "+  
		    " BPMJ_ORDER = '"+BPMJ_ORDER+"' , "+   
		//    " BPMJ_JOB_STATUS = '"+BPMJ_JOB_STATUS+"' , "+   
		//    " BPMJ_CENTER = '"+BPMJ_CENTER+"' , "+  
		    " BPMJ_DOC_ATTACH_NAME_1 = '"+BPMJ_DOC_ATTACH_NAME_1+"' , "+  
		    " BPMJ_DOC_ATTACH_NAME_2 = '"+BPMJ_DOC_ATTACH_NAME_2+"' , "+  
		    " BPMJ_DOC_ATTACH_NAME_3 = '"+BPMJ_DOC_ATTACH_NAME_3+"' , "+  
		    " BPMJ_DOC_ATTACH_NAME_4 = '"+BPMJ_DOC_ATTACH_NAME_4+"' , "+  
		    " BPMJ_DOC_ATTACH_NAME_5 = '"+BPMJ_DOC_ATTACH_NAME_5+"' , "+   
		    " BPMJ_DOC_ATTACH_NAME_6 = '"+BPMJ_DOC_ATTACH_NAME_6+"' , "+  
		    " BPMJ_DOC_ATTACH_PATH_1 = '"+BPMJ_DOC_ATTACH_PATH_1+"' , "+  
		    " BPMJ_DOC_ATTACH_PATH_2 = '"+BPMJ_DOC_ATTACH_PATH_2+"' , "+  
		    " BPMJ_DOC_ATTACH_PATH_3 = '"+BPMJ_DOC_ATTACH_PATH_3+"' , "+  
		    " BPMJ_DOC_ATTACH_PATH_4 = '"+BPMJ_DOC_ATTACH_PATH_4+"' , "+   
		    " BPMJ_DOC_ATTACH_PATH_5 = '"+BPMJ_DOC_ATTACH_PATH_5+"' , "+   
		    " BPMJ_DOC_ATTACH_PATH_6 = '"+BPMJ_DOC_ATTACH_PATH_6+"' , "+   
		    " BPMJ_DOC_ATTACH_HOTLINK_1 = '"+BPMJ_DOC_ATTACH_HOTLINK_1+"' , "+   
		    " BPMJ_DOC_ATTACH_HOTLINK_2 = '"+BPMJ_DOC_ATTACH_HOTLINK_2+"' , "+  
		    " BPMJ_DOC_ATTACH_HOTLINK_3 = '"+BPMJ_DOC_ATTACH_HOTLINK_3+"' , "+   
		    " BPMJ_DOC_ATTACH_HOTLINK_4 = '"+BPMJ_DOC_ATTACH_HOTLINK_4+"' , "+   
		    " BPMJ_DOC_ATTACH_HOTLINK_5 = '"+BPMJ_DOC_ATTACH_HOTLINK_5+"' , "+   
		    " BPMJ_DOC_ATTACH_HOTLINK_6 = '"+BPMJ_DOC_ATTACH_HOTLINK_6+"'  "; 
			query=query+" WHERE BPMJ_NO ='"+bpmmaIds[0]+"' and   BPMJ_SERAIL='"+bpmmaIds[1]+"'  and   BPMJ_ORDER="+bpmmaIds[2]+"";
			 
		 //alert(bpmmaIds[0]+","+bpmmaIds[2])
		 //alert(BPMJ_CUST_NAME)
		  return query;
	}
function doUpdateDataPMMA(){ 
	var query_update =doUpdatePMMAJob('update');
	// alert(query_update);
	 if(query_update!=false){
		// return false;
	   }else
	   	   return false;
// return false;
 //alert(query_update);
var querys=[];
 querys.push(query_update); 
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
			bootbox.dialog("แก้ใขข้อมูลเรียบร้อยแล้ว.",[{
			    "label" : "Ok",
			    "class" : "btn-primary",
			    "callback": function() {
			    	//loadDynamicPage('dispatcher/page/todolist')
			    }
			 }]);
		}
	}
});
}

function doClosePMMAJob(btdl_type,message_created,is_hide_todolist){   
	 var querys=[];  
		   if('${state}'!='' && is_hide_todolist){
		  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bpmmaId}' and "+
			"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' "; 
			 querys.push(query2); 
			 
		 }  
		 var   bpmmaIds=  '${bpmmaId}'.split("_"); 
			 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_JOB_STATUS='4' where    BPMJ_NO ='"+bpmmaIds[0]+"' and   BPMJ_SERAIL='"+bpmmaIds[1]+"'  and   BPMJ_ORDER="+bpmmaIds[2]+""; 
			  querys.push(query2); 
		 
			var query_update =doUpdatePMMAJob('update');
			 
			 if(query_update!=false){
				// return false;
			   }else
			   	   return false; 
		 querys.push(query_update); 
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
					    	loadDynamicPage('dispatcher/page/pm_ma_complete')
					    }
					 }]);
				}
			}
		});
		
	}

 function doClosePMMAJobToSub(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	 var querys=[];  
		var btdl_state_update='wait_for_supervisor_pmma_close';
		 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
				"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
				"('${bpmmaId}','"+btdl_type+"','"+btdl_state_update+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','"+$("#BPMJ_NO").val()+"') ";
		 if('${state}'!='' && is_hide_todolist){
		  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bpmmaId}' and "+
			"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' "; 
			 querys.push(query2); 
		 }  
		 var   bpmmaIds=  '${bpmmaId}'.split("_"); 
			 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_JOB_STATUS='3' where   BPMJ_NO ='"+bpmmaIds[0]+"' and   BPMJ_SERAIL='"+bpmmaIds[1]+"'  and   BPMJ_ORDER="+bpmmaIds[2]+""; 
			  querys.push(query2); 
		 
			var query_update =doUpdatePMMAJob('update');
			 
			 if(query_update!=false){
				// return false;
			   }else
			   	   return false; 
		 querys.push(query_update); 
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

 function clearSelect(ele_name){
	 $('input[name=\"'+ele_name+'\"]').prop('checked', false);
 }
 function getSelectEle(ele_name,ele_value){
	 $('input[name=\"'+ele_name+'\"][value="' + ele_value + '"]').prop('checked', true);
 }
 function show_hide_element(ele_name_source,ele_name,ele_value){
	 
    if($('#'+ele_name_source).prop('checked')){
    	 $('#'+ele_name).slideDown(1000);
    }else
    	 $('#'+ele_name).slideUp(1000); 
 }
 function show_hide(ele_name,ele_value){
	 if(ele_value=='1'){
		 $('#'+ele_name).show();
	 }else
		 $('#'+ele_name).hide();
 }
 function clearElementValue(ele){
	 $("#"+ele).val("");
 }
 function clearElementTimeValue(element){
	   $("#"+element).val("");
	// $("#BPMJ_DUEDATE_START_TIME").val("");
	// $("#BPMJ_DUEDATE_END_TIME").val(""); 
 }
</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px;padding-left:2px">
        <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px" bgcolor="#F9F9F9">
          <form id="breakdownForm" name="breakdownForm" class="well" action="" method="post">
            <fieldset style="font-family: sans-serif;">
              <div align="left">
                  <span><strong id="delivery_install_title">Job No. </strong>
                  <input type="hidden" id="BPMJ_ORDER" />
                    <input type="hidden" id="BPMJ_CUST_CODE" />
                  
                  <input type="text" id="BPMJ_NO" style="height: 30px;width: 125px" value=" " readonly="readonly"/>
                  </span> 
                   <span  style="padding-left: 5px"><strong>วันที่เปิดเอกสาร</strong>
                    <input type="text" readonly="readonly" style="width:130px; height: 30px;" id="BPMJ_CREATED_DATE" /> 
                  </span> 
                   <span  style="padding-left: 5px"><strong>เวลานัดหมาย</strong>
                    <input type="text" id="BPMJ_DUEDATE" style="width:100px; height: 30px;" value="" readonly="readonly">
                    ระบุเวลา
                    <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BPMJ_DUEDATE_START_TIME" type="text"> 
                                  - เวลา
                                  <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BPMJ_DUEDATE_END_TIME" type="text">
                                   
                  </span>  
                  
                    <c:if test="${isPMMAAccount}">
                    <span  style="padding-left: 50px">
                  <a class="btn btn-primary"  style="margin-top: -10px" onclick="doUpdateDataPMMA()"><span style="color: white;font-weight: bold;">แก้ใขข้อมูล</span></a>
                  </span>
                  </c:if>
                <br>
                <br>
              </div>
              <table border="0" width="100%" style="font-size: 12px;"> 
                    <tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="6%">
    					   				<span>
    					   					บริษัทปฏิบัติงาน:
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_CUST_NAME" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ชื่อผู้ติดต่อ:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_CONTACT_NAME" />
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					เบอร์โทร:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_CONTACT_MOBILE" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	<tr>
    					   		<td width="6%">
    					   				<span>
    					   					สถานที่ปฏิบัติงาน:
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_LOCATION" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ที่อยู่:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_ADDR1" />
    					   				</span> 
    					   		</td> 
    					   		<td width="6%">
    					   				<span>
    					   					แขวง/ตำบล:
    					   				</span>
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_ADDR2" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	<tr>
    					   		<td width="7%">
    					   				<span>
    					   					เขต/อำเภอ:
    					   				</span> 
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_ADDR3" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					จังหวัด:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_PROVINCE" />
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					รหัสไปรษณีย์:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_ZIPCODE" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   		<tr>
    					   		<td width="7%">
    					   				<span>
    					   					UPS รุ่น
    					   				</span> 
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_UPS_MODEL" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ขนาดจ่ายกำลัง:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="height: 30px;" id="BPMJ_VOTE" />VA.
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					หมายเลขเครื่อง:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BPMJ_SERAIL" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	</table> 
    					  </div>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					   <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px;">
	        					<thead> 	
	       							<tr> 
	        							<th width="45%"><div class="th_class">การทดสอบเครื่อง UPS</div></th> 
	        							<th width="5%"><div class="th_class">PASS</div></th> 
	        							<th width="5%"><div class="th_class">FAIL</div></th> 
	        							<th width="45%"><div class="th_class">NOTE</div></th> 
	        						</tr>
	       						</thead>
	        					<tbody>    
			   						<tr style="cursor: pointer;">
			    						<td style="text-align: left;">1. RECTIFIER </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST1_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST1_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST1_NOTE"/></td>  
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">2. INVERTER </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST2_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST2_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST2_NOTE"/></td> 
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">3. STATIC BYPASS SWITCH </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST3_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST3_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST3_NOTE"/></td>   
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">4. LED.MAIN PRESENT </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST4_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST4_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST4_NOTE"/></td> 
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">5. LED.MAIN FAIL (BEEP) </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST5_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST5_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST5_NOTE"/></td>   
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">6. LED.MAIN RETURN </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST6_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST6_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST6_NOTE"/></td> 
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">7. OPERATION ON BYPASS </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST7_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST7_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST7_NOTE"/></td> 
		            				</tr>  
		            				<tr style="cursor: pointer;">
			    						<td style="text-align: left;">8. WORKING ON BATTERY </td>     
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_UPS_TEST8_IS_PASS"/></td>    
		            					<td style="text-align: center;"><input type="radio" value="0" name="BPMJ_UPS_TEST8_IS_PASS"/></td>    		
		            					<td style="text-align: left;"><input type="text" style="width:500px;height: 30;" id="BPMJ_UPS_TEST8_NOTE"/></td>  
		            				</tr>  
		        				</tbody> 
	    					</table>   
    					  </div>
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					  	<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px;">
	        					<thead> 	
	       							<tr> 
	        							<th width="100%" colspan="10"><div class="th_class">ค่าใช้งาน LOAD</div></th> 
	        						</tr>
	        						<tr> 
	        							<th width="20%" colspan="2" rowspan="2"><div class="th_class">STATE</div></th> 
	        							<th width="20%" colspan="2" ><div class="th_class">CURRENT(A)</div></th> 
	        							<th width="20%" colspan="2" ><div class="th_class">VOLTAGE(V)</div></th> 
	        							<th width="20%" colspan="2" ><div class="th_class">VERIFICATION</div></th> 
	        							<th width="20%" colspan="2"  rowspan="2"><div class="th_class">% (LOAD)</div></th> 
	        						</tr>
	        						<tr> 
	        							<th width="10%"><div class="th_class">INPUT</div></th>
	        							<th width="10%"><div class="th_class">OUTPUT</div></th>
	        							<th width="10%"><div class="th_class">INPUT</div></th>
	        							<th width="10%"><div class="th_class">OUTPUT</div></th>
	        							<th width="10%"><div class="th_class">INPUT</div></th>
	        							<th width="10%"><div class="th_class">OUTPUT</div></th>
	        						</tr>
	       						</thead>
	        					<tbody>    
			   						<tr style="cursor: pointer;">
			    						<td colspan="2"  style="text-align: left;">INVERTER</td>     
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_INV_CURRENT_IN"/></td>  
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_INV_CURRENT_OUT"/></td>  
			     						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_INV_VOLTAGE_IN"/></td>  
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_INV_VOLTAGE_OUT"/></td>   
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_WORK_LOAD_INV_VERIFICATION_IN"/>PASS&nbsp;&nbsp;<input type="radio" value="0" name="BPMJ_WORK_LOAD_INV_VERIFICATION_IN"/>FAIL</td>    
		            					<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_WORK_LOAD_INV_VERIFICATION_OUT"/>PASS&nbsp;&nbsp;<input type="radio" value="0" name="BPMJ_WORK_LOAD_INV_VERIFICATION_OUT"/>FAIL</td>       		
		            					<td colspan="2" style="text-align: center;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_INV__PERCENT_LOAD"/></td> 
		            				</tr>
		            				<tr style="cursor: pointer;">
			    						<td colspan="2"  style="text-align: left;">BYPASS</td>     
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_BYPASS_CURRENT_IN"/></td>  
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_BYPASS_CURRENT_OUT"/></td>  
			     						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_BYPASS_VOLTAGE_IN"/></td>  
			    						<td style="text-align: left;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_BYPASS_VOLTAGE_OUT"/></td>   
			     						<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN"/>PASS&nbsp;&nbsp;<input type="radio" value="0" name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_IN"/>FAIL</td>    
		            					<td style="text-align: center;"><input type="radio" value="1" name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT"/>PASS&nbsp;&nbsp;<input type="radio" value="0" name="BPMJ_WORK_LOAD_BYPASS_VERIFICATION_OUT"/>FAIL</td>       		
		            					<td colspan="2" style="text-align: center;"><input type="text" style="width:120px;height: 30;" id="BPMJ_WORK_LOAD_BYPASS__PERCENT_LOAD"/></td> 
		            				</tr>   
		        				</tbody> 
	    					</table>   
    					  </div>
    					  <div align="center" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					    <table  width="100%">
    					    	<tr valign="top">
    					    		<td width="50%">
    					    		<div align="center" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					    			<table class="table table-striped table-bordered table-condensed" border="1" style="width:100%;font-size: 12px">
	        					<thead> 	
	       							<tr> 
	        							<th width="100%" colspan="2"><div class="th_class">Upload เอกสาร</div></th> 
	        						</tr>
	       						</thead>
	        					<tbody>    
			   						<tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 1</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_1" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_1_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
			    					 <tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 2</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_2" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_2_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
			    					 <tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 3</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_3" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_3_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
			    					 <tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 4</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_4" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_4_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
			    					 <tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 5</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_5" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_5_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
			    					 <tr style="cursor: pointer;">
			    						<td style="text-align: right;" width="30%">แนบเอกสาร 6</td>
       													<td style="text-align: left;" width="70%">  
       													<span>
    					   									<input class="btn" id="BPMJ_DOC_ATTACH_6" type="button" value="Upload">     
    					   								</span>
    					   								<span id="BPMJ_DOC_ATTACH_6_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       										</td>      
			    					 </tr> 
		        				</tbody> 
	    					</table> 
	    					</div>
    					    		</td>
    					    		<td width="50%">
    					    		  <div align="center" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					    			<table class="table table-striped table-bordered table-condensed" border="1" style="width:100%;font-size: 12px">
	        					<thead> 	
	       							<tr> 
	        							<th width="100%" colspan="3"><div class="th_class">การทดสอบ BATTERY</div></th> 
	        						</tr>
	       						</thead>
	        					<tbody>    
			   						<tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">BACKUP TIME&nbsp;&nbsp;<input type="text" style="height: 30;"id="BPMJ_BATTERY_BACKUP_TIME"/>MIN&nbsp;&nbsp;(การทดสอบที่ 15 MIN)</td>     
			    					 </tr>
		            				<tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">VOLTAGE CHARGE FOR BATTERY&nbsp;&nbsp;<input type="text" style="height: 30;" id="BPMJ_BATTERY_CHARGE_ON"/>VDC&nbsp;&nbsp;(On Battery)</td>     
			    					 </tr>  
			    					 <tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">VOLTAGE CHARGE FOR BATTERY&nbsp;&nbsp;<input type="text" style="height: 30;" id="BPMJ_BATTERY_CHARGE_OFF"/>VDC&nbsp;&nbsp;(Off Battery)</td>     
			    					 </tr>  
			    					 <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">สภาพสายไฟและเบรกเกอร์</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="1" name="BPMJ_BATTERY_CABLE_STATUS"/>ปกติ</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="0" name="BPMJ_BATTERY_CABLE_STATUS"/>ผิดปกติ</td>    
			    					 </tr> 
			    					  <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">สภาพภายนอก (น๊อต,สกรู)</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="1" name="BPMJ_BATTERY_EXTERNAL_STATUS"/>ปกติ</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="0" name="BPMJ_BATTERY_EXTERNAL_STATUS"/>ผิดปกติ</td>    
			    					 </tr> 
			    					   <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">จำนวนแบตเตอร์รี่</td> 
			    						<td width="20%" style="text-align: center;"><input type="text" style="width:50px;height: 30;" id="BPMJ_BREAKER_AMOUNT"/>ก้อน</td> 
			    						<td width="20%" style="text-align: center;"></td>    
			    					 </tr> 
			    					   <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">ขนาด</td> 
			    						<td width="20%" style="text-align: center;">
			    						<select id="BPMJ_BREAKER_SIZE_1" style="width:75px"> 
			    							<option value="6">6</option>
			    							<option value="12">12</option>
			    							<option value="24">24</option>
			    							<option value="48">48</option>
			    						</select>
			    						Vdc</td> 
			    						<td width="20%" style="text-align: center;">
			    						<select  id="BPMJ_BREAKER_SIZE_2" style="width:75px">
			    							<option value="1.2">1.2</option>
			    							<option value="5">5</option>
			    							<option value="7">7</option>
			    							<option value="9">9</option>
			    							<option value="18">18</option>
			    							<option value="26">26</option>
			    							<option value="45">45</option>
			    							<option value="65">48</option>
			    						</select>Ah</td>    
			    					 </tr> 
		        				</tbody> 
	    					</table> 
	    					</div>
    					    		</td>
    					    	</tr>
    					    </table>
    					 	 
    					  <%-- 
    					  	<table class="table table-striped table-bordered table-condensed" border="1" style="width:50%;font-size: 12px">
	        					<thead> 	
	       							<tr> 
	        							<th width="100%" colspan="3"><div class="th_class">การทดสอบ BATTERY</div></th> 
	        						</tr>
	       						</thead>
	        					<tbody>    
			   						<tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">BACKUP TIME&nbsp;&nbsp;<input type="text" style="height: 30;"id="BPMJ_BATTERY_BACKUP_TIME"/>MIN&nbsp;&nbsp;(การทดสอบที่ 15 MIN)</td>     
			    					 </tr>
		            				<tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">VOLTAGE CHARGE FOR BATTER&nbsp;&nbsp;<input type="text" style="height: 30;" id="BPMJ_BATTERY_CHARGE_ON"/>VDC&nbsp;&nbsp;(On Battery)</td>     
			    					 </tr>  
			    					 <tr style="cursor: pointer;">
			    						<td colspan="3"  style="text-align: left;">VOLTAGE CHARGE FOR BATTER&nbsp;&nbsp;<input type="text" style="height: 30;" id="BPMJ_BATTERY_CHARGE_OFF"/>VDC&nbsp;&nbsp;(Off Battery)</td>     
			    					 </tr>  
			    					 <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">สภาพสายไฟและเบรกเกอร์</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="1" name="BPMJ_BATTERY_CABLE_STATUS"/>ปกติ</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="0" name="BPMJ_BATTERY_CABLE_STATUS"/>ผิดปกติ</td>    
			    					 </tr> 
			    					  <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">สภาพภายนอก (น๊อต,สกรู)</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="1" name="BPMJ_BATTERY_EXTERNAL_STATUS"/>ปกติ</td> 
			    						<td width="20%" style="text-align: center;"><input type="radio" value="0" name="BPMJ_BATTERY_EXTERNAL_STATUS"/>ผิดปกติ</td>    
			    					 </tr> 
			    					   <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">จำนวนแบตเตอร์รี่</td> 
			    						<td width="20%" style="text-align: center;"><input type="text" style="width:50px;height: 30;" id="BPMJ_BREAKER_AMOUNT"/>ก้อน</td> 
			    						<td width="20%" style="text-align: center;"></td>    
			    					 </tr> 
			    					   <tr style="cursor: pointer;">
			    						<td width="60%" style="text-align: right;">ขนาด</td> 
			    						<td width="20%" style="text-align: center;">
			    						<select id="BPMJ_BREAKER_SIZE_1" style="width:75px"> 
			    							<option value="6">6</option>
			    							<option value="12">12</option>
			    							<option value="24">24</option>
			    							<option value="48">48</option>
			    						</select>
			    						Vdc</td> 
			    						<td width="20%" style="text-align: center;">
			    						<select  id="BPMJ_BREAKER_SIZE_2" style="width:75px">
			    							<option value="1.2">1.2</option>
			    							<option value="5">5</option>
			    							<option value="7">7</option>
			    							<option value="9">9</option>
			    							<option value="18">18</option>
			    							<option value="26">26</option>
			    							<option value="45">45</option>
			    							<option value="65">48</option>
			    						</select>Ah</td>    
			    					 </tr> 
		        				</tbody> 
	    					</table>   
	    						 --%>
    					  </div>
    					     <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					  	<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px;">
	        					<thead> 	
	       							<tr> 
	        							<th width="50%"><div class="th_class">การตรวจสอบสภาพและบำรุงรักษา</div></th>
	        							<th width="50%"><div class="th_class">NOTE</div></th> 
	        						</tr> 
	       						</thead>
	        					<tbody>    
			   						<tr valign="top" style="cursor: pointer;">  
			    						<td><input type="checkbox" value="1" id="BPMJ_IS_MAINTAIN1"/>&nbsp;&nbsp;1. ความสะอาดภายในและภายนอก</td> 
			    						<td rowspan="2"><textarea    style="width:580px" id="BPMJ_NOTE" cols="100" rows="3"></textarea></td> 
		            				</tr>
		            				<tr style="cursor: pointer;">
			    						<td><input type="checkbox" value="1" id="BPMJ_IS_MAINTAIN2"/>&nbsp;&nbsp;2. อาการผิดปกติ (จากการตรวจสอบหรือสอบถามเจ้าหน้าที่)</td>   
		            				</tr>   
		        				</tbody> 
	    					</table>   
	    				
    					  </div>
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					  	<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px;">
	        					<thead> 	
	       							<tr>  
	        							<th width="100%"><div class="th_class">ข้อเสนอแนะสำหรับลูกค้า</div></th> 
	        						</tr> 
	       						</thead>
	        					<tbody>    
			   						<tr valign="top" style="cursor: pointer;">  
			    						<td><input type="checkbox" value="1" id="BPMJ_IS_RECOMMEND1"/>&nbsp;&nbsp;1. แนะนำให้ลูกค้าทำการทดสอบ Battery เดือนละ 1 ครั้งๆ ละประมาณ 5- 10 นาที</td> 
		            				</tr>
		            				<tr style="cursor: pointer;">
			    						<td><input type="checkbox" value="1" id="BPMJ_IS_RECOMMEND2"/>&nbsp;&nbsp;2. อธิบายวิธีการใช้งานพอสังเขป</td>   
		            				</tr>   
		        				</tbody> 
	    					</table>   
    					  </div>
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					  	<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px;">
	        					<thead> 	
	       							<tr>  
	        							<th width="100%" colspan="3"><div class="th_class">ผู้มีส่วนเกียวข้อง</div></th> 
	        						</tr> 
	       						</thead>
	        					<tbody>    
			   						<tr valign="top" style="cursor: pointer;">  
			    						<td style="text-align: right;" width="33%"> เจ้าหน้าที่ตรวจสอบ</td> 
			    						<td width="33%">ชื่อ&nbsp;<input type="text" id="BPMJ_STAFF_FIRST_NAME" style="width:120px;height: 30px;"/>&nbsp;&nbsp;นามสกุล&nbsp;<input type="text" id="BPMJ_STAFF_LAST_NAME" style="width:120px;height: 30px;"/></td>
			    						<td width="33%">ตำแหน่ง&nbsp;<input type="text" id="BPMJ_STAFF_POSITION" style="height: 30px;"/></td>
		            				</tr>
		            				<tr valign="top" style="cursor: pointer;">  
			    						<td style="text-align: right;" width="33%">เจ้าหน้าที่ของหน่วยงาน</td> 
			    						<td width="33%">ชื่อ&nbsp;<input type="text" id="BPMJ_CUSTOMER_FIRST_NAME" style="width:120px;height: 30px;"/>&nbsp;&nbsp;นามสกุล&nbsp;<input type="text" id="BPMJ_CUSTOMER_LAST_NAME" style="width:120px;height: 30px;"/></td>
			    						<td width="33%">ตำแหน่ง&nbsp;<input type="text" id="BPMJ_CUSTOMER_POSITION" style="height: 30px;"/></td>
		            				</tr> 
		            				 
                  
		            				<tr valign="top" style="cursor: pointer;">  
			    						<td style="text-align: right;" width="33%">วันที่ปฎิบัติงาน</td> 
			    						<td width="66%" colspan="2">&nbsp;
			    						<%-- 
			    						<input data-date-format="mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months" 
			    						 readonly="readonly" style="cursor:pointer;width:90px; height: 30px;" type="text" 
			    						  id="PMMA_SELECT_DATE_END" value="05/2014">
			    						 --%>
			    						
			    						<input data-date-format="dd/mm/yyyy" type="text" id="BPMJ_WORK_DATE" readonly="readonly" style="width:100px;height: 30px;"/>
			    						
			    						&nbsp;เวลา : <%-- 
			    						   <div class= "input-append bootstrap-timepicker"> 
           <input  style="cursor: pointer;width:50px; height: 30px;" readonly="readonly" id="BPMJ_WORK_TIME" type="text" class="input-small"> 
            <span class="add-on"><i class="icon-time"></i></span>
        </div>--%>
			   						<input type="text" id="BPMJ_WORK_TIME" style="width:50px;height: 30px;"  readonly="readonly"/>
			   
			    						 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue('BPMJ_WORK_TIME')"></i>
			    						</td>
			    						
		            				</tr>  
		        				</tbody> 
	    					</table>   
    					  </div>
    					</td>
    				</tr>
    		</table> 
            </fieldset>
            <div style="padding-top: 10px" align="center">
              <table style="width: 100%" border="0">
                <tbody>
                  <tr>
                    <td width="50%">
                    <c:if test="${isPMMAAccount}">
                    <%-- 
                      <a id="back_job_element" style="display:none;" class="btn btn-info" onClick="loadDynamicPage('dispatcher/page/pm_ma_planing')"> <span style="color:white; font-weight:bold; ">Back</span></a>&nbsp;
                       --%>
                    </c:if>
                     <c:if test="${!isPMMAAccount}">
                      <a  class="btn btn-info" onClick="loadDynamicPage('dispatcher/page/todolist')"> <span style="color:white; font-weight:bold; ">Back</span></a>&nbsp;
                    </c:if>
                    
                     <c:if test="${isPMMAAccount}">
                     <a id="close_job_element" style="display:none;" class="btn btn-primary"  onclick="doClosePMMAJob('3', 'Job Closed',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a>
                     </c:if>
                    <c:if test="${!isPMMAAccount}">
                     <a class="btn btn-primary"  onclick="doClosePMMAJobToSub('3','wait_for_supervisor_pmma_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Job</span></a>
				 	</c:if>
                  
    				
    					 
                    </td>
                    <td align="center" width="80%">
                    <%-- <span id="button_send" style="display: none;"> 
                    <a class="btn btn-primary" onclick="doSubmitCallCenter()">&nbsp;<span style="color:white; font-weight:bold;">Submit</span></a>
                     </span> <span id="button_update" style="display: none;"> <a class="btn btn-primary" onclick="doSaveDraftAction()">&nbsp;
                     <span style="color:white; font-weight:bold;">Update</span></a> </span>
                      --%>
                     </td>
                  </tr>
                </tbody>
              </table>
            </div>
            </form>
            </div>
  </fieldset>