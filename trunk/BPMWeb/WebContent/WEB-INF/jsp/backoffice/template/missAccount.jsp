<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	$('#tabs').tabs();
	$('#tabs').bind('tabsselect', function(event, ui) {
		if(ui.index==1){
			 // /exam/{meId}/questions
			// alert("test/exam/"+$("#_meId").val()+"/questions");
			 if($("#_maId").val().length>0){
			  $.ajax({
				  type: "get",
				  url: "miss/account/"+$("#_maId").val()+"/contacts",
				  cache: false
				 // data: { name: "John", location: "Boston" }
				}).done(function( data ) {
					if(data!=null){
						appendContentWithId(data,"tabs-3");
						// $("#tabs-3").html(data);
					  }
				});
			  $("#tabs-3_1").html("");
			 }
			
		   } else  if(ui.index==2){
				 // /exam/{meId}/questions
				// alert("test/exam/"+$("#_meId").val()+"/questions");
				 if($("#_maId").val().length>0){
				  $.ajax({
					  type: "get",
					  url: "role/"+$("#_maId").val(),
					  cache: false
					 // data: { name: "John", location: "Boston" }
					}).done(function( data ) {
						if(data!=null){
							appendContentWithId(data,"tabs-3_1");
							// $("#tabs-3").html(data);
						  }
					});
				  $("#tabs-3").html("");
				 }
				
			   } else{
			   $("#tabs-3").html("");
			   $("#tabs-3_1").html("");
		   }
		});
	$("#maContactBirthDate" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	//alert(parseInt($("#_miss_section").val()))
	$('#tabs').tabs('select', parseInt($("#_miss_section").val())-1);
	
	//$tabs.tabs('select', 2);
	/* var $tabs = $('#example').tabs();
	var selected = $tabs.tabs('option', 'selected'); // => 0 */
	/* //getter
	var selected = $( ".selector" ).tabs( "option", "selected" );
	//setter
	$( ".selector" ).tabs( "option", "selected", 3 ); */
	//getPhoto('','');
	
	new AjaxUpload('mc_upload', {
		 action: 'upload/mcLogo/${missForm.missAccount.maId}',
		onSubmit : function(file , ext){
           // Allow only images. You should add security check on the server-side.
			if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
				this.setData({
					'key': 'This string will be send with the file',
					'test':'chatchai'
				});					
				$('#mc_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only images are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			//alert(response)
			var obj = jQuery.parseJSON(response); //obj.hotlink
			$("#mc_photo").attr("src","getfile/mcLogo/${missForm.missAccount.maId}/"+obj.hotlink);
		}		
	});
});
function getPhoto(_id,_hotlink){
	if(_id!=null && _id.length>0 
			&& _hotlink!=null && _hotlink.length>0)
		$("#miss_photo").attr("src","getfile/missAccount/"+_id+"/"+_hotlink)
	
}
 
