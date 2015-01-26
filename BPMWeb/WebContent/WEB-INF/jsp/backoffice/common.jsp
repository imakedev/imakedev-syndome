<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.servletapi.*" %>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_REPAIR')" var="isManageRepair"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_DELIVERY')" var="isManageDelivery"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_PM_MA')" var="isManagePMMA"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_REPORT')" var="isManageReport"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_SETTING')" var="isManageSetting"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_USER')" var="isManageUser"/> 
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_CALL_CENTER_ACCOUNT')" var="isCallCenterAccount"/> 
 <sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/>  
 
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_DELIVERT')" var="isVeiwReportDeliveryAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_PENDING_JOB')" var="isVeiwReportPendingJobAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_SLA')" var="isVeiwReportSLAAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_SO')" var="isVeiwReportSOAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_DEPT_STATUS')" var="isVeiwReportDeptStatusAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_OPERATION_STATUS')" var="isVeiwReportOperationStatusAccount"/>  
 <sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_PM_MA')" var="isVeiwReportPMMAAccount"/>  
  
 
<sec:authentication var="myUser" property="principal.myUser"/>
<sec:authentication var="username" property="principal.username"/>  
<!-- user user = (user)securitycontextholder.getcontext().getauthentication().getprincipal();
      string name = user.getusername(); //get logged in username -->
<html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
<title>SynDome BPM</title>
 <meta charset="UTF-8" />
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
<%-- 
<meta http-equiv="X-UA-Compatible" content="IE=7, IE=9"/>
 --%>  
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>      
<c:url var="url" value="/" />
<c:url value="/logout" var="logoutUrl"/>
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />   
<link href="<c:url value='/resources/css/smoothness/jquery-ui-1.9.1.custom.css'/>" type="text/css"  rel="stylesheet" /> 
<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet"  media="all" type="text/css"/>  
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/demo.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style3.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/animate-custom.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/jquery.ui.timepicker.css'/>" /> 

<link rel="stylesheet" href="<c:url value='/resources/css/jquery.fileupload-ui.css'/>">
<%--
<link rel="stylesheet" href="<c:url value='/resources/css/fileupload/jquery.fileupload.css'/>">
 --%> 
<style>
.ui-widget { font-family: Trebuchet MS, Tahoma, Verdana,
 Arial, sans-serif; font-size: 12px; }
 </style>
<style type="text/css"> 
.th_class{text-align: center;
}
a{cursor: pointer;}
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
  img.ui-datepicker-trigger{cursor: pointer;} 
</style> 

<script  src="<c:url value='/resources/js/jquery-1.8.3.min.js'/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/resources/js/smoothness/jquery-ui-1.9.1.custom.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/bootbox.min.js'/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.dateFormat-1.0.js'/>"></script>   
<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery-ui-timepicker-addon.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.ui.timepicker.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/resources/js/jshashtable-3.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.numberformatter-1.2.4.jsmin.js'/>"></script>
<script src="<c:url value='/resources/js/ajaxupload.js'/>"></script> 
<%--
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="<c:url value='/resources/js/vendor/jquery.ui.widget.js'/>"></script> 
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="<c:url value='/resources/js/jquery.iframe-transport.js'/>"></script>
<!-- The basic File Upload plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload.js'/>"></script>
<!-- The File Upload processing plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-process.js'/>"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-image.js'/>"></script>
<!-- The File Upload audio preview plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-audio.js'/>"></script>
<!-- The File Upload video preview plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-video.js'/>"></script>
<!-- The File Upload validation plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-validate.js'/>"></script>
<!-- The File Upload user interface plugin -->
<script src="<c:url value='/resources/js/jquery.fileupload-ui.js'/>"></script>
 --%>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/SynDomeBPMAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/util.js"></script>
<%@ include file="/WEB-INF/jsp/schema.jsp" %>  


<c:set var="aoeTest">
  <spring:message code='navigation_home'/>
</c:set>
<script type="text/javascript">
var _path=""; 
var mail_toG;
var mail_subjectG;
var mail_messageG;
var mail_attachG; 
var _perpageG=20;
var intRegex = /^\d+$/;
//var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+))$/;
var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+)|(-\d+(\.\d *)?)|((-\d*\.)?\d+))$/;

