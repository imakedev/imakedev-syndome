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
.ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
.ui-timepicker-div dl { text-align: left; }
.ui-timepicker-div dl dt { float: left; clear:left; padding: 0 0 0 5px; }
.ui-timepicker-div dl dd { margin: 0 10px 10px 40%; }
.ui-timepicker-div td { font-size: 90%; }
.ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }

.ui-timepicker-rtl{ direction: rtl; }
.ui-timepicker-rtl dl { text-align: right; padding: 0 5px 0 0; }
.ui-timepicker-rtl dl dt{ float: right; clear: right; }
.ui-timepicker-rtl dl dd { margin: 0 40% 10px 10px; }
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 
   getSaleOrder(); 
   getDeliveryTran();
}); 
function loadFile(path_file){ 
	var src = path_file;
//	src=src+"?type="+type;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
}
function getDeliveryTran(){  
	var query="SELECT "+
		" BSO_ID ,"+
		" BDT_CUST_NAME ,"+
		" BDT_DOC_ATTACH_NAME ,"+
		" BDT_DOC_ATTACH_PATH ,"+
		" BDT_IS_INTERNAL ,"+
		" IFNULL(DATE_FORMAT(BDT_CREATED_DATE,'%d/%m/%Y %H:%i'),'') ,"+  
		" BDT_CREATED_BY ,"+
		" BDT_DOC_ATTACH_HOTLINK "+
		" FROM "+SCHEMA_G+".BPM_DELIVERY_TRAN   where BSO_ID=${bsoId} ";
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
					var BDT_CUST_NAME=data[0][1]!=null?data[0][1]:"";  $("#BDT_CUST_NAME").val(BDT_CUST_NAME);
					var BDT_DOC_ATTACH_NAME=data[0][2]!=null?data[0][2]:"";// $("#BDT_DOC_ATTACH_NAME").val(BDT_DOC_ATTACH_NAME);
					var BDT_DOC_ATTACH_HOTLINK=data[0][7]!=null?data[0][7]:"";// $("#BDT_DOC_ATTACH_HOTLINK").val(BDT_DOC_ATTACH_HOTLINK);
					var BDT_CREATED_BY=data[0][6]!=null?data[0][6]:"";  $("#BDT_CREATED_BY").html(BDT_CREATED_BY);
					var BDT_CREATED_DATE=data[0][5]!=null?data[0][5]:"";  $("#BDT_CREATED_DATE").html("( "+BDT_CREATED_DATE+" )");
					$("#BDT_DOC_ATTACH_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
					$("#BDT_DOC_ATTACH_SRC").html(BDT_DOC_ATTACH_NAME);
				     $("#BDT_DOC_ATTACH_SRC").attr("onclick","loadFile('getfile/delivery/${bsoId}/"+BDT_DOC_ATTACH_HOTLINK+"')");
				}else{
				var querys=[];  
					
					var query_insert="insert into "+SCHEMA_G+".BPM_DELIVERY_TRAN set BSO_ID=${bsoId} "+
					  ", BDT_CREATED_DATE=now(),BDT_CREATED_BY='${username}'";
					querys.push(query_insert); 
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
								//searchDeliveryInstallation("1"); 
							}
						}
					});
				}
			}});
}
function bsoTypeCheck(type){  
	//alert(type)
	// type='3'
       $("#bsoType_1").slideUp(1000);
	   $("#bsoType_2").slideUp(1000);  
	   $("#cust_input_1").slideUp(1000);  
	   $("#cust_input_2").slideUp(1000);  
	   $("#cust_input_3").slideUp(1000);   
	   if(type=='1' || type=='2'){
		   $("#bsoType_"+type).slideDown(1000);
	   		if(type=='1')
	   	    	$("#cust_input_"+type).slideDown(1000);
	   		/* $("#bsoType_"+type).slideDown(1000);
	   	    $("#cust_input_"+type).slideDown(1000);
	   	    if(type=='2')
	   	    	 $("#cust_input_3").slideDown(1000); */
	   }
	   
	   if(type=='3'){ 
				  $("#bsoType_1").slideDown(1000);
				  $("#bsoType_2").slideDown(1000); 
				  $("#cust_input_1").slideDown(1000);  
				 /*  $("#cust_input_2").slideDown(1000);  
				  $("#cust_input_3").slideDown(1000);  */
		  }
}

