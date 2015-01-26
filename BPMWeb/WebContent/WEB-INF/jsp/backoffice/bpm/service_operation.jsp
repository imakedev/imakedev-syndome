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
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:550px}
 .modal.fade.in{top:1%}
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 var usernameG='${username}';
    getCallCenter(); 
    $("#BCC_DUE_DATE" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	 
	 $('#BCC_DUE_DATE_START').timepicker({
		    showPeriodLabels: false
	 });
	 $('#BCC_DUE_DATE_END').timepicker({
		    showPeriodLabels: false
	 }); 
	 
	 
	 var query=" SELECT mapping.SERIAL,product.IMA_ItemName , "+
	 " so.BSO_IS_DELIVERY,so.BSO_IS_INSTALLATION,so.BSO_IS_DELIVERY_INSTALLATION,so.BSO_IS_NO_DELIVERY ,so.BSO_IS_WARRANTY ,so.BSO_IS_PM_MA, "+
	 "  so.BSO_PM_MA,so.BSO_SLA "+
		"  ,so.BSO_DELIVERY_LOCATION "+
		"  ,so.BSO_DELIVERY_CONTACT "+
		"  ,so.BSO_DELIVERY_ADDR1 "+
		"  ,so.BSO_DELIVERY_ADDR2 "+
		"  ,so.BSO_DELIVERY_ADDR3 "+ 
		"  ,so.BSO_DELIVERY_PROVINCE "+
		"  ,so.BSO_DELIVERY_ZIPCODE  "+
		"  ,so.BSO_DELIVERY_TEL_FAX "+

		 " ,so.BSO_INSTALLATION_SITE_LOCATION "+
		"  ,so.BSO_INSTALLATION_CONTACT "+
		"  ,so.BSO_INSTALLATION_ADDR1 "+
		 "  ,so.BSO_INSTALLATION_ADDR2 "+
		"  ,so.BSO_INSTALLATION_ADDR3 "+
		"  ,so.BSO_INSTALLATION_PROVINCE "+
		"  ,so.BSO_INSTALLATION_ZIPCODE "+
		"  ,so.BSO_INSTALLATION_TEL_FAX "+
		" ,arms2.CUSNAM "+
		" ,so.CUSCOD "+ 
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_START,'%d/%m/%Y'),'')  "+
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_END,'%d/%m/%Y'),'')  "+
		" ,IFNULL(so.BSO_MA_NO,'')  "+
		" ,datediff(IFNULL(DATE_FORMAT(so.BSO_MA_END,'%Y-%m-%d'),''),now())  "+ 
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping "+
	 " left join SYNDOME_BPM_DB.BPM_ARMAS  armas on "+
	 "  armas.cuscod=mapping.cuscod  "+
	 " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on  "+
	 "  so.BSO_ID= mapping.BSO_ID  "+
	 " left join SYNDOME_BPM_DB.BPM_PRODUCT product on "+
	 "   product.ima_itemid=mapping.ima_itemid "+
	 " left join SYNDOME_BPM_DB.BPM_ARMAS arms2 "+
	 " on so.CUSCOD=arms2.CUSCOD "+
	// " where auto_k=0 and serial like   ";
	 " where serial like   ";
	// var query="SELECT CUSCOD,CUSTYP,PRENAM,CUSNAM,ADDR01,ADDR02,ADDR03,ZIPCOD,TELNUM,CONTACT,CUSNAM2  FROM "+SCHEMA_G+".BPM_ARMAS where CUSCOD like "; 
	   $("#BCC_SERIAL" ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%' limit 15";
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
						        	  IMA_ItemName: item[1],
						        	  BSO_IS_DELIVERY: item[2],
						        	  BSO_IS_INSTALLATION: item[3],
						        	  BSO_IS_DELIVERY_INSTALLATION: item[4],
						        	  BSO_IS_NO_DELIVERY: item[5],
						        	  BSO_IS_WARRANTY: item[6],
						        	  BSO_IS_PM_MA: item[7],
						        	  BSO_PM_MA: item[8],
						        	  BSO_SLA: item[9],
						        	  BSO_DELIVERY_LOCATION: item[10],
						        	  BSO_DELIVERY_CONTACT: item[11],
						        	  BSO_DELIVERY_ADDR1: item[12],
						        	  BSO_DELIVERY_ADDR2: item[13],
						        	  BSO_DELIVERY_ADDR3: item[14],
						        	  BSO_DELIVERY_PROVINCE: item[15],
						        	  BSO_DELIVERY_ZIPCODE: item[16],
						        	  BSO_DELIVERY_TEL_FAX: item[17],

						              BSO_INSTALLATION_SITE_LOCATION: item[18],
						        	  BSO_INSTALLATION_CONTACT: item[19],
						        	  BSO_INSTALLATION_ADDR1: item[20],
						        	  BSO_INSTALLATION_ADDR2: item[21],
						        	  BSO_INSTALLATION_ADDR3: item[22],
						        	  BSO_INSTALLATION_PROVINCE: item[23],
						        	  BSO_INSTALLATION_ZIPCODE: item[24],
						        	  BSO_INSTALLATION_TEL_FAX : item[25],
						        	  CUSNAM: item[26],
						              CUSCOD: item[27],
						              BSO_MA_START: item[28],
						              BSO_MA_END: item[29],
						              BSO_MA_NO: item[30],
						              datediff: item[31] 
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
				  $("#BCC_MODEL").val(ui.item.IMA_ItemName);
				  $("#BCC_CUSCODE").val(ui.item.CUSCOD);
				  
				  if(ui.item.datediff!=null && parseInt(ui.item.datediff)>0){ // อยู่ในประกัน 
					  if(ui.item.BSO_MA_NO!=''){ //have ma no  
						 // $("#BCC_IS_MA3").prop('checked', true);
						  $('input[name="radio1"][value="2"]').prop('checked', true);
					  
					  }else{ // not have ma no
						 // $("#BCC_IS_MA1").prop('checked', true); 
						  $('input[name="radio1"][value="1"]').prop('checked', true);
					  }
				  }else{
					  $('input[name="radio1"][value="0"]').prop('checked', true);
					  $('input[name="BCC_STATUS"][value="0"]').prop('checked', true);
					  
				  }
				  $("#BCC_MA_START").val(ui.item.BSO_MA_START);
				  $("#BCC_MA_END").val(ui.item.BSO_MA_END);
				  $("#BCC_MA_NO").val(ui.item.BSO_MA_NO);
				 /*
				  BSO_MA_START: item[28],
	              BSO_MA_END: item[29],
	              BSO_MA_NO: item[30],
	              datediff: item[31] 
				  BCC_MA_START
				  BCC_MA_END
				  BCC_MA_NO
				  */
				 /*
				  alert(ui.item.BSO_IS_DELIVERY);
				  alert(ui.item.BSO_IS_INSTALLATION)
				  alert(ui.item.BSO_IS_DELIVERY_INSTALLATION)
				  alert(ui.item.BSO_IS_NO_DELIVERY) 
				  alert(ui.item.BSO_IS_WARRANTY)
				  alert(ui.item.BSO_PM_MA)
				  */
				  var BCC_CONTACT="";
				  var BCC_TEL="";
				  var BCC_LOCATION="";
				  var BCC_ADDR1="";
				  var BCC_ADDR2="";
				  var BCC_ADDR3="";
				  var BCC_PROVINCE="";
				  var BCC_ZIPCODE="";
				  if(ui.item.BSO_IS_DELIVERY =='1'){
					  BCC_CONTACT=ui.item.BSO_DELIVERY_CONTACT;
					  BCC_TEL=ui.item.BSO_DELIVERY_TEL_FAX;
					  BCC_LOCATION=ui.item.BSO_DELIVERY_LOCATION;
					  BCC_ADDR1=  ui.item.BSO_DELIVERY_ADDR1 ;
					  BCC_ADDR2=  ui.item.BSO_DELIVERY_ADDR2 ;
					  BCC_ADDR3=  ui.item.BSO_DELIVERY_ADDR3 ;
					  BCC_PROVINCE=ui.item.BSO_DELIVERY_PROVINCE;
					  BCC_ZIPCODE=ui.item.BSO_DELIVERY_ZIPCODE;  

				  } 
				  else if(ui.item.BSO_IS_INSTALLATION =='1' || ui.item.BSO_IS_DELIVERY_INSTALLATION=='1'){ 
					  BCC_CONTACT=ui.item.BSO_INSTALLATION_CONTACT;
					  BCC_TEL=ui.item.BSO_INSTALLATION_TEL_FAX;
					  BCC_LOCATION=ui.item.BSO_INSTALLATION_SITE_LOCATION;
					  BCC_ADDR1=  ui.item.BSO_INSTALLATION_ADDR1 ;
					  BCC_ADDR2=  ui.item.BSO_INSTALLATION_ADDR2 ;
					  BCC_ADDR3=  ui.item.BSO_INSTALLATION_ADDR3 ;
					  BCC_PROVINCE=ui.item.BSO_INSTALLATION_PROVINCE;
					  BCC_ZIPCODE=ui.item.BSO_INSTALLATION_ZIPCODE;  
				  }
				
				  /* name="radio1"
					  id="BCC_IS_MA1"
					  */
				// $("input[name=radio1]").prop('checked', false);
				//  $("input[name=mygroup][value=" + value + "]").prop('checked', true);
				 
				//  alert(BSO_IS_PM_MA)
				   $("#BCC_SLA").val(ui.item.BSO_SLA);
				   $("#BCC_CUSTOMER_NAME").val(ui.item.CUSNAM);
				   $("#BCC_CONTACT").val(BCC_CONTACT); 
				   $("#BCC_TEL").val(BCC_TEL); 
				   $("#BCC_LOCATION").val(BCC_LOCATION); 
				   $("#BCC_ADDR1").val(BCC_ADDR1); 
				   $("#BCC_ADDR2").val(BCC_ADDR2);  
				   $("#BCC_ADDR3").val(BCC_ADDR3);  
				   $("#BCC_PROVINCE").val(BCC_PROVINCE);  
				   $("#BCC_ZIPCODE").val(BCC_ZIPCODE);  
				 /*  $("#CONTACT").val(ui.item.CONTACT); 
				  $("#CUSNAM").val(ui.item.CUSNAM); 
				  $("#ADDR01").val(ui.item.ADDR01+" "+ui.item.ADDR02);
				  $("#TELNUM").val(ui.item.TELNUM);   */
			      return false;
			  },
			  open: function() {
			    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			  },
			  close: function() {
			    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			  }
			}); 
	 
}); 
function getCallCenter(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	} 
  if(isEdit){  
	  var query=" SELECT "+
	  " call_center.BCC_NO ,"+
	  " IFNULL(call_center.BCC_SERIAL,'') ,"+
	    " IFNULL(call_center.BCC_MODEL,'') ,"+
	    " IFNULL(call_center.BCC_CAUSE,'') ,"+
	    "  call_center.BCC_CREATED_TIME  ,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%Y-%m-%d %H:%i'),'') ,"+
	    " IFNULL(call_center.BCC_SLA,'') ,"+
	    " IFNULL(call_center.BCC_IS_MA ,'') ,"+
	    " IFNULL(call_center.BCC_MA_NO ,'') ,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') ,"+
	    " IFNULL(call_center.BCC_STATUS ,'') ,"+
	    " IFNULL(call_center.BCC_REMARK ,'') ,"+
	    " IFNULL(call_center.BCC_USER_CREATED ,'') ,"+
	    " IFNULL(call_center.BCC_DUE_DATE ,'') ,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') ,"+
	    " IFNULL(call_center.BCC_TEL ,'') ,"+ 
	    " IFNULL(arms.CUSNAM ,'') ,"+ //17
	    " IFNULL(call_center.BCC_ADDR1 ,'') ,"+
	    " IFNULL(call_center.BCC_ADDR2 ,'') ,"+
	    " IFNULL(call_center.BCC_ADDR3 ,'') ,"+
	    " IFNULL(call_center.BCC_LOCATION ,'') ,"+
	    " IFNULL(call_center.BCC_PROVINCE ,'') ,"+
	    " IFNULL(call_center.BCC_ZIPCODE ,'') ,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') , "+
	    " IFNULL(call_center.BCC_CUSCODE ,'') ,"+
	    " IFNULL(call_center.BCC_SALE_ID ,'') ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') , "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') , "+ 
	   " (select count(*)  FROM "+SCHEMA_G+".BPM_TO_DO_LIST todo "+ 
	   "	   where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2') , "+
	   " IFNULL(call_center.BCC_STATE ,'') , "+
	   "IFNULL((select so.BSO_MA_TYPE from  "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping    "+
	   " left join  "+SCHEMA_G+".BPM_SALE_ORDER so on   "+
	   " 	   so.BSO_ID= mapping.BSO_ID  where mapping.SERIAL=call_center.BCC_SERIAL "+
	   " and mapping.auto_k=0 ) ,'') "+
	   " "+
	   " FROM "+SCHEMA_G+".BPM_CALL_CENTER call_center left join  "+
	   "  "+SCHEMA_G+".BPM_ARMAS arms   "+
	   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
	  // " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	  // " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where call_center.BCC_NO='${bccNo}'";
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
				if(data!=null && data.length>0){ 
					$("#BCC_NO").val(data[0][0]);
					 var BCC_SERIAL=data[0][1]; $("#BCC_SERIAL").val(BCC_SERIAL);
					 
					 var BCC_MODEL=data[0][2]; $("#BCC_MODEL").val(BCC_MODEL);
					 var BCC_CAUSE=data[0][3]; $("#BCC_CAUSE").val(BCC_CAUSE);
					 var BCC_CREATED_TIME=data[0][5]; $("#BCC_CREATED_TIME").val(BCC_CREATED_TIME);
					 var BCC_SLA=data[0][6]; $("#BCC_SLA").val(BCC_SLA);
					 var BCC_IS_MA=data[0][7]; $("#BCC_IS_MA").val(BCC_IS_MA);
					 // alert(BCC_IS_MA)
					 $("input[name=radio1][value=" + BCC_IS_MA + "]").prop('checked', true); 
					 var BCC_MA_NO=data[0][8]; $("#BCC_MA_NO").val(BCC_MA_NO);
					 var BCC_MA_START=data[0][9]; $("#BCC_MA_START").val(BCC_MA_START);
					 var BCC_MA_END=data[0][10]; $("#BCC_MA_END").val(BCC_MA_END);
					 var BCC_STATUS=data[0][11]; $("#BCC_STATUS").val(BCC_STATUS);
					 $("input[name=BCC_STATUS][value=" + BCC_STATUS + "]").prop('checked', true);
					 var BCC_REMARK=data[0][12]; $("#BCC_REMARK").val(BCC_REMARK);
					 var BCC_USER_CREATED=data[0][13]; $("#BCC_USER_CREATED").val(BCC_USER_CREATED);
					 var BCC_DUE_DATE=data[0][14]; $("#BCC_DUE_DATE").val(BCC_DUE_DATE);
					 var BCC_CONTACT=data[0][15]; $("#BCC_CONTACT").val(BCC_CONTACT);
					 var BCC_TEL=data[0][16]; $("#BCC_TEL").val(BCC_TEL);
					 var BCC_CUSTOMER_NAME=data[0][17]; $("#BCC_CUSTOMER_NAME").val(BCC_CUSTOMER_NAME);
					 var BCC_ADDR1=data[0][18]; $("#BCC_ADDR1").val(BCC_ADDR1);
					 var BCC_ADDR2=data[0][19]; $("#BCC_ADDR2").val(BCC_ADDR2);
					 var BCC_ADDR3=data[0][20]; $("#BCC_ADDR3").val(BCC_ADDR3);
					 var BCC_LOCATION=data[0][21]; $("#BCC_LOCATION").val(BCC_LOCATION);
					 var BCC_PROVINCE=data[0][22]; $("#BCC_PROVINCE").val(BCC_PROVINCE);
					 var BCC_ZIPCODE=data[0][23]; $("#BCC_ZIPCODE").val(BCC_ZIPCODE);
					 var BCC_DUE_DATE=data[0][24]; $("#BCC_DUE_DATE").val(BCC_DUE_DATE);
					 var BCC_CUSCODE=data[0][25]; $("#BCC_CUSCODE").val(BCC_CUSCODE);
					 var BCC_SALE_ID=data[0][26]; $("#BCC_SALE_ID").val(BCC_SALE_ID);
					 var BCC_DUE_DATE_START=data[0][27]; $("#BCC_DUE_DATE_START").val(BCC_DUE_DATE_START);
					 var BCC_DUE_DATE_END=data[0][28]; $("#BCC_DUE_DATE_END").val(BCC_DUE_DATE_END);
				 
					var to_do_count=data[0][29]!=null?data[0][29]:0; 
					var BCC_STATE=data[0][30];
					var BSO_MA_TYPE=data[0][31];
					//  $('input[name="radio1"][value="2"]').prop('checked', true);
					//alert(BCC_STATE)
				if(BCC_STATE!='cancel')
					if(BCC_STATE.length>0){
						$("#button_update").show();
					}else
						$("#button_send").show();
				if(isEdit && BCC_STATE!=''){
					 $("#BCC_SERIAL").attr("readonly","readonly" );
					 $("input[name=radio1]").attr("disabled",true);
					 $("#BCC_MA_NO").attr("readonly","readonly" );
					 $("input[name=BCC_STATUS]").attr("disabled",true);
					 
				 }
				var BCC_IS_MA_0="&nbsp;";
				var BCC_IS_MA_1="&nbsp;";
				var BCC_IS_MA_2="&nbsp;";
				if(BCC_IS_MA=='0') 
					BCC_IS_MA_0="x";
				else if(BCC_IS_MA=='1')
					BCC_IS_MA_1="x";
				else if(BCC_IS_MA=='2')
					BCC_IS_MA_2="x";
				$("#BCC_IS_MA_0").html(BCC_IS_MA_0);
				$("#BCC_IS_MA_1").html(BCC_IS_MA_1);
				$("#BCC_IS_MA_2").html(BCC_IS_MA_2);
				
				//1=Gold,2=Silver,3=Bronze 
				var BSO_MA_TYPE_1="&nbsp;";
				var BSO_MA_TYPE_2="&nbsp;";
				var BSO_MA_TYPE_3="&nbsp;";
				if(BSO_MA_TYPE=='1') 
					BSO_MA_TYPE_1="x";
				else if(BSO_MA_TYPE=='2')
					BSO_MA_TYPE_2="x";
				else if(BSO_MA_TYPE=='3')
					BSO_MA_TYPE_3="x";
				$("#BSO_MA_TYPE_1").html(BSO_MA_TYPE_1);
				$("#BSO_MA_TYPE_2").html(BSO_MA_TYPE_2);
				$("#BSO_MA_TYPE_3").html(BSO_MA_TYPE_3);
				
				 
				var flow="";
				if(BCC_STATUS=='0')
					flow="เสนอราคาซ่อม";
				else if(BCC_STATUS=='1')
					flow="ให้ดำเนินการซ่อม Onsite (กทม ปริฯ)";
				else if(BCC_STATUS=='2')
					flow="ให้ดำเนินการซ่อม Onsite (ภูมิภาค)";
				else if(BCC_STATUS=='3')
					flow="ให้ซ่อมภายใน SC";
				else if(BCC_STATUS=='4')
					flow="ให้ดำเนินการรับเครื่อง (กทม ปริฯ)";
				else if(BCC_STATUS=='5')
					flow="ให้ดำเนินการรับเครื่อง (ภูมิภาค)";
				$("#flow").html(flow);
					/*
					if(to_do_count>0){
						$("#button_send").hide();
					}else
						$("#button_update").show();
					 */
					 
				} 
				//searchItemList("1");
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("CALL_CENTER","ym","4","en",{
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
					$("#BCC_NO").val(data);
					var querys=[];  
					//return false;
					var query="insert into "+SCHEMA_G+".BPM_CALL_CENTER set BCC_NO='"+data+"' ,BCC_USER_CREATED='${username}' ,"+
					  " BCC_CREATED_TIME=now() ";
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
								   " BCC_NO, BCC_USER_CREATED  FROM "+SCHEMA_G+".BPM_CALL_CENTER where BCC_NO='"+$("#BCC_NO").val()+"'";
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
											loadDynamicPage('dispatcher/page/callcenter_job?bccNo='+data2[0][0]+'&mode=edit');
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
function doUpdateCallCenter(mode){ 
	 var BCC_NO="${bccNo}"; 
	 var BCC_SERIAL = jQuery.trim($("#BCC_SERIAL").val());
	 var BCC_MODEL =jQuery.trim($("#BCC_MODEL").val());
	 var BCC_CAUSE = jQuery.trim($("#BCC_CAUSE").val());
	 var BCC_CREATED_TIME = jQuery.trim($("#BCC_CREATED_TIME").val());
	 var BCC_SLA = jQuery.trim($("#BCC_SLA").val());
	// var BCC_IS_MA = jQuery.trim($("#BCC_IS_MA").val());
	 var BCC_MA_NO =jQuery.trim($("#BCC_MA_NO").val());
	 var BCC_MA_START = jQuery.trim($("#BCC_MA_START").val());
	 var BCC_MA_END =jQuery.trim($("#BCC_MA_END").val());
	// var BCC_STATUS = jQuery.trim($("#BCC_STATUS").val());
	//   var BCC_STATUS=$("input[name=BCC_STATUS]:checked" ).val();
	   var BCC_STATUS=  jQuery.trim($('input:radio[name="BCC_STATUS"]:checked').val());
	   var BCC_IS_MA=  jQuery.trim($('input:radio[name="radio1"]:checked').val());
	//  alert(BCC_STATUS)
	 var BCC_REMARK = jQuery.trim($("#BCC_REMARK").val());
	 var BCC_USER_CREATED = jQuery.trim($("#BCC_USER_CREATED").val());
	 var BCC_DUE_DATE = jQuery.trim($("#BCC_DUE_DATE").val());
	 var BCC_CONTACT =jQuery.trim($("#BCC_CONTACT").val());
	// var BSO_BORROW_DURATION = jQuery.trim($("#BSO_BORROW_DURATION").val());
	 var BCC_TEL = jQuery.trim($("#BCC_TEL").val());
	 var BCC_CUSTOMER_NAME =jQuery.trim($("#BCC_CUSTOMER_NAME").val());
	 var BCC_ADDR1 =jQuery.trim($("#BCC_ADDR1").val());
	 var BCC_ADDR2 = jQuery.trim($("#BCC_ADDR2").val());
	 var BCC_ADDR3= jQuery.trim($("#BCC_ADDR3").val());
	 var BCC_LOCATION = jQuery.trim($("#BCC_LOCATION").val());
	 var BCC_PROVINCE = jQuery.trim($("#BCC_PROVINCE").val()); 
	 var BCC_ZIPCODE = jQuery.trim($("#BCC_ZIPCODE").val()); 
	 var BCC_CUSCODE = jQuery.trim($("#BCC_CUSCODE").val()); 
	 var BCC_SALE_ID= jQuery.trim($("#BCC_SALE_ID").val()); 
	 var BCC_DUE_DATE_START= jQuery.trim($("#BCC_DUE_DATE_START").val()); 
	 var BCC_DUE_DATE_END= jQuery.trim($("#BCC_DUE_DATE_END").val());  
		 
	var query=" UPDATE "+SCHEMA_G+".BPM_CALL_CENTER SET "+ 
	 " BCC_SERIAL = '"+BCC_SERIAL+"' , "+ 
	" BCC_MODEL = '"+BCC_MODEL+"', "+
	" BCC_CAUSE = '"+BCC_CAUSE+"' ,  "+
	// " BCC_CREATED_TIME = "+BCC_CREATED_TIME+", "+
	" BCC_SLA = '"+BCC_SLA+"' , "+
	" BCC_IS_MA = '"+BCC_IS_MA+"' , "+
	" BCC_MA_NO = '"+BCC_MA_NO+"', "+
	// " BCC_MA_START = '"+BCC_MA_START+"' , "+ 
	// " BCC_MA_END = '"+BCC_MA_END+"' ,"+
	" BCC_STATUS = '"+BCC_STATUS+"' ,"+
	" BCC_REMARK = '"+BCC_REMARK+"' ,"+
	// " BCC_USER_CREATED = '"+BCC_USER_CREATED+"' ,"+
	// " BCC_DUE_DATE = '"+BCC_DUE_DATE+"', "+ 
	" BCC_CONTACT = '"+BCC_CONTACT+"' ,"+
	//" BSO_BORROW_DURATION = '"+BSO_BORROW_DURATION+"', "+
	" BCC_TEL = '"+BCC_TEL+"', "+
//	" BCC_CUSTOMER_NAME = '"+BCC_CUSTOMER_NAME+"', "+
	" BCC_ADDR1 = '"+BCC_ADDR1+"' ,  "+
	" BCC_ADDR2 = '"+BCC_ADDR2+"', "+
	" BCC_ADDR3= '"+BCC_ADDR3+"', "+
	" BCC_LOCATION = '"+BCC_LOCATION+"', "+
	" BCC_PROVINCE = '"+BCC_PROVINCE+"' , "+ 
	" BCC_ZIPCODE = '"+BCC_ZIPCODE+"' , "+
	" BCC_SALE_ID = '"+BCC_SALE_ID+"' ,  " ;
	if(mode=='submit'){
		query=query+" BCC_STATE = 'wait_for_assign_to_team' , " ;
	}
	 
	//	" BCC_DUE_DATE_START = '"+BCC_DUE_DATE_START+"' ,  "+
	//	" BCC_DUE_DATE_END = '"+BCC_DUE_DATE_END+"' ,  ";
		 
	 var BCC_MA_START_VALUE="";
	 if(BCC_MA_START.length>0){
			var BCC_MA_START_ARRAY=BCC_MA_START.split("/");
			BCC_MA_START_VALUE=BCC_MA_START_ARRAY[2]+"-"+BCC_MA_START_ARRAY[1]+"-"+BCC_MA_START_ARRAY[0]+" 00:00:00"; 
			 
		}
	 if(BCC_MA_START_VALUE.length>0){
			query=query+" BCC_MA_START='"+BCC_MA_START_VALUE+"' , ";
		}else
			query=query+" BCC_MA_START=null  , ";
	 
	 var BCC_MA_END_VALUE="";
	 if(BCC_MA_END.length>0){
			var BCC_MA_END_ARRAY=BCC_MA_END.split("/");
			BCC_MA_END_VALUE=BCC_MA_END_ARRAY[2]+"-"+BCC_MA_END_ARRAY[1]+"-"+BCC_MA_END_ARRAY[0]+" 00:00:00"; 
			 
		}
	 if(BCC_MA_END_VALUE.length>0){
			query=query+" BCC_MA_END='"+BCC_MA_END_VALUE+"' , ";
		}else
			query=query+" BCC_MA_END=null  , ";
	 
		var BCC_DUE_DATE=jQuery.trim($("#BCC_DUE_DATE").val());
		//var BSO_DELIVERY_DUE_DATE_TIME_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val());
		var BCC_DUE_DATE_VALUE="";
		if(BCC_DUE_DATE.length>0){
			var BCC_DUE_DATE_ARRAY=BCC_DUE_DATE.split("/");
			BCC_DUE_DATE_VALUE=BCC_DUE_DATE_ARRAY[2]+"-"+BCC_DUE_DATE_ARRAY[1]+"-"+BCC_DUE_DATE_ARRAY[0]+" 00:00:00"; 
			 
		}

		if(BCC_DUE_DATE_VALUE.length>0){
			query=query+" BCC_DUE_DATE='"+BCC_DUE_DATE_VALUE+"' , ";
		}else
			query=query+" BCC_DUE_DATE=null  , ";
		
//		" BCC_DUE_DATE_START = '"+BCC_DUE_DATE_START+"' ,  "+
		//	" BCC_DUE_DATE_END = '"+BCC_DUE_DATE_END+"' ,  ";
		var BCC_DUE_DATE_START=jQuery.trim($("#BCC_DUE_DATE_START").val()); 
		var BCC_DUE_DATE_START_VALUE="";
		if(BCC_DUE_DATE_START.length>0){ 
			BCC_DUE_DATE_START_VALUE=BCC_DUE_DATE_START+":00";  
		}
		if(BCC_DUE_DATE_START_VALUE.length>0){
			query=query+" BCC_DUE_DATE_START='"+BCC_DUE_DATE_START_VALUE+"' , ";
		}else
			query=query+" BCC_DUE_DATE_START=null  , ";
		
		var BCC_DUE_DATE_END=jQuery.trim($("#BCC_DUE_DATE_END").val()); 
		var BCC_DUE_DATE_END_VALUE="";
		if(BCC_DUE_DATE_END.length>0){ 
			BCC_DUE_DATE_END_VALUE=BCC_DUE_DATE_END+":00";  
		}

		if(BCC_DUE_DATE_END_VALUE.length>0){
			query=query+" BCC_DUE_DATE_END='"+BCC_DUE_DATE_END_VALUE+"' , ";
		}else
			query=query+" BCC_DUE_DATE_END=null  , ";
		query=query+" BCC_CUSCODE = '"+BCC_CUSCODE+"'   " ;
 
		query=query+" WHERE BCC_NO = '"+BCC_NO+"' ";
 	  
	 
	  return query;
}
function doSubmitCallCenter(){ 
	var querys=[];  
	var query_update =doUpdateCallCenter('submit');
	 if(query_update!=false){ 
	   }else
	   	   return false;
	
		var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
        " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=5) as hod_reg ,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=3) as hod_sc,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=9) as hod_reg_logistic	FROM dual ";
		
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
	if(data!=null && data.length>0){
		//var BSO_DELIVERY_TYPE=$("input[name=BSO_DELIVERY_TYPE]:checked" ).val();
	  // * ไม่อยู่ในประกัน => ไปหา sale
  	  // * ให้ดำเนินการซ่อม Onsite =>ไปหา sub IT
      // * ให้ซ่อมภายใน SC => ไปหา role SC คุณฝน
      // * ให้ดำเนินการรับเครื่อง => ไปหา sup logistice
      /*
       ให้ดำเนินการซ่อม Onsite  1
	   ให้ซ่อมภายใน SC  2
       ให้ดำเนินการรับเครื่อง  3
      */
      querys.push(query_update); 
       var BCC_STATUS=$("input[name=BCC_STATUS]:checked" ).val();
      var state="";
		if(BCC_STATUS=='2'){ // IT REG
			 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
				"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
				"('${bccNo}','2','wait_for_assign_to_team','"+data[0][1]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		} 
		else if(BCC_STATUS=='1'){ // IT
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][0]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='3'){ // SC
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][2]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='4'){ // REF
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][3]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='5'){ // REF REG
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][4]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='0'){ // SALE
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_quotation','ROLE_QUOTATION_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_quotation";
		}else  { // Key Account
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
	 		querys.push(query); 
	 		 state="wait_for_send_to_supervisor";
  		}
		
		 //query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='wait_for_assign_to_team' where BSO_ID=${bccNo}";
		// querys.push(query); 
	 
		/*
		var message_todolist="Job wait for assign to Team";
		var owner_type="2";
		var owner="ROLE_SUPERVISOR_ACCOUNT";
		var hide_status='1';
		var	 query3="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_assign_to_team','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	null,'"+hide_status+"','${username}','${bccNo}',(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00'))) ) ";
		
		querys.push(query3); 
		*/
		query=" INSERT INTO "+SCHEMA_G+".BPM_SERVICE_JOB (BCC_NO,BSJ_CREATED_TIME,BSJ_STATE) VALUES ('${bccNo}',now(),'"+state+"')";
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
											bootbox.dialog("Submit Job.",[{
											    "label" : "Ok",
											    "class" : "btn-primary",
											    "callback": function() {
											    	loadDynamicPage('dispatcher/page/callcenter')
											    }
											 }]);
										}
									}
								});
	}
}});
		
	 return false;
    // return false; 
}
function doSaveDraftAction(){  	  
	   query =doUpdateCallCenter('savedraft');
	   if(query!=false){ 
	   }else
	   	   return false;
	var querys=[];
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
			//alert(data); 
			if(data!=0){
				
				loadDynamicPage('dispatcher/page/callcenter');
			}
		},errorHandler:function(errorString, exception) { 
			alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
		}
	 });
	}
