<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authorize access="hasAnyRole('ROLE_CALL_CENTER_ACCOUNT')" var="isCallCenter"/>
 <sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/>  
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
    getCallCenter(); 
    autoProvince("BCC_PROVINCE");
    autoAmphur("BCC_ADDR3");
      autoDealer("BCC_CUSTOMER_NAME");
      autoCaller("BCC_LOCATION");
  //  autoCustname("BCC_CUSTOMER_NAME");
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
	 
	 $("#BCC_MA_START" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 $("#BCC_MA_END" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 
	 var query=" SELECT mapping.SERIAL as c0,product.IMA_ItemName as c1, "+
	 " so.BSO_IS_DELIVERY as c2,so.BSO_IS_INSTALLATION as c3,so.BSO_IS_DELIVERY_INSTALLATION as c4,so.BSO_IS_NO_DELIVERY as c5,so.BSO_IS_WARRANTY as c6,so.BSO_IS_PM_MA as c7, "+
	 "  so.BSO_PM_MA as c8,so.BSO_SLA as c9"+
		"  ,so.BSO_DELIVERY_LOCATION as c10"+
		"  ,so.BSO_DELIVERY_CONTACT as c11"+
		"  ,so.BSO_DELIVERY_ADDR1 as c12"+
		"  ,so.BSO_DELIVERY_ADDR2 as c13"+
		"  ,so.BSO_DELIVERY_ADDR3 as c14"+ 
		"  ,so.BSO_DELIVERY_PROVINCE as c15"+
		"  ,so.BSO_DELIVERY_ZIPCODE  as c16"+
		"  ,so.BSO_DELIVERY_TEL_FAX as c17"+

		 " ,so.BSO_INSTALLATION_SITE_LOCATION as c18"+
		"  ,so.BSO_INSTALLATION_CONTACT as c19"+
		"  ,so.BSO_INSTALLATION_ADDR1 as c20"+
		 "  ,so.BSO_INSTALLATION_ADDR2 as c21"+
		"  ,so.BSO_INSTALLATION_ADDR3 as c22"+
		"  ,so.BSO_INSTALLATION_PROVINCE as c23"+
		"  ,so.BSO_INSTALLATION_ZIPCODE as c24"+
		"  ,so.BSO_INSTALLATION_TEL_FAX as c25"+
		" ,arms2.CUSNAM as c26"+
		" ,so.CUSCOD as c27"+ 
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_START,'%d/%m/%Y'),'')  as c28"+
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_END,'%d/%m/%Y'),'')  as c29"+
		" ,IFNULL(so.BSO_MA_NO,'')  as c30"+
		" ,datediff(IFNULL(DATE_FORMAT(so.BSO_MA_END,'%Y-%m-%d'),''),now())  as c31 ,"+ 
		 "  CASE  "+
		 "    WHEN (so.BSO_IS_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+ 
		 "  IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') "+
		 "       WHEN (so.BSO_IS_DELIVERY_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+ 
		 "  IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') "+
		 "       WHEN (select so.BSO_IS_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 "  IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') "+
		 "       WHEN (select so.BSO_IS_NO_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 "  IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%d/%m/%Y'),'') "+ 
		 
		 "         ELSE "+
	    "  			 ''"+
		 "        END as c32, "+
		 "  CASE  "+
		 "    WHEN (select so.BSO_IS_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+  
		//    IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_DELIVERY_DUE_DATE,INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'') 
		 "  IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_DELIVERY_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'')  "+
		 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+ 
		 "  IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'')  "+ 
		 "       WHEN (select so.BSO_IS_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 "  IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'')  "+ 
		 "       WHEN (select so.BSO_IS_NO_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 "  IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_CREATED_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL 1 DAY),'%d/%m/%Y'),'')  "+  
		 "         ELSE "+
	    "  			 ''"+ 
		 "        END as c33, "+ 
		 "  CASE  "+
		 "    WHEN (select so.BSO_IS_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+  
		 " datediff(IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_DELIVERY_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL so.BSO_WARRANTY DAY) ,'%Y-%m-%d'),''),now()) "+
		 "       WHEN (select so.BSO_IS_DELIVERY_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+ 
		 " datediff(IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL so.BSO_WARRANTY DAY) ,'%Y-%m-%d'),''),now()) "+
		 "       WHEN (select so.BSO_IS_INSTALLATION='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 " datediff(IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_INSTALLATION_DUE_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL so.BSO_WARRANTY DAY) ,'%Y-%m-%d'),''),now()) "+
		 "       WHEN (select so.BSO_IS_NO_DELIVERY='1' and so.BSO_IS_WARRANTY='1')   "+
		 "         THEN   "+
		 " datediff(IFNULL(DATE_FORMAT(DATE(DATE_ADD(so.BSO_CREATED_DATE, INTERVAL so.BSO_WARRANTY YEAR) -INTERVAL so.BSO_WARRANTY DAY) ,'%Y-%m-%d'),''),now()) "+
		 
		 "         ELSE "+
	    "  			 ''"+
		 "        END as c34 ,"+ 
		 " ifnull(so.BSO_MA_TYPE,'') as c35 "+
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
	 " where   serial like   ";
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
						              BSO_MA_START: item[32],
						              BSO_MA_END: item[33],
						              BSO_MA_NO: item[30],
						               datediff: item[34] ,
						               BSO_MA_TYPE:item[35]
						              /*
						              BSO_MA_START: item[28],
						              BSO_MA_END: item[29],
						              BSO_MA_NO: item[30],
						               datediff: item[31] 
						              */
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
				  $('input[name="radio1"]').prop('checked', false);
				  $('input[name="BCC_STATUS"]').prop('checked', false);
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
				//  alert(ui.item.BSO_MA_TYPE)
				  $('input[name="BCC_MA_TYPE"]').prop('checked', false);
				  $('input[name="BCC_MA_TYPE"][value="'+ui.item.BSO_MA_TYPE+'"]').prop('checked', true);
				  
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
				   //$("#BCC_CUSTOMER_NAME").val(ui.item.CUSNAM);
				   $("#BCC_CONTACT").val(BCC_CONTACT); 
				   $("#BCC_TEL").val(BCC_TEL); 
				 //  $("#BCC_FAX").val(BCC_FAX); 
				   
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
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') ,"+
	    " IFNULL(call_center.BCC_SLA,'') ,"+
	    " IFNULL(call_center.BCC_IS_MA ,'') ,"+
	    " IFNULL(call_center.BCC_MA_NO ,'') ,"+
	  //  " IFNULL(call_center.BCC_MA_START ,'') ,"+
	  //  " IFNULL(call_center.BCC_MA_END ,'') ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') ,"+
	    " IFNULL(call_center.BCC_STATUS ,'') ,"+
	    " IFNULL(call_center.BCC_REMARK ,'') ,"+
	    " IFNULL(call_center.BCC_USER_CREATED ,'') ,"+
	    " IFNULL(call_center.BCC_DUE_DATE ,'') ,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') ,"+
	    " IFNULL(call_center.BCC_TEL ,'') ,"+
	    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') ,"+ //17
	  //  " IFNULL(arms.CUSNAM ,'') ,"+ //17
	    " IFNULL(call_center.BCC_ADDR1 ,'') ,"+
	    " IFNULL(call_center.BCC_ADDR2 ,'') ,"+
	    " IFNULL(call_center.BCC_ADDR3 ,'') ,"+
	    " IFNULL(call_center.BCC_LOCATION ,'') ,"+
	    " IFNULL(call_center.BCC_PROVINCE ,'') ,"+
	    " IFNULL(call_center.BCC_ZIPCODE ,'') ,"+
	   // " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%Y-%m-%d %H:%i:%s'),'') , "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') , "+
	    " IFNULL(call_center.BCC_CUSCODE ,'') ,"+
	    " IFNULL(call_center.BCC_SALE_ID ,'') ,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') , "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') , "+
	   // " IFNULL(call_center.BCC_DUE_DATE_START ,'') ,"+
	   // " IFNULL(call_center.BCC_DUE_DATE_END ,'') ,"+   
	   " (select count(*)  FROM "+SCHEMA_G+".BPM_TO_DO_LIST todo "+ 
	   "	   where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2') , "+
	   " IFNULL(call_center.BCC_STATE ,'') , "+
	   " IFNULL(call_center.BCC_CANCEL_CAUSE ,''), "+
	   " ifnull(call_center.BCC_MA_TYPE,'') ,  "+
	   " ifnull(call_center.BCC_CUSTOMER_TICKET,'') "+
	  // " IFNULL(call_center.BCC_FAX ,'') "+
	   
	   " FROM "+SCHEMA_G+".BPM_CALL_CENTER call_center left join  "+
	   "  "+SCHEMA_G+".BPM_ARMAS arms   "+
	   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
	  // " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	  // " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where call_center.BCC_NO='${bccNo}'";
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
					var BCC_CANCEL_CAUSE=data[0][31];
					var BCC_MA_TYPE=data[0][32];
					var BCC_CUSTOMER_TICKET=data[0][33]; $("#BCC_CUSTOMER_TICKET").val(BCC_CUSTOMER_TICKET);
					 $("input[name=BCC_MA_TYPE][value=" + BCC_MA_TYPE + "]").prop('checked', true);
					//var BCC_FAX=data[0][32];
					//  $('input[name="radio1"][value="2"]').prop('checked', true);
					//alert(BCC_STATE)
					$("#cancel_element").hide();
				if(BCC_STATE!='cancel')
					if(BCC_STATE.length>0){
						$("#button_update").show();
					}else{
						$("#button_send").show();
					
					}
				if(BCC_STATE=='cancel'){
					$("#cancel_element").show();
					$("#cancel_element").html("สาเหตุการยกเลิก : "+BCC_CANCEL_CAUSE);
				}
				if(isEdit && BCC_STATE!=''){
					// $("#BCC_SERIAL").attr("readonly","readonly" );
					// $("input[name=radio1]").attr("disabled",true);
					 //$("#BCC_MA_NO").attr("readonly","readonly" );
					 $("input[name=BCC_STATUS]").attr("disabled",true);
					 
				 }
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
					  " BCC_CREATED_TIME=now() ,BCC_UPDATED_BY = '${username}' ,BCC_UPDATED_TIME = now() "; 
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
	 var BCC_MA_TYPE= jQuery.trim($('input:radio[name="BCC_MA_TYPE"]:checked').val());
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
	 //var BCC_FAX= jQuery.trim($("#BCC_FAX").val());
	 var BCC_CUSTOMER_NAME =jQuery.trim($("#BCC_CUSTOMER_NAME").val());
	 var BCC_ADDR1 =jQuery.trim($("#BCC_ADDR1").val());
	 var BCC_ADDR2 = jQuery.trim($("#BCC_ADDR2").val());
	 var BCC_ADDR3= jQuery.trim($("#BCC_ADDR3").val());
	 var BCC_LOCATION = jQuery.trim($("#BCC_LOCATION").val());
	 var BCC_PROVINCE = jQuery.trim($("#BCC_PROVINCE").val()); 
	 var BCC_ZIPCODE = jQuery.trim($("#BCC_ZIPCODE").val()); 
	 var BCC_CUSCODE = jQuery.trim($("#BCC_CUSCODE").val()); 
	 var BCC_SALE_ID= jQuery.trim($("#BCC_SALE_ID").val()); 
	 var BCC_CUSTOMER_TICKET= jQuery.trim($("#BCC_CUSTOMER_TICKET").val()); 
	 var BCC_DUE_DATE_START= jQuery.trim($("#BCC_DUE_DATE_START").val()); 
	 var BCC_DUE_DATE_END= jQuery.trim($("#BCC_DUE_DATE_END").val());  
	//	alert("BCC_CUSTOMER_NAME->"+BCC_CUSTOMER_NAME)
	 if(!BCC_CUSTOMER_NAME.length>0){
		  alert("กรุณาใส่ บริษัทผู้แจ้ง");
		  $("#BCC_CUSTOMER_NAME").focus();
		  return false;
	  }
		 
		 if(!BCC_SERIAL.length>0){
			  alert("กรุณาใส่ หมายเลขเครื่อง");
			  $("#BCC_SERIAL").focus();
			  return false;
		  } 
		 if(!BCC_IS_MA.length>0){
			  alert("กรุณาใส่ ระบุสถานะ");
			  $("#BCC_MA_NO").focus();
			  return false;
		  }
	 if(!BCC_CONTACT.length>0){
		  alert("กรุณาใส่ ชื่อผู้ติดต่อ");
		  $("#BCC_CONTACT").focus();
		  return false;
	  }
	 if(!BCC_TEL.length>0){
		  alert("กรุณาใส่ เบอร์โทร");
		  $("#BCC_TEL").focus();
		  return false;
	  }
 
	 
	 if(!BCC_LOCATION.length>0){
		  alert("กรุณาใส่ สถานที่ซ่อม");
		  $("#BCC_LOCATION").focus();
		  return false;
	  }
	 if(!BCC_ADDR1.length>0){
		  alert("กรุณาใส่ ที่อยู่");
		  $("#BCC_ADDR1").focus();
		  return false;
	  }
	 if(!BCC_ADDR2.length>0){
		  alert("กรุณาใส่ แขวง/ตำบล");
		  $("#BCC_ADDR2").focus();
		  return false;
	  }
	 if(!BCC_ADDR3.length>0){
		  alert("กรุณาใส่ เขต/อำเภอ");
		  $("#BCC_ADDR3").focus();
		  return false;
	  }
	 if(!BCC_PROVINCE.length>0){
		  alert("กรุณาใส่ จังหวัด");
		  $("#BCC_PROVINCE").focus();
		  return false;
	  }
	 if(!BCC_ZIPCODE.length>0){
		  alert("กรุณาใส่ รหัสไปรษณีย์");
		  $("#BCC_ZIPCODE").focus();
		  return false;
	  }
	 
	 
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
	"BCC_MA_TYPE='"+BCC_MA_TYPE+"' ,"+
	" BCC_REMARK = '"+BCC_REMARK+"' ,"+
	// " BCC_USER_CREATED = '"+BCC_USER_CREATED+"' ,"+
	// " BCC_DUE_DATE = '"+BCC_DUE_DATE+"', "+ 
	" BCC_CONTACT = '"+BCC_CONTACT+"' ,"+
	//" BSO_BORROW_DURATION = '"+BSO_BORROW_DURATION+"', "+
	" BCC_TEL = '"+BCC_TEL+"', "+
	//" BCC_FAX='"+BCC_FAX+"',"+ 	
	" BCC_CUSTOMER_NAME = '"+BCC_CUSTOMER_NAME+"', "+
	" BCC_ADDR1 = '"+BCC_ADDR1+"' ,  "+
	" BCC_ADDR2 = '"+BCC_ADDR2+"', "+
	" BCC_ADDR3= '"+BCC_ADDR3+"', "+
	" BCC_LOCATION = '"+BCC_LOCATION+"', "+
	" BCC_PROVINCE = '"+BCC_PROVINCE+"' , "+ 
	" BCC_ZIPCODE = '"+BCC_ZIPCODE+"' , "+
	" BCC_CUSTOMER_TICKET='"+BCC_CUSTOMER_TICKET+"' , "+
	" BCC_SALE_ID = '"+BCC_SALE_ID+"' ,  " +
	" BCC_UPDATED_BY = '${username}' ,  " +
	" BCC_UPDATED_TIME = now(),  " ; 

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
//	alert("query_update->"+query_update)
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
		//alert(query_search)
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
      //var BCC_STATUS_ELEMENT=document.getElementsByName("BCC_STATUS");
       var BCC_STATUS=jQuery.trim($("input[name=BCC_STATUS]:checked" ).val());
       var SBJ_JOB_STATUS="0";
       var SBJ_DEPT_ID="";
    // alert(BCC_STATUS)
     if(!BCC_STATUS.length>0){
		  alert("กรุณาระบุ สถานะ");
		 // $("#BCC_SERIAL").focus();
		  return false;
	  }
      var state="";
		if(BCC_STATUS=='2'){ // IT REG
			 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
				"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
				"('${bccNo}','2','wait_for_assign_to_team','"+data[0][1]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
			 SBJ_DEPT_ID="3";
			 SBJ_JOB_STATUS="1";
		} 
		else if(BCC_STATUS=='1'){ // IT
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][0]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
			 SBJ_DEPT_ID="2";
			 SBJ_JOB_STATUS="1";
		}
		else if(BCC_STATUS=='3'){ // SC
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][2]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 SBJ_JOB_STATUS="4";
			 state="wait_for_assign_to_team";
			 SBJ_DEPT_ID="1";
		}
		else if(BCC_STATUS=='4'){ // REF
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][3]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
			 SBJ_DEPT_ID="4";
			 SBJ_JOB_STATUS="1";
		}
		else if(BCC_STATUS=='5'){ // REF REG
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][4]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
			 SBJ_DEPT_ID="5";
			 SBJ_JOB_STATUS="1";
		}
		else if(BCC_STATUS=='0'){ // SALE
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_quotation','ROLE_QUOTATION_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_quotation";
			 SBJ_JOB_STATUS="2";
			 SBJ_DEPT_ID="6";
		}else  { // Key Account
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','Job wait for Check','',0,now(),	null,'1','${username}','${bccNo}',null) ";
	 		querys.push(query); 
	 		 state="wait_for_send_to_supervisor";
	 		 SBJ_JOB_STATUS="6";
			 SBJ_DEPT_ID="7";
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
		query=" INSERT INTO "+SCHEMA_G+".BPM_SERVICE_JOB (BCC_NO,BSJ_CREATED_TIME,BSJ_STATE,SBJ_JOB_STATUS,SBJ_DEPT_ID) VALUES ('${bccNo}',now(),'"+state+"','"+SBJ_JOB_STATUS+"','"+SBJ_DEPT_ID+"')";
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
											    	<c:if test="${isCallCenter || isKeyAccount }">
											    	loadDynamicPage('dispatcher/page/callcenter');
											    	</c:if> 
											    	<c:if test="${!isCallCenter || !isKeyAccount}">
											    	loadDynamicPage('dispatcher/page/todolist');
											    	</c:if>
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
 function clearElementTimeMAValue(){
	 $("#BCC_MA_START").val("");
	 $("#BCC_MA_END").val("");  
 }
 function clearElementTimeValue(){
	 $("#BCC_DUE_DATE").val("");
	 $("#BCC_DUE_DATE_START").val("");
	 $("#BCC_DUE_DATE_END").val(""); 
 }
 function printJobServices(){
	 var src = "getJobServices/${bccNo}";
		//src=src+"?type="+type;
		window.open(src,"_bank");
		/*
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
		*/
}
 function printTag(){
	 var src = "getTag/${bccNo}";
		//src=src+"?type="+type;
		window.open(src,"_bank");
 }
 function copyHistory(bcc_no){
	 var queryCopy="SELECT  ifnull(center.BCC_CUSTOMER_NAME,'') as c0,ifnull(center.BCC_LOCATION,'') as c1,ifnull(center.BCC_CONTACT,'') as c2"+
	 " ,ifnull(center.BCC_TEL,'') as c3, ifnull(center.BCC_ADDR1,'') as c4,ifnull(center.BCC_ADDR2,'') as c5, ifnull(center.BCC_ADDR3,'') as c6,ifnull(center.BCC_PROVINCE,'') as c7 "+
	 "		 ,ifnull(center.BCC_ZIPCODE,'')  as c8 , ifnull(center.BCC_MODEL,'')  as c9, ifnull(center.BCC_CAUSE,'')  as c10 ,"+
	 "ifnull(center.BCC_SLA,'')  as c11,ifnull(center.BCC_IS_MA,'')  as c12,ifnull(center.BCC_MA_NO,'')  as c13,DATE_FORMAT(center.BCC_MA_START,'%d/%m/%Y')  as c14, "+
	 "DATE_FORMAT(center.BCC_MA_END,'%d/%m/%Y')  as c15,ifnull(center.BCC_MA_TYPE,'')  as c16 "+ 
	 
	 "	 FROM   "+SCHEMA_G+".BPM_SERVICE_JOB sv left join "+
	 "	   "+SCHEMA_G+".BPM_CALL_CENTER center on sv.bcc_no=center.bcc_no where  center.bcc_no='"+bcc_no+"' ";
 SynDomeBPMAjax.searchObject(queryCopy,{
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
				 $("#BCC_CUSTOMER_NAME").val(data[0][0]);
				 $("#BCC_LOCATION").val(data[0][1]);
				 $("#BCC_CONTACT").val(data[0][2]);
				 $("#BCC_TEL").val(data[0][3]);
				 $("#BCC_ADDR1").val(data[0][4]);
				 $("#BCC_ADDR2").val(data[0][5]);
				 $("#BCC_ADDR3").val(data[0][6]);
				 $("#BCC_PROVINCE").val(data[0][7]);
				 $("#BCC_ZIPCODE").val(data[0][8]);
				 
				 $("#BCC_MODEL").val(data[0][9]);
				 $("#BCC_CAUSE").val(data[0][10]);
				 $("#BCC_SLA").val(data[0][11]);
				 //$("#BCC_IS_MA").val(data[0][12]);
				 $("input[name=radio1][value=" + data[0][12] + "]").prop('checked', true); 
				 $("#BCC_MA_NO").val(data[0][13]);
				 $("#BCC_MA_START").val(data[0][14]);
				 $("#BCC_MA_END").val(data[0][15]); 
				  $('input[name="BCC_MA_TYPE"][value="'+data[0][16]+'"]').prop('checked', true);
				 
				 
				 bootbox.dialog("Copy ข้อมูลเรียบร้อย.",[{
					    "label" : "Ok",
					     "class" : "btn-success"
				 }]);
			}
		}});
 }
 function doCheckHistory(){
	 var BCC_SERIAL=jQuery.trim($("#BCC_SERIAL").val());
	 if(!BCC_SERIAL.length>0){
		  alert("กรุณาใส่ หมายเลขเครื่อง");
		  $("#BCC_SERIAL").focus();
		  return false;
	  }
	 $("#history_section").html("<img src=\'"+_path+"resources/images/loading.gif\' />"); 
	 var queryCheck="SELECT  center.bcc_no as c0,center.BCC_CAUSE as c1,DATE_FORMAT(center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i') as c2,center.BCC_CUSTOMER_NAME as c3,center.BCC_LOCATION as c4,center.BCC_CONTACT as c5"+
		 " ,center.BCC_TEL as c6,concat(center.BCC_ADDR1,' ',center.BCC_ADDR2,' ',center.BCC_ADDR3,' ',center.BCC_PROVINCE "+
		 "		 ,center.BCC_ZIPCODE) as c7 , center.BCC_USER_CREATED as c8"+
		 "	 FROM   "+SCHEMA_G+".BPM_SERVICE_JOB sv left join "+
		// "	   "+SCHEMA_G+".BPM_CALL_CENTER center on sv.bcc_no=center.bcc_no where  lower(center.BCC_SERIAL) like '%"+BCC_SERIAL+"%' "+
		 "	   "+SCHEMA_G+".BPM_CALL_CENTER center on sv.bcc_no=center.bcc_no where  lower(center.BCC_SERIAL) = '"+BCC_SERIAL+"' "+
		 "		 order by sv.BSJ_CREATED_TIME" ;
	// alert(queryCheck);
	 SynDomeBPMAjax.searchObject(queryCheck,{
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
				var BCC_NO_CHECK=$("#BCC_NO").val();
				//alert(BCC_CREATED_TIME)
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		        "	<thead> 	"+
		        "  		<tr> "+
		        "  		<th width=\"5%\"><div class=\"th_class\">#</div></th> "+
		        "  		<th width=\"15%\"><div class=\"th_class\">อาการเสีย</div></th> "+
		        "  		<th width=\"10%\"><div class=\"th_class\">วันที่เปิดเอกสาร</div></th> "+
		        "  		<th width=\"15%\"><div class=\"th_class\">บริษัทผู้ขาย(Dealer/User)</div></th> "+   
		        "  		<th width=\"16%\"><div class=\"th_class\">บริษัทผู้แจ้ง</div></th> "+ 
		        "  		<th width=\"10%\"><div class=\"th_class\">ชื่อผู้ติดต่อ</div></th> "+
		        "  		<th width=\"5%\"><div class=\"th_class\">เบอร์โทร</div></th> "+  
		        "  		<th width=\"22%\"><div class=\"th_class\">ที่อยู่</div></th> "+ 
		        "  		<th width=\"2%\"><div class=\"th_class\"></div></th> "+
		        " 		</tr>"+
		        "	</thead>"+
		        "	<tbody>   ";  
				if(data!=null && data.length>0){
					var color=""
					for(var j=0;j<data.length;j++){
						if(data[j][0]==BCC_NO_CHECK)
							color="background-color:yellow;"; 
						 else
							 color="";
						  str=str+ "  	<tr style=\"cursor: pointer;\">"+
						       "  		<td style=\"text-align: left;"+color+"\"><span style=\"text-decoration: underline;\" onclick=\"loadDynamicPage(\'dispatcher/page/service_detail?bccNo="+data[j][0]+"&mode=edit\');\" >"+data[j][0]+"</span></td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][1]+"</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][2]+"("+data[j][8]+")</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][3]+"</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][4]+"</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][5]+"</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][6]+"</td>"+  
							   "  		<td style=\"text-align: left;\">"+data[j][7]+"</td>"+  
							   "  		<td style=\"text-align: left;\"><i onclick=\"copyHistory('"+data[j][0]+"')\" class=\"icon-circle-arrow-down\"></i></td>"+  
						        "  	</tr>  "; 
						        if(j==20)
						        	break;
					}
				}else{
					 str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    		"<thead>"+
			    		"<tr> "+
		      			"<th colspan=\"8\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
		      		"</tr>"+
		    	"</thead>"+
		    	"<tbody>"; 
				   }
				        str=str+  " </tbody>"+
						   "</table> "; 
				$("#history_section").html(str);
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
              <div align="left"><strong id="delivery_install_title">เลขที่แจ้งซ่อม</strong>
                  <input type="text" id="BCC_NO" style="height: 30px;width: 125px" value=" " readonly="">
                   <span style="padding-left:10px;">Customer Ticket</span>
                     <span style="padding-left:5px;"><input type="text" id="BCC_CUSTOMER_TICKET" style="height: 30px;width: 125px" ></span>
                  <span style="padding-left:20px;color:red" id="cancel_element"></span>
              <!--  มีใบยืม                	เลขที่
                <input id="BSO_BORROW_NO" style="height: 30px;width: 125px" type="text">-->
                	<c:if test="${isKeyAccount || isQuotationAccount}">
                <a class="btn btn-primary" onclick="printJobServices()"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบแจ้งซ่อม</span></a>
               </c:if>
                  <span style="padding-left:20px;">
                   <a class="btn btn-primary" onclick="printTag()"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบ Tag</span></a>
                  </span>
                <br>
                <br>
              </div>
              <table style="font-size: 12px" border="0" width="100%">
                <tbody>
                  <tr>
                    <td width="100%"></td>
                  </tr>
                  <tr valign="top">
                    <td align="left" valign="top"><table class="table table-striped table-bordered table-condensed" style="font-size: 12px" border="1">
                      <thead>
                        <tr>
                          <th width="5%"><div class="th_class">หมายเลขเครื่อง<span style="color: red;font-size: 20;"><strong>*</strong></span></div></th>
                          <th width="12%"><div class="th_class">Model (รุ่น)</div></th>
                          <th width="53%"><div class="th_class">อาการเสีย</div></th>
                          <th width="10%"><div class="th_class">วันที่เปิดเอกสาร</div></th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr style="cursor: pointer;">
                          <td style="text-align: left;"><input name="BCC_SERIAL" style="height: 30;" type="text" id="BCC_SERIAL" value=""></td>
                          <td style="text-align: left;"><input name="BCC_MODEL" style="height: 30;" type="text" id="BCC_MODEL" value=""></td>
                          <td style="text-align: left;"><textarea name="BCC_CAUSE" id="BCC_CAUSE" cols="100" rows="3" class="span10"></textarea></td>
                          <td style="text-align: left;">
                          <span style="padding-left: 3px">
                          	<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
    					   	 <input type="text" readonly="readonly" value="${time}" style="width:130px; height: 30px;" id="BCC_CREATED_TIME" />
    					   	 </span></td>
    
                        </tr>
                      </tbody>
                    </table>
                      <fieldset>
                      <legend><span style="font-size:14px">SLA : </span>
                      <select name="BCC_SLA" id="BCC_SLA" class="span2">
                        <option>24</option>
                        <option>48</option>
                        <option>72</option>                        
                      </select>
                     <span style="font-size:14px">ชม.</span></legend>
                      <legend><span style="font-size:14px">ระบุสถานะ<span style="color: red;font-size: 20;"><strong>*</strong></span></span></legend>
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

                                ระยะเวลาประกัน <input type="text"  id="BCC_MA_START" style="width:100px; height: 30px;" value="" readonly="readonly" >
                                      - <input type="text"   id="BCC_MA_END" style="width:100px; height: 30px;" value="" readonly="readonly">
                                       <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeMAValue()"></i>
                                      <br/>
                                      <input type="radio" value="1" name="BCC_MA_TYPE">Gold &nbsp;&nbsp;
    					   				<input type="radio" value="2" name="BCC_MA_TYPE">Silver  &nbsp;&nbsp;
    					   				<input type="radio" value="3" name="BCC_MA_TYPE">Bronze  &nbsp;&nbsp; 
    					   				 <i class="icon-refresh" style="cursor: pointer;" onclick="clearSelect('BCC_MA_TYPE')"></i>
                                  </p>
                                <p>&nbsp;</p></td>
                            <td width="20%" valign="top" nowrap=""><input type="radio" name="BCC_STATUS"  value="0">
