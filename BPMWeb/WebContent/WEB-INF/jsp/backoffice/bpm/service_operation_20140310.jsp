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
  // getServiceJob(); 
}); 

function clearElementValue(ele){
	 $("#"+ele).val("");
}


function getServiceJob(){  
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
	  // " so.BSO_DOC_CREATED_DATE, "+
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
	   " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'')  , "+ 
	   " so.BSO_RFE_NO,  "+
	   " so.BSO_INT_NO ,"+
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
					var BSO_IS_DELIVERY_INSTALLATION=data[0][44]!=null?data[0][44]:"";
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
					var BDT_IS_INTERNAL="0";
					if(BSO_RFE_NO!=''){
						$("#BSO_RFE_NO").val(BSO_RFE_NO); 
						$("#bsoRfe_element").show(); 
						$("#attach_file1").hide(); 
						 $("#delivery_form_element").show(); 
						BDT_IS_INTERNAL="1";
					}else{
						$("#BSO_EXPRESS_INV_NO").val(BSO_EXPRESS_INV_NO);
						 $("#invoice_form_element").show(); 
					}
					$("#BDT_IS_INTERNAL").val(BDT_IS_INTERNAL);
					var query="SELECT "+
					" BSO_ID ,"+
					" BDT_CUST_NAME ,"+
					" BDT_DOC_ATTACH_NAME ,"+
					" BDT_DOC_ATTACH_PATH ,"+
					" BDT_IS_INTERNAL ,"+
					" BDT_CREATED_DATE ,"+
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
								$("#BDT_DOC_ATTACH_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
								$("#BDT_DOC_ATTACH_SRC").html(BDT_DOC_ATTACH_NAME);
							     $("#BDT_DOC_ATTACH_SRC").attr("onclick","loadFile('getfile/delivery/${bsoId}/"+BDT_DOC_ATTACH_HOTLINK+"')");
							}else{
							var querys=[];  
								
								var query_insert="insert into "+SCHEMA_G+".BPM_DELIVERY_TRAN set BSO_ID=${bsoId} "+
								  ", BDT_CREATED_DATE=now(),BDT_CREATED_BY='${username}' ,BDT_IS_INTERNAL='"+BDT_IS_INTERNAL+"' ";
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
					// BSO_BORROW_EXT
					//BSO_BORROW_DURATION
					//BSO_WARRANTY_EXT
					//BSO_PM_MA_EXT

					  if(BSO_IS_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_1"]').prop('checked', true);
						// bsoTypeCheck('1');
						// $("#bsoRfe_element").show(); 
						 
					  }
					if(BSO_IS_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_2"]').prop('checked', true);
						// bsoTypeCheck('2');
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						 $("#install_form_element").show();
					}
					if(BSO_IS_DELIVERY_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_3"]').prop('checked', true);
						// bsoTypeCheck('3');
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						 $("#install_form_element").show();
					}
					if(BSO_IS_NO_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_4"]').prop('checked', true);
						  bsoTypeCheck('4');
					}   
					if('${state}'=='wait_for_operation_delivery'){
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
					  //alert(BSO_IS_INSTALLATION)
					  if(BSO_IS_INSTALLATION=='1' || BSO_IS_DELIVERY_INSTALLATION=='1'){  
							searchItemListByInstall('1');
						}else
							searchItemList("1");
				}else{
					
				} 
				/* if(BSO_IS_INSTALLATION=='1' || BSO_IS_DELIVERY_INSTALLATION=='1'){  
					searchItemListByInstall('1');
				}else
					searchItemList("1"); */
				
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
	$("#pageNo").val(document.getElementById("pageSelect").value);
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
	document.getElementById("pageSelect").value=$("#pageNo").val();
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
 

function showDialog(messaage){
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary"
	 }]);
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
 function downloadForm(){ 
		var src = "getRFE/${bsoId}";
		//src=src+"?type="+type;
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
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
			 <input type="hidden" name="bccNo" id="bccNo"  value="${bccNo}"/> 
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
            <input type="hidden" id="IMA_ItemID" name="IMA_ItemID"/>
          <!--   <input type="hidden" id="LastCostAmt" name="LastCostAmt"/> -->
         
            <c:if test="${isOperationAccount && ( state=='wait_for_operation_services' ) }">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
				 		<div align="center"> 
    					     <a class="btn btn-primary"  onclick="doCloseServicesJob('2','wait_for_supervisor_services_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a>
				 		 
				 		 </div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if> 
			  </form>   
			
</fieldset>