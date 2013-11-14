<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.servletapi.*" %>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_MISSCONSULT')" var="isManageMC"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_COMPANY')" var="isManageCompany"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_CANDIDATE')" var="isManageCandidate"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_SEARCH_REPORT')" var="isManageSearchReport"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_SERIES')" var="isManageSeries"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_TEST')" var="isManageTest"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_DOWNLOAD')" var="isManageDownload"/>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_MISSCONSULT_REPORT_MANAGEMENT')" var="isManageReportManagement"/> 
<sec:authentication var="myUser" property="principal.myUser"/> 
<html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
<title>PST BackOffice</title>
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
 
<style>
.ui-widget { font-family: Trebuchet MS, Tahoma, Verdana,
 Arial, sans-serif; font-size: 12px; }
 </style>
<style type="text/css"> 
.th_class{text-align: center;
}
a{cursor: pointer;}
</style> 

<script  src="<c:url value='/resources/js/jquery-1.8.3.min.js'/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/resources/js/smoothness/jquery-ui-1.9.1.custom.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>" type="text/javascript"></script>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/PSTAjax.js"></script>
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
	$('#tabs').tabs();
	$('#tabs > ul > li > a').css("width","70px"); 
		 
	//loadDynamicPage("employee/init");
	togle_page('employeeWorkMapping/init','employee_link');
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
            <td><span style="padding: 10px"></span> 
            </td>
            <td>
             <div class="navbar" style="float:right;position: relative;top: 8px">
              <div class="navbar-inner">
                <div class="container"> 
                  <div class="nav-collapse collapse navbar-responsive-collapse">
                    <ul class="nav"> 
                      <li id="employee_link"><a onclick="togle_page('employeeWorkMapping/init','employee_link')">To-do-list</a></li>
                      <li  id="job_link"><a onclick="togle_page('job/init','job_link')">แจ้งซ่อม</a></li>
                      <li id="breakdown_link"><a onclick="togle_page('breakdown/init','breakdown_link')">ส่งเครื่องใหม่/ติดตั้ง</a></li>
                      <li id="costs_link"><a onclick="togle_page('costs/init','costs_link')">PM/MA</a></li> 
                     <li class="dropdown" id="report_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report<b class="caret"></b></a>
                      	<ul class="dropdown-menu"> 
                           <li><a  href="javascript:void(0);"  onclick="togle_page('report/page/report1','report_link')"  style="text-align: left;">สรุปค่าแรงพนักงานรายวัน</a></li>
                          <li><a  href="javascript:void(0);"  onclick="togle_page('report/page/report2','report_link')"  style="text-align: left;">สรุปค่าคิวประจำคน</a></li>
                          <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report3','report_link')"  style="text-align: left;">รายงานการออกงานประจำวัน</a></li>
                          <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report4','report_link')"  style="text-align: left;">สถิติเบรคดาวน์ประจำเดือน</a></li>
                           <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report5','report_link')"  style="text-align: left;">รายงานสรุปคิวคอนกรีตประจำเดือน</a></li>
                           <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report6','report_link')"  style="text-align: left;">รายงานเงินประเมิณประจำเดือน</a></li>
                            <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report7','report_link')"  style="text-align: left;">รายงานคะแนนประเมิณประจำเดือน</a></li>
                             <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report8','report_link')"  style="text-align: left;">สรุปยอดรหัสการจ่ายประจำเดือน</a></li>
                             <li><a  href="javascript:void(0);" onclick="togle_page('report/page/report9','report_link')"  style="text-align: left;">รายงานสรุปค่าคิวรถออกงานประจำเดือน</a></li>
                         </ul>
                      </li> 
                       <li class="dropdown" id="maintenance_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Setting<b class="caret"></b></a>
                      	<ul class="dropdown-menu"> 
                          <li><a href="javascript:void(0);"  onclick="togle_page('maintenance/page/maintenance_roadpump_search','maintenance_link')" style="text-align: left;">ตรวจสภาพรถ</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('department/init','maintenance_link')"  style="text-align: left;">จัดการแผนก</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('workType/init','maintenance_link')"  style="text-align: left;">จัดการประเภทงาน</a></li>
                          <li><a href="javascript:void(0);" onclick="togle_page('maintenance/page/maintenance_check_search','maintenance_link')"  style="text-align: left;">จัดการตรวจเช็ค</a></li>
                         </ul>
                      </li>
                       <li class="dropdown" id="user_link"> 
                      	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${myUser.fullName}<b class="caret"></b></a>
                      	<ul class="dropdown-menu">
                      	   <li><a href="javascript:void(0);" onclick="togle_page('user/init','user_link')" style="text-align: left;">จัดการ User</a></li>
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
     	<div id="_content" class="span8 offset2"> 
      	</div>
    </div> 
  </div>  
</body>
</html>


