<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Miss Consult</title>
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon" />
<script  src="<c:url value='/resources/js/jquery-1.7.2.min.js'/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/resources/js/smoothness/jquery-ui-1.8.21.custom.min.js'/>"></script>
<link href="<c:url value='/resources/css/smoothness/jquery-ui-1.8.21.custom.css'/>" type="text/css"  rel="stylesheet" /> 
<link  href="<c:url value='/resources/css/style.css'/>"  type="text/css" rel="stylesheet"/>
<style type="text/css">
.content_box_top { 
	background: url(<c:url value='/resources/images/content_top.png'/>) no-repeat; 
}
</style>
<script type="text/javascript">
function goHome(){
	window.location.href="<c:url value='/todolist'/>";
}
$(document).ready(function() {
	if($("#_message").val().length>0){ 
		//$("#_message_show").html($("#_message").val())
		$( "#dialog-Message" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Ok": function() { 
					$( this ).dialog( "close" );
					 
				}
			}
		   //,
			//close: function(event, ui) {  window.location.href="<c:url value='/logout'/>"; }
		});
	}
});
</script>
</head>

<body>
<c:url value="/j_spring_security_check" var="security_check"/>
 <div id="dialog-Message" title="Message" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	<span id="_message_show">${message}</span>
</div>
<div id="wrapper">
<div align="left" style="padding-top:5px;"><a href="#" title="Miss Consult"><img src="<c:url value='/resources/images/logowebmc.png'/>"  border="0"/></a></div>
<div align="right" class="language" style="padding-top:10px; padding-right:10px;"><a  style="cursor: pointer;" href="?language=th_TH">TH</a> | <a  style="cursor: pointer;" href="?language=en">EN</a></div>
 <div class="content_box_top"></div>
        <div class="content_box">
          <div style="border-bottom:1px dashed #999; padding-bottom:3px;"><h2>Welcome to MissConsult</h2></div>                   
          <p><em>The Professional Psychometric Test and People Development Provider.</em></p>
                   
        <div  style="padding-bottom:10px;">                       
           <div id="stylized" class="loginform">
            <form id="form" name="form" method="post" action='${security_check}'>
            <input type="hidden" id="_message" value="${message}"/>
            <h1>Login form</h1>
            <p>Only MissConsult members</p>
            
            <label>Username</label>
            <input type="text" name="j_username" id="name" />        
                        
            <label>Password
           <!--  <span class="small">Min. size 6 chars</span> -->
            </label>
            <input type="password" name="j_password" id="password" />
            <label>&nbsp;</label>
           <!--   <input name="submit" type="submit" value="Log-in"/> -->
              <button type="submit">Log-in</button>
           <!--  <a href="#">Forget Password?</a> -->
            <div class="spacer"></div>
            
            </form>
          </div>
                        
          </div>
                  <div class="cleaner"></div>
  </div>
	<div class="content_box_bottom"></div>
    <div class="footer">©2012 MISSCONSULT ALL RIGHTS RESERVED</div>
</div>       
</body>
</html>
