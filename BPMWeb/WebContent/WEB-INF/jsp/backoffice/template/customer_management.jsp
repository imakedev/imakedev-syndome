<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<script type="text/javascript">
$(document).ready(function() {
 
});
function goBackCustomer(){
 
	  $.ajax({
		  type: "get",
		  url: "customer/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doCustomerAction(action,mode,id){
	/* var pbdUid=jQuery.trim($("#pbdUid").val());
	if(pbdUid.length==0){
		 alert('กรุณากรอก รหัสรายการ');  
		 $("#pbdUid").focus();
	        return false;
	    } 
	var pbdName=jQuery.trim($("#pbdName").val());
	if(pbdName.length==0){
		 alert('กรุณากรอก รายละเอียด');  
		 $("#pbdName").focus();
	        return false;
	    }  */
	var target="customer"; 
   $("#pcAddress").val(CKEDITOR.instances["pcAddress"].getData());
 	$.post(target+"/action/customer",$("#customerForm").serialize(), function(data) {
		  // alert(data);
		  appendContent(data);
		   //appendContentWithId(data,"tabs-3");
		  // alert($("#_content").html());
		});
  }
 
</script>
<div style="${display};padding-top:10px">
 <div class="alert alert-success" style="${display}">    
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	    <form:form id="customerForm" name="customerForm" modelAttribute="customerForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${customerForm.pstCustomer.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${customerForm.pstCustomer.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstCustomer.pcId" id="pcId" /> 
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>ลูกค้า</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">รหัสลูกค้า  :</span></td>
    					<td width="75%" colspan="2"> 
    						<form:input path="pstCustomer.pcNo" id="pcNo" cssStyle="height: 30;width:80px"/>
    					</td> 
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ชื่อลูกค้า :</span></td>
    					<td width="75%" colspan="2"> 
    					<form:input path="pstCustomer.pcName" id="pcName" cssStyle="height: 30;"/>
    					</td>
    				</tr> 
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">ที่อยู่ :</span></td>
    					<td width="75%" colspan="2"> 
    					<%-- <form:input path="pstCustomer.pcAddress" id="pcAddress" cssStyle="height: 30;"/> --%>
    					<form:textarea path="pstCustomer.pcAddress" id="pcAddress" rows="4" cols="4"></form:textarea>
    					<script>
    					if (CKEDITOR.instances['pcAddress']) {
    			            CKEDITOR.remove(CKEDITOR.instances['pcAddress']);
    			         }
    					CKEDITOR.replace( 'pcAddress',
    						    { 
    						        //toolbar : 'Basic',
    						        toolbar : [
    						                      	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ] },
    						                      	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent' ] },
    						                      	{ name: 'links', items: [ 'Link', 'Unlink' ] }
    						                     // 	{ name: 'others', items: [ '-' ] },
    						                      //	{ name: 'about', items: [ 'About' ] }
    						                      ],
    						        height:"100"
    						        //, width:"200"
    						      //  uiColor : '#9AB8F3'
    						    });
    					//CKEDITOR.instances['pcAddress'].resize( '100%', '50' );
    					</script>
    					</td>
    				</tr> 
    			</table> 
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackCustomer()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doCustomerAction('action','${customerForm.mode}','${customerForm.pstCustomer.pcId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>