เสนอราคาซ่อม  <br></td>
                            <td valign="top" nowrap=""> <p>
                              <input type="radio" name="BCC_STATUS" value="1">
<%-- ให้ดำเนินการซ่อม Onsite (กทม ปริฯ)<br><br>  --%>
ให้ดำเนินการซ่อม Onsite (ช่าง IT)<br><br>
 <input type="radio" name="BCC_STATUS" value="2">
 <%-- 
ให้ดำเนินการซ่อม Onsite (ภูมิภาค)<br><br>
 --%>
ให้ดำเนินการซ่อม Onsite (ช่างภูมิภาค)<br><br>
<input type="radio" name="BCC_STATUS" value="3">
                              ให้ซ่อมภายใน SC<br><br>
                            </p>
                              <p>
                                <input type="radio" name="BCC_STATUS" value="4">
<%-- 
ให้ดำเนินการรับเครื่อง (กทม ปริฯ)<br><br>
 --%>
ให้ดำเนินการรับเครื่อง (ขนส่งรับจ้าง)<br><br>
<input type="radio" name="BCC_STATUS" value="5">
<%-- 
ให้ดำเนินการรับเครื่อง (ภูมิภาค)<br><br>
 --%>
ให้ดำเนินการรับเครื่อง (ขนส่งต่างจังหวัด)<br><br>
<input type="radio" name="BCC_STATUS" value="6">
<%-- 
ให้ดำเนินการรับเครื่อง (ภูมิภาค)<br><br>
 --%>
