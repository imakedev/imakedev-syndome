<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.servletapi.*" %>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_REPAIR')" var="isManageRepair"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_DELIVERY')" var="isManageDelivery"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_PM_MA')" var="isManagePMMA"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_REPORT')" var="isManageReport"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_SETTING')" var="isManageSetting"/>
<sec:authorize access="hasAnyRole('ROLE_MANAGE_USER')" var="isManageUser"/> 
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorUser"/>

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
<meta http-equiv="X-UA-Compatible" content="IE=7, IE=9"/>        
<c:url var="url" value="/" />
<c:url value="/logout" var="logoutUrl"/>
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />   
<link href="<c:url value='/resources/css/smoothness/jquery-ui-1.9.1.custom.css'/>" type="text/css"  rel="stylesheet" /> 
<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet"  type="text/css"/>  
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/demo.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style3.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/animate-custom.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/jquery.ui.timepicker.css'/>" /> 
<link rel="stylesheet" href="<c:url value='/resources/css/jquery.fileupload-ui.css'/>">
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
	togle_page('dispatcher/page/todolist','todolist_link');
});
function   calculatePage( perPage, total)
{ 
	return total % perPage != 0 ? Math.floor(total / perPage) + 1 : Math.floor(total / perPage);
}
function loadDynamicPage(pageId){
	 
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
	if(data.indexOf("j_username")!=-1 || data.indexOf("loginform")!=-1){
	 
		  window.location.href="<c:url value='/logout'/>";
		 //$("#_content").html(data);
	  }else{ 
			  $("#"+contentId).html(data); 
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
                    <ul class="nav" id="nav_element">  
                      <li id="todolist_link"><a onclick="togle_page('dispatcher/page/todolist','todolist_link')">To-do-list</a></li>                     
                      <c:if test="${isManageRepair}">
                        <%--  <li  id="service_link"><a onclick="togle_page('service/init','service_link')">แจ้งซ่อม</a></li> --%>
                        <li  id="service_link"><a onclick="togle_page('dispatcher/page/service_search','service_link')">แจ้งซ่อม</a></li>
                      </c:if>
                       <c:if test="${isManageDelivery}">
                      <li id="deliveryInstall_link"><a onclick="togle_page('dispatcher/page/delivery_install_search','deliveryInstall_link')">ส่งเครื่องใหม่/ติดตั้ง</a></li>
                      </c:if>
                       <c:if test="${isManagePMMA}">
                      <%-- 
                      <li id="pmMa_link"><a onclick="togle_page('pmMa/init','pmMa_link')">PM/MA</a></li> 
                       --%>
                       <li id="pmMa_link"><a onclick="togle_page('dispatcher/page/pm_ma_search','pmMa_link')">PM/MA</a></li> 
                      </c:if>
                        <c:if test="${isSupervisorUser}"> 
                        <li id="monitor_job_link"><a onclick="togle_page('dispatcher/page/monitor_job','monitor_job_link')">Monitor Job</a></li>
                        <li id="delivery_install_report_link"><a onclick="togle_page('dispatcher/page/delivery_install_report','delivery_install_report_link')">Daily Report</a></li>
                        
                        </c:if>
                       <c:if test="${isManageReport}">
                     <li class="dropdown" id="report_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report<b class="caret"></b></a>
                      	<ul class="dropdown-menu"> 
                           <li><a  href="javascript:void(0);"  onclick="togle_page('report/page/report1','report_link')"  style="text-align: left;">report 1</a></li>
                          <li><a  href="javascript:void(0);"  onclick="togle_page('report/page/report2','report_link')"  style="text-align: left;">report 2</a></li>
                          <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report3','report_link')"  style="text-align: left;">report 3</a></li>
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
                         </ul>
                      </li>
                      </c:if>
                       <li class="dropdown" id="user_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${myUser.fullName}<b class="caret"></b></a>
                      	<ul class="dropdown-menu">
                      	<c:if test="${isManageUser}">
                      	   <li><a href="javascript:void(0);" onclick="togle_page('dispatcher/page/user_search','user_link')" style="text-align: left;">Manage User</a></li>
                      	</c:if>
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
     	<div id="_content" class="span10 offset1"> 
      	</div>
    </div> 
  </div>  
</body>
</html>