function _getTheme(obj){
	// alert(obj.value);
	//alert($("body").css("background-image"));
	
//	$("body").css("background-image","url(/MISSExamBackOffice/resources/images/body-theme1.gif)");
/* /usr/local/data/BACK_UP/Work/Server/apache-tomcat-7.0.27/webapps/MISSExamBackOffice/resources/images/gray.jpg
  /usr/local/data/BACK_UP/Work/Server/apache-tomcat-7.0.27/webapps/MISSExamBackOffice/resources/images/blue1.jpg
  */
  <%-- 
   if(obj.value=='1'){
		$("body").css("background-image","url(<c:url value='/resources/images/body-theme4.gif'/>)");
		$("#s2").attr("src","<c:url value='/resources/images/gray.jpg'/>");
   }else if(obj.value=='2'){
	   $("body").css("background-image","url(<c:url value='/resources/images/body-theme2.gif'/>)");
	   $("#s2").attr("src","<c:url value='/resources/images/blue1.jpg'/>");
   }
   --%>
	$.get("miss/theme/${missForm.missAccount.maId}/"+obj.value, function(data) {
		
		 	var _data = jQuery.parseJSON(data);		
		 //   alert($("#_navi_element"))
		 //	  alert(_data.mtLogo);
		 //   alert($("#"))
		 
		 $("#_navi_element").css("background-color",_data.mtBgColor );
			$("body").css("background-image", "url("+_path+"resources/images/"+_data.mtLogo+")");
			$("#s2").attr("src", _path+"resources/images/"+_data.mtSamePlePicture);
			$("#tabs-2").attr("style","background: url("+_path+"resources/images/"+_data.mtWaterWall+") no-repeat scroll right top "+_data.mtBgColor);
			$("#tabs-3").attr("style","background: url("+_path+"resources/images/"+_data.mtWaterWall+") no-repeat scroll right top "+_data.mtBgColor);
			$("#tabs-3_1").attr("style","background: url("+_path+"resources/images/"+_data.mtWaterWall+") no-repeat scroll right top "+_data.mtBgColor);
			$("#tabs-4").attr("style","background: url("+_path+"resources/images/"+_data.mtWaterWall+") no-repeat scroll right top "+_data.mtBgColor);
			
			 
	});
}
function doAction(action,formID,sectionID){
	/* $("#mode").val(mode);
	if(mode!='search'){
		$("#msId").val(id);
	}else{
		$("#msId").val("0");
	} */
	//alert(CKEDITOR.instances["maAddress"].getData());
	$("#maAddress").val(CKEDITOR.instances["maAddress"].getData());
	$("#maCustomizePassMessage").val(CKEDITOR.instances["maCustomizePassMessage"].getData());
	$("#maCustomizeRejectMessage").val(CKEDITOR.instances["maCustomizeRejectMessage"].getData());
	$("#maCustomizeRetestMessage").val(CKEDITOR.instances["maCustomizeRetestMessage"].getData());
	//alert($("#maAddress").val());
	//alert(action)
	//$("#_miss_section").val(sectionID);
	$.post("miss/"+action+"/"+sectionID,$("#"+formID).serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
  }
</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff;
} 
</style>
 <div class="alert alert-success" style="${display}">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
    </div>
<fieldset style="font-family: sans-serif;">  
<input type="hidden" id="_miss_section" name="_miss_section" value="${missForm.missAccount.section}"/>
 <input type="hidden" id="_maId" name="_maId" value="${missForm.missAccount.maId}"/>
