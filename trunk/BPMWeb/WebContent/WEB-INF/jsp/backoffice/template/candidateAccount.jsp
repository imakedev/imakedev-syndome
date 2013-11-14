<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	$('#tabs').tabs();
	/*
	$("#mcaBirthDate" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	*/
	$("#picker2").birthdaypicker({
         futureDates: true,
        // maxYear: 2020,
         maxAge: 90 ,
        // defaultDate: "10-17-1980"
         defaultDate: "${candidateForm.mcaBirthDate}"
       });
	 $('select[class="birth-month"]').css("width","70px");
	 $('select[class="birth-day"]').css("width","61px");
	 $('select[class="birth-year"]').css("width","63px");
	 $('fieldset[class="birthday-picker"]').css("padding","0px");
	// picker2.defaultDate="04-17-1983";
	// alert(picker2.defaultDate);
	var _candidate_section=$("#_candidate_section").val().length>0?parseInt($("#_candidate_section").val()):0;
	if(_candidate_section==2)
		_candidate_section=0;
	$('#tabs').tabs('select', _candidate_section);
	new AjaxUpload('candidate_upload', {
        action: 'upload/candidateImg/${candidateForm.missCandidate.mcaId}',
		onSubmit : function(file , ext){
            // Allow only images. You should add security check on the server-side.
			if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
				/* Setting data */
				this.setData({
					'key': 'This string will be send with the file',
					'test':'chatchai'
				});					 
			$('#candidate_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only images are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			//alert(response)
			var obj = jQuery.parseJSON(response);
			$("#candidate_photo").attr("src","getfile/candidateImg/${candidateForm.missCandidate.mcaId}/"+obj.hotlink);
			//$('#example2 .text').text('Uploaded ' + file);		
			//alert(file);
			//alert(response)
		
		}		
	});
});
function doReactivate(action,formID,sectionID){
	//$("#mode").val("reactivate");
	doAction(action,formID,sectionID);
}
function doAction(action,formID,sectionID){
	//alert($("#maCustomizePassMessage").val());
	/* $("#maAddress").val(CKEDITOR.instances["maAddress"].getData());
	$("#maCustomizePassMessage").val(CKEDITOR.instances["maCustomizePassMessage"].getData());
	$("#maCustomizeRejectMessage").val(CKEDITOR.instances["maCustomizeRejectMessage"].getData());
	$("#maCustomizeRetestMessage").val(CKEDITOR.instances["maCustomizeRetestMessage"].getData()); */
	//alert($("#maCustomizePassMessage").val());
	//$("#_miss_section").val(sectionID);
	if(formID=='candidateForm_profile'){
		$("#mcaBirthDate").val($("#birthdate").val());
	}
	$.post("candidate/"+action+"/"+sectionID,$("#"+formID).serialize(), function(data) {
		    appendContent(data);
		});
  }