$(document).ready(function() {
	_path="${url}";
	//alert(_path)
	$('#tabs').tabs();
	$('#tabs > ul > li > a').css("width","70px"); 
		 
	//loadDynamicPage("employee/init");
	//alert($("#nav_element").html())
	<c:if test="${isCallCenterAccount}"> 
       togle_page('dispatcher/page/callcenter','callCenterList_link');
    </c:if>
    <c:if test="${!isCallCenterAccount && !isManagePMMA && username!='stock'}">
    	togle_page('dispatcher/page/todolist','todolist_link');
    </c:if>
    <c:if test="${isManagePMMA}"> 
       togle_page('dispatcher/page/pm_ma_search','pmMa_link');
    </c:if> 
    <c:if test="${username=='stock'}"> 
    	togle_page('dispatcher/page/stock','stock_link');
   </c:if> 
});
function setSpanClass(mode){ 
	var _content_element=$("#_content");
	if(mode=='width'){ 
		_content_element.attr("class","span12");
	}else{
		_content_element.attr("class","span10 offset1");
	}
}
function   calculatePage( perPage, total)
{ 
	return total % perPage != 0 ? Math.floor(total / perPage) + 1 : Math.floor(total / perPage);
}
function checkWithSet(_id,_value){
	if($("#"+_id).get(0)){
		$("#"+_id).val(_value);
	}
}

function loadDynamicPage(pageId){
	var load_str="<fieldset style=\"font-family: sans-serif;padding-top:5px\">"+    
		 "<div style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 10px\"> <img src='${url}resources/images/loading.gif' /></div></fieldset>";
	 $("#_content").html(load_str); 
	 //$("#loadingDiv").slideDown(1000);
			$.ajax({
				  type: "get",
				  url: pageId,
				  cache: false
				 // data: { name: "John", location: "Boston" }
				}).done(function( data ) {
					if(data!=null){
						  appendContent(data);
					  }
				});
}
function togle_page(pageId,id_active){  
	$("ul[class=nav] > li").removeClass("active"); 
	    $("#"+id_active).addClass("active");
		loadDynamicPage(pageId);
}
function appendContentWithId(data,contentId){
	//$('#candidate_photo').attr('src', _path+"resources/images/loading.gif"); 
	
	
	if(data.indexOf("j_username")!=-1 || data.indexOf("loginform")!=-1){
	 
		  window.location.href="<c:url value='/logout'/>";
		 //$("#_content").html(data);
	  }else{ 
			  $("#"+contentId).html(data); 
			 // $("#loadingDiv").slideUp(1000);
	  } 
}
function appendContent(data){
	//alert(data)
	appendContentWithId(data,"_content");
	
}
function doSendMailToApprove(mail_todo_idG,mail_todo_refG){
	loadDynamicPage("getmailToApprove/"+mail_todo_idG+"/"+mail_todo_refG); 
  }
function openMailDialog(todo_id,todo_ref){
	$("#mail_todo_id").val(todo_id);
	$("#mail_todo_ref").val(todo_ref);
	$( "#dialog-modal" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Ok": function() { 
				$( this ).dialog( "close" );  
				doSendMailToApprove(todo_id,todo_ref); 
				 
			},
			"Close": function() { 
				$( this ).dialog( "close" );				 
			}
		}
	});
}
function checkNumber(txtVal){
	// alert(txtVal) 
	 if(!(intRegex.test(txtVal) || floatRegex.test(txtVal))) {
	      //  alert('Please fill Number !!!');
	      return true; 
	    }
	 return false;
 }
function checkNumberDecimal(txtVal){
	// alert(txtVal) 
	 if(!(intRegex.test(txtVal))) {
	      //  alert('Please fill Number !!!');
	      return true; 
	    }
	 return false;
 }
