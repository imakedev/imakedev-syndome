<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<html>
<head>
<title></title>  

<script type="text/javascript"
        src="<c:url value='/dwr/interface/MissExamAjax.js'/>"></script> 
<script type="text/javascript"
        src="<c:url value='/dwr/engine.js'/>"></script> 
<script type="text/javascript"
        src="<c:url value='/dwr/util.js'/>"></script>	
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.7.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" type="text/css">
<link type="text/css" href="<c:url value='/resources/css/custom-theme/jquery-ui-1.8.20.custom.css'/>" rel="stylesheet" /> 
<link rel="stylesheet" href="<c:url value='/resources/css/jquery.ui.selectmenu.css'/>" type="text/css">
<script type="text/javascript" src="<c:url value='/resources/js/jquery-ui-1.8.20.custom.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.ui.selectmenu.js'/>"></script>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.jstree.js'/>"></script>  <%--     
<script type="text/javascript" src="<c:url value='/resources/js/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/_lib/jquery.hotkeys.js'/>"></script>  --%> 
<%-- <link type="text/css" href="<c:url value='/resources/js/themes/default/style.css'/>" rel="stylesheet" />  --%>

<style>
.ui-widget { font-family: Trebuchet MS, Tahoma, Verdana,
 Arial, sans-serif; font-size: 12px;  }
 </style>
 <style type="text/css">
 /*  fieldset { width: 100%; }
  fieldset legend { width: 100%; }
  fieldset legend div { margin: 0.3em 0.5em; }
  fieldset .field { margin: 0.5em; padding: 0.5em; }
  fieldset .field label { margin-right: 0.4em; } */