function getSaleOrder(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	//$("#delivery_install_title").html("Sale Order ("+function_message+")");
	$("#delivery_install_title").html("Sale Order ");
  if(isEdit){  
	  var query=" SELECT "+
	   " so.BSO_ID, "+
	   " so.CUSCOD, "+
	   " so.BSO_SALE_ID, "+
	   " so.BSO_IS_DELIVERY, "+
	   " so.BSO_IS_INSTALLATION, "+
	   " so.BSO_DELIVERY_DUE_DATE, "+
	   " so.BSO_DELIVERY_LOCATION, "+
	   " so.BSO_DELIVERY_CONTACT, "+
	   " so.BSO_INSTALLATION_SITE_LOCATION, "+
	   " so.BSO_INSTALLATION_CONTACT, "+
	   " so.BSO_INSTALLATION_TEL_FAX, "+
	   " so.BSO_INSTALLATION_DUE_DATE, "+
	   " so.BSO_LEVEL, "+
	   " IFNULL(DATE_FORMAT(so.BSO_DOC_CREATED_DATE,'%d/%m/%Y'),'') ,"+
	   " so.BSO_CUSTOMER_TYPE, "+
	   " so.BSO_PO_NO, "+
	   " so.BSO_PAYMENT_TERM, "+
	   " so.BSO_PAYMENT_TERM_DESC, "+
	   " so.BSO_BORROW_TYPE, "+
	   " so.BSO_BORROW_EXT, "+
	   " so.BSO_BORROW_DURATION, "+
	   " so.BSO_IS_WARRANTY, "+
	   " so.BSO_WARRANTY, "+
	   " so.BSO_IS_PM_MA, "+
	   " so.BSO_OPTION, "+
	   " so.BSO_TYPE, "+
	   " so.BSO_TYPE_NO, "+
	   " so.BSO_CREATED_BY, "+
	   " so.BSO_UPDATED_BY, "+  
	   " armas.CUSNAM , "+
	   " armas.CUSTYP, "+
	   " armas.PRENAM, "+
	   " armas.ADDR01, "+
	   " armas.ADDR02, "+
	   " armas.ADDR03, "+
	   " armas.ZIPCOD, "+ 
	   " armas.TELNUM, "+
	   " armas.CONTACT, "+
	   " armas.CUSNAM2 ,"+  
	   " so.BSO_SLA ,"+
	   " so.BSO_PM_MA, "+ 
	   " so.BSO_IS_OPTION ,"+
	   " so.BSO_IS_HAVE_BORROW , "+
	   " so.BSO_BORROW_NO ,"+
	   " so.BSO_IS_DELIVERY_INSTALLATION ,"+ 
	   " so.BSO_IS_NO_DELIVERY, "+  
	   " so.BSO_DELIVERY_TYPE, "+ 
	   " so.BSO_DELIVERY_ADDR1, "+ 
	   " so.BSO_DELIVERY_ADDR2, "+ 
	   " so.BSO_DELIVERY_ADDR3, "+ 
	   " so.BSO_DELIVERY_PROVINCE, "+
	   " so.BSO_DELIVERY_ZIPCODE, "+
	   " so.BSO_DELIVERY_TEL_FAX, "+
	   " so.BSO_INSTALLATION_ADDR1, "+
	   " so.BSO_INSTALLATION_ADDR2, "+
	   " so.BSO_INSTALLATION_ADDR3, "+
	   " so.BSO_INSTALLATION_PROVINCE, "+
	   " so.BSO_INSTALLATION_ZIPCODE, "+
	   " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'') , "+ 
	   " so.BSO_RFE_NO , "+
	   " so.BSO_INT_NO , "+
	   " so.BSO_EXPRESS_INV_NO "+
	   " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	   " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where so.BSO_ID=${bsoId}";
	   
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
					$("#bsoTypeNo").val(data[0][26]);
					var BSO_ID=data[0][0]!=null?data[0][0]:""; 
					var CUSCOD=data[0][1]!=null?data[0][1]:""; $("#CUSCOD").val(CUSCOD);
					var BSO_SALE_ID=data[0][2]!=null?data[0][2]:""; $("#BSO_SALE_ID").val(BSO_SALE_ID);
					var BSO_IS_DELIVERY=data[0][3]!=null?data[0][3]:""; $("#BSO_IS_DELIVERY").val(BSO_IS_DELIVERY);
					var BSO_IS_INSTALLATION=data[0][4]!=null?data[0][4]:""; $("#BSO_IS_INSTALLATION").val(BSO_IS_INSTALLATION);
					var BSO_DELIVERY_DUE_DATE=data[0][5]!=null?data[0][5]:"";// $("#BSO_DELIVERY_DUE_DATE").val(BSO_DELIVERY_DUE_DATE);
					var BSO_DELIVERY_LOCATION=data[0][6]!=null?data[0][6]:""; $("#BSO_DELIVERY_LOCATION").val(BSO_DELIVERY_LOCATION);
					var BSO_DELIVERY_CONTACT=data[0][7]!=null?data[0][7]:""; $("#BSO_DELIVERY_CONTACT").val(BSO_DELIVERY_CONTACT);
					var BSO_INSTALLATION_SITE_LOCATION=data[0][8]!=null?data[0][8]:""; $("#BSO_INSTALLATION_SITE_LOCATION").val(BSO_INSTALLATION_SITE_LOCATION);
					var BSO_INSTALLATION_CONTACT=data[0][9]!=null?data[0][9]:""; $("#BSO_INSTALLATION_CONTACT").val(BSO_INSTALLATION_CONTACT);
					var BSO_INSTALLATION_TEL_FAX=data[0][10]!=null?data[0][10]:""; $("#BSO_INSTALLATION_TEL_FAX").val(BSO_INSTALLATION_TEL_FAX);
					var BSO_INSTALLATION_DUE_DATE=data[0][11]!=null?data[0][11]:"";// $("#BSO_INSTALLATION_DUE_DATE").val(BSO_INSTALLATION_DUE_DATE);
					var BSO_LEVEL=data[0][12]!=null?data[0][12]:"";// $("#BSO_LEVEL").val(BSO_LEVEL);
					var BSO_DOC_CREATED_DATE=data[0][13]!=null?data[0][13]:""; $("#BSO_DOC_CREATED_DATE").val(BSO_DOC_CREATED_DATE);
					var BSO_CUSTOMER_TYPE=data[0][14]!=null?data[0][14]:""; //$("#BSO_CUSTOMER_TYPE").val(BSO_CUSTOMER_TYPE);
					var BSO_PO_NO=data[0][15]!=null?data[0][15]:""; $("#BSO_PO_NO").val(BSO_PO_NO);
					var BSO_PAYMENT_TERM=data[0][16]!=null?data[0][16]:"";// $("#BSO_PAYMENT_TERM").val(BSO_PAYMENT_TERM);
					var BSO_PAYMENT_TERM_DESC=data[0][17]!=null?data[0][17]:""; $("#BSO_PAYMENT_TERM_DESC").val(BSO_PAYMENT_TERM_DESC);
					var BSO_BORROW_TYPE=data[0][18]!=null?data[0][18]:""; // $("#BSO_BORROW_TYPE").val(BSO_BORROW_TYPE);
					var BSO_BORROW_EXT=data[0][19]!=null?data[0][19]:"";// $("#BSO_BORROW_EXT").val(BSO_BORROW_EXT);
					var BSO_BORROW_DURATION=data[0][20]!=null?data[0][20]:"";// $("#BSO_BORROW_DURATION").val(BSO_BORROW_DURATION);
					var BSO_IS_WARRANTY=data[0][21]!=null?data[0][21]:"";// $("#BSO_IS_WARRANTY").val(BSO_IS_WARRANTY);
					var BSO_WARRANTY=data[0][22]!=null?data[0][22]:"";// $("#BSO_WARRANTY").val(BSO_WARRANTY);
					var BSO_IS_PM_MA=data[0][23]!=null?data[0][23]:""; //$("#BSO_IS_PM_MA").val(BSO_IS_PM_MA);
					var BSO_OPTION=data[0][24]!=null?data[0][24]:"";// $("#BSO_OPTION").val(BSO_OPTION);
					var BSO_TYPE=data[0][25]!=null?data[0][25]:""; $("#BSO_TYPE").val(BSO_TYPE);
					var BSO_TYPE_NO=data[0][26]!=null?data[0][26]:""; $("#BSO_TYPE_NO").val(BSO_TYPE_NO);
					var BSO_CREATED_BY=data[0][27]!=null?data[0][27]:""; $("#BSO_CREATED_BY").val(BSO_CREATED_BY);
					var BSO_UPDATED_BY=data[0][28]!=null?data[0][28]:"";   $("#BSO_UPDATED_BY").val(BSO_UPDATED_BY);
					var CUSNAM=data[0][29]!=null?data[0][29]:""; $("#CUSNAM").val(CUSNAM);
					
					var CUSTYP=data[0][30]!=null?data[0][30]:""; $("#CUSTYP").val(CUSTYP);
					var PRENAM=data[0][31]!=null?data[0][31]:""; $("#PRENAM").val(PRENAM); 
					var ADDR01=data[0][32]!=null?data[0][32]:""; $("#ADDR01").val(ADDR01);
					var ADDR02=data[0][33]!=null?data[0][33]:""; $("#ADDR02").val(ADDR02);
					var ADDR03=data[0][34]!=null?data[0][34]:""; $("#ADDR03").val(ADDR03);
					var ZIPCOD=data[0][35]!=null?data[0][35]:""; $("#ZIPCOD").val(ZIPCOD);
					var TELNUM=data[0][36]!=null?data[0][36]:""; $("#TELNUM").val(TELNUM);
					var CONTACT=data[0][37]!=null?data[0][37]:""; $("#CONTACT").val(CONTACT);
					var CUSNAM2=data[0][38]!=null?data[0][38]:""; $("#CUSNAM2").val(CUSNAM2); 
					var BSO_SLA=data[0][39]!=null?data[0][39]:""; $("#BSO_SLA").val(BSO_SLA);
					var BSO_PM_MA=data[0][40]!=null?data[0][40]:""; 
					var BSO_IS_OPTION=data[0][41]!=null?data[0][41]:"";
					var BSO_IS_HAVE_BORROW=data[0][42]!=null?data[0][42]:"";
					var BSO_BORROW_NO=data[0][43]!=null?data[0][43]:""; $("#BSO_BORROW_NO").val(BSO_BORROW_NO);  
					var BSO_IS_DELIVERY_INSTALLATION=data[0][44]!=null?data[0][44]:"";$("#BSO_IS_DELIVERY_INSTALLATION").val(BSO_IS_DELIVERY_INSTALLATION);
					var BSO_IS_NO_DELIVERY=data[0][45]!=null?data[0][45]:""; 
					var BSO_DELIVERY_TYPE=data[0][46]!=null?data[0][46]:"";  

					var BSO_DELIVERY_ADDR1=data[0][47]!=null?data[0][47]:""; $("#BSO_DELIVERY_ADDR1").val(BSO_DELIVERY_ADDR1);  
					var BSO_DELIVERY_ADDR2=data[0][48]!=null?data[0][48]:""; $("#BSO_DELIVERY_ADDR2").val(BSO_DELIVERY_ADDR2);  
					var BSO_DELIVERY_ADDR3=data[0][49]!=null?data[0][49]:""; $("#BSO_DELIVERY_ADDR3").val(BSO_DELIVERY_ADDR3);
					var BSO_DELIVERY_PROVINCE=data[0][50]!=null?data[0][50]:""; $("#BSO_DELIVERY_PROVINCE").val(BSO_DELIVERY_PROVINCE);  
					var BSO_DELIVERY_ZIPCODE=data[0][51]!=null?data[0][51]:""; $("#BSO_DELIVERY_ZIPCODE").val(BSO_DELIVERY_ZIPCODE);  
					var BSO_DELIVERY_TEL_FAX=data[0][52]!=null?data[0][52]:""; $("#BSO_DELIVERY_TEL_FAX").val(BSO_DELIVERY_TEL_FAX);
					var BSO_INSTALLATION_ADDR1=data[0][53]!=null?data[0][53]:""; $("#BSO_INSTALLATION_ADDR1").val(BSO_INSTALLATION_ADDR1);  
					var BSO_INSTALLATION_ADDR2=data[0][54]!=null?data[0][54]:""; $("#BSO_INSTALLATION_ADDR2").val(BSO_INSTALLATION_ADDR2);  
					var BSO_INSTALLATION_ADDR3=data[0][55]!=null?data[0][55]:""; $("#BSO_INSTALLATION_ADDR3").val(BSO_INSTALLATION_ADDR3);
					var BSO_INSTALLATION_PROVINCE=data[0][56]!=null?data[0][56]:""; $("#BSO_INSTALLATION_PROVINCE").val(BSO_INSTALLATION_PROVINCE);  
					var BSO_INSTALLATION_ZIPCODE=data[0][57]!=null?data[0][57]:""; $("#BSO_INSTALLATION_ZIPCODE").val(BSO_INSTALLATION_ZIPCODE);  
					
					var BSO_DELIVERY_DUE_DATE_PICKER=data[0][58]!=null?data[0][58]:""; $("#BSO_DELIVERY_DUE_DATE_PICKER").val(BSO_DELIVERY_DUE_DATE_PICKER);
					var BSO_DELIVERY_DUE_DATE_TIME_PICKER=data[0][59]!=null?data[0][59]:""; $("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val(BSO_DELIVERY_DUE_DATE_TIME_PICKER);
					var BSO_INSTALLATION_TIME_PICKER=data[0][60]!=null?data[0][60]:""; $("#BSO_INSTALLATION_TIME_PICKER").val(BSO_INSTALLATION_TIME_PICKER);
					var BSO_INSTALLATION_TIME_TIME_PICKER=data[0][61]!=null?data[0][61]:""; $("#BSO_INSTALLATION_TIME_TIME_PICKER").val(BSO_INSTALLATION_TIME_TIME_PICKER);
					var BSO_RFE_NO=data[0][62]!=null?data[0][62]:""; 
					var BSO_INT_NO=data[0][63]!=null?data[0][63]:"";
					var BSO_EXPRESS_INV_NO=data[0][64]!=null?data[0][64]:"";
					
					if(BSO_RFE_NO!=''){
						$("#BSO_RFE_NO").val(BSO_RFE_NO); 
						$("#bsoRfe_element").show(); 
					}else{
						$("#BSO_EXPRESS_INV_NO").val(BSO_EXPRESS_INV_NO);
						$("#invoice_form_element").show(); 
						
					}
					// BSO_BORROW_EXT
					//BSO_BORROW_DURATION
					//BSO_WARRANTY_EXT
					//BSO_PM_MA_EXT

					if(BSO_IS_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_1"]').prop('checked', true);
						// bsoTypeCheck('1');
					}
					if(BSO_IS_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_2"]').prop('checked', true);
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						 $("#install_form_element").show();
						// bsoTypeCheck('2');
					}
					if(BSO_IS_DELIVERY_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_3"]').prop('checked', true);
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						 $("#install_form_element").show();
						// bsoTypeCheck('3');
					}
					if(BSO_IS_NO_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_4"]').prop('checked', true);
						  bsoTypeCheck('4');
					}   
					
					if('${state}'=='wait_for_supervisor_delivery_close'){
						bsoTypeCheck('1');
					}else
						bsoTypeCheck('2');
					
				 	$('input[name="BSO_LEVEL"][value="' + BSO_LEVEL + '"]').prop('checked', true);
					$('input[name="BSO_CUSTOMER_TYPE"][value="' + BSO_CUSTOMER_TYPE + '"]').prop('checked', true);
					$('input[name="BSO_PAYMENT_TERM"][value="' + BSO_PAYMENT_TERM + '"]').prop('checked', true);
					
					$('input[name="BSO_IS_WARRANTY"][value="' + BSO_IS_WARRANTY + '"]').prop('checked', true);
					
					var BSO_WARRANTY_EXT="";
					var BSO_WARRANTY_VALUE='0';
					/*
					if(BSO_WARRANTY.length>0){
						BSO_WARRANTY_VALUE=BSO_WARRANTY;
						if(BSO_WARRANTY!='2' && BSO_WARRANTY!='3'){
							BSO_WARRANTY_EXT=BSO_WARRANTY;
							BSO_WARRANTY_VALUE="0"; 
						} 
					}else{
						BSO_WARRANTY_VALUE=BSO_WARRANTY; 
					} 
					*/
					BSO_WARRANTY_VALUE=BSO_WARRANTY; 
					$('input[name="BSO_WARRANTY"][value="' + BSO_WARRANTY_VALUE + '"]').prop('checked', true);
					$("#BSO_WARRANTY_EXT").val(BSO_WARRANTY_EXT);
					
					var BSO_PM_MA_EXT="";
					var BSO_PM_MA_VALUE='0';
					if(BSO_PM_MA.length>0){
						BSO_PM_MA_VALUE=BSO_PM_MA;
						if(BSO_PM_MA!='4' && BSO_PM_MA!='3'){
							BSO_PM_MA_EXT=BSO_PM_MA;
							BSO_PM_MA_VALUE="0"; 
						} 
					}else{
						BSO_PM_MA_VALUE=BSO_PM_MA; 
					} 
					$('input[name="BSO_PM_MA"][value="' + BSO_PM_MA_VALUE + '"]').prop('checked', true);
					$("#BSO_PM_MA_EXT").val(BSO_PM_MA_EXT);
					
					//var BSO_BORROW_TYPE="";
					var BSO_BORROW_EXT_VALUE="";
					var BSO_BORROW_DURATION_VALUE=""; 
					if(BSO_BORROW_TYPE.length>0){
						if(BSO_BORROW_TYPE=='7'){
							BSO_BORROW_DURATION_VALUE=BSO_BORROW_DURATION;
							BSO_BORROW_EXT_VALUE=BSO_BORROW_EXT; 
						} 
					}
					$('input[name="BSO_BORROW_TYPE"][value="' + BSO_BORROW_TYPE + '"]').prop('checked', true); 
					$("#BSO_BORROW_EXT").val(BSO_BORROW_EXT_VALUE);
					$("#BSO_BORROW_DURATION").val(BSO_BORROW_DURATION_VALUE);
					
					//var BSO_PAYMENT_TERM_EXT="";
					
					var BSO_PAYMENT_TERM_DESC_3="";
					var BSO_PAYMENT_TERM_DESC_4="";
					//var BSO_PAYMENT_TERM_VALUE='0';
					if(BSO_PAYMENT_TERM.length>0){ 
						if(BSO_PAYMENT_TERM=='3'){ 
							BSO_PAYMENT_TERM_DESC_3=BSO_PAYMENT_TERM_DESC;
						}else if( BSO_PAYMENT_TERM=='4'){
							BSO_PAYMENT_TERM_DESC_4=BSO_PAYMENT_TERM_DESC;
						}
					}else{
						BSO_PAYMENT_TERM_VALUE=BSO_PAYMENT_TERM; 
					} 
					
					$('input[name="BSO_PAYMENT_TERM"][value="' + BSO_PAYMENT_TERM + '"]').prop('checked', true);
					$("#BSO_PAYMENT_TERM_DESC_4").val(BSO_PAYMENT_TERM_DESC_4);
					$("#BSO_PAYMENT_TERM_DESC_3").val(BSO_PAYMENT_TERM_DESC_3);
					
					$('input[name="BSO_IS_PM_MA"][value="' + BSO_IS_PM_MA + '"]').prop('checked', true);
					$('input[name="BSO_IS_OPTION"][value="' + BSO_IS_OPTION + '"]').prop('checked', true); 
					
					
					
					
					$('input[name="BSO_OPTION"][value="' + BSO_OPTION + '"]').prop('checked', true);
					
					$('input[id="BSO_IS_HAVE_BORROW"][value="' + BSO_IS_HAVE_BORROW + '"]').prop('checked', true); 
				/* 	$('input[name="BSO_DELIVERY_TYPE"][value="' + BSO_DELIVERY_TYPE + '"]').prop('checked', true);
					 bsoTypeCheck(BSO_DELIVERY_TYPE); */
					/* BSO_PAYMENT_TERM_DESC_3
					BSO_PAYMENT_TERM_DESC_4
					 */
					query=" SELECT BS_ID,BS_SLA_LIMIT "+
					   " FROM "+SCHEMA_G+".BPM_SLA  ORDER BY BS_SLA_LIMIT ";
					var sla_select="<select name=\"BSO_SLA\" id=\"BSO_SLA\"  style=\"width: 75px\">";   
					  SynDomeBPMAjax.searchObject(query,{
							callback:function(data2){  
								//alert(data2)
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
								for(var i=0;i<data2.length;i++){ 
									sla_select=sla_select+"<option value=\""+data2[i][1]+"\">"+data2[i][1]+"</option>";
								}
								sla_select=sla_select+"</select>"; 
								$("#sla_select_element").html(sla_select);
								$("#BSO_SLA").val(BSO_SLA);
							}
					  });
					  if(BSO_IS_INSTALLATION=='1' || BSO_IS_DELIVERY_INSTALLATION=='1'){  
							searchItemListByInstall('1');
						}else
							searchItemList("1");
				}else{
					
				} 
				//searchItemList("1");
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("SALE_ORDER_BY_YEAR","y","5","th",{
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
					$("#bsoTypeNo").val(data);
					var querys=[];  
					
					var query="insert into "+SCHEMA_G+".BPM_SALE_ORDER set BSO_TYPE='1',BSO_TYPE_NO='"+data+"' ,BSO_STATE='Sale Order Created' ,BSO_CREATED_BY='${username}' ,"+
					  " BSO_CREATED_DATE=now(),BSO_DOC_CREATED_DATE=now()";
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
								   " BSO_ID , CUSCOD FROM "+SCHEMA_G+".BPM_SALE_ORDER where BSO_TYPE_NO='"+$("#bsoTypeNo").val()+"'";
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
											loadDynamicPage('dispatcher/page/delivery_install_management?bsoId='+data2[0][0]+'&mode=edit');
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
		searchItemList(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchItemList(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchItemList($("#pageNo").val());
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
	checkWithSet("pageSelect",$("#pageNo").val());
}
function confirmDelete(cuscod,itemid){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(cuscod,itemid);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
} 
function doAction(cuscod,itemid){ 
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM where BSO_ID=${bsoId} and CUSCOD='"+cuscod+"' and IMA_ItemID='"+itemid+"'";
	querys.push(query); 
	  query="DELETE FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING where BSO_ID=${bsoId} and CUSCOD='"+cuscod+"' and IMA_ItemID='"+itemid+"'"; 
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
function searchItemListByInstall(_page){
	$("#pageNo").val(_page);
	var query="SELECT product.ima_itemid,product.ima_itemname,mapping.serial,mapping.is_serial ,trans.BIT_CHECK_STATUS FROM  "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping left join  "+ 
	" "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM item  "+
	"on(  mapping.bso_id=item.bso_id and mapping.cuscod=item.cuscod  "+
	"and mapping.ima_itemid=item.ima_itemid and mapping.AUTO_K=item.AUTO_K) left join   "+SCHEMA_G+".BPM_PRODUCT product "+
	// "and mapping.ima_itemid=item.ima_itemid  ) left join  "+SCHEMA_G+".BPM_PRODUCT product "+
	"on mapping.ima_itemid=product.ima_itemid  "+
	" left join "+SCHEMA_G+".BPM_INSTALLATION_TRAN  trans "+ 
	" on (trans.BSO_ID=${bsoId} and trans.IMA_ItemID=mapping.IMA_ItemID and trans.SERIAL=mapping.SERIAL) "+
	  " where item.BSO_ID=${bsoId}  ";
	// " where item.BSO_ID=${bsoId} and mapping.IMA_ItemID like '9%'";
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	// alert(queryObject)
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
			        "  		<th width=\"11%\"><div class=\"th_class\">รหัสสินค้า</div></th> "+
			        "  		<th width=\"73%\"><div class=\"th_class\">สินค้า</div></th> "+
			        "  		<th width=\"11%\"><div class=\"th_class\">Serial</div></th> "+   
			      //  "  		<th width=\"11%\"><div class=\"th_class\">ราคาขายต่อหน่วย</div></th> "+			        
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+ 
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   var total=0;
				   var vat=0;
				   var grand_total=0;
				   for(var i=0;i<data.length;i++){ 
					     total=$.formatNumber(data[i][5]+"", {format:"#,###.00", locale:"us"});
					     vat=$.formatNumber(data[i][6]+"", {format:"#,###.00", locale:"us"});
					     grand_total=$.formatNumber(data[i][7]+"", {format:"#,###.00", locale:"us"});
					     var serial=data[i][3]=='1'?data[i][2]:"ไม่ระบุ";
					     var reviewed=data[i][4]=='2'?" [ตรวจสอบแล้ว]":"";
					    
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" "+reviewed+" </td>"+
					   "  		<td style=\"text-align: left;\"> "+serial+" </td>"+   
				        "    	<td style=\"text-align: center;\"> ";
				        
				        if(data[i][0].indexOf('9')==0 && data[i][3]=='1')
				        	 str=str+ "	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/delivery_install_preview?bsoId=${bsoId}&mode=edit&state=${state}&requestor=${requestor}&ima_itemid="+data[i][0]+"&serial="+data[i][2]+"')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;";
				        str=str+  "</td>  "+  
				        "  	</tr>  ";
				   }
				   
				  /*  str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคารวม</td>"+    
			       "    	<td style=\"text-align: right;\">"+total+"</td>  "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">Vat 7%</td>"+    
			       "    	<td style=\"text-align: right;\">"+vat+"</td>  "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคาสุทธิ</td>"+    
			       "    	<td style=\"text-align: right;\">"+grand_total+"</td>  "+
			        "  	</tr>  "; */
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
	/*
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
	*/
}
function searchItemList(_page){  
	$("#pageNo").val(_page);   
	
	var query="SELECT  item.IMA_ItemID ,product.IMA_ItemName ,item.AMOUNT,item.PRICE, "+
	          " ROUND(item.AMOUNT*item.PRICE,2) AS SUM_PRICE ,"+
	          "(select sum(ROUND(AMOUNT*PRICE,2)) "+
	          " from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as SUM_TOTAL ,"+
	          " (select ROUND((sum(ROUND(AMOUNT*PRICE,2))*7)/100,2)"+
	          "  from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as VAT ,"+
	          " (select ROUND(ROUND((sum(ROUND(AMOUNT*PRICE,2))*7)/100,2) + sum(ROUND(AMOUNT*PRICE,2)),2)"+ 
	          "  from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as GRAND_TOTAL ,"+
	          "  item.PRICE_COST , "+
	          " ROUND(item.AMOUNT*item.PRICE_COST,2) AS SUM_PRICE_COST ,"+
	        /*   "(select sum(ROUND(AMOUNT*PRICE_COST,2)) "+
	          " from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as SUM_TOTAL_COST ,"+ */
	          " item.cuscod ,"+
	          "  item.DETAIL , "+
	          "  item.AUTO_K , "+
	          "  item.IS_REPLACE , "+
	          "  item.REPLACE_NAME  "+
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM  item left join "+SCHEMA_G+".BPM_PRODUCT product "+ 
		" on item.IMA_ItemID=product.IMA_ItemID where item.BSO_ID=${bsoId}  and item.IMA_ItemID not in('900002','900004','90100002' )";
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"11%\"><div class=\"th_class\">รหัสสินค้า</div></th> "+
			        "  		<th width=\"84%\"><div class=\"th_class\">สินค้า</div></th> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+   
			      //  "  		<th width=\"11%\"><div class=\"th_class\">ราคาขายต่อหน่วย</div></th> "+			        
			       // "  		<th width=\"12%\"><div class=\"th_class\">ราคาขายรวม</div></th> "+ 
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   var total=0;
				   var vat=0;
				   var grand_total=0;
				   for(var i=0;i<data.length;i++){ 
					   var IS_REPLACE=data[i][13]!=null?data[i][13]:"0";
					     var REPLACE_NAME=data[i][14]!=null?data[i][14]:"";
					   var name ="";
					     if(IS_REPLACE=='1'){
					    	 name=REPLACE_NAME;
					     }else
					    	 name=data[i][1];
					     total=$.formatNumber(data[i][5]+"", {format:"#,###.00", locale:"us"});
					     vat=$.formatNumber(data[i][6]+"", {format:"#,###.00", locale:"us"});
					     grand_total=$.formatNumber(data[i][7]+"", {format:"#,###.00", locale:"us"});
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+name+" "+(data[i][11]!=null?("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i][11]):"")+"</td>"+
				        "    	<td style=\"text-align: center;\"><span style=\"text-decoration: underline;\" onclick=\"showItem('"+data[i][10]+"','"+data[i][0]+"','"+data[i][12]+"')\">"+data[i][2]+"</span></td>  "+  
				     //    "    	<td style=\"text-align: right;\">"+((data[i][3]!=null)? $.formatNumber(data[i][3]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				      //   "    	<td style=\"text-align: right;\">"+((data[i][4]!=null)? $.formatNumber(data[i][4]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				        "  	</tr>  ";
				   }
				   
				 /*   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคารวม</td>"+    
			       "    	<td style=\"text-align: right;\">"+total+"</td>  "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">Vat 7%</td>"+    
			       "    	<td style=\"text-align: right;\">"+vat+"</td>  "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคาสุทธิ</td>"+    
			       "    	<td style=\"text-align: right;\">"+grand_total+"</td>  "+
			        "  	</tr>  "; */
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
	/*
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
	*/
} 
function showItem(cuscod,itemId,auto){
	
	var query="  SELECT "+
	" mapping.BSO_ID,"+
	"  mapping.CUSCOD,"+
	"  mapping.IMA_ItemID,"+
	"  product.IMA_ItemName,"+
	"  mapping.SERIAL , "+
	"  mapping.IS_SERIAL "+
	"  FROM BPM_SALE_PRODUCT_ITEM_MAPPING mapping"+ 
	"  left join BPM_PRODUCT product"+
	"  on mapping.IMA_ItemID=product.IMA_ItemID"+
	"  where mapping.bso_id=${bsoId} and mapping.cuscod='"+cuscod+"' and mapping.IMA_ItemID='"+itemId+"' "+
	" and mapping.AUTO_K="+auto+
	"   order by  mapping.SERIAL asc "; 
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
			 role_ids=[];
			if(data!=null && data.length>0){
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			    "  		<th width=\"95%\"><div class=\"th_class\">Serial Number</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){ 
					   str=str+ "  	<tr style=\"cursor: pointer;font-size: 16px; font-family: tahoma;\">"+
					   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+((data[i][5]=="1")?data[i][4]:"ไม่ระบุ")+" </td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   bootbox.dialog(str,[{
					    "label" : "Close",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
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
	//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
	//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
	var btdl_type='1';var btdl_state='wait_for_operation';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='Sale Order wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];  
	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bsoId}','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	null,'"+hide_status+"','${username}','"+$("#bsoTypeNo").val()+"',(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00'))) ) ";
	 
	 if('${state}'!='' && is_hide_todolist){
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
		"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
		 querys.push(query2); 
	 } 
	 if(btdl_state=='wait_for_operation' || btdl_state=='wait_for_supervisor_close'){
		 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
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
//1(type จัดส่ง),wait_for_create_to_express,ROLE_INVOICE_ACCOUNT,2(role),ข้อมูล ถูก update เรียบร้อยแล้ว
function doUpdateJob(btdl_type,btdl_state,owner,owner_type,message){
	var querys=[]; 
	var query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
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
				 if(btdl_state!='wait_for_create_to_express' && btdl_state!='wait_for_stock'){
					 if(btdl_state=='wait_for_supervisor_close')
						 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='Sale Order Closed', BSO_STATUS='1' where BSO_ID=${bsoId}";
					 else
						 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
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
				 }else
						showDialog(message);
				}else{
					showDialog(message);
				} 
			}});
}
function doSendToSupervisor(){
	var selectValue=$("select[id=supervisor_select] option:selected").val();
	 doUpdateState('1','wait_for_assign_to_team',selectValue,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor เรียบร้อยแล้ว','Sale Order wait for assign to Team','1',true);
	
	 //doUpdateState();
}
function showDialog(messaage){
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary"
	 }]);
}
function doSubmitSaleOrder(){ 
	
	var querys=[];  
	// send to Express
	var  query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bsoId}','1','wait_for_create_to_express','ROLE_INVOICE_ACCOUNT','2','Sale Order Created','5',60,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(5*60))) ";
	//alert(query)
	// send to Store
	 
	var  query2="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
	"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
	"('${bsoId}','1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order Created','1',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(1*3600))) ";
	
	// if(ส่งของ send to RFE, ติดตั้ง send to IT ,ส่งของพร้อมติดตั้ง send to IT)
	var	 query3="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
						"BTDL_TYPE='1' and BTDL_STATE='wait_for_assign_to_team' ";  

	 querys.push(query);
	 querys.push(query2);    
	 querys.push(query3); 
	var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
			         " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
			         " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
			         " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic	FROM dual ";
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
					var BSO_DELIVERY_TYPE=$("input[name=BSO_DELIVERY_TYPE]:checked" ).val();
					//if(document.getElementById("bsoTypeCheck_1").checked){ // RFE
					if(BSO_DELIVERY_TYPE=='1'){
						//24 3600
						 /* query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','24',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(24*3600))) "; */
						 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					} 
					if(BSO_DELIVERY_TYPE=='3' || BSO_DELIVERY_TYPE=='2'){
					//if(document.getElementById("bsoTypeCheck_3").checked || document.getElementById("bsoTypeCheck_2").checked){ // IT
						/*  query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','24',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(24*3600))) "; */
							 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
								"('${bsoId}','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					}
					 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='wait_for_assign_to_team' where BSO_ID=${bsoId}";
					 querys.push(query); 
				}
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
							showDialog("Submit Sale Order.");
						}
					}
				});
			}});
	
    // return false; 
	 
}
// 1(type จัดส่ง),wait_for_create_to_express,ROLE_INVOICE_ACCOUNT,2(role),ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว,ข้อมูลถูกส่งไปฝ่าย บัญชี เรียบร้อยแล้ว,Sale Order Created,1(show,0=hide)
function doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bsoId}' and "+
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
							"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
							"('${bsoId}','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','"+$("#bsoTypeNo").val()+"') ";
					 if('${state}'!='' && is_hide_todolist){
					  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
					 } 
					 if(btdl_state=='wait_for_operation' || btdl_state=='wait_for_supervisor_close'){
						 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
						  querys.push(query2); 
					 }
					 if(btdl_state=='wait_for_supervisor_close'){
						 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATUS='3' where BSO_ID=${bsoId}"; 
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
	var BSO_ID="${bsoId}";
	var CUSCOD=jQuery.trim($("#CUSCOD").val());
	var BSO_SALE_ID=jQuery.trim($("#BSO_SALE_ID").val()); 
	var BSO_IS_INSTALLATION=jQuery.trim($("#BSO_IS_INSTALLATION").val());
	var BSO_DELIVERY_DUE_DATE=jQuery.trim($("#BSO_DELIVERY_DUE_DATE").val());
	var BSO_DELIVERY_LOCATION=jQuery.trim($("#BSO_DELIVERY_LOCATION").val());
	var BSO_DELIVERY_CONTACT=jQuery.trim($("#BSO_DELIVERY_CONTACT").val());
	var BSO_INSTALLATION_SITE_LOCATION=jQuery.trim($("#BSO_INSTALLATION_SITE_LOCATION").val());
	var BSO_INSTALLATION_CONTACT=jQuery.trim($("#BSO_INSTALLATION_CONTACT").val());
	var BSO_INSTALLATION_TEL_FAX=jQuery.trim($("#BSO_INSTALLATION_TEL_FAX").val());
	var BSO_INSTALLATION_DUE_DATE=jQuery.trim($("#BSO_INSTALLATION_DUE_DATE").val());
	var BSO_LEVEL=jQuery.trim($("input[name=BSO_LEVEL]:checked" ).val());
	var BSO_DOC_CREATED_DATE=jQuery.trim($("#BSO_DOC_CREATED_DATE").val());
	var BSO_CUSTOMER_TYPE=jQuery.trim($("input[name=BSO_CUSTOMER_TYPE]:checked" ).val());
	var BSO_PO_NO=jQuery.trim($("#BSO_PO_NO").val());
	var BSO_PAYMENT_TERM=jQuery.trim($("input[name=BSO_PAYMENT_TERM]:checked" ).val());
	var BSO_PAYMENT_TERM_DESC=jQuery.trim($("#BSO_PAYMENT_TERM_DESC").val());
	var BSO_BORROW_TYPE=jQuery.trim($("input[name=BSO_BORROW_TYPE]:checked" ).val());  
	var BSO_BORROW_EXT='';//jQuery.trim($("#BSO_BORROW_EXT").val());
	var BSO_BORROW_DURATION='';//jQuery.trim($("#BSO_BORROW_DURATION").val());
	var BSO_IS_WARRANTY=jQuery.trim($("input[name=BSO_IS_WARRANTY]:checked" ).val());
	var BSO_WARRANTY=jQuery.trim($("input[name=BSO_WARRANTY]:checked" ).val()); 
	var BSO_IS_PM_MA=jQuery.trim($("input[name=BSO_IS_PM_MA]:checked" ).val()); 
	var BSO_OPTION=jQuery.trim($("input[name=BSO_OPTION]:checked" ).val());
	var BSO_TYPE=jQuery.trim($("#BSO_TYPE").val());
	var BSO_TYPE_NO=jQuery.trim($("#BSO_TYPE_NO").val());
	var BSO_STATE=jQuery.trim($("#BSO_STATE").val());
	var BSO_SLA=jQuery.trim($("#BSO_SLA").val());
	var BSO_PM_MA=jQuery.trim($("input[name=BSO_PM_MA]:checked" ).val()); 
	var BSO_DELIVERY_TYPE=jQuery.trim($("input[name=BSO_DELIVERY_TYPE]:checked" ).val());
	var BSO_CREATED_DATE=jQuery.trim($("#BSO_CREATED_DATE").val());
	var BSO_UPDATED_DATE=jQuery.trim($("#BSO_UPDATED_DATE").val());
	var BSO_STATUS=jQuery.trim($("#BSO_STATUS").val());
	var BSO_SUPERVISOR=jQuery.trim($("#BSO_SUPERVISOR").val());
	var BSO_SLA_LIMIT_TIME=jQuery.trim($("#BSO_SLA_LIMIT_TIME").val());
	var BSO_IS_OPTION=jQuery.trim($("input[name=BSO_IS_OPTION]:checked" ).val());
	var BSO_IS_HAVE_BORROW=jQuery.trim($("input[id=BSO_IS_HAVE_BORROW]:checked" ).val());
	var BSO_BORROW_NO=jQuery.trim($("#BSO_BORROW_NO").val()); 
	
	var BSO_DELIVERY_ADDR1=jQuery.trim($("#BSO_DELIVERY_ADDR1").val()); 
	var BSO_DELIVERY_ADDR2=jQuery.trim($("#BSO_DELIVERY_ADDR2").val());
	var BSO_DELIVERY_ADDR3=jQuery.trim($("#BSO_DELIVERY_ADDR3").val());
	var BSO_DELIVERY_PROVINCE=jQuery.trim($("#BSO_DELIVERY_PROVINCE").val());
	var BSO_DELIVERY_ZIPCODE=jQuery.trim($("#BSO_DELIVERY_ZIPCODE").val());
	var BSO_DELIVERY_TEL_FAX=jQuery.trim($("#BSO_DELIVERY_TEL_FAX").val());
	var BSO_INSTALLATION_ADDR1=jQuery.trim($("#BSO_INSTALLATION_ADDR1").val());
	var BSO_INSTALLATION_ADDR2=jQuery.trim($("#BSO_INSTALLATION_ADDR2").val());
	var BSO_INSTALLATION_ADDR3=jQuery.trim($("#BSO_INSTALLATION_ADDR3").val());
	var BSO_INSTALLATION_PROVINCE=jQuery.trim($("#BSO_INSTALLATION_PROVINCE").val());
	var BSO_INSTALLATION_ZIPCODE=jQuery.trim($("#BSO_INSTALLATION_ZIPCODE").val());
	 
	var BSO_IS_DELIVERY="0";
	var BSO_IS_INSTALLATION="0";
	var BSO_IS_DELIVERY_INSTALLATION="0";
	var BSO_IS_NO_DELIVERY="0";
	if($('#bsoTypeCheck_1').prop('checked')){
		BSO_IS_DELIVERY="1";
	}
	if($('#bsoTypeCheck_2').prop('checked')){
		BSO_IS_INSTALLATION="1";
	}
	if($('#bsoTypeCheck_3').prop('checked')){
		BSO_IS_DELIVERY_INSTALLATION="1";
	} 
	if($('#bsoTypeCheck_4').prop('checked')){
		BSO_IS_NO_DELIVERY="1";
	} 
	if(BSO_WARRANTY=='0'){
		BSO_WARRANTY=$("#BSO_WARRANTY_EXT").val();
	}
	if(BSO_PM_MA=='0')
		BSO_PM_MA=$("#BSO_PM_MA_EXT").val();

	if(BSO_PAYMENT_TERM=='3')
		BSO_PAYMENT_TERM_DESC=$("#BSO_PAYMENT_TERM_DESC_3").val();
	if(BSO_PAYMENT_TERM=='4')
		BSO_PAYMENT_TERM_DESC=$("#BSO_PAYMENT_TERM_DESC_4").val();
	
	if(BSO_BORROW_TYPE=='7'){
		BSO_BORROW_EXT=$("#BSO_BORROW_EXT").val();
		BSO_BORROW_DURATION=$("#BSO_BORROW_DURATION").val();
	}
	
	var query=" UPDATE "+SCHEMA_G+".BPM_SALE_ORDER SET "+
	   // "  BSO_ID = "+BSO_ID+" "+
 " CUSCOD = '"+CUSCOD+"' , "+ 
" BSO_SALE_ID = '"+BSO_SALE_ID+"', "+
" BSO_LEVEL = '"+BSO_LEVEL+"' ,  "+
" BSO_SLA = "+BSO_SLA+", "+
" BSO_CUSTOMER_TYPE = '"+BSO_CUSTOMER_TYPE+"' , "+
" BSO_PO_NO = '"+BSO_PO_NO+"' , "+
" BSO_PAYMENT_TERM = '"+BSO_PAYMENT_TERM+"', "+
" BSO_BORROW_TYPE = '"+BSO_BORROW_TYPE+"' , "+ 
" BSO_IS_WARRANTY = '"+BSO_IS_WARRANTY+"' ,"+
" BSO_IS_PM_MA = '"+BSO_IS_PM_MA+"' ,"+
" BSO_WARRANTY = '"+BSO_WARRANTY+"' ,"+
" BSO_PM_MA = '"+BSO_PM_MA+"' ,"+
" BSO_OPTION = '"+BSO_OPTION+"', "+ 
" BSO_BORROW_EXT = '"+BSO_BORROW_EXT+"' ,"+
" BSO_BORROW_DURATION = '"+BSO_BORROW_DURATION+"', "+
" BSO_IS_OPTION = '"+BSO_IS_OPTION+"', "+
" BSO_IS_HAVE_BORROW = '"+BSO_IS_HAVE_BORROW+"', "+
" BSO_BORROW_NO = '"+BSO_BORROW_NO+"' ,  "+
// " BSO_IS_DELIVERY = '"+BSO_IS_DELIVERY+"', "+
//" BSO_IS_INSTALLATION = '"+BSO_IS_INSTALLATION+"', "+
//" BSO_IS_DELIVERY_INSTALLATION = '"+BSO_IS_DELIVERY_INSTALLATION+"', "+
//" BSO_IS_NO_DELIVERY = '"+BSO_IS_NO_DELIVERY+"' , "+
" BSO_DELIVERY_TYPE = '"+BSO_DELIVERY_TYPE+"' ,"+
	
	" BSO_DELIVERY_ADDR1 = '"+BSO_DELIVERY_ADDR1+"' ,  "+
	" BSO_DELIVERY_ADDR2 = '"+BSO_DELIVERY_ADDR2+"' ,  "+
	" BSO_DELIVERY_ADDR3 = '"+BSO_DELIVERY_ADDR3+"' ,  "+
	" BSO_DELIVERY_PROVINCE = '"+BSO_DELIVERY_PROVINCE+"' ,  "+
	" BSO_DELIVERY_ZIPCODE = '"+BSO_DELIVERY_ZIPCODE+"' ,  "+
	" BSO_DELIVERY_TEL_FAX = '"+BSO_DELIVERY_TEL_FAX+"' ,  "+
	" BSO_INSTALLATION_ADDR1 = '"+BSO_INSTALLATION_ADDR1+"' ,  "+
	" BSO_INSTALLATION_ADDR2 = '"+BSO_INSTALLATION_ADDR2+"' ,  "+
	" BSO_INSTALLATION_ADDR3 = '"+BSO_INSTALLATION_ADDR3+"' ,  "+
	" BSO_INSTALLATION_PROVINCE = '"+BSO_INSTALLATION_PROVINCE+"' ,  "+
	" BSO_INSTALLATION_ZIPCODE = '"+BSO_INSTALLATION_ZIPCODE+"' , "+
	" BSO_DELIVERY_LOCATION = '"+BSO_DELIVERY_LOCATION+"', "+
	" BSO_DELIVERY_CONTACT = '"+BSO_DELIVERY_CONTACT+"', "+
	" BSO_INSTALLATION_TEL_FAX = '"+BSO_INSTALLATION_TEL_FAX+"' ,  "+
	" BSO_INSTALLATION_SITE_LOCATION = '"+BSO_INSTALLATION_SITE_LOCATION+"' ,"+
	" BSO_PAYMENT_TERM_DESC = '"+BSO_PAYMENT_TERM_DESC+"' ,";
//alert("BSO_SLA="+BSO_SLA);
//return false;
/*

" BSO_IS_INSTALLATION = "+BSO_IS_INSTALLATION+" ,"+
" BSO_DELIVERY_DUE_DATE = "+BSO_DELIVERY_DUE_DATE+" ,"+




" BSO_INSTALLATION_ = "+BSO_INSTALLATION_DUE_DATE+" ,"+
" BSO_DOC_CREATED_DATE = "+BSO_DOC_CREATED_DATE+" ,"+




 

" BSO_TYPE = "+BSO_TYPE+" ,"+
" BSO_TYPE_NO = "+BSO_TYPE_NO+" ,"+
" BSO_STATE = "+BSO_STATE+" ,"+ 


" BSO_CREATED_DATE = "+BSO_CREATED_DATE+" ,"+
" BSO_UPDATED_DATE = "+BSO_UPDATED_DATE+" ,"+
" BSO_STATUS = "+BSO_STATUS+" ,"+ 
" BSO_SUPERVISOR = "+BSO_SUPERVISOR+" ,"+
" BSO_SLA_LIMIT_TIME = "+BSO_SLA_LIMIT_TIME+" ,"+
*/

	var BSO_DELIVERY_DUE_DATE_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_PICKER").val());
	var BSO_DELIVERY_DUE_DATE_TIME_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val());
	var BSO_DELIVERY_DUE_DATE="";
	if(BSO_DELIVERY_DUE_DATE_PICKER.length>0){
		var BSO_DELIVERY_DUE_DATE_ARRAY=BSO_DELIVERY_DUE_DATE_PICKER.split("/");
		BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE_ARRAY[2]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[1]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[0];
		if(BSO_DELIVERY_DUE_DATE_TIME_PICKER.length>0){
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
		}else
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" 00:00:00";
		 
	}

	if(BSO_DELIVERY_DUE_DATE.length>0){
		query=query+" BSO_DELIVERY_DUE_DATE='"+BSO_DELIVERY_DUE_DATE+"' , ";
	}else
		query=query+" BSO_DELIVERY_DUE_DATE=null  , ";
	
	var BSO_INSTALLATION_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_PICKER").val());
	var BSO_INSTALLATION_TIME_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_TIME_PICKER").val());
	var BSO_INSTALLATION_DUE_DATE="";
	if(BSO_INSTALLATION_TIME_PICKER.length>0){
		var BSO_INSTALLATION_DUE_DATE_ARRAY=BSO_INSTALLATION_TIME_PICKER.split("/");
		BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE_ARRAY[2]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[1]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[0];
		if(BSO_INSTALLATION_TIME_TIME_PICKER.length>0){
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
		}else
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" 00:00:00";
		 
	}

	if(BSO_DELIVERY_DUE_DATE.length>0){
		query=query+" BSO_DELIVERY_DUE_DATE='"+BSO_DELIVERY_DUE_DATE+"' , ";
	}else
		query=query+" BSO_DELIVERY_DUE_DATE=null  , ";
	if(BSO_INSTALLATION_DUE_DATE.length>0){
		query=query+" BSO_INSTALLATION_DUE_DATE='"+BSO_INSTALLATION_DUE_DATE+"' , ";
	}else
		query=query+" BSO_INSTALLATION_DUE_DATE=null  , ";
	
	
	query=query+" BSO_INSTALLATION_CONTACT = '"+BSO_INSTALLATION_CONTACT+"' ";
	" WHERE BSO_ID = "+BSO_ID+" ";