function showOnSite(){  
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
     var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
     "<tbody>"+
     "<tr style=\"cursor: pointer;\">"+
      " <td style=\"text-align: left;\">สาเหตุ (Cause)<br>"+
      "     <textarea name=\"textarea3\" id=\"textarea3\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
      "     <br>"+
      "   การแก้ไข (Solution)<br>"+
      "   <textarea name=\"textarea4\" id=\"textarea4\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
      "   <br>"+
      "   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
      "   <span style=\"padding-right:10px\">  รับเครื่อง</span>"+
      "     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
      "   <span style=\"padding-right:10px\">  เปลี่ยนเครื่องใหม่</span>"+
      "    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
      "   <span style=\"padding-right:10px\">  วางสแปร์</span>"+
      "     <input type=\"checkbox\" name=\"checkbox4\" id=\"checkbox4\">"+
      "   <span style=\"padding-right:10px\">  เปลี่ยน Battery</span>"+
      "     <input name=\"textfield3\" style=\"height: 30px;\" type=\"text\" id=\"textfield3\" class=\"span1\">"+
      "   <span style=\"padding-right:10px\">  ลูก ปี Battery</span>"+
      "     <input name=\"textfield4\" style=\"height: 30px;\" type=\"text\" id=\"textfield4\" class=\"span1\">"+
      "   <span style=\"padding-right:10px\">  (ตัวปั้ม)</span></td>"+
     "  </tr>"+
   "  </tbody>"+
 "  </table>";
						bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
		 
}
function showSC( ){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
  var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
  "<tbody>"+
  "<tr style=\"cursor: pointer;\">"+
   " <td style=\"text-align: left;\">สาเหตุ (Cause)<br>"+
   "     <textarea name=\"textarea3\" id=\"textarea3\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
   "     <br>"+
   "   การแก้ไข (Solution)<br>"+
   "   <textarea name=\"textarea4\" id=\"textarea4\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
   "   <br>"+
   "   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
   "   <span style=\"padding-right:10px\">  เปลี่ยนอุปกรณ์ ตามรายการ</span>"+
   "     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
   "   <span style=\"padding-right:10px\">  ชาร์ตแบตเตอรี่</span>"+
   "    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
   "   <span style=\"padding-right:10px\">  แนะนำการใช้งาน</span>"+ 
   " </td>"+
  "  </tr>"+
"  </tbody>"+
"  </table>"+
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"5%\"><div class=\"th_class\">ลำดับ</div></th> "+
"  		<th width=\"10%\"><div class=\"th_class\">รหัส</div></th> "+
"  		<th width=\"80%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
 "  	<tr style=\"cursor: pointer;\">"+  
"  		<td>1</td>"+  
"  		<td style=\"text-align: left;\">90001</td>"+    
"  		<td style=\"text-align: left;\">Test</td>"+    
"  		<td style=\"text-align: left;\">2</td>"+   
 "  	</tr>  "+
"  </tbody>"+
"  </table>";
						bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showBorrow(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"<tbody>"+
"<tr style=\"cursor: pointer;\">"+
" <td style=\"text-align: left;\"> "+
"   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
"   <span style=\"padding-right:10px\">  ซ่อม Site</span>"+
"     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
"   <span style=\"padding-right:10px\">  สแปร์</span>"+
"    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
"   <span style=\"padding-right:10px\">  เปลี่ยนเครื่อง</span>"+ 
" </td>"+
"  </tr>"+

"  </tbody>"+
"  </table>"+
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"5%\"><div class=\"th_class\">ลำดับ</div></th> "+
"  		<th width=\"10%\"><div class=\"th_class\">รหัส</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">คลัง</div></th> "+
"  		<th width=\"75%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+  
"  		<td>1</td>"+  
"  		<td style=\"text-align: left;\">90001</td>"+   
"  		<td style=\"text-align: left;\">2</td>"+   
"  		<td style=\"text-align: left;\">Test</td>"+    
"  		<td style=\"text-align: left;\">2</td>"+   
"  	</tr>  "+
"  </tbody>"+
"  </table>";
						bootbox.dialog("<div>ยืม</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showCheck(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
var str="<table width=\"100%\" style=\"font-size: 12px\" border=\"0\">"+
"<tbody>"+ 
"<tr valign=\"top\" style=\"cursor: pointer;\">"+
" <td style=\"text-align: left;\" valign=\"top\" width=\"60%\"> "+ 
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"80%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"15%\"><div class=\"th_class\">วัดได้</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">ผ่าน</div></th> "+ 
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 198-242Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 165-198Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 243-275Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Battery Mode)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ความถี่ Output (Battery Mode)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดันชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">กระแสชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Low Battery Cut Off</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ทดสอบสำรองไฟ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การทำงานของพัดลม</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การแสดงผลของ LED/LCD</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">สัญญาณเสียง Alarm ต่างๆ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ปุ่มทดสอบแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การทำงานของพัดลม</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การแสดงผลของ LED/LCD</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">สัญญาณเสียง Alarm ต่างๆ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ปุ่มทดสอบแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  </tbody>"+
"  </table>"+
" </td>"+
" <td style=\"text-align: left;padding-left:5px\" valign=\"top\" width=\"40%\"> "+ 
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"100%\" colspan=\"2\"><div class=\"th_class\">รายการ</div></th> "+ 
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td width=\"30%\"  style=\"text-align: left;\"><span>กระแสโหลด</span></td>"+   
"  		<td width=\"70%\" style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"> A</span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+ 
"  		<td style=\"text-align: left;\"><span>ขนาดสายไฟ</span></td>"+  
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"> SQ.mm</span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\"><span>ปีแบตเตอรี่ (ตัวปั้ม)</span></td>"+   
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"></span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+  
"  		<td style=\"text-align: left;\"><span>ปีแบตเตอรี่ (สติ๊กเกอร์)</span></td>"+   
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"></span></td>"+   
"  	</tr>  "+
"  	<tr  valign=\"top\" style=\"cursor: pointer;\">"+   
"  		<td colspan=\"2\" style=\"text-align: left;\"><span>อื่นๆ <textarea name=\"textarea\" id=\"textarea\" cols=\"100\" rows=\"3\"></textarea></span></td>"+   
"  	</tr>  "+ 
"  </tbody>"+
"  </table>"+
" </td>"+
"  </tr>"+ 
"  </tbody>"+
"  </table>"; 
						bootbox.dialog("<div>ตรวจเช็ค</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showReceive(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
	var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
    "<tbody>"+
    "<tr style=\"cursor: pointer;\">"+
    "  <td style=\"text-align: left;\"><table width=\"100%\" border=\"0\" cellpadding=\"0\">"+
    "    <tbody><tr>"+
    "      <td width=\"20%\">กล่องกระดาษกระเป๋า</td>"+
    "      <td width=\"80%\"><input type=\"radio\" name=\"radio\"   value=\"radio\">"+
    "        มี&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" name=\"radio\"  value=\"radio2\">"+
    "ไม่มี</td>"+
    "      </tr>"+
    "    <tr>"+
    "      <td>สายไฟ</td>"+
    "      <td><input type=\"radio\" name=\"radio0\"   value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio0\"  value=\"radio2\">"+
"ไม่มี</td>"+
 "         </tr>"+
 "       <tr>"+
 "         <td>รอยขีดข่วน</td>"+
 "         <td><input type=\"radio\" name=\"radio1\"  value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio1\"   value=\"radio2\">"+
"ไม่มี</td>"+
"          </tr>"+
"        <tr>"+
"          <td>แบตเตอรี่</td>"+
"          <td><input type=\"radio\" name=\"radio2\"  value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio2\"   value=\"radio2\">"+
"ไม่มี</td>"+
"          </tr>"+
"        <tr>"+
"          <td colspan=\"2\">อื่นๆ : "+
"           <textarea name=\"textarea\" id=\"textarea\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea></td>"+
"          </tr>"+
"      </tbody></table>"+
"       </td>"+
"    </tr>"+
"  </tbody>"+
"</table>";
bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
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
 function clearElementTimeValue(){
	 $("#BCC_DUE_DATE").val("");
	 $("#BCC_DUE_DATE_START").val("");
	 $("#BCC_DUE_DATE_END").val(""); 
 }
 
 function doCloseServicesJob(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
		var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bccNo}' and "+
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
						var btdl_state_update='wait_for_supervisor_services_close';
						 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
								"('${bccNo}','"+btdl_type+"','"+btdl_state_update+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','${bccNo}') ";
						 if('${state}'!='' && is_hide_todolist){
						  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bccNo}' and "+
							"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
							//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
							 querys.push(query2); 
						 } 
						 if(btdl_state=='wait_for_supervisor_services_close'){
							 query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_STATE='"+btdl_state+"' where BCC_NO=${bccNo}"; 
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

</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px;padding-left:2px">
        <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px" bgcolor="#F9F9F9">
          <form id="breakdownForm" name="breakdownForm" class="well" action="" method="post">
            <fieldset style="font-family: sans-serif;">
              <div align="left">
                  <span><strong id="delivery_install_title">เลขที่แจ้งซ่อม </strong>
                  <input type="text" id="BCC_NO" style="height: 30px;width: 125px" value=" " readonly="readonly"/>
                  </span> 
                   <span  style="padding-left: 5px"><strong>วันที่เปิดเอกสาร</strong>
                    <input type="text" readonly="readonly" style="width:130px; height: 30px;" id="BCC_CREATED_TIME" /> 
                  </span> 
                   <span  style="padding-left: 5px"><strong>เวลานัดหมาย</strong>
                    <input type="text" id="BCC_DUE_DATE" style="width:100px; height: 30px;" value="" readonly="readonly">
                    ระบุเวลา
                    <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_START" type="text"> 
                                  - เวลา
                                  <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_END" type="text">
                                  <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
                  </span>  
                <br>
                <br>
              </div>
              <table border="0" width="100%" style="font-size: 12px"> 
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
    					   					บริษัทผู้แจ้ง:
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_CUSTOMER_NAME" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ชื่อผู้ติดต่อ:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_CONTACT" />
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					เบอร์โทร:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_TEL" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	<tr>
    					   		<td width="6%">
    					   				<span>
    					   					สถานที่ซ่อม:
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_LOCATION" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ที่อยู่:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR1" />
    					   				</span> 
    					   		</td> 
    					   		<td width="6%">
    					   				<span>
    					   					แขวง/ตำบล:
    					   				</span>
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR2" />
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
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR3" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					จังหวัด:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_PROVINCE" />
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					รหัสไปรษณีย์:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ZIPCODE" />
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
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="66%" colspan="4">
    					   				<span style="padding-left: 100px">
    					   					[ <span id="BCC_IS_MA_1"></span> ] ในประกัน (Warranty)
    					   				</span> 
    					   				<span style="padding-left: 50px">
    					   					[ <span id="BCC_IS_MA_2"></span> ] สัญญา MA เลขที่ (Contact No.):
    					   				</span> 
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;"  id="BCC_MA_NO" />
    					   				</span> 
    					   		</td> 
    					   		<td width="10%">
    					   				<span>
    					   					วันเริ่มรับประกัน:
    					   				</span>
    					   		</td>
    					   		<td width="23%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;" readonly="readonly" id="BCC_MA_START" />
    					   				</span> 
    					   		</td> 
    					   	</tr> 
    					   	<tr>
    					   		<td width="66%" colspan="4">
    					   				<span style="padding-left: 100px">
    					   					[ <span id="BCC_IS_MA_0"></span> ] นอกประกัน (Out Warranty)
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_1"></span> ] Gold
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_2"></span> ] Silver
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_3"></span> ] Bronze
    					   				</span>  
    					   		</td> 
    					   		<td width="10%">
    					   				<span>
    					   					วันหมดรับประกัน:
    					   				</span>
    					   		</td>
    					   		<td width="23%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;" readonly="readonly" id="BCC_MA_END" />
    					   				</span> 
    					   		</td> 
    					   	</tr> 
    					   	</table> 
    					  </div>
    					</td>
    				</tr>
    		</table>
              <table style="font-size: 12px" border="0" width="100%">
                <tbody>
                  <tr>
                    <td width="100%"></td>
                  </tr>
                  <tr valign="top">
                    <td align="left" valign="top"><table class="table table-striped table-bordered table-condensed" style="font-size: 12px" border="1">
                      <thead>
                        <tr>
                          <th width="5%"><div class="th_class">หมายเลขเครื่อง</div></th>
                          <th width="12%"><div class="th_class">Model (รุ่น)</div></th>
                          <th width="38%"><div class="th_class">อาการเสีย</div></th>
                           <th width="15%"><div class="th_class">Flow</div></th>
                           <th width="22%"><div class="th_class">บันทึกเพิ่มเติม</div></th>
                          <th width="8%"><div class="th_class">SLA</div></th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr style="cursor: pointer;">
                          <td style="text-align: left;"><input name="BCC_SERIAL" style="width:130px;height: 30;" type="text" id="BCC_SERIAL" value=""></td>
                          <td style="text-align: left;"><input name="BCC_MODEL" style="width:150px;height: 30;" type="text" id="BCC_MODEL" value=""></td>
                          <td style="text-align: left;"><textarea name="BCC_CAUSE" id="BCC_CAUSE" cols="100" rows="3" class="span10"></textarea></td>
                          <td style="text-align: left;">
                          <span id="flow"></span></td>
    					   	  <td style="text-align: left;">
    					   	   <textarea name="BCC_REMARK" id="BCC_REMARK" cols="100" rows="3" class="span10"></textarea>
                         </td>
    					   	  <td style="text-align: left;">
    					   	 <select name="BCC_SLA" id="BCC_SLA" style="width:70px">
                        <option value="24">24 ชม.</option>
                        <option value="48">48 ชม.</option>
                        <option value="72">72 ชม.</option> </select></td>
    
                        </tr>
                      </tbody>
                    </table>
                    <%-- 
                      <fieldset>
                      <legend><span style="font-size:14px">SLA : </span> 
                     </legend>
                      <legend><span style="font-size:14px">ระบุสถานะ</span></legend>
                      <table style="width: 100%;font-size:13px" border="0">
                        <tbody>
                          <tr style="height: 30px;">
                            <td width="30%" valign="top" nowrap="">
                                <p>
                                  <input type="radio" name="radio1" id="BCC_IS_MA1" value="1">
                                  อยู่ในประกัน<br>
                                  <input type="radio" name="radio1" id="BCC_IS_MA2" value="0">
                                  ไม่อยู่ในประกัน<br>
                                  <input type="radio" name="radio1" id="BCC_IS_MA3" value="2">
                                  อยู่ในประกัน MA เลขที่
                                  <input type="text" name="BCC_MA_NO" id="BCC_MA_NO" style="height: 30; width: 100px"><br>

                                ระยะเวลาประกัน <input type="text"  id="BCC_MA_START" style="width:100px; height: 30px;" value="" readonly="readonly">
                                      - <input type="text"   id="BCC_MA_END" style="width:100px; height: 30px;" value="" readonly="readonly">
                                  </p>
                                <p>&nbsp;</p></td>
                            <td width="20%" valign="top" nowrap=""><input type="radio" name="BCC_STATUS"  value="0">
เสนอราคาซ่อม  <br></td>
                            <td valign="top" nowrap=""> <p>
                              <input type="radio" name="BCC_STATUS" value="1">
ให้ดำเนินการซ่อม Onsite (กทม ปริฯ)<br><br>
 <input type="radio" name="BCC_STATUS" value="2">
ให้ดำเนินการซ่อม Onsite (ภูมิภาค)<br><br>
<input type="radio" name="BCC_STATUS" value="3">
                              ให้ซ่อมภายใน SC<br><br>
                            </p>
                              <p>
                                <input type="radio" name="BCC_STATUS" value="4">
ให้ดำเนินการรับเครื่อง (กทม ปริฯ)<br><br>
<input type="radio" name="BCC_STATUS" value="5">
ให้ดำเนินการรับเครื่อง (ภูมิภาค)<br><br>
                              </p>
                              <p>บันทึกเพิ่มเติม:<span style="text-align: left;">
                                <textarea name="BCC_REMARK" id="BCC_REMARK" cols="100" rows="3" class="span10"></textarea>
                              </span></p>
                              <br></td>
                          </tr>
                        </tbody>
                      </table>     
                      <hr>
                       
                      <table width="100%" border="0" cellpadding="0">
                        <tbody><tr>
                          <td>สำหรับงานเสียซ้ำ<br>
                            ติด NC เลขที่
                            <input type="text" name="textfield4" id="textfield4" style="height: 30; width: 100px">
        <input type="checkbox" name="checkbox" id="checkbox">
                            เสียคร้งที่
                            <input type="text" name="textfield5" id="textfield5" style="height: 30; width: 40px"></td>
                        </tr>
                      </tbody></table>
                       
                    </fieldset>
                     --%></td>
                  </tr>
                   
                </tbody>
              </table>
              <table border="0" width="100%" style="font-size: 12px"> 
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="100%" align="center">
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showOnSite()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">On Site</span>&nbsp;</a> 
    					   				</span> 
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showSC()">&nbsp;&nbsp;
    					   					<span style="color:white;font-weight:bold;">SC</span>&nbsp;&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showBorrow()">&nbsp;&nbsp;
    					   					<span style="color:white;font-weight:bold;">ยืม</span>&nbsp;&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showCheck()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">ตรวจเช็ค</span>&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showReceive()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">รับเครื่อง</span>&nbsp;</a> 
    					   				</span>
    					   		</td>
    					   	 </tr>
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
                    <a class="btn btn-info" onClick="loadDynamicPage('dispatcher/page/todolist')"> <span style="color:white; font-weight:bold; ">Back</span></a>&nbsp; 
                    <a class="btn btn-primary"  onclick="doCloseServicesJob('2','wait_for_supervisor_services_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a>
				 		 
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