</style>
<style type="text/css">
label,select,.ui-select-menu { float: left; margin-right: 10px; }
select { width: 200px; } 
/*.ui-widget{font-family: Tahoma;font-size: 12px; }*/
</style>
<script type="text/javascript">
/* $(function () {
	 $("#demo1").jstree({ 
			"json_data" : {
				"data" : [
					{ 
						"data" : "A node", 
						"metadata" : { id : 23 },
						"children" : [ "Child 1", "A Child 2" ]
					},
					{ 
						"attr" : { "id" : "li.node.id1" }, 
						"data" : { 
							"title" : "Long format demo", 
							"attr" : { "href" : "#" } 
						} 
					}
				]
			},
			"plugins" : [ "themes", "json_data", "ui" ]
		}).bind("select_node.jstree", function (e, data) { alert(data.rslt.obj.data("id")); });
}); */
$(document).ready(function() {
	$('#tabs').tabs();
  //   $("fieldset.collapsibleClosed").collapse( { closed : true } );
  $('select#bpgGroupId').selectmenu({style:'dropdown'});
//  http://localhost:8080/MISSExamBackOffice/resources/js/themes/;jsessionid=0417888C3FB24BAFB9C2FC46A841E0DAdefault/style.cssFailed to load resource: the server responded with a status of 404 
  $.jstree._themes = "/MISSExamBackOffice/resources/js/themes/";
    $("#demo1").jstree({ 
		"json_data" : {
			"data" : [
				{ 
					"attr" : { "id" : "aoe1" }, 
					"data" : {title:"Home",icon : "<c:url value='/resources/js/_demo/file.png'/>" },
					"metadata" : { id : 23 },
					 
				},
				{ 
					"attr" : { "id" : "aoe2" }, 
					"data" : { 
						"title" : "บัญชีผู้ใช้", 
						"attr" : { "href" : "#" } ,
						icon : "<c:url value='/resources/js/_demo/file.png'/>"
					},
					"metadata" : { id : "aoe2"},
					"children" : [
						{ attributes: { id : "pjson_2" }, data: { title : "Miss", icon : "<c:url value='/resources/js/_demo/file.png'/>" },"attr" : { "id" : "24"},"metadata" : { id : "24"} },
						{ attributes: { id : "pjson_3" }, data: {title:"Company",attributes:{ "href" : "www.google.com" } , icon : "<c:url value='/resources/js/_demo/file.png'/>"},"metadata" : { id : 25 } },
						{ attributes: { id : "pjson_4" }, data: { title:"Candidate", icon : "<c:url value='/resources/js/_demo/file.png'/>"} }
					          ] 
					
				},
				{ 
					"attr" : { "id" : "li.node.id3" }, 
					"data" : { 
						"title" : "Result Report", 
						"attr" : { "href" : "www.google.com" } ,
						icon : "<c:url value='/resources/js/_demo/file.png'/>"
					},
					"children" : [
						{ attributes: { id : "pjson_5" }, data: { title : "EPT",  icon : "<c:url value='/resources/js/_demo/file.png'/>"} },
						{ attributes: { id : "pjson_6" }, data: {title:"EPT Plus",attributes:{ "href" : "www.google.com" },  icon : "<c:url value='/resources/js/_demo/file.png'/>"},"metadata" : { id : 25 } },
						{ attributes: { id : "pjson_7" }, data: {title: "..." , icon : "<c:url value='/resources/js/_demo/file.png'/>"} }
					          ] 
					
				},
				{ 
					"attr" : { "id" : "li.node.id4" }, 
					"data" : { 
						"title" : "จัดการแบบสอบถาม", 
						"attr" : { "href" : "www.google.com" } ,
						icon : "<c:url value='/resources/js/_demo/file.png'/>"
					},
					"children" : [
						{ attributes: { id : "pjson_5" }, data: { title : "Series",  icon : "<c:url value='/resources/js/_demo/file.png'/>" } },
						{ attributes: { id : "pjson_6" }, data: {title:"Test",attributes:{ "href" : "www.google.com" }, icon : "<c:url value='/resources/js/_demo/file.png'/>" },"metadata" : { id : 25 } }
					          ] 
					
				},
				{ 
					"attr" : { "id" : "li.node.id5" }, 
					"data" : { 
						"title" : "etc.", 
						"attr" : { "href" : "www.google.com" },
						icon : "<c:url value='/resources/js/_demo/file.png'/>"
					},
					"children" : [
						{ attributes: { id : "pjson_5" }, data: { title : "Download",  icon : "<c:url value='/resources/js/_demo/file.png'/>" } }
						
					          ] 
					
				}
			]
		},
		"plugins" : [ "themes", "json_data", "ui" ],
		"auto_save":false
	}).bind("select_node.jstree", function (e, data) {
		alert(data.rslt.obj.data("id"));
	 //	alert(data.rslt.obj.data("id"));
	//	alert("e="+e);
	//	alert("data="+data);
	//	alert("href="+data.rslt.obj.data("href")); 
		});   
});
function callAjax(){
		var id="1";
		$.get('ajax/search', function(data) {
			   alert(data);
			});
}
</script>
</head>
<body>
 <div class="container-fluid">
    <div class="row-fluid">
    	<div class="span12" align="center">
    	
    	 <div class="alert alert-error">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Warning!</strong> Best check yo self, you're not looking too good.
    </div>
    	    <div class="alert">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Warning!</strong> Best check yo self, you're not looking too good.
    </div>
     <div class="alert alert-info">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Heads up!</strong> Best check yo self, you're not looking too good.2
    </div>
     <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Success!</strong> Best check yo self, you're not looking too good.2
    </div>
       <form>
       <select name="bpsGroupId" id="bpgGroupId">
											<%--
											<option value="0">---Select Category--</option>
											
											 --%>
											 <option value="0">---Select Category--</option>
												
	    					</select>
       </form>
    	<!-- <fieldset class="collapsible">
<legend>Can Collapse Me!</legend>
  <h2>1914 translation by H. Rackham</h2>
  <p>"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment...,"</p>
</fieldset> -->
    	<table width="100%">
    	<tr>
    			  <td width="15%">
    			  <%--
    			  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="149" height="71">
                    <param name="movie" value="http://www.missconsult.com/jobexpertweb/images/logo.swf" />
                    <param name="quality" value="high" />
                    <embed src="http://www.missconsult.com/jobexpertweb/images/logo.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="149" height="71"></embed>
                  </object>
                   --%></td>
                   
                  <td width="80%"><div align="left">
                  <%-- <img src="http://www.missconsult.com/jobexpertweb/images/text.jpg" width="407" height="32" />
                   --%>
                  </div></td>
                  <td width="5%"><div align="left">system time</div></td>
                </tr>
             </table>
    	<fieldset>
		<legend>ทดสอบ2</legend> 
    	Test ${aoe} ทดสอบ
