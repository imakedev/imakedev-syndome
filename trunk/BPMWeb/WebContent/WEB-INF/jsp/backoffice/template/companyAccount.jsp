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
				  url: "company/account/"+$("#_maId").val()+"/contacts",
				  cache: false
				 // data: { name: "John", location: "Boston" }
				}).done(function( data ) {
					if(data!=null){
						appendContentWithId(data,"tabs-3")
						// $("#tabs-3").html(data);
					  }
				});
			  $("#tabs-4").html("");
			  $("#tabs-3_1").html("");
			 }
		   }else if(ui.index==3){
				 // /exam/{meId}/questions
				// alert("test/exam/"+$("#_meId").val()+"/questions");
				 if($("#_maId").val().length>0){
				  $.ajax({
					  type: "get",
					  url: "company/item/unit/"+$("#_maId").val(),
					  cache: false
					 // data: { name: "John", location: "Boston" }
					}).done(function( data ) {
						if(data!=null){
							appendContentWithId(data,"tabs-4");
							// $("#tabs-3").html(data);
						  }
					});
				  $("#tabs-3").html("");
				  $("#tabs-3_1").html("");
				 }
				
			   }else  if(ui.index==2){
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
					  $("#tabs-4").html("");
					 }
					
				   }else{
			   $("#tabs-3").html("");
			   $("#tabs-4").html("");
			   $("#tabs-3_1").html("");
		   }
		});
	/* $("#maContactBirthDate" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" 
	});  */
	var _company_section=$("#_company_section").val().length>0?parseInt($("#_company_section").val()):5;
	//$('#tabs').tabs('select', parseInt($("#_company_section").val())-3);
	$('#tabs').tabs('select', _company_section-5);
	
	new AjaxUpload('company_upload', {
		 action: 'upload/companyLogo/${companyForm.missAccount.maId}',
		onSubmit : function(file , ext){
            // Allow only images. You should add security check on the server-side.
			if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
				this.setData({
					'key': 'This string will be send with the file',
					'test':'chatchai'
				});					
				$('#company_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only images are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			var obj = jQuery.parseJSON(response); //obj.hotlink			
			$("#company_photo").attr("src","getfile/companyLogo/${companyForm.missAccount.maId}/"+obj.hotlink);
		}		
	});
	
	 
});
function doAction(action,formID,sectionID){
	//alert($("#maCustomizePassMessage").val());
	$("#maAddress").val(CKEDITOR.instances["maAddress"].getData());
	$("#maCustomizePassMessage").val(CKEDITOR.instances["maCustomizePassMessage"].getData());
	$("#maCustomizeRejectMessage").val(CKEDITOR.instances["maCustomizeRejectMessage"].getData());
	$("#maCustomizeRetestMessage").val(CKEDITOR.instances["maCustomizeRetestMessage"].getData());
	//alert($("#maCustomizePassMessage").val());
	//$("#_miss_section").val(sectionID);
	$.post("company/"+action+"/"+sectionID,$("#"+formID).serialize(), function(data) {
		    appendContent(data);
		});
  }