//	alert(BSO_DELIVERY_DUE_DATE);
//	alert(BSO_DELIVERY_DUE_DATE_TIME_PICKER)
	//alert(query)
  if(!CUSCOD.length>0){
	  alert("กรุณาใส่ Code ลูกค้า");
	  return false;
  }
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
		if(data!=0){
			//alert(data);
			loadDynamicPage('dispatcher/page/delivery_install_search');
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
 function show_hide(ele_name,ele_value){
	 if(ele_value=='1'){
		 $('#'+ele_name).show();
	 }else
		 $('#'+ele_name).hide();
 }
 function checkForClose(btdl_type,btdl_state,owner,owner_type,message){
			 var querys=[]; 
		var btdl_state_update='${state}'; 
		var query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
		"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state_update+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
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
						 querys=[];  
						 query="SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST where ref_no='"+$("#bsoTypeNo").val()+"' "+
							 " and btdl_owner_type='1' and btdl_hide='1'" ;
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
									var message_used=message;
									if(data==0){ 
										 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='Sale Order Closed', BSO_STATUS='1' where BSO_ID=${bsoId}";
									}else{
										 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
										 message_used="Wait for other module";
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
												bootbox.dialog(message_used,[{
												    "label" : "Ok",
												    "class" : "btn-primary",
												    "callback": function() {
												    //	$("ul[class=nav] > li").removeClass("active"); 
													 //   $("#monitor_job_link").addClass("active"); 
												    	loadDynamicPage('dispatcher/page/todolist')
												    }
												 }]); 
											}
										}
									});
								}});
					}else{
						bootbox.dialog(message,[{
						    "label" : "Ok",
						    "class" : "btn-primary",
						    "callback": function() {
						    	/*
						    	$("ul[class=nav] > li").removeClass("active"); 
							    $("#monitor_job_link").addClass("active"); 
						    	loadDynamicPage('dispatcher/page/monitor_job')
						    	*/
						    	loadDynamicPage('dispatcher/page/todolist')
						    }
						 }]); 
					} 
				}});
 }
 function doCheck(btdl_type,btdl_state,owner,owner_type,message){
	 <c:if test="${state=='wait_for_supervisor_install_close'}">
	   var queryCheck=""+ 
		" SELECT count(*) as c0 FROM   BPM_SALE_PRODUCT_ITEM_MAPPING mapping where mapping.bso_id=${bsoId} and  mapping.IMA_ItemID like '9%' and mapping.IS_SERIAL='1' "+
		" union  all "+
		" SELECT count(*) as c0 FROM   BPM_INSTALLATION_TRAN tran where tran.bso_id=${bsoId} and tran.BIT_CHECK_STATUS='2' and tran.IMA_ItemID like '9%'   ";
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
					 if(data[0]!=data[1]){
						  bootbox.dialog("กรุณาตรวจสอบการติดตั้งให้ครบ",[{
							    "label" : "Close",
							     "class" : "btn-danger"
						 }]);
						 return false;
					 }else{
						 doCloseJob(btdl_type,btdl_state,owner,owner_type,message);
					 }
					}
		     });
	   </c:if>
	   <c:if test="${state!='wait_for_supervisor_install_close'}">
	     doCloseJob(btdl_type,btdl_state,owner,owner_type,message);
	   </c:if>
 }
 function doCloseJob(btdl_type,btdl_state,owner,owner_type,message){
	   /*  alert($("#BSO_IS_DELIVERY").val());
	    alert($("#BSO_IS_INSTALLATION").val()) */;  
	    if($("#BSO_IS_DELIVERY").val()=='1' && $("#BSO_IS_INSTALLATION").val()=='1'){
	    	checkForClose(btdl_type,btdl_state,owner,owner_type,message);
	    }else{
	    	var querys=[]; 
			var btdl_state_update='${state}'; 
			var query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0' ,BTDL_ACTION_TIME=now() where BTDL_REF='${bsoId}' and "+
			"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state_update+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
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
							 querys=[];   
						 if(btdl_state!='wait_for_create_to_express' && btdl_state!='wait_for_stock'){
							 if(btdl_state=='wait_for_supervisor_close')
								 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='Sale Order Closed', BSO_STATUS='1' , BSO_JOB_STATUS=6  where BSO_ID=${bsoId}";
							 else
								 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
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
										bootbox.dialog(message,[{
										    "label" : "Ok",
										    "class" : "btn-primary",
										    "callback": function() {
										    	//$("ul[class=nav] > li").removeClass("active"); 
											    //$("#monitor_job_link").addClass("active"); 
										    	//loadDynamicPage('dispatcher/page/monitor_job')
										    	loadDynamicPage('dispatcher/page/todolist')
										    }
										 }]); 
									}
								}
							});
						 }else
							 bootbox.dialog(message,[{
								    "label" : "Ok",
								    "class" : "btn-primary",
								    "callback": function() {
								    	/*
								    	$("ul[class=nav] > li").removeClass("active"); 
									    $("#monitor_job_link").addClass("active"); 
								    	loadDynamicPage('dispatcher/page/monitor_job')
								    	*/
								    	loadDynamicPage('dispatcher/page/todolist')
								    }
								 }]); 
						}else{
							bootbox.dialog(message,[{
							    "label" : "Ok",
							    "class" : "btn-primary",
							    "callback": function() {
							    	/*
							    	$("ul[class=nav] > li").removeClass("active"); 
								    $("#monitor_job_link").addClass("active"); 
							    	loadDynamicPage('dispatcher/page/monitor_job')
							    	*/
							    	loadDynamicPage('dispatcher/page/todolist')
							    }
							 }]); 
						} 
					}});
	    }
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
			 <input type="hidden" name="bsoId" id="bsoId"  value="${bsoId}"/> 
			 <input type="hidden" id="BSO_IS_DELIVERY" />
			 <input type="hidden" id="BSO_IS_INSTALLATION" />
			 <input type="hidden" id="BSO_IS_DELIVERY_INSTALLATION" />
			  
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
            <input type="hidden" id="IMA_ItemID" name="IMA_ItemID"/>
          <!--   <input type="hidden" id="LastCostAmt" name="LastCostAmt"/> -->
            
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="delivery_install_title"></strong><input type="text" id="bsoTypeNo" style="height: 30px;width: 125px" readonly="readonly"/> 
           	
           	 <c:if test="${isExpressAccount}">
           	 IV No. <input type="text" id="BSO_INV_NO" style="height: 30px;width: 125px" /> 
           	 </c:if>
           	  <c:if test="${isStoreAccount}">
           	<!--  RTE No. <input type="text" id="BSO_RFE_NO" style="height: 30px;width: 125px" /> -->
           	 คนรับของ <input type="text" id="BSO_RFE_NAME" style="height: 30px;width: 125px" />  
           	 </c:if>
           	 <%-- <c:if test="${isSupervisorAccount}">
           	  RTE No. <input type="text" id="BSO_RFE_NO" style="height: 30px;width: 125px" /> 
           	 </c:if> --%>
           	 <span id="bsoRfe_element" style="display: none">
           	  RFE No. <input type="text" id="BSO_RFE_NO" style="height: 30px;width: 125px" /> 
           	   <!-- <span style="padding-left: 3px">
    			 <input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BSO_RFE_DATE_PICKER" />
    			
    		  </span>
    					   			
    		  <span style="padding-left: 5px">ระบุเวลา 
    			 <input type="text" readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BSO_RFE_DATE_TIME_PICKER" />
    			 
    		</span> -->
           	 </span>
           	 <span id="install_form_element" style="padding-left: 10px;display: none">
            	<!-- <a class="btn" style="margin-top:-12px;" onclick="downloadForm('2')">&nbsp;Download Form&nbsp;</a> -->
            	INT No. <input type="text" id="BSO_INT_NO" readonly="readonly" style="height: 30px;width: 125px" />
            	</span>
            	<span id="invoice_form_element" style="padding-left: 10px;display: none">  
            	IV No. <input type="text" id="BSO_EXPRESS_INV_NO"  readonly="readonly" style="height: 30px;width: 125px" />
            	</span>
            	 <span id="score_form_element" style="padding-left: 10px;">  
            	คะแนน: 
            	<select style="width:48px">
            		<option>1</option>
            		<option>2</option>
            		<option>3</option>
            		<option>4</option>
            		<option>5</option>
            		<option>6</option>
            		<option>7</option>
            		<option>8</option>
            		<option>9</option>
            		<option>10</option>
            	</select>
            	</span>
           	 <br></br>
           	   
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="50%" valign="top" align="left">
    					  <div id="bsoType_1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;display: none" >
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BSO_DELIVERY_DUE_DATE_PICKER" />
    					   			</span>
    					   			<span style="padding-left: 3px">ระบุเวลา
    					   				<input type="text" readonly="readonly" style="width:50px; height: 30px;" id="BSO_DELIVERY_DUE_DATE_TIME_PICKER" />
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
    					   				<input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_CONTACT" />
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
    					   				<input type="text"   readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_LOCATION" />
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
    					   			 <input type="text"  readonly="readonly"   style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR1" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR2" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR3" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_PROVINCE" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ZIPCODE" /> 
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
    					   			<input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_DELIVERY_TEL_FAX" /> 
    					   			 <!-- <textarea style="width: 320px;height: 47px" id="TELNUM_2" rows="2" cols="4"></textarea>  -->
    					   			</span>
    					   		</td>
    					   	</tr>
    					    
    					   	</table>
    					   </div>
    					   <div id="bsoType_2" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;display: none">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดติดตั้ง
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BSO_INSTALLATION_TIME_PICKER" />
    					   			</span>
    					   			<span style="padding-left: 3px">ระบุเวลา
    					   				<input type="text" readonly="readonly" style="width:50px; height: 30px;" id="BSO_INSTALLATION_TIME_TIME_PICKER" />
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
    					   				<input type="text"  readonly="readonly"  style="width:300px; height: 30px;" id="BSO_INSTALLATION_CONTACT" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   		<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ระบุชื่อ Site งาน
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_SITE_LOCATION" />
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
    					   			 <input type="text"   readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR1" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR2" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR3" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_PROVINCE" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ZIPCODE" /> 
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
    					   			 <input type="text"  readonly="readonly"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_TEL_FAX" /> 
    					   			 <!-- <textarea style="width: 320px;height: 47px" id="TELNUM_2" rows="2" cols="4"></textarea> --> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   </div>
    					
    					</td>
    					<td width="50%" valign="top">
    					<div  id="cust_input_1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px;display: none">
    					   	<table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					ชื่อลูกค้ารับของ
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text"   style="height: 30px;" id="BDT_CUST_NAME" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					แนบเอกสาร
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<span id="BDT_DOC_ATTACH_SRC" style="padding-left: 3px"> 
    					   				</span>
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					Update By
    					   				</span>
    					   		</td>
    					   		<td width="75%">  
    					   				<span id="BDT_CREATED_BY" style="padding-left: 3px">  
    					   				</span>
    					   				<span id="BDT_CREATED_DATE" style="padding-left: 3px">  
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div id="cust_input_2" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px;display: none">
    					   	<table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					ชื่อลูกค้าตรวจสอบการติดตั้ง
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text"  style="height: 30px;" id="dd" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					แนบเอกสาร
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปสถานที่
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปพื้นที่ก่อนการติดตั้ง
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปพื้นที่หลังการติดตั้ง
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปพื้นที่หลังการทดสอบ
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปปัญหา 1
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="35%">
    					   				<span>
    					   					รูปปัญหา 2
    					   				</span>
    					   		</td>
    					   		<td width="65%">
    					   				<span style="padding-left: 3px">
    					   					<input type="file" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   		<div  id="cust_input_3" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px;display: none">
    					   	<table style="width: 100%;font-size:13px" border="1">
    					   	<tr style="height: 30px;">
    					   		<td width="100%" colspan="2" align="center">
    					   				<span>
    					   					<strong>การทดสอบ</strong>
    					   				</span>
    					   		</td> 
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				<span>
    					   					Input
    					   				</span>
    					   		</td>
    					   		<td width="50%" align="center">
    					   				<span>
    					   					Output
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   		<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 V(R)<input type="text" style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 V(R)<input type="text"  style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 V(S)<input type="text" style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 V(S)<input type="text"  style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 V(T)<input type="text" style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 V(T)<input type="text"  style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 V(g)<input type="text" style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 V(g)<input type="text"  style="width:100px;height: 30px;"/>Vac
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 I(R)<input type="text" style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 I(R)<input type="text"  style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 I(S)<input type="text" style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 I(S)<input type="text"  style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				 I(T)<input type="text" style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   		<td width="50%" align="center">
    					   				 I(T)<input type="text"  style="width:100px;height: 30px;"/>Amp
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				  
    					   		</td>
    					   		<td width="50%" align="center">
    					   				Load<input type="text"  style="width:100px;height: 30px;"/>%
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="50%" align="center">
    					   				  
    					   		</td>
    					   		<td width="50%" align="center">
    					   				Backup time<input type="text"  style="width:100px;height: 30px;"/>min
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	</td>
    				</tr>
    			</table> 
    			</fieldset> 
             <c:if test="${isSaleOrder}">
    			<div align="center" style="padding-top: 10px">
    			<table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/delivery_install_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%" align="center">
				 		 <a class="btn btn-primary"  onclick="doSubmitSaleOrder()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
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
				 			Assign to Supervisor
				 			<span id="supervisor_select_element"></span>
    					  <a class="btn btn-primary"  onclick="doSendToSupervisor()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Send</span></a>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
				 		</td>
				 	</tr>
				 </table>
				</div>
				</c:if>
			<c:if test="${isExpressAccount && state=='wait_for_create_to_express'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">
    					  <div align="center"><a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_create_to_express','ROLE_INVOICE_ACCOUNT','2','Sale Order updated ')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Status</span></a>
    					  </div>
				 		</td>
				 	</tr>
				 </table> 
				</div>
			</c:if>
			<c:if test="${isSupervisorAccount && state=='wait_for_assign_to_team'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%" align="center"> 
    					  <a class="btn btn-primary"  onclick="showTeam()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Assign to Team</span></a>
    					<!--  <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a> -->
				 		</td>
				 	</tr>
				 </table>
				</div>
			 </c:if>
			 <c:if test="${isStoreAccount && state=='wait_for_stock'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">  
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order updated ')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">จัดรายการแล้ว</span></a></div>
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
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateState('1','wait_for_supervisor_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Sale Order wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			<c:if test="${isSupervisorAccount && ( state=='wait_for_supervisor_delivery_close' || state=='wait_for_supervisor_install_close' )}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
				 		 <div align="center"> <a class="btn btn-primary"  onclick="doCheck('1','wait_for_supervisor_close','${username}','1','Sale Order Closed')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
    					 
    					 
    					</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
		 
			  </form>   
			  <c:if test="${mode=='edit'}">
			   <div  class="well">
			  <table border="0" width="100%" style="font-size: 13px">
	    					<tbody> 
	    					<tr>
	    					<td align="left" width="70%">   
	    						
	    					</td><td align="right" width="30%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="pageSelect" id="pageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
			 <div  id="item_section"> 
    		 </div> 
			</div>
			</c:if>
</fieldset>