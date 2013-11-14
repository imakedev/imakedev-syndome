<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	
});
function doSendMail(){
	
	//alert(action)
	$("#mail_message").val(CKEDITOR.instances["mail_message"].getData());
	var checked="1";
	 //alert(mail_attach.checked);
	if(!document.getElementById("mail_attach").checked)
		checked="0";
	 
	  var data_to_server= { 
			  mail_todo_id:'${mail_todo_idG}',
			  mail_todo_ref:'${mail_todo_refG}',
			  mail_to: $("#mail_to").val(),
			  mail_subject:$("#mail_subject").val(),
			  mail_message:$("#mail_message").val(),
			  mail_attach:checked
				};
	 // return false;
	//$.post("sendmailToApprove",$("#mailApproveForm").serialize(), function(data) {
	$.post("sendmailToApprove",data_to_server, function(data) {
		 // alert(data);
		 
		    appendContent(data);
		  // alert($("#_content").html());
		});
  }

  </script>
	    <!--Body content-->
	    <fieldset style="font-family: sans-serif;">  
            <form class="well" method="post" action="">
          <%-- <form:form  id="resultForm" name="resultForm" modelAttribute="resultForm" cssClass="well" cssStyle="border:2px solid #DDD" method="post" action=""> --%>
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="17%" colspan="6"><strong>Send mail</strong></td>
	    					</tr>
	    				 
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">To:</td>
	    					 <td align="left" colspan="4"><input type="text" id="mail_to" name="mail_to">  
	    					 </td>	    					 
	    					</tr>
	    					<%--
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">CC:</td>
	    					 <td align="left" colspan="4"><input type="text" id="mail_cc" name="mail_cc"> 
	    					 </td>	    					 
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">BCC:</td>
	    					 <td align="left" colspan="4"><input type="text" id="mail_bcc" name="mail_bcc">
	    					 </td>	    					 
	    					</tr> 
	    					 --%>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Subject:</td>
	    					 <td align="left" colspan="4"><input type="text" id="mail_subject" name="mail_subject">
	    					 </td>	    					 
	    					</tr> 
	    					<tr>
	    					 <td align="left" colspan="6">Message:</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" colspan="6"><textarea rows="4" cols="4" id="mail_message" name="mail_message"></textarea> 
    					<script>
    					if (CKEDITOR.instances['mail_message']) {
    			            CKEDITOR.remove(CKEDITOR.instances['mail_message']);
    			         }
    					CKEDITOR.replace( 'mail_message',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script></td>
	    					</tr>
	    					<tr>
	    					 <td align="left" colspan="6"><input type="checkbox" id="mail_attach" name="mail_attach"/>Attach Report(PDF)</td>
	    					</tr>
	    					</table> 
	    			</form>
	    					<!-- <div align="center"><input type="button" value="Send"></div> -->
	    					
	    					<div align="center"><a class="btn btn-primary" onclick="doSendMail();"><i class="icon-envelope icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Send</span></a></div>
      </fieldset> 
   