ตรวจสอบเอกสาร<br><br>

                              </p>
                              <p>บันทึกเพิ่มเติม:<span style="text-align: left;">
                                <textarea name="BCC_REMARK" id="BCC_REMARK" cols="100" rows="3" class="span10"></textarea>
                              </span></p>
                              <br></td>
                          </tr>
                        </tbody>
                      </table>     
                      <hr>
                      <div>
                      <span id="button_check"> <a class="btn btn-primary" onclick="doCheckHistory()">&nbsp;<span style="color:white; font-weight:bold;">ดูประวัติการซ่อม</span></a> </span>
                      </div>
                      <div align="center" id="history_section"></div>
                      <%-- 
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
                      --%>
                      <%-- 
                 <table class="table table-striped table-bordered table-condensed" border="1" style="font-family: tohoma;font-size: 12px">
			    <thead> 	 
			    <tr>
			    <th width="5%"><div class="th_class">No.</div></th>
			    <th width="20%"><div class="th_class">อาการเสีย</div></th>
			    <th width="10%"><div class="th_class">วันที่เปิดเอกสาร</div></th>  
			    <th width="45%"><div class="th_class">สถานที่ซ่อม</div></th> 
			    <th width="15%"><div class="th_class">ชื่อผู้ติดต่อ/เบอร์โทร</div></th> 
			    
			    <th width="5%"><div class="th_class"></div></th>
			     </tr> 
			    </thead> 
			    <tbody>
			    <tr>
			    <td>1.</td>
			    <td>ไฟไม่ติด</td>
			    <td>2014-04-18 00:09</td>
			    <td>บริษัท ออโต้เมทด์ จำกัด 35/15 หมู่7 ซอยกิ่งแก้ว ราชาเทวะ บางพลี สมุทรปราการ 10540</td>
			     <td>คุณสมทรง 02-738-5071-3,F02-175-1743</td> 
			    <td></td> 
			    </tr> 
			    </tbody>
			    </table> 
			     --%>
                    </fieldset></td>
                  </tr>
                  <tr valign="top">
                    <td align="left" valign="top" width="100%"><div id="bsoType_2" style="background: none repeat scroll 0% 0% rgb(249, 249, 249); padding: 2px; margin-top: 1px;">
                          <fieldset><legend>สถานที่ซ่อม</legend><table style="width: 100%;font-size:13px" border="0">
                            <tbody>
                              <tr>
                                <td width="25%"> เวลานัดหมาย </td>
                                <td width="75%"><input type="text" id="BCC_DUE_DATE" style="width:100px; height: 30px;" value="" readonly="readonly">
                                      ระบุเวลา
                                  <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_START" type="text"> 
                                  - เวลา
                                  <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_END" type="text">
                                  <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
                                  <br></td>
                              </tr>
                              <tr>
                                <td>บริษัทผู้ขาย(Dealer/User)<span style="color: red;font-size: 20;"><strong>*</strong></span></td> 
                                <td> <input type="hidden" id="BCC_CUSCODE"/><input type="text" id="BCC_CUSTOMER_NAME" style="width:300px; height: 30px;" value="">                                </td>
                              </tr>
                             
                              
                              <tr>
                                <td width="20%"> บริษัทผู้แจ้ง<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="80%"><input style="height: 30px;width: 320px" id="BCC_LOCATION" type="text">                                </td>
                              </tr>
                              <tr>
                                <td width="25%"> ชื่อผู้ติดต่อ<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="75%"><input type="hidden" id="BCC_CUSCODE"/><input type="text" id="BCC_CONTACT" style="width:300px; height: 30px;" value="">                                </td>
                              </tr>
                              <tr>
                                <td> เบอร์โทร<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td><input type="text" id="BCC_TEL" style="width:300px; height: 30px;" value="">                                </td>
                              </tr>
                               
                              <tr valign="top">
                                <td width="20%"> ที่อยู่<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="80%"><input style="height: 30px;width: 700px" id="BCC_ADDR1" type="text">                                </td>
                              </tr>
                              <tr valign="top">
                                <td width="20%"> แขวง/ตำบล<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="80%"><input type="text" id="BCC_ADDR2" style="height: 30px;width: 320px" value="">                                </td>
                              </tr>
                              <tr valign="top">
                                <td width="20%"> เขต/อำเภอ<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="80%"><input type="text" id="BCC_ADDR3" style="height: 30px;width: 320px" value="">                                </td>
                              </tr>
                              <tr valign="top">
                                <td width="20%"> จังหวัด<span style="color: red;font-size: 20;"><strong>*</strong></span> </td>
                                <td width="80%"><input type="text" id="BCC_PROVINCE" style="height: 30px;width: 320px" value="">                                </td>
                              </tr>
                              <tr valign="top">
                                <td width="20%"> รหัสไปรษณีย์<span style="color: red;font-size: 20;"><strong>*</strong></span></td>
                                <td width="80%"><input style="height: 30px;width: 320px" id="BCC_ZIPCODE" type="text">                                </td>
                              </tr> 
                            </tbody>
                          </table></fieldset>
                        </div>                    </td>
                  </tr>
                </tbody>
              </table>
            </fieldset>
            <div style="padding-top: 10px" align="center">
              <table style="width: 100%" border="0">
                <tbody>
                  <tr> 
                    <td width="20%">
                     <c:if test="${isCallCenter || isKeyAccount || isSupervisorAccount}"><a class="btn btn-info" onClick="loadDynamicPage('dispatcher/page/callcenter')"> <span style="color:white; font-weight:bold; ">Back</span></a>&nbsp; 
                     </c:if>
                     </td>
                    
                    <td align="center" width="80%">
                    <c:if test="${!isStoreAccount}">
                    <span id="button_send" style="display: none;"> <a class="btn btn-primary" onclick="doSubmitCallCenter()">&nbsp;<span style="color:white; font-weight:bold;">Submit</span></a> </span> <span id="button_update" style="display: none;"> <a class="btn btn-primary" onclick="doSaveDraftAction()">&nbsp;<span style="color:white; font-weight:bold;">Update</span></a> </span>
                    </c:if>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            </form>
            </div>
  </fieldset>