<input type="button" onclick="callAjax()" value="aoe"/>
    	</fieldset></div>
    </div>
    	<div class="row-fluid"> 
	    <div class="span2">
	    <!--Sidebar content--> 
		 
	    <span id="demo1"></span>
	   
	    </div>
	    <div class="span8">
	    <!--Body content-->
	    <fieldset> 
<table class="table table-striped table-bordered table-condensed">
        <thead>
          <tr>
            <th>Student-ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Grade</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>001</td>
            <td>Rammohan </td>
            <td>Reddy</td>
            <td>A+</td>
          </tr>
          <tr>
            <td>002</td>
            <td>Smita</td>
            <td>Pallod</td>
            <td>A</td>
          </tr>
          <tr>
            <td>003</td>
            <td>Rabindranath</td>
            <td>Sen</td>
            <td>A+</td>
          </tr>
        </tbody>
      </table>
      </fieldset>
<br/>
	 <ul id="myTab" class="nav nav-tabs">
            <li class="active"><a href="#home" data-toggle="tab">Home</a></li>
            <li><a href="#profile" data-toggle="tab">Profile</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#dropdown1" data-toggle="tab">@fat</a></li>
                <li><a href="#dropdown2" data-toggle="tab">@mdo</a></li>
              </ul>
            </li>
          </ul>
 <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="home">
              <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
            </div>
            <div class="tab-pane fade" id="profile">
              <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.</p>
            </div>
            <div class="tab-pane fade" id="dropdown1">
              <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
            </div>
            <div class="tab-pane fade" id="dropdown2">
              <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>
            </div>
          </div>
          <h2 class="demoHeaders">Tabs</h2> 
		<fieldset>
		<legend>Test</legend>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">First</a></li>
				<li><a href="#tabs-2">Second</a></li>
				<li><a href="#tabs-3">Third</a></li>
			</ul>
			<div id="tabs-1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
			<div id="tabs-2">Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.</div>
			<div id="tabs-3">Nam dui erat, auctor a, dignissim quis, sollicitudin eu, felis. Pellentesque nisi urna, interdum eget, sagittis et, consequat vestibulum, lacus. Mauris porttitor ullamcorper augue.</div>
		</div>
		</fieldset>
		    <div class="pagination">
    <ul>
    <li><a href="#">Prev</a></li>
    <li class="active">
    <a href="#">1</a>
    </li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">Next</a></li>
    </ul>
    </div>
    <ul class="dropdown-menu">
    <li>aoe</li>
    <li>aoe2</li> 
    </ul> 
	    </div>
  <div class="span2">
	    <!--Sidebar content-->
	        <blockquote>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis.</p>
    <small>Someone famous</small>
    </blockquote>

	    
	    <ul class="unstyled">
	      <li>unstyled1</li>
	    <li>unstyled2</li>
	    </ul>
	     <ol>
	    <li>a1</li>
	    <li>a2</li>
	    </ol>
	    <ul>
	    <li>a1</li>
	    <li>a2</li>
	    </ul>
	    <dl class="dl-horizontal">
	    aoeee 
	    </dl>
	        <pre>
    &lt;p&gt;Sample text here...&lt;/p&gt;
    </pre>
        <pre class="prettyprint
    linenums">
    &lt;p&gt;Sample text here2...&lt;/p&gt;
    </pre>
	    <form class="well">
    <input type="text" class="input-small" placeholder="Email">
    <input type="password" class="input-small" placeholder="Password">
    <label class="checkbox">
    <input type="checkbox"> Remember me
    </label>
    <button type="submit" class="btn">Sign in</button>
    </form>
	    </div>
	 </div>
    </div>

</body>
</html>