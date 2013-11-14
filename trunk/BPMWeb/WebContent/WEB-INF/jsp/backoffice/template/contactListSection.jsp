<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
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
});
function confirmDelete(mode,id){
	$( "#dialog-confirm-Contact-Delete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doContactAction(mode,id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
}
function loadContactInit(_url){
	var target="miss";
	if($("#mcontactType").val() != '1'){
		target="company";
	}
	$.ajax({
		  type: "get",
		  url: target+_url,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				appendContentWithId(data,"tabs-3");
			  }
		});
}
function loadContact(_url){
	$.ajax({
		  type: "get",
		  url: _url,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				appendContentWithId(data,"tabs-3");
			  }
		});
	
}
 function doContactAction(mode,id){
	//alert($("#maCustomizePassMessage").val());
	 $("#mode").val(mode);
		if(mode=='deleteItems'){
			$("#mcontactIdArray").val(id);
		}else if(mode!='search'){
			$("#mcontactId").val(id);
		}else {
			$("#mcontactId").val("0");
		}
		var target="miss";
		if($("#mcontactType").val() != '1'){
			target="company";
		}
		
		$.post(target+"/account/"+$("#maId").val()+"/contacts",$("#contactForm").serialize(), function(data) {
			    appendContentWithId(data,"tabs-3");
			});
  }
 function toggleCheckbox(){
		var _check=document.getElementById("mcontactIdCheckboxAll").checked;
		var mcontactIdCheckbox=document.getElementsByName("mcontactIdCheckbox"); 
		for(var i=0;i<mcontactIdCheckbox.length;i++){ 
			mcontactIdCheckbox[i].checked=_check;
		}
	}
 function doDeleteItems(){
		var mcontactIdCheckbox=document.getElementsByName("mcontactIdCheckbox");
		//alert(mcontactIdCheckbox.length);
		var mcontactIds="";
		for(var i=0;i<mcontactIdCheckbox.length;i++){
			 if(mcontactIdCheckbox[i].checked)
				 mcontactIds=mcontactIds+mcontactIdCheckbox[i].value+",";
		}
		 
		mcontactIds=mcontactIds.substring(0, mcontactIds.length-1);
		if(mcontactIds.length>0){
			//alert(mcontactIds);
			$( "#dialog-confirm-Contact-Delete" ).dialog({
				/* height: 140, */
				modal: true,
				buttons: {
					"Yes": function() { 
						$( this ).dialog( "close" );
						doContactAction("deleteItems",mcontactIds);
					},
					"No": function() {
						$( this ).dialog( "close" );
						return false;
					}
				}
			});
		}
	}
</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
</style>

<div id="dialog-confirm-Contact-Delete" title="Delete Contact" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Contact ?
</div>
<form:form  id="contactForm" name="contactForm" modelAttribute="contactForm"  method="post" action="">
    		<form:hidden path="mode"/>
    	<%-- 	<form:hidden path="missExam.meId" id="meId"/>--%>
            <form:hidden path="missContact.mcontactId" id="mcontactId"/> 
            <form:hidden path="mcontactIdArray" id="mcontactIdArray"/>
            <form:hidden path="maId" id="maId"/>
            <form:hidden path="missContact.mcontactType" id="mcontactType"/>
            
  </form:form>
		<div>
    			<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadContactInit('/account/${contactForm.maId}/contact/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="color: white;">Create</span></a>&nbsp;
	    					<a class="btn btn-danger"  onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;<span style="color: white;">Delete</span></a></td>
	    					<td align="right" width="50%">
	    					
	    					</td>
	    					</tr>
	    					</table> 
		<table id="table_list" class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px;background-color:#F9F9F9;">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class"><input type="checkbox" id="mcontactIdCheckboxAll" onclick="toggleCheckbox()"/></div></th>
            		<th width="20%"><div class="th_class">First-Lastname</div></th> 
            		<th width="15%"><div class="th_class">Position</div></th>
            		<th width="20%"><div class="th_class">Department</div></th> 
            		<th width="15%"><div class="th_class">Mobile Phone</div></th>
            		<th width="15%"><div class="th_class">Email</div></th> 
            		<th width="10%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${missContacts}" var="missContact" varStatus="loop"> 
          	<tr>
            	<td><input type="checkbox" name="mcontactIdCheckbox" value="${missContact.mcontactId}"/></td>
            	<td>&nbsp;${missContact.mcontactName}&nbsp;${missContact.mcontactLastname}</td>
            	<td>&nbsp;${missContact.mcontactPostion}</td>
            	<td>&nbsp;${missContact.mcontactDepartment}</td>
            	<td>&nbsp;${missContact.mcontactMobilePhone}</td>
            	<td>&nbsp;${missContact.mcontactEmail}</td>
            	<td style="text-align: center;">
            	<i title="Edit" onclick="loadContactInit('/account/${missContact.mcontactRef}/contact/${missContact.mcontactId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	<i title="Delete" onclick="confirmDelete('delete','${missContact.mcontactId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td> 
          	</tr>
          	</c:forEach>
        	</tbody>
      </table>
    				</div>	