function hideAllDialog(){
	bootbox.hideAll();
}
function clearElementValue(ele){
	 $("#"+ele).val("");
}
function changeDateToStr(dateForm){
	if(dateForm.length>0){
		var dateForm_ARRAY=dateForm.split("/");
		dateForm=dateForm_ARRAY[2]+"-"+dateForm_ARRAY[1]+"-"+dateForm_ARRAY[0];
		dateForm=dateForm+" 00:00:00";
		return dateForm;
  }else
	  return "";
}
function loadFile(path_file){ 
	var src = path_file;
//	src=src+"?type="+type;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
}
function showDialog(messaage){ 
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary" 
	 }]);
}
function autoAmphur(amphur_element_id){  
	   var query=" SELECT amphur_code,amphur_name  FROM "+SCHEMA_G+".amphur where amphur_name like "; 
	   $("#"+amphur_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%' order by amphur_name limit 20";
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
						        	  label: item[1],
						        	  value: item[1] ,
						        	  amphur_code: item[0],
						        	  amphur_name: item[1]  
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
				 // this.value = ui.item.label +"- "+ ui.item.value ;
				 
				  //$("#"+amphur_element_id).val(ui.item.amphur_name);  
				  $("#"+amphur_element_id).val(jQuery.trim(ui.item.amphur_name));
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
function autoCustname(custname_element_id){  
	   var query="SELECT cuscod,concat(ifnull(prenam,''),' ',ifnull(cusnam,''))  FROM "+SCHEMA_G+".BPM_ARMAS where concat(ifnull(prenam,''),'',ifnull(cusnam,'')) like "; 
	   $("#"+custname_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%' order by cusnam limit 15";
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
						        	  label: item[1],
						        	  value: item[0] ,
						        	  cuscod: item[0],
						        	  cusnam: item[1]  
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
				  this.value = ui.item.label +"- "+ ui.item.value ;
				  $("#"+custname_element_id).val(ui.item.cusnam);  
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
function autoProvince(province_element_id){  
	   var query="SELECT province_id,province_code,province_name  FROM "+SCHEMA_G+".province where province_name like "; 
	   $("#"+province_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%' order by province_name limit 15";
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
						        	  label: item[2],
						        	  value: item[2] ,
						        	  province_id: item[0],
						        	  province_code: item[1],
						        	  province_name: item[2] 
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
				  $("#"+province_element_id).val(ui.item.province_name);  
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
function autoDealer(dealer_element_id){  
 
	   var query="SELECT  BCC_CUSTOMER_NAME  FROM "+SCHEMA_G+".BPM_CALL_CENTER where BCC_CUSTOMER_NAME like "; 
	   $("#"+dealer_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by BCC_CUSTOMER_NAME  order by BCC_CUSTOMER_NAME limit 15";
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
function autoCaller(caller_element_id){  
	/*
	var query=" SELECT "+  
    " concat(ifnull(BCC_LOCATION,''),' ',ifnull(BCC_CONTACT,'') "+
    " ,' ',ifnull(BCC_TEL,''),' ',ifnull(BCC_ADDR1,'')  "+
    " ,' ',ifnull(BCC_ADDR2,'') ,' ',ifnull(BCC_ADDR3,'') "+
	" ,' ',ifnull(BCC_PROVINCE,'') ,' ',ifnull(BCC_ZIPCODE,'')) , "+
    "BCC_LOCATION, "+
    "BCC_CONTACT, "+
    "BCC_TEL, "+
    "BCC_ADDR1, "+
    "BCC_ADDR2, "+
    "BCC_ADDR3, "+
    "BCC_PROVINCE, "+
    "BCC_ZIPCODE  "+
	"FROM "+SCHEMA_G+".BPM_CALL_CENTER group by  "+
    " concat(ifnull(BCC_LOCATION,''),' ',ifnull(BCC_CONTACT,'') "+
   "  ,' ',ifnull(BCC_TEL,''),' ',ifnull(BCC_ADDR1,'')  "+
	" ,' ',ifnull(BCC_ADDR2,'') ,' ',ifnull(BCC_ADDR3,'') "+
	" ,' ',ifnull(BCC_PROVINCE,'') ,' ',ifnull(BCC_ZIPCODE,'')) ";
*/
	   var query=" SELECT "+  
	    " concat(ifnull(BCC_LOCATION,''),' ',ifnull(BCC_CONTACT,'') "+
	    " ,' ',ifnull(BCC_TEL,''),' ',ifnull(BCC_ADDR1,'')  "+
	    " ,' ',ifnull(BCC_ADDR2,'') ,' ',ifnull(BCC_ADDR3,'') "+
		" ,' ',ifnull(BCC_PROVINCE,'') ,' ',ifnull(BCC_ZIPCODE,'')) , "+
	    "BCC_LOCATION, "+
	    "BCC_CONTACT, "+
	    "BCC_TEL, "+
	    "BCC_ADDR1, "+
	    "BCC_ADDR2, "+
	    "BCC_ADDR3, "+
	    "BCC_PROVINCE, "+
	    "BCC_ZIPCODE  FROM "+SCHEMA_G+".BPM_CALL_CENTER where BCC_LOCATION like ";
	   $("#"+caller_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by  "+
				    " concat(ifnull(BCC_LOCATION,''),' ',ifnull(BCC_CONTACT,'') "+
				    "  ,' ',ifnull(BCC_TEL,''),' ',ifnull(BCC_ADDR1,'')  "+
				 	" ,' ',ifnull(BCC_ADDR2,'') ,' ',ifnull(BCC_ADDR3,'') "+
				 	" ,' ',ifnull(BCC_PROVINCE,'') ,' ',ifnull(BCC_ZIPCODE,''))  order by BCC_LOCATION limit 15";
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
						        	  label: item[0],
						        	  value: item[1] ,
						        	  BCC_LOCATION: item[1],
						        	  BCC_CONTACT: item[2],
						        	  BCC_TEL: item[3],
						        	  BCC_ADDR1: item[4],
						        	  BCC_ADDR2: item[5],
						        	  BCC_ADDR3: item[6],
						        	  BCC_PROVINCE: item[7],
						        	  BCC_ZIPCODE: item[8]
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
				  $("#"+caller_element_id).val(ui.item.BCC_LOCATION);  
				  
				  $("#BCC_CONTACT").val(ui.item.BCC_CONTACT);
				  $("#BCC_TEL").val(ui.item.BCC_TEL);
				  $("#BCC_ADDR1").val(ui.item.BCC_ADDR1);
				  $("#BCC_ADDR2").val(ui.item.BCC_ADDR2);
				  $("#BCC_ADDR3").val(ui.item.BCC_ADDR3);
				  $("#BCC_PROVINCE").val(ui.item.BCC_PROVINCE); 
				  $("#BCC_ZIPCODE").val(ui.item.BCC_ZIPCODE);
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
 
function autoDeliveryLocation(delivery_element_id){  
	    var query="SELECT   BSO_DELIVERY_LOCATION ,BSO_DELIVERY_CONTACT, "+
			" BSO_DELIVERY_ADDR1,BSO_DELIVERY_ADDR2,BSO_DELIVERY_ADDR3, "+
			" BSO_DELIVERY_PROVINCE,BSO_DELIVERY_ZIPCODE,BSO_DELIVERY_TEL_FAX  FROM "+SCHEMA_G+".BPM_SALE_ORDER where BSO_DELIVERY_LOCATION like "; 
	   $("#"+delivery_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by    "+
				    " concat(ifnull(BSO_DELIVERY_LOCATION,''), "+
				    "   ' ',ifnull(BSO_DELIVERY_CONTACT,''),' ',ifnull(BSO_DELIVERY_ADDR1,'')  "+
				 	" ,' ',ifnull(BSO_DELIVERY_ADDR2,'') ,' ',ifnull(BSO_DELIVERY_ADDR3,'') "+
				 	" ,' ',ifnull(BSO_DELIVERY_PROVINCE,'') ,' ',ifnull(BSO_DELIVERY_ZIPCODE,''),'',ifnull(BSO_DELIVERY_TEL_FAX,''))   order by BSO_DELIVERY_LOCATION limit 15";
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
						        	  label: item[0],
						        	  value: item[0] ,
						        	  BSO_DELIVERY_LOCATION: item[0],
						        	  BSO_DELIVERY_CONTACT: item[1],
						        	  BSO_DELIVERY_ADDR1: item[2],
						        	  BSO_DELIVERY_ADDR2: item[3],
						        	  BSO_DELIVERY_ADDR3: item[4],
						        	  BSO_DELIVERY_PROVINCE: item[5],
						        	  BSO_DELIVERY_ZIPCODE: item[6],
						        	  BSO_DELIVERY_TEL_FAX: item[7]
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
				  $("#"+delivery_element_id).val(ui.item.location);  
				  $("#BSO_DELIVERY_LOCATION").val(ui.item.BSO_DELIVERY_LOCATION);
				  $("#BSO_DELIVERY_CONTACT").val(ui.item.BSO_DELIVERY_CONTACT);
				  $("#BSO_DELIVERY_ADDR1").val(ui.item.BSO_DELIVERY_ADDR1);
				  $("#BSO_DELIVERY_ADDR2").val(ui.item.BSO_DELIVERY_ADDR2);
				  $("#BSO_DELIVERY_ADDR3").val(ui.item.BSO_DELIVERY_ADDR3);
				  $("#BSO_DELIVERY_PROVINCE").val(ui.item.BSO_DELIVERY_PROVINCE);
				  $("#BSO_DELIVERY_ZIPCODE").val(ui.item.BSO_DELIVERY_ZIPCODE);
				  $("#BSO_DELIVERY_TEL_FAX").val(ui.item.BSO_DELIVERY_TEL_FAX);
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

function autoInstallationLocation(installation_element_id){  
	 
	 var query="SELECT   BSO_INSTALLATION_SITE_LOCATION ,BSO_INSTALLATION_CONTACT, "+
		" BSO_INSTALLATION_ADDR1,BSO_INSTALLATION_ADDR2,BSO_INSTALLATION_ADDR3, "+
		" BSO_INSTALLATION_PROVINCE,BSO_INSTALLATION_ZIPCODE,BSO_INSTALLATION_TEL_FAX  FROM "+SCHEMA_G+".BPM_SALE_ORDER where BSO_INSTALLATION_SITE_LOCATION like "; 
	   $("#"+installation_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by    "+
				    " concat(ifnull(BSO_INSTALLATION_SITE_LOCATION,''), "+
				    "   ' ',ifnull(BSO_INSTALLATION_CONTACT,''),' ',ifnull(BSO_INSTALLATION_ADDR1,'')  "+
				 	" ,' ',ifnull(BSO_INSTALLATION_ADDR2,'') ,' ',ifnull(BSO_INSTALLATION_ADDR3,'') "+
				 	" ,' ',ifnull(BSO_INSTALLATION_PROVINCE,'') ,' ',ifnull(BSO_INSTALLATION_ZIPCODE,''),'',ifnull(BSO_INSTALLATION_TEL_FAX,''))   order by BSO_DELIVERY_LOCATION limit 15";
				
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
						        	  label: item[0],
						        	  value: item[0] ,
						        	  BSO_INSTALLATION_SITE_LOCATION: item[0],
						        	  BSO_INSTALLATION_CONTACT: item[1],
						        	  BSO_INSTALLATION_ADDR1: item[2],
						        	  BSO_INSTALLATION_ADDR2: item[3],
						        	  BSO_INSTALLATION_ADDR3: item[4],
						        	  BSO_INSTALLATION_PROVINCE: item[5],
						        	  BSO_INSTALLATION_ZIPCODE: item[6],
						        	  BSO_INSTALLATION_TEL_FAX: item[7]
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
				  $("#"+installation_element_id).val(ui.item.location);  
				  $("#BSO_INSTALLATION_SITE_LOCATION").val(ui.item.BSO_INSTALLATION_SITE_LOCATION);
				  $("#BSO_INSTALLATION_CONTACT").val(ui.item.BSO_INSTALLATION_CONTACT);
				  $("#BSO_INSTALLATION_ADDR1").val(ui.item.BSO_INSTALLATION_ADDR1);
				  $("#BSO_INSTALLATION_ADDR2").val(ui.item.BSO_INSTALLATION_ADDR2);
				  $("#BSO_INSTALLATION_ADDR3").val(ui.item.BSO_INSTALLATION_ADDR3);
				  $("#BSO_INSTALLATION_PROVINCE").val(ui.item.BSO_INSTALLATION_PROVINCE);
				  $("#BSO_INSTALLATION_ZIPCODE").val(ui.item.BSO_INSTALLATION_ZIPCODE);
				  $("#BSO_INSTALLATION_TEL_FAX").val(ui.item.BSO_INSTALLATION_TEL_FAX);
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

function autoSaleID(sale_element_id){   
	 var query="SELECT   bs_id,bs_sale_name FROM "+SCHEMA_G+".BPM_SALE where bs_id like "; 
	   $("#"+sale_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'    order by BS_ID limit 15";
				
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
						        	  label: item[0]+" "+item[1] ,
						        	  value: item[0],
						        	  BSO_SALE_CODE: item[0],
						        	  BSO_SALE_ID: item[1]
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
				 // this.value = ui.item.label;
				  $("#"+sale_element_id).val(ui.item.location);  
				  $("#BSO_SALE_CODE").val(ui.item.BSO_SALE_CODE);
				  $("#BSO_SALE_ID").val(ui.item.BSO_SALE_ID); 
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
</script>
</head> 
<body>
   <div class="container">  
      <div class="row-fluid"  style="position:fixed;z-index: 1030;background-image: url(<c:url value='/resources/css/smoothness/images/ui-bg_highlight-soft_75_cccccc_1x100.png'/>)">
         <div class="span12">
     	<span style="float:center;"> 
            <table border="0" width="100%">
            <tr><td>
            
            </td>
            <td><span style="padding: 10px"> <i onclick="window.open('https://docs.google.com/a/lansingbs.com/spreadsheet/ccc?key=0AoStrel5bd_edG1ZN204S1JxeUU0VGNORlYyN0ZRNXc&usp=drive_web#gid=0',
            	  '_blank')" style="cursor: pointer;" class=" icon-warning-sign"></i></span> 
            </td>
            <td>
             <div class="navbar" style="float:right;position: relative;top: 8px">
              <div class="navbar-inner">
                <div class="container">
                  <div class="nav-collapse collapse navbar-responsive-collapse">
                    <ul class="nav" id="nav_element" > 
                    <%--  <c:if test="${content.contentType.name ne 'MCE'}"> --%>
                     <c:if test="${username=='stock'}">
                     	<li   id="stock_link"><a onclick="togle_page('dispatcher/page/stock','stock_link')">Stock</a></li>
                     </c:if>
                     <c:if test="${!isCallCenterAccount && !isManagePMMA && username!='stock'}">
                     	<li   id="todolist_link"><a onclick="togle_page('dispatcher/page/todolist','todolist_link')">To-do-list</a></li>
                     </c:if>
                      <c:if test="${isCallCenterAccount || isKeyAccount || isQuotationAccount || isSupervisorAccount || isStoreAccount}">
                     	<li   id="callCenterList_link"><a onclick="togle_page('dispatcher/page/callcenter','callCenterList_link')">แจ้งซ่อม</a></li>
                     </c:if>
                      <c:if test="${isManageRepair}">
                        <%--  
                        <li  id="service_link"><a onclick="togle_page('dispatcher/page/service_search','service_link')">แจ้งซ่อม</a></li>
                        --%>
                      </c:if>
                       <c:if test="${isManageDelivery || isManagePMMA || isSupervisorAccount || isKeyAccount}">
                      <li id="deliveryInstall_link"><a onclick="togle_page('dispatcher/page/delivery_install_search','deliveryInstall_link')">ส่งเครื่องใหม่/ติดตั้ง</a></li>
                      </c:if>
                       <c:if test="${isManagePMMA}">
                      <%-- 
                      <li id="pmMa_link"><a onclick="togle_page('pmMa/init','pmMa_link')">PM/MA</a></li> 
                       --%>
                       <li id="pmMa_link"><a onclick="togle_page('dispatcher/page/pm_ma_search','pmMa_link')">PM/MA</a></li> 
                        <li id="pmMa_Planing_link"><a onclick="togle_page('dispatcher/page/pm_ma_planing','pmMa_Planing_link')">Planing</a></li> 
                          <li id="pmMa_Complete_link"><a onclick="togle_page('dispatcher/page/pm_ma_complete','pmMa_Complete_link')">Complete Job(PM)</a></li> 
                      </c:if>
                        <c:if test="${isSupervisorAccount || isKeyAccount}"> 
                        <li id="monitor_job_link"><a onclick="togle_page('dispatcher/page/monitor_job','monitor_job_link')">Monitor Job</a></li>
                        </c:if>
                        <c:if test="${isSupervisorAccount && !isManagePMMA}"> 
                        <li id="delivery_install_report_link"><a onclick="togle_page('dispatcher/page/delivery_install_report','delivery_install_report_link')">Daily Report</a></li>
                        
                        </c:if>
                         <c:if test="${isStoreAccount}"> 
                        <li id="prepare_job_link"><a onclick="togle_page('dispatcher/page/prepare_job','prepare_job_link')">จัดรายการแล้ว</a></li>
                               </c:if>
                       <c:if test="${isManageReport}">
                     <li class="dropdown" id="report_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report<b class="caret"></b></a>
                      	<ul class="dropdown-menu"> 
   						  <c:if test="${isVeiwReportDeliveryAccount}">
                           <li><a  href="javascript:void(0);"  onclick="togle_page('dispatcher/page/report1','report_link')"  style="text-align: left;">รายงาน ขนส่ง</a></li>
                          </c:if>
                           <%-- 
                          <li><a  href="javascript:void(0);"  onclick="togle_page('report/page/report2','report_link')"  style="text-align: left;">รายงาน การเข้าระบบ</a></li>
                           --%>
                           <c:if test="${isVeiwReportPendingJobAccount}">
                          <li><a  href="javascript:void(0);"  onclick="togle_page('dispatcher/page/report3','report_link')"  style="text-align: left;">รายงาน งานคงค้าง</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportSLAAccount}">
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report4','report_link')"  style="text-align: left;">รายงาน SLA</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportSOAccount}"> 
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report5','report_link')"  style="text-align: left;">รายงาน SO</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportDeptStatusAccount}">
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report6','report_link')"  style="text-align: left;">รายงาน สถานะงานตามแผนก</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportOperationStatusAccount}">
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report7','report_link')"  style="text-align: left;">รายงาน สถานะงานตาม Line Operation</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportPMMAAccount}">
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report8','report_link')"  style="text-align: left;">รายงาน แผน PM/MA</a></li>
                          </c:if>
                          <c:if test="${isVeiwReportPMMAAccount}">
                          <li><a  href="javascript:void(0);" onclick="togle_page('dispatcher/page/report10','report_link')"  style="text-align: left;">รายงานการขายเครื่องใหม่เป็นฐานMA</a></li>
                          </c:if>
                           
                         </ul>
                      </li> 
                      </c:if>
                       <c:if test="${isManageSetting}">
                       <li class="dropdown" id="setting_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Setting<b class="caret"></b></a>
                      	<ul class="dropdown-menu"> 
                          <li><a href="javascript:void(0);"  onclick="togle_page('setting/page/department_search','setting_link')" style="text-align: left;">Department</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/setting_sla','setting_link')"  style="text-align: left;">SLA</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/role_search','setting_link')"  style="text-align: left;">Role</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/problemType_search','setting_link')"  style="text-align: left;">ประเภทปัญหา</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/solutionType_search','setting_link')"  style="text-align: left;">วิธีแก้ไข/ป้องกันปัญหา</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/driver_search','setting_link')"  style="text-align: left;">คนขับรถ</a></li>
                        <li><a href="javascript:void(0);" onclick="togle_page('setting/page/registrationCar_search','setting_link')"  style="text-align: left;">ทะเบียนรถ</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('setting/page/saleManager_search','setting_link')"  style="text-align: left;">Sale Manager</a></li>
                        
                         </ul>
                      </li>
                      </c:if>
                       <li class="dropdown" id="user_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${myUser.fullName}<b class="caret"></b></a>
                      	<ul class="dropdown-menu">
                      	<c:if test="${isManageUser}">
                      	   <li><a href="javascript:void(0);" onclick="togle_page('dispatcher/page/user_search','user_link')" style="text-align: left;">Manage User</a></li>
                      	</c:if> 
                      	 <li><a href="javascript:void(0);"  onclick="togle_page('setting/page/changePassword','user_link')"  style="text-align: left;">แก้ใขข้อมูลส่วนตัว</a></li>
                      	   <li><a href="<c:url value='/logout'/>"  style="text-align: left;">Log out</a></li>
                         </ul>
                      </li>
                    </ul>  
                  </div> 
                </div>
              </div> 
            </div>
            </td>
            </tr> 
            </table>
         </span> 
     	</div>
     </div>
     <div class="row-fluid" style="margin-top: 63px"> 
     	<!--  <div id="_content" class="span10 offset1">   -->
     	 <div id="_content" class="span12">
      	</div>
      	<%-- <div id='loadingDiv' style="display: none"  class="span10 offset1"> 
    		Please wait...  <img src='${url}resources/images/loading.gif' />
 		  </div> --%>
    </div> 
  </div>  
</body>
</html>


