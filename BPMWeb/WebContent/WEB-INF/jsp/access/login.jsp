<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="UTF-8" />
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
        <title>Login with PST</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta http-equiv="X-UA-Compatible" content="IE=7, IE=9"/>
        <meta name="description" content="Login and Registration Form with HTML5 and CSS3" />
        <%--   <meta name="keywords" content="html5, css3, form, switch, animation, :target, pseudo-class" />  --%>
        <meta name="author" content="IMake" />
       <%--  <link rel="shortcut icon" href="../favicon.ico">   --%>
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/demo.css'/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style3.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/animate-custom.css'/>" />
		<script  src="<c:url value='/resources/js/jquery-1.8.3.min.js'/>" type="text/javascript"></script>
		<script>
	$(document).ready(function() { 
		$.get("/bpm/checksession",function(data) {
			//var obj = data;//jQuery.parseJSON(data);
			//  alert(data);
			//  alert(window.location.href.indexOf("login\/"))
		//	wrapper var n=str.indexOf("welcome");
			//if(data!='anonymousUser' && window.location.href.indexOf("login\/")==-1){
				// alert(data)
			if(data!='anonymousUser'){
			//	alert("redirect")
				window.location.href="<c:url value='/'/>";
			}
			else{
				$("#login_body").slideDown("slow"); 
			}
			});
		});
		</script>
    </head>
    <body id="login_body" style="display: none">
    <c:url value="/j_spring_security_check" var="security_check"/>
        <div class="container">
            <!-- Codrops top bar -->
            <div class="codrops-top">
                  <br/><br/>
              <!-- 
                <a href="">
                    <strong>&laquo; Previous Demo: </strong>Responsive Content Navigator
                </a>
             -->
                <span class="right">
             <!-- 
                    <a href=" http://tympanus.net/codrops/2012/03/27/login-and-registration-form-with-html5-and-css3/">
                        <strong>Back to the Codrops Article</strong>
                    </a>
                 -->
                </span>
                <div class="clr"></div>
            </div><!--/ Codrops top bar -->
            <header>
               <!-- 
                <h1>Login and Registration Form <span>with HTML5 and CSS3</span></h1>
				<nav class="codrops-demos">
					<span>Click <strong>"Join us"</strong> to see the form switch</span>
					<a href="index.html">Demo 1</a>
					<a href="index2.html">Demo 2</a>
					<a href="index3.html" class="current-demo">Demo 3</a>
				</nav>
              -->
                  <img src="<c:url value='/resources/images/logo.png'/>" />
            </header>
            <section>				
                <div id="container_demo" >
                    <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
                    <a class="hiddenanchor" id="toregister"></a>
                      <!-- 
                    <a class="hiddenanchor" id="tologin"></a>
                     
					<div align="center">dd</div>
					--><div align="center">${message}</div>
                    <div id="wrapper">
                        <div id="login" class="animate form">
                            <form  id="form" name="form" method="post" action="${security_check}" autocomplete="on"> 
                                <h1>Log in</h1> 
                                <p> 
                                    <label for="username" class="uname" data-icon="u" > Your username </label> 
                                    <input id="username" name="j_username" required="required" type="text" placeholder="myusername or mymail@mail.com"/>
                                </p>
                                <p> 
                                    <label for="password" class="youpasswd" data-icon="p"> Your password </label> 
                                    <input id="password" name="j_password" required="required" type="password" placeholder="eg. X8df!90EO" /> 
                                </p>
                                <p class="keeplogin"> 
									<!-- <input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" /> 
									 <label for="loginkeeping">
                                   Keep me logged in </label>
                                     --> 
								</p>
                                <p class="login button"> 
                                    <input type="submit" value="Login" /> 
								</p>
                                <p class="change_link">
                                    <!-- 
									Not a member yet ?
									<a href="#toregister" class="to_register">Join us</a>
                                    -->
								</p>
                            </form>
                        </div>

                        <div id="register" class="animate form">
                            <form  action="mysuperscript.php" autocomplete="on"> 
                                <h1> Sign up </h1> 
                                <p> 
                                    <label for="usernamesignup" class="uname" data-icon="u">Your username</label>
                                    <input id="usernamesignup" name="usernamesignup" required="required" type="text" placeholder="mysuperusername690" />
                                </p>
                                <p> 
                                    <label for="emailsignup" class="youmail" data-icon="e" > Your email</label>
                                    <input id="emailsignup" name="emailsignup" required="required" type="email" placeholder="mysupermail@mail.com"/> 
                                </p>
                                <p> 
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="passwordsignup" name="passwordsignup" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p> 
                                    <label for="passwordsignup_confirm" class="youpasswd" data-icon="p">Please confirm your password </label>
                                    <input id="passwordsignup_confirm" name="passwordsignup_confirm" required="required" type="password" placeholder="eg. X8df!90EO"/>
                                </p>
                                <p class="signin button"> 
									<input type="submit" value="Sign up"/> 
								</p>
                                <p class="change_link">  
									Already a member ?
									<a href="#tologin" class="to_register"> Go and log in </a>
								</p>
                            </form>
                        </div>
						
                    </div>
                </div>  
            </section>
        </div>
    </body>
</html>