function _getTheme(obj){ 
	$.get("company/theme/${companyForm.missAccount.maId}/"+obj.value, function(data) {
		
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
			$("#tabs-5").attr("style","background: url("+_path+"resources/images/"+_data.mtWaterWall+") no-repeat scroll right top "+_data.mtBgColor);
			 
			 
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
   <input type="hidden" id="_maId" name="_maId" value="${companyForm.missAccount.maId}"/>
   <input type="hidden" id="_company_section" name="_company_section" value="${companyForm.missAccount.section}"/>
            <div id="tabs">
			<ul>
			<!-- 	<li><a href="#tabs-1">Account</a></li> -->
				<li><a href="#tabs-2"><spring:message code="tab_profile"/></a></li>
				<li><a href="#tabs-3"><spring:message code="tab_contact"/></a></li>
				<li><a href="#tabs-3_1"><spring:message code="tab_role"/></a></li>
				<li><a href="#tabs-4"><spring:message code="tab_unit"/></a></li>
				<li><a href="#tabs-5"><spring:message code="tab_customize"/></a></li>
			</ul>
			<%-- <div id="tabs-1">
			<form:form  id="companyForm_account" name="companyForm_account" modelAttribute="companyForm" cssClass="well"  method="post" action="">
			  <fieldset style="font-family: sans-serif;">   
	     <h6><strong>Company - Account</strong></h6> 
			    <table border="0" width="100%" style="font-size: 12px">
   		 			<tr>
    					<td width="25%">&nbsp;</td>
    					<td width="50%" colspan="2">Username&nbsp;&nbsp;:&nbsp;&nbsp;
    					<form:input path="missAccount.maUsername"/>
    					</td>
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td width="25%">&nbsp;</td>
    					<td width="50%" colspan="2">Password&nbsp;&nbsp;:&nbsp;&nbsp;
    						<form:password path="missAccount.maPassword"/>
    					</td>
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td colspan="4" align="center">
    					</td> 
    				</tr>
    			</table>    
    			</fieldset>			
			</form:form>
			<div align="center"><a class="btn btn-primary"  onclick="doAction('action','companyForm_account','4')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			    </div> --%>
			<div id="tabs-2" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
			<form:form  id="companyForm_profile" name="companyForm_profile" modelAttribute="companyForm"  method="post" action="">
			  <fieldset style="font-family: sans-serif;">   
	     <h6><strong>Company - Profile</strong></h6> 
	       <!-- <pre style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Company Profile</strong></td>
    				</tr>
   		 			<tr valign="top">
    					<td width="25%">Name:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missAccount.maName"/>
    					</td>
    					 <td width="25%" align="right" rowspan="2"></td>
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
    					<td width="50%" colspan="2">
    					<form:textarea path="missAccount.maAddress" cols="4" rows="4" id="maAddress"/>
    					<!-- <textarea cols="4" rows="4" id="company_editor11"></textarea> -->
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
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missAccount.maPhone"/>
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Fax:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missAccount.maFax"/>
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Email:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missAccount.maEmail"/>
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				 
    			</table>
    				<!-- </pre> -->
    			</fieldset>
		<!-- 	</form>
			<form class="well"> -->
			<%-- 
			 <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px">
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Contct Point Profile</strong></td>
    				</tr>
   		 			<tr valign="top">
    					<td width="25%">First-Lastname:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactName" cssStyle="width:120px"/>
    					&nbsp;
    					<form:input path="missAccount.maContactLastname" cssStyle="width:120px"/>
    					</td>
    					 <td width="25%" align="right" rowspan="8"><img src="<c:url value='/resources/images/photo.png'/>"/>
    					 <div align="right">
    					 <a id="company_photo" class="btn btn-mini"><i class="icon-picture"></i>&nbsp;Upload</a>
    					 </div></td>
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
    					<form:input path="maContactBirthDate"  id="maContactBirthDate" cssStyle="width: 75px"/>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Position:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactTitle"/>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Department:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactDepartment"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Phone:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactPhone"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Fax:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactFax"/>
    					</td>
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Email:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missAccount.maContactEmail"/>
    					</td>
    				</tr>
    			</table>
    			</pre>
    			--%> 
			<!-- </form> -->
			  </form:form> 
			<!-- <div align="center"><input type="button" class="btn" value="Save"/></div> -->
			<div align="center"><a class="btn btn-primary" onclick="doAction('action','companyForm_profile','5')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			</div>
			<div id="tabs-3" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
    		
    			</div>
    			<div id="tabs-3_1" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
    		 <%--   <fieldset style="font-family: sans-serif;">   
           <form:form  id="companyForm_role" name="companyForm_role" modelAttribute="companyForm" cssClass="well" cssStyle="border:2px solid #DDD" method="post" action="">
            <form:hidden path="mode"/>
            <form:hidden path="missAccount.maId" id="maId"/>
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong>Role Setting</strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="center" width="100%" colspan="6">&nbsp;Role name : 
	    					 <form:select path="rcId">
	    					 	<form:option  value="0" label="-- Select --"></form:option>
	    					 	 <form:options itemLabel="rcName" items="${roleContacts}" itemValue="rcId"/>
	    					  </form:select>
	    					  <form:select path="rcActionId" cssStyle="width:90px">
	    					 	 <form:option  value="0" label="List Role"></form:option>
	    					 	 <form:option  value="1" label="Add Role"></form:option>
	    					 	 <form:option  value="2" label="Edit Role"></form:option>
	    					 	 <form:option  value="3" label="Delete Role"></form:option> 
	    					  </form:select>&nbsp;&nbsp;
	    					  <a class="btn btn-primary"  onclick="doAction('action','companyForm_role','7')"><i class="icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Ok</span></a>
	    					</td>
	    					</tr>
	    					</table> 
	    					</form:form>
	    					 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox" id="rtIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="30%"><div class="th_class">Role</div></th> 
            		<th width="65%"><div class="th_class">Description</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${roleTypes}" var="roleType" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" name="rtIdCheckbox" value="${roleType.rtId}"/></td> 
            	<td>&nbsp;${roleType.role}</td>
            	<td>&nbsp;${roleType.roleDesc}</td>
          	</tr>
          	</c:forEach>
        </tbody>
      </table>
      
</fieldset>
<div align="center"><a class="btn btn-primary"  onclick="doAction('action','companyForm_role','7')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div> 
 --%>
    			</div>
    			
			<div id="tabs-4" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
		
			</div>
			<div id="tabs-5" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
			<form:form  id="companyForm_customize" name="companyForm_customize" modelAttribute="companyForm" 
			  method="post" action="">
			    <fieldset style="font-family: sans-serif;">   
	     <h6><strong>Company - Customize</strong></h6> 
			    <table border="0" width="100%" style="font-size: 12px">
			    	<!-- tr>
    					<td width="100%" colspan="4"><strong>Company Customize</strong></td>
    				</tr> -->
   		 			<tr valign="top">
    					<td width="25%">Logo:</td>
    					<td width="50%" colspan="2">
    					<c:if test="${not empty companyForm.missAccount.maCustomizeLogoHotlink}">
    						<img id="company_photo"  width="350" height="66" src="getfile/companyLogo/${companyForm.missAccount.maId}/${companyForm.missAccount.maCustomizeLogoHotlink}" />
    					</c:if>
    					<c:if test="${empty companyForm.missAccount.maCustomizeLogoHotlink}">
    						<img id="company_photo" width="350" height="66" src="<c:url value='/resources/images/logowebmc.png'/>"/>
    					</c:if>    					
    					<input  id="company_upload" type="button" value="Upload">(350px × 66px)
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_MISSCONSULT')">
    				<tr valign="top">
    					<td width="25%">Type:</td>
    					<td width="50%" colspan="2">
    					<form:select path="missAccount.maGrade">    				
    				    	<%-- <form:option value="0">-- Select Type --</form:option> --%>
    						<form:option value="1">Standard</form:option>
							<form:option value="2">Premium</form:option>
    					</form:select>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				</sec:authorize>
    				<sec:authorize access="!hasAnyRole('ROLE_ADMIN','ROLE_MANAGE_MISSCONSULT')">
    				<tr valign="top">
    					<td width="25%">Type:</td>
    					<td width="50%" colspan="2">
    					<form:select path="missAccount.maGrade" disabled="true">    				
    				    	<%-- <form:option value="0">-- Select Type --</form:option> --%>
    						<form:option value="1">Standard</form:option>
							<form:option value="2">Premium</form:option>
    					</form:select>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				</sec:authorize>
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
    					<img id="s2" width="350" height="66" src="<c:url value='/resources/images/${companyForm.missAccount.missTheme.mtSamePlePicture}'/>"/>
    				 </td>
    					 <td width="25%">&nbsp;
    					 <!-- <input type="button" class="btn" value="Apply"/> -->
    					 </td>
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
    					<!-- <img src=""/> -->
    					<form:select path="missAccount.maBackgroundColor">
    						<form:option value="240,240,240">Gray</form:option>
							<form:option value="253,253,253">White</form:option>
    					</form:select></td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    				--%>
    				<tr>
    					<td width="100%" colspan="4"><strong>Response Candidate</strong></td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4">Pass Message</td>
    				</tr>
    				<tr>
    					<td width="100%" colspan="4">
    					<!-- <textarea cols="4" rows="4" id="company_editor1"></textarea> -->
    						<form:textarea path="missAccount.maCustomizePassMessage" cols="4" rows="4" id="maCustomizePassMessage"/>
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
    					<td width="100%" colspan="4">
    					<form:textarea path="missAccount.maCustomizeRejectMessage" cols="4" rows="4" id="maCustomizeRejectMessage"/>
    					<!-- <textarea cols="4" rows="4" id="company_editor2"></textarea> -->
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
    					<td width="100%" colspan="4">
    					
    					<form:textarea path="missAccount.maCustomizeRetestMessage" cols="4" rows="4" id="maCustomizeRetestMessage"/>
    					<!-- <textarea cols="4" rows="4" id="maCustomizeRetestMessage"></textarea> -->
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
			<div align="center"><a class="btn btn-primary"  onclick="doAction('action','companyForm_customize','9')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			</div>
			
		</div>
		</fieldset>