function checkIndustryMaster(obj){
	
	//alert(obj.value)
	if(obj.value==999999999){
		$("#mimExt").css("display","block");
	}else
		$("#mimExt").css("display","none");
}
function checkID(id) 
{ 
	if(id.length != 13)
		return false; 
		for(i=0, sum=0; i < 12; i++) 
			sum += parseFloat(id.charAt(i))*(13-i); 
		if((11-sum%11)%10!=parseFloat(id.charAt(12))) 
	 		return false; 
	return true;
} 
function getCandidateInfo(){ 
	//
	//
	var mcaCitizenId=jQuery.trim($("#missCandidate\\.mcaCitizenId").val());
	var mcaEmail=jQuery.trim($("#missCandidate\\.mcaEmail").val());
	var haveError=false;
	var message="";
	if(!checkID(mcaCitizenId) && mcaCitizenId.length>0){
		message="รหัสประชาชนไม่ถูกต้อง";	
		haveError=true;		
	}else if(mcaEmail.length==0 && mcaCitizenId.length==0){
		message="กรุณากรอก รหัสประชาชน และ Email";
		haveError=true;
	}
	if(haveError){
		$("#_message_show").html(message);
		$( "#dialog-Message" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Ok": function() { 
					$( this ).dialog( "close" );
					 
				}
			}
		  });
	}else{ 
		//alert("xxx")
		$.ajax({
			  type: "get",
			  url: "candidate/getcandidateinfo?citizendID="+mcaCitizenId+"&email="+mcaEmail,
			  cache: false
			}).done(function( data ) {
				//alert(data)
				if(data!=null){  
					if(data.mcaId!=null){
						$("#missCandidate\\.mcaTitleType").val(data.mcaTitleType);
						$("#missCandidate\\.mcaFirstName").val(data.mcaFirstName);
						$("#missCandidate\\.mcaLastName").val(data.mcaLastName);
						//$("#missCandidate\\.mcaGender").val(data.mcaGender);
						 var mcaGenders=document.getElementsByName("missCandidate.mcaGender");
						for(var i=0;i<mcaGenders.length;i++){
							if(mcaGenders[i].value==data.mcaGender)
								mcaGenders[i].checked=true;
							else
								mcaGenders[i].checked=false;
						} 
						//alert(data.mcaBirthDate);
						if(data.mcaBirthDate!=null){
							//1983-04-17
							var birthDate=data.mcaBirthDate.split("-");
							$("select[name='birth\[day\]']").val(parseInt(birthDate[2]));
							$("select[name='birth\[month\]']").val(parseInt(birthDate[1]));
							$("select[name='birth\[year\]']").val(birthDate[0]);
						}
						/* $("select[name='birth\[day\]']").val(data.mcaTitleType);
						$("select[name='birth\[day\]']").val(data.mcaTitleType);
						$("select[name='birth\[day\]']").val(data.mcaTitleType); */
						$("#missCandidate\\.missCareerMaster\\.mcmId").val(data.missCareerMaster.mcmId);
						$("#missCandidate\\.mcaPosition").val(data.mcaPosition);
						$("#missCandidate\\.mcaDepartment").val(data.mcaDepartment);
						$("#missCandidate\\.mcaPhone").val(data.mcaPhone);
						//alert(data.missIndustryMaster.mimId)
						if(data.missIndustryMaster.mimId!=null)
							$("#missCandidate\\.missIndustryMaster\\.mimId").val(data.missIndustryMaster.mimId); 
						//alert(data.mcaPictureHotlink)
						if(data.mcaPictureHotlink!=null && data.mcaPictureHotlink.length>0) {
							$("#candidate_photo").attr("src","getfile/candidateImg/"+data.mcaId+"/"+data.mcaPictureHotlink);
							// update picture again 
							/* private String mcaPictureFileName; 
							private String mcaPicturePath; 
							private String mcaPictureHotlink; */							
						}
						
					}
					else
						alert("not have data");
				} 
			});
	}
}
/* function checkForm() 
{ if(!checkID(document.form1.txtID.value)) 
alert('รหัสประชาชนไม่ถูกต้อง'); 
else alert('รหัสประชาชนถูกต้อง เชิญผ่านได้');} 
*/
</script> 
<div id="dialog-Message" title="Message" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	<span id="_message_show"></span>
</div>
 <div class="alert alert-success" style="${display}">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
   <input type="hidden" id="_candidate_section" name="_candidate_section" value="${candidateForm.missCandidate.section}"/>
            <div id="tabs">
			<ul>
				<li><a href="#tabs-1">Account</a></li>
				<li><a href="#tabs-2">Profile</a></li>
			</ul>
			<div id="tabs-1" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
			<form:form  id="candidateForm_account" name="candidateForm_account" modelAttribute="candidateForm"  method="post" action="">
			 <form:hidden path="mode"></form:hidden>
			  <!-- <fieldset style="font-family: sans-serif;"> -->   
	      <h6><strong>Candidate - Account</strong></h6> 
			    <table border="0" width="100%" style="font-size: 12px">
   		 			<tr>
    					<td width="10%">&nbsp;</td>
    					<td width="10%" align="right">Username :</td>
    					 <td width="55%" >
    					 <form:input path="missCandidate.mcaUsername"/>
    					 <!-- <input type="text"/> -->
    					 </td>
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td width="10%">&nbsp;</td>
    					<td width="10%" align="right">Password :</td>
    					<td width="55%">
    					 <form:input path="missCandidate.mcaPassword"/>
    					<!-- <input type="password"/> -->
    					</td>
    					  					
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td width="10%">&nbsp;</td>
    					<td width="10%" align="right">Series :</td>
    					<td width="55%">
    					<c:if test="${candidateForm.missCandidate.mcaStatus=='1'}">
    					<form:select path="missCandidate.missSery.msId" disabled="true">
    						<%--  <form:option value="-1">-- Select Series --</form:option> --%>
    						 <form:options items="${missSeries}" itemLabel="msSeriesName" itemValue="msId"></form:options>
	    					     
    					</form:select>
    					</c:if>
    					<c:if test="${candidateForm.missCandidate.mcaStatus!='1'}">
    					<form:select path="missCandidate.missSery.msId">
    						<%--  <form:option value="-1">-- Select Series --</form:option> --%>
    						 <form:options items="${missSeries}" itemLabel="msSeriesName" itemValue="msId"></form:options>
	    					     
    					</form:select>
    					</c:if>
    					<!-- <select name="bpsGroupId" id="bpgGroupId"> 
											 <option value="0">Series1</option>
											 <option value="2">Series2</option>
	    					</select> -->
	    				</td>
    					  					
    					<td width="25%">&nbsp;</td>
    				</tr>
    				<tr>
    					<td colspan="4" align="center">
    					<!-- <input type="button" class="btn" value="Save"/>&nbsp;
    					<input type="button" class="btn" value="Delete"/>&nbsp;
    					<input type="button" class="btn" value="Reactivate"/>&nbsp; -->
    					</td> 
    				</tr>
    				 
    			</table>    
    			<!-- </fieldset>	 -->		
			</form:form>
			<div align="center"><a class="btn btn-primary" onclick="doAction('action','candidateForm_account','0')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>&nbsp;
			<%--
			<a class="btn btn-danger"><i class="icon-trash icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Delete</span></a>&nbsp;
			 --%>
			<a class="btn btn-info"  onclick="doReactivate('action','candidateForm_account','2')"><i class="icon-refresh icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Reactivate</span></a>&nbsp;</div>
			    </div>
			<div id="tabs-2" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
			<form:form  id="candidateForm_profile" name="candidateForm_profile" modelAttribute="candidateForm"    method="post" action="">
			 <!--  <fieldset style="font-family: sans-serif;">    -->
	      <h6><strong>Candidate - Profile</strong></h6> 
	      
	   <!--    <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px;margin-top: 0px"> -->
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"><strong> </strong></td>
    				</tr>
			    	<tr valign="top">
    					<td width="25%">Account Type:</td>
    					<td width="50%" colspan="2">
    					 	<form:radiobutton path="missCandidate.mcaType" value="1"/>New Recruit&nbsp;&nbsp;&nbsp;<form:radiobutton path="missCandidate.mcaType" value="2"/>Current Employee
    				<!-- 	<input type="radio" name="type"/>New Recruit&nbsp;&nbsp;&nbsp;<input type="radio" name="type">Current Employee -->
    				</td>
    					 <td width="25%">&nbsp;</td>
    				</tr>
    			</table>
    			<br></br>
    			<!-- </pre> -->
    			<!-- </fieldset> -->
			<!-- </form> -->
		<!-- 	<form class="well"> -->
		<!-- <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Candidate Profile</strong></td>
    				</tr>
   		 			<tr valign="top">
    					<td width="25%">Citizen ID:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missCandidate.mcaCitizenId"/>
    					</td>
    					 <td width="25%" align="right" rowspan="9">
    					  <c:if test="${not empty candidateForm.missCandidate.mcaPictureHotlink}"> 
						 	<img id="candidate_photo" width="128" height="128" src="getfile/candidateImg/${candidateForm.missCandidate.mcaId}/${candidateForm.missCandidate.mcaPictureHotlink}" />
						 </c:if>
						 <c:if test="${empty candidateForm.missCandidate.mcaPictureHotlink}"> 
						 	<img id="candidate_photo" width="128"  height="128" src="<c:url value='/resources/images/photo.png'/>" />
						 </c:if>
    					 <div align="right">
    					<!--  <input type="button" id="candidate_photo" value="Upload"> -->
    					  <!-- <a id="candidate_upload" class="btn btn-mini"><i class="icon-picture"></i>&nbsp;Upload</a> -->
    					  <input  id="candidate_upload" type="button" value="Upload">
    					 </div>
    					  <div align="right">(128px × 128px)</div>
    					  </td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Email:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missCandidate.mcaEmail"/>
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">&nbsp;</td>
    					<td width="50%" colspan="2" align="left">
    					 <a class="btn"  onclick="getCandidateInfo()"><i class="icon-search"></i>&nbsp;<spring:message code='button_search'/></a>
    					<!-- <input type="button" value="" /> -->
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">First-Lastname:</td>
    					<td width="50%" colspan="2">
    					<form:select path="missCandidate.mcaTitleType" cssStyle="width:70px;">
    						<form:option value="0">นาย</form:option>
    						<form:option value="1">นาง</form:option>
    						<form:option value="2">นางสาว</form:option>
    						<form:option value="3">ระบุ 	&rarr;</form:option>
    					</form:select>
    					<!-- <select style="width: 50px" > 
    					<option value="0">นาย</option>
    					<option  value="1">นาง</option>
    					<option  value="2">นางสาว</option>
    					<option  value="3">อื่นๆ</option>
    					</select> -->
    					<!-- <input type="text" style="width: 120px" /> -->
    					<form:input path="missCandidate.mcaFirstName" cssStyle="width:120px;bgcolor:#FFFFFF"/>
    					&nbsp;
    					<!-- <input type="text" style="width: 120px" /> -->
    					<form:input path="missCandidate.mcaLastName" cssStyle="width:120px"/>
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">Gender:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="radio" name="sex"/>Female&nbsp;&nbsp;&nbsp;<input type="radio" name="sex">Male -->
    					<form:radiobutton path="missCandidate.mcaGender" value="0"/>Female&nbsp;&nbsp;&nbsp;<form:radiobutton path="missCandidate.mcaGender" value="1"/>Male
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">Birth Date:</td>
    					<td width="50%" colspan="2">
    					<div class="picker" id="picker2"></div> 
    					<form:hidden path="mcaBirthDate"  id="mcaBirthDate"/>
    					</td> 
    				</tr>
    				<!-- <tr valign="top">
    					<td width="25%">Birth Date2:</td>
    					<td width="50%" colspan="2">
    					<input type="text" id="datepicker" style="width: 75px"/>
    					<div class="picker" id="picker2"></div>
    					</td>
    					 <td width="25%">&nbsp;</td>
    				</tr> -->
    				 <tr valign="top">
    					<td width="25%">Career Group:</td>
    					<td width="50%" colspan="2">
    					 <form:select path="missCandidate.missCareerMaster.mcmId" cssStyle="background:#FFFFFF">
    						<form:options items="${missCareerMasterList}" itemLabel="mcmName" itemValue="mcmId"></form:options>
    					</form:select>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="25%">Position:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missCandidate.mcaPosition"/>
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">Department:</td>
    					<td width="50%" colspan="2">
    					<form:input path="missCandidate.mcaDepartment"/>
    				   <!-- <input type="text" width="100%" /> -->
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				 <tr valign="top">
    					<td width="25%">Phone:</td>
    					<td width="50%" colspan="2">
    					<!-- <input type="text" width="100%" /> -->
    					<form:input path="missCandidate.mcaPhone"/>
    					</td>
    					 <!-- <td width="25%">&nbsp;</td> -->
    				</tr>
    				<tr valign="top">
    					<td width="25%">Industry Type:</td>
    					<td width="75%" colspan="3"> 
    					 <form:select path="missCandidate.missIndustryMaster.mimId" cssStyle="background:#FFFFFF" onchange="checkIndustryMaster(this)">    					 
    						<form:options items="${missIndustryMasterList}" itemLabel="mimName" itemValue="mimId"></form:options>
    					</form:select> 
    					<c:if test="${candidateForm.missCandidate.missIndustryMaster.mimId==999999999}">
    					   <span id="mimExt" style="display:block">
    						 <form:input path="missCandidate.mimExt"/>&nbsp;&nbsp;( ระบุ )
    						 </span>
    					</c:if>
    					<c:if test="${candidateForm.missCandidate.missIndustryMaster.mimId!=999999999}">
    						<span id="mimExt"  style="display:none">
    						 <form:input path="missCandidate.mimExt"/>&nbsp;&nbsp;( ระบุ )
    						 </span>
    					</c:if>
    					 
    					</td>
    				</tr>
    				
    				 
    			</table>
    		<!-- 	</pre> -->
			</form:form>
			
			<!-- <div align="center"><input type="button" class="btn" value="Save"/></div> -->
				<div align="center"><a class="btn btn-primary"  onclick="doAction('action','candidateForm_profile','1')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			</div>
			
		</div>