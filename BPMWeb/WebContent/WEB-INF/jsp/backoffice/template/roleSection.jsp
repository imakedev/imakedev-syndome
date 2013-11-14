<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
var role_name_G; 
$(document).ready(function() {
//	$('#tabs').tabs();
  //   $("fieldset.collapsibleClosed").collapse( { closed : true } );
//	$('#tabs').tabs('select', parseInt($("#_test_section").val()));
	/* $('#tabs').bind('tabsselect', function(event, ui) {

	    // Objects available in the function context:
	  
	   //alert("index="+ui.index+",panel="+ui.panel+",tab="+ui.tab)
	   if(ui.index==2){
		   alert($("#_meId").val())
		   $("#tabs-3").html("");
	   }

	}); */
	role_name_G=$( "#rolename" );
});
function toggleCheckbox(){
	var _check=document.getElementById("rtIdCheckboxAll").checked;
	var rtIdCheckbox=document.getElementsByName("rtIdCheckbox"); 
	for(var i=0;i<rtIdCheckbox.length;i++){ 
		rtIdCheckbox[i].checked=_check;
	}
}
function goUpdateRole(){
  var rcActionId=document.getElementById("rcActionId");
  var rcAction=rcActionId.value;
  $("#rolename").val($("select[id=rcId] option:selected").text());
  var rcId=$("select[id=rcId] option:selected").val();
  if(rcAction=='1'){// Add
	//  $('#dialog-createOrUpdate-role').dialog('option', 'title', 'Add Role');
	  $("#rolename").val("");
	  $( "#dialog-createOrUpdate-role" ).dialog({
			/* height: 140, */
			modal: true,
			title:'Add Role',
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					goActionRole("addRole");
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
  }else  if(rcAction=='2'){// Edit
	 // $('#dialog-createOrUpdate-role').dialog('option', 'title', 'Edit Role');
	  if(rcId=='0'){
		  alert("Please select Role name to Edit");
	  }else{
		  $( "#dialog-createOrUpdate-role" ).dialog({
			/* height: 140, */
			modal: true,
			title:'Edit Role',
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					goActionRole("updateRole");
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	  }
  }else  if(rcAction=='3'){// Delete
	  if(rcId=='0'){
		  alert("Please select Role name to Delete");
	  }else{
	  	$( "#dialog-confirmDelete" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					goActionRole("deleteRole");
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	  }
	}
	
}
function goActionRole(_mode){
	/*  if($("#_maId").val().length>0){
		  $.ajax({
			  type: "post",
			  url: "role/"+$("#_maId").val(),
			  cache: false
			 // data: { name: "John", location: "Boston" }
			}).done(function( data ) {
				if(data!=null){
					appendContentWithId(data,"tabs-3_1");
					// $("#tabs-3").html(data);
				  }
			});
		//  $("#tabs-3").html("");
		//  $("#tabs-4").html("");
		 }	 */
	//alert(document.getElementById("rolename").value)
    //	$("#roleName").val(document.getElementById("rolename").value); 
		// alert($("#rolename").val())
		// alert(document.getElementById("rolename").value)
	//	alert(role_name_G.val())
	$("#roleName").val(role_name_G.val());
	
	$("#mode").val(_mode);
	 $.post("role/"+$("#_maId").val(),$("#roleForm").serialize(), function(data) {
		 appendContentWithId(data,"tabs-3_1");
		});
}
</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
</style>
<div id="dialog-confirmDelete" title="Delete Role" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Role ?
</div>
<div id="dialog-createOrUpdate-role" title="Role" style="display: none;background:'')" class="ui-dialog-titlebar2">
	<form id="role_form" name="role_form">
	    Role name&nbsp;:&nbsp;<input type="text" name="rolename" id="rolename" /><br/>
	</form>
</div>
 <div class="alert alert-success" style="${display}">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
  <fieldset style="font-family: sans-serif;">   
           <%-- <form:form  id="roleForm" name="roleForm" modelAttribute="roleForm" cssStyle="border:2px solid #DDD" method="post" action=""> --%>
           <form:form  id="roleForm" name="roleForm" modelAttribute="roleForm"  method="post" action="">
               <form:hidden path="mode"/>
               <form:hidden path="roleName"/>
	 
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong>Role Setting</strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="center" width="100%" colspan="6">&nbsp;Role name : 
	    					 <form:select path="rcId" onchange="goActionRole('load')">
	    					 	<form:option  value="0" label="-- Select --"></form:option>
	    					 	 <form:options itemLabel="rcName" items="${roleContacts}" itemValue="rcId"/>
	    					  </form:select>
	    					  <form:select path="rcActionId" cssStyle="width:90px">
	    					 <%-- 	 <form:option  value="0" label="List Role"></form:option> --%>
	    					 	 <form:option  value="1" label="Add Role"></form:option>
	    					 	 <form:option  value="2" label="Edit Role"></form:option>
	    					 	 <form:option  value="3" label="Delete Role"></form:option> 
	    					  </form:select>&nbsp;&nbsp;
	    					  <a class="btn btn-primary"  onclick="goUpdateRole()">&nbsp;<span style="color: white;font-weight: bold;">Ok</span>&nbsp;</a>
	    					</td>
	    					</tr>
	    					</table> 
	    					
	    					 
		<table id="table_list"  class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<!-- <th width="5%"><div class="th_class"><input type="checkbox" id="rtIdCheckboxAll" onclick="toggleCheckbox()"/></div></th> -->
            		<th width="30%"><div class="th_class">Role</div></th> 
            		<th width="58%"><div class="th_class">Description</div></th>
            		<th width="12%"><div class="th_class">Permission</div></th>              		 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${roleTypes}" var="roleType" varStatus="loop"> 
          	<tr>
            	<%-- <td>
            	<c:if test="${roleType.selected=='1'}">
            		<input type="checkbox" name="rtIdCheckbox" checked="checked" value="${roleType.rtId}"/>
            	</c:if>
            	<c:if test="${roleType.selected!='1'}">
            		<input type="checkbox" name="rtIdCheckbox" value="${roleType.rtId}"/>
            	</c:if>
            	</td>  --%>
            	<td>&nbsp;${roleType.role}</td>
            	<td>&nbsp;${roleType.roleDesc}</td>
            	<td>
            	 <c:if test="${not empty roleForm.rcId}"> 
            	 	<c:if test="${roleForm.rcId!=0}">
            	 		<c:if test="${roleType.selected=='1'}">
            				<input type="radio" value="${roleType.rtId}" checked="checked" name="rtIdCheckbox_radio_${roleType.rtId}">
            				<img src="<c:url value='/resources/images/Select.png'/>"/>&nbsp;
            				<input type="radio" value="0" name="rtIdCheckbox_radio_${roleType.rtId}">
            				<img src="<c:url value='/resources/images/deSelect.png'/>"/>
            			</c:if>
            			<c:if test="${roleType.selected!='1'}">
            				<input type="radio" value="${roleType.rtId}"  name="rtIdCheckbox_radio_${roleType.rtId}">
            				<img src="<c:url value='/resources/images/Select.png'/>"/>&nbsp;
            				<input type="radio" value="0" checked="checked" name="rtIdCheckbox_radio_${roleType.rtId}">
            				<img src="<c:url value='/resources/images/deSelect.png'/>"/>
            			</c:if>
            	 	</c:if>   
            	 	<c:if test="${roleForm.rcId==0}">
            	 		<input type="radio" value="${roleType.rtId}"  name="rtIdCheckbox_radio_${roleType.rtId}">
            	 		<img src="<c:url value='/resources/images/Select.png'/>"/>&nbsp;
            			<input type="radio" value="0" name="rtIdCheckbox_radio_${roleType.rtId}">
            			<img src="<c:url value='/resources/images/deSelect.png'/>"/>
            	 	</c:if>         	 	
            	 </c:if>
            	 <c:if test="${empty roleForm.rcId}"> 
            	 		<input type="radio" value="${roleType.rtId}"   name="rtIdCheckbox_radio_${roleType.rtId}">
            	 		<img src="<c:url value='/resources/images/Select.png'/>"/>&nbsp;
            			<input type="radio" value="0" name="rtIdCheckbox_radio_${roleType.rtId}">
            			<img src="<c:url value='/resources/images/deSelect.png'/>"/>
            	 </c:if>
            	 </td>
          	</tr>
          	</c:forEach>
        </tbody>
      </table>
      </form:form>
</fieldset>
<div align="center"><a class="btn btn-primary"  onclick="goActionRole('updateRoleMapping')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>