<div id="tabs">
			<ul>
				<!-- <li><a href="#tabs-1">Account</a></li> -->
				<li><a href="#tabs-2"><spring:message code="tab_profile"/></a></li>
				<li><a href="#tabs-3"><spring:message code="tab_contact"/></a></li>
				<li><a href="#tabs-3_1"><spring:message code="tab_role"/></a></li>
				<li><a href="#tabs-4"><spring:message code="tab_customize"/></a></li>
			</ul>
			<%-- <div id="tabs-1">
			 <form:form  id="missForm_account" name="missForm_account" modelAttribute="missForm" cssClass="well"  method="post" action="">
			
			  <fieldset style="font-family: sans-serif;">   
	     <h6><strong>MissConsult - Account</strong></h6> 
			    <table border="0" width="100%" style="font-size: 12px">
   		 			<tr>
    					<td width="25%">&nbsp;</td>
    					<td width="50%" colspan="2">Username&nbsp;&nbsp;:&nbsp;&nbsp;admin</td>
    					 <form:hidden path="missAccount.maUsername" id="maUsername"/>
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td width="25%">&nbsp;</td>
    					<td width="50%" colspan="2">Password&nbsp;&nbsp;:&nbsp;&nbsp;
    					<form:password path="missAccount.maPassword" id="maPassword"/></td>
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td colspan="4" align="center">
    					</td> 
    				</tr>
    			</table>    
    			</fieldset>			
			</form:form>
				<div align="center"><a class="btn btn-primary" onclick="doAction('action','missForm_account','0')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			  </div> --%>
			<div id="tabs-2" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
		 <form:form  id="missForm_profile" name="missForm_profile" modelAttribute="missForm" method="post"
		  action="">
		 
		<!--   <form class="well"> -->
		
			  <fieldset style="font-family: sans-serif;">  
			    <h6><strong>MissConsult - Profile</strong></h6>  
			   <%-- 
			  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px;margin-top: 0px;border:2px solid #DDD;background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
	    --%>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Company Profile</strong></td>
    				</tr>
   		 			<tr valign="top">
    					<td width="25%">Name:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maName" id="maName"/>
    				<!-- 	<input type="text" width="100%" /> -->
    					</td>
    					 <td width="25%" align="right" rowspan="2">
    					<!--  <img id="miss_photo" width="128"  src=""/>
    					 <div align="right"><input  id="button2" type="button" value="Upload"></div> --></td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Industry Type:</td>
    					<td width="50%" colspan="2">
    					 <form:select path="missAccount.missIndustryMaster.mimId" cssStyle="background:#FFFFFF">    					 
    						<form:options items="${missIndustryMasterList}" itemLabel="mimName" itemValue="mimId"></form:options>
    					</form:select>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Address:</td>
    					<td width="50%" colspan="2"><form:textarea path="missAccount.maAddress" cols="4" rows="4" id="maAddress"/>
    					<script>
    					if (CKEDITOR.instances['maAddress']) {
    			            CKEDITOR.remove(CKEDITOR.instances['maAddress']);
    			         }
    					CKEDITOR.replace( 'maAddress',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					</td>
    					<!--  <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">Phone:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maPhone" id="maPhone"/>
    					<!-- <input type="text" width="100%" /> -->
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Fax:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maFax" id="maFax"/>
    					<!-- <input type="text" width="100%" /> -->
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Email:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maEmail" id="maEmail"/>
    					<!-- <input type="text" width="100%" /> -->
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				 
    			</table>
    			<%--
    			</pre>
    			 --%>
    			  </fieldset>
    			  <!-- </form> -->
			<%-- </form:form> --%>
				<!-- <form class="well"> -->
				 <%-- <form:form  id="missForm_profile2" name="missForm_profile2" modelAttribute="missForm" cssClass="well"  method="post" action=""> --%>
			<!--  <form class="well"> -->
			<%--
			  <fieldset style="font-family: sans-serif;">   
			  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px">
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Contct Point Profile</strong></td>
    				</tr>
   		 			<tr valign="top">
    					<td width="25%">First-Lastname:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactName" id="maContactName" cssStyle="width:120px"/>
    					&nbsp;
    					<form:input path="missAccount.maContactLastname" id="maContactLastname" cssStyle="width:120px"/>
    					</td>
    					 <td width="25%"  align="right"  rowspan="8">
    					 <img id="miss_photo" width="128"  src="<c:url value='/resources/images/photo.png'/>"/>
    					 <div align="right"><input  id="button2" type="button" value="Upload"></div>
    					 </td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Gender:</td>
    					<td width="50%" colspan="2">
    					<form:radiobutton path="missAccount.maContactGender" value="0"/>Female&nbsp;&nbsp;&nbsp;<form:radiobutton path="missAccount.maContactGender" value="1"/>Male
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Birth Date:</td>
    					<td width="50%" colspan="2">
    					<form:input path="maContactBirthDate" id="maContactBirthDate" cssStyle="width: 75px"/>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Position:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactTitle" id="maContactTitle"/>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Department:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactDepartment" id="maContactDepartment"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Phone:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactPhone" id="maContactPhone"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Fax:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactFax" id="maContactFax"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Email:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactEmail" id="maContactEmail"/>
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    			</table>
    			</pre>
    			</fieldset>
    			--%>
    			<!-- </form> -->
			  </form:form> 
			<%--
			<div align="center"><input type="button" class="btn" value="Save"/></div>
			 --%>
			<div align="center"><a class="btn btn-primary" onclick="doAction('action','missForm_profile','1')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			</div>
			<!-- <div id="tabs-3"> -->
			<div id="tabs-3" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
				
			<!-- <form class="well"> -->
    			
			
			</div>
			<div id="tabs-3_1" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
    			
			
			</div>
			
			<!-- <div id="tabs-4" style="background: url('/MISSExamBackOffice/resources/images/bg-water-theme1.gif') no-repeat scroll right top rgb(231, 231, 231)"> -->
			<div id="tabs-4" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			  
				<!-- <form class="well"> -->
				<%--  <form:form  id="missForm_customize" name="missForm_customize" modelAttribute="missForm" cssClass="well"  method="post" action=""> --%>
				 <form:form  id="missForm_customize" name="missForm_customize" modelAttribute="missForm"   method="post" action=""> 
				
			  <fieldset style="font-family: sans-serif;">   
	      <h6><strong>MissConsult - Customize</strong></h6> 
			    <table border="0" width="100%" style="font-size: 12px">
			    	<!-- <tr>
    					<td width="100%" colspan="4"><strong>MCConsult Customize</strong></td>
    				</tr> -->
   		 			<tr valign="top">
    					<td width="25%">Logo:</td>
    					<td width="50%" colspan="2"> 
    					<c:if test="${not empty missForm.missAccount.maCustomizeLogoHotlink}">
    						<img id="mc_photo"  width="350" height="66" src="getfile/mcLogo/${missForm.missAccount.maId}/${missForm.missAccount.maCustomizeLogoHotlink}" />
    					</c:if>
    					<c:if test="${empty missForm.missAccount.maCustomizeLogoHotlink}">
    						<img id="mc_photo" width="350" height="66" src="<c:url value='/resources/images/logowebmc.png'/>"/>
    					</c:if>
    					<div>
    					<input  id="mc_upload" type="button" value="Upload">(350px × 66px)
    					</div></td>
    					
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<%--
    				<tr valign="top">
    					<td width="25%">Theme Color:</td>
    					<td width="50%" colspan="2">
    					<form:select path="missAccount.maCustomizeHeadColor">
    						<form:option value="body.gif">Gray</form:option>
							<form:option value="body-b.gif">Blue</form:option>
							<form:option value="body-g.gif">Green</form:option>
							<form:option value="body-o.gif">Orange</form:option>
    					</form:select>
    					&nbsp;&nbsp;&nbsp;<form:select path="missAccount.maCustomizeColor">
    					    <form:option value="smoothness">Gray</form:option>
							<form:option value="redmond">Blue</form:option>
							<form:option value="le-frog">Green</form:option>
							<form:option value="ui-lightness">Orange</form:option>
    					</form:select>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Background:</td>
    					<td width="50%" colspan="2">
    					<form:select path="missAccount.maBackgroundColor">
    						<form:option value="240,240,240">Gray</form:option>
							<form:option value="253,253,253">White</form:option>
    					</form:select></td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				 --%>
    				<tr valign="top">
    					<td width="25%">Theme:</td>
    					<td width="50%" colspan="2">
    					<!-- <img src=""/> -->
    					<!-- <select id="aoe" onchange="testTheme(this)">
    						<option value="1">theme 1</option>
    						<option value="2">theme 2</option>
    					</select> --> 
    					
    					<form:select path="missAccount.missTheme.mtId" onchange="_getTheme(this)">
    					  <form:options items="${missThemes}" itemLabel="mtName" itemValue="mtId"></form:options>
    						<%-- <form:option value="1">Theme 1</form:option>
							<form:option value="2">Theme 2</form:option> --%>
    					</form:select>
    				 </td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%"> </td>
    					<td width="50%" colspan="2">
    					<!-- <img src=""/> --> 
    					<img id="s2" width="350" height="66" src="<c:url value='/resources/images/${missForm.missAccount.missTheme.mtSamePlePicture}'/>"/>
    				 </td>
    					 <td width="25%">&nbsp;
    					 <!-- <input type="button" class="btn" value="Apply"/> -->
    					 </td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4"><strong>Response Candidate</strong></td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4">Pass Message</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4"><form:textarea path="missAccount.maCustomizePassMessage" cols="4" rows="4" id="maCustomizePassMessage"/>
    					<%-- <c:out value="" escapeXml="false" /> --%>
    					<script>
    					if (CKEDITOR.instances['maCustomizePassMessage']) {
    			            CKEDITOR.remove(CKEDITOR.instances['maCustomizePassMessage']);
    			         }
    					CKEDITOR.replace( 'maCustomizePassMessage',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4">Reject Message</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4"><form:textarea path="missAccount.maCustomizeRejectMessage" cols="4" rows="4" id="maCustomizeRejectMessage"/>
    					<script>
    					if (CKEDITOR.instances['maCustomizeRejectMessage']) {
    			            CKEDITOR.remove(CKEDITOR.instances['maCustomizeRejectMessage']);
    			         }
    					CKEDITOR.replace( 'maCustomizeRejectMessage',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4">Retest Message</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4"><form:textarea path="missAccount.maCustomizeRetestMessage" cols="4" rows="4" id="maCustomizeRetestMessage"/>
    					<script>
    					if (CKEDITOR.instances['maCustomizeRetestMessage']) {
    			            CKEDITOR.remove(CKEDITOR.instances['maCustomizeRetestMessage']);
    			         }
    					CKEDITOR.replace( 'maCustomizeRetestMessage',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					</td>
    				</tr>
    			</table>
    			</fieldset>
			</form:form>
			<!-- <div align="center"><input type="button" class="btn" value="Save"/></div> -->
			<div align="center"><a class="btn btn-primary" onclick="doAction('action','missForm_customize','4')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			
			</div>
			
		</div>
		</fieldset>
	  