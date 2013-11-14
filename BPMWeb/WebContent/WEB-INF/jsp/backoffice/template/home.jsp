<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
var mail_toG;
var mail_subjectG;
var mail_messageG;
var mail_attachG;
$(document).ready(function() {
	$( "#dialog-modal" ).dialog( "destroy" );
	mail_toG= $( "#mail_to" );
	mail_subjectG= $( "#mail_subject" );
	mail_messageG= $( "#mail_message" );
	mail_attachG= $( "#mail_attach" );
});
function testAlert(){
	alert("ok")
}
function doSendMail(mail_todo_idG,mail_todo_refG){
	
	/* $.get("getmailToApprove/"+mail_todo_idG+"/"+mail_todo_refG, function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});  */
	loadDynamicPage("getmailToApprove/"+mail_todo_idG+"/"+mail_todo_refG);
	//alert(action)
	//  alert(mail_attachG.val());
	/* var checked="1";
	 alert(mail_attach.checked);
	if(!document.getElementById("mail_attach").checked)
		checked="0";
	 
	  var data_to_server= { 
			  mail_todo_id:mail_todo_idG,
			  mail_todo_ref:mail_todo_refG,
			  mail_to: mail_toG.val(),
			  mail_subject: mail_subjectG.val(),
			  mail_message:mail_messageG.val(),
			  mail_attach:checked
				};
	 // return false;
	//$.post("sendmailToApprove",$("#mailApproveForm").serialize(), function(data) {
	$.post("sendmailToApprove",data_to_server, function(data) {
		 // alert(data);
		 
		    appendContent(data);
		  // alert($("#_content").html());
		}); */
  }
function changeCheckBox(){
	alert(mail_attach.checked)
}
function openDialog(todo_id,todo_ref){
	$("#mail_todo_id").val(todo_id);
	$("#mail_todo_ref").val(todo_ref);
	$("#checked_box").val("0");
	$( "#dialog-modal" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Ok": function() { 
				alert($("#mail_attach").attr("checked"));
 
				alert(document.getElementById("mail_attach").checked);
				$( this ).dialog( "destroy" ); 
				$( this ).dialog( "close" );  
				
				doSendMail(todo_id,todo_ref);
				
				 
			},
			"Close": function() { 
				$( this ).dialog( "destroy" ); 
				$( this ).dialog( "close" );				 
			}
		}
	});
}
</script>
<style>
th{ font-family:Tahoma; font-size:12px; font-weight:bold;
 color: #fff;background:url(<c:url value='/resources/images/${UserMissContact.missTheme.mtTr}'/>) repeat-x scroll 0 0 ${UserMissContact.missTheme.mtTrColor};padding: 5px 8px;border:1px solid #fff; 
}
table[id=table_list] tr:nth-child(even) {background: #FFFFFF}
/* tr:nth-child(odd) {background: #FFFFFF} */
</style>
<!--Body content-->
<!-- <div class="alert alert-info">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Heads up!</strong> Best check yo self, you're not looking too good.2
    </div> -->
    <div id="dialog-modal" title="Send Email Form" style="display: none">
	<!-- <p>Adding the modal overlay screen makes the dialog look more prominent because it dims out the page content.</p> -->
	<form id="mailApproveForm" name="mailApproveForm"  method="post" action="">
	<input type="hidden" id="mail_todo_id" name="mail_todo_id">
	<input type="hidden" id="mail_todo_ref" name="mail_todo_ref">
	<input type="hidden" id="checked_box" name="checked_box" value=""/>
	<table>
	<tr valign="top"><td width="20%">To</td><td width="80%"><input type="text" id="mail_to" name="mail_to"></td></tr>
	<tr valign="top"><td width="20%">Subject</td><td width="80%"><input type="text" id="mail_subject" name="mail_subject" ></td></tr>
	<tr valign="top"><td width="20%">Message</td><td width="80%"><textarea rows="4" cols="4" id="mail_message" name="mail_message"></textarea></td></tr>
	<tr valign="top"><td align="left" colspan="2" width="100%"><input type="checkbox" onclick="changeCheckBox()" value="1" id="mail_attach" name="mail_attach">Attach Report(PDF)</td></tr>
	 
	<tr valign="top"><td width="20%"></td><td width="80%"></td></tr>
	</table>
	</form>
</div>
  <fieldset style="font-family: sans-serif;"> 
	   <!--  <form   class="well" style="background-color:white;border: 2px solid rgba(0, 0, 0, 0.05)" > -->
	  <!--  <form   class="well" style="border:2px solid #DDD;background: url('/MISSExamBackOffice/resources/images/bg-water-theme1.gif') no-repeat scroll right top rgb(231, 231, 231)" > -->
	   <form   class="well" style="border:2px solid #DDD;background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}" method="post" enctype="multipart/form-data">
	   <!--   <fieldset style="font-family: sans-serif;">  -->  
	      <h3  style="font:Arial,Helvetica,sans-serif"><strong>
	      <c:if test="${UserMissContact.isMC=='1'}">
	      	MC - Home
	      </c:if>
	       <c:if test="${UserMissContact.isMC=='0'}">
	      	Company - Home
	      </c:if>
	      </strong></h3>  
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="20%">
	    					
	    					<strong><spring:message code="home_todo"/></strong></td>
	    					<td align="right" width="80%">
	    				<!-- 	<a  class="btn btn-primary" onclick="testAlert()"><i class="icon-search icon-white"></i>&nbsp;Seach</a> -->
	    					<%--
	    					<a href="#">Prev</a>&nbsp;|&nbsp;<select name="bpsGroupId" id="bpgGroupId" style="width: 50px"> 
											 <option value="0">1</option>
											 <option value="20">20</option>
											 <option value="300">300</option>
												
	    					</select>&nbsp;|&nbsp;<a href="#">Next</a>
	    					 --%>
	    					<input type="hidden" value="${totals}" id="totals"/>
	    					<input type="hidden" value="${pageObj.pageNo}" id="pageNo"/>
	    					<input type="hidden" value="${pageObj.pageSize}" id="pageSize"/>
	    					</td>
	    					</tr>
	    					</table>  
 
  <table id="table_list"  class="table stable-striped table-bordered table-condensed" border="1" style="font-size: 12px"> 
<!-- <table   border="1" style="font-size: 12px;width:100%" > -->
        <thead>
          <tr>
            <th width="70%"><div class="th_class"><spring:message code="home_task"/></div></th>
            <th width="15%"><div class="th_class">Status</div></th> 
            <th width="15%"><div class="th_class"><spring:message code="home_respond"/></div></th> 
          </tr>
        </thead>
        <tbody>
         <c:forEach items="${todolists}" var="todolist" varStatus="loop">  
            <tr>
             <td><div class="th_class" style="text-align: left;"><c:out value="${todolist.mtodoTask}"/> 
            </div></td>
            <td><div class="th_class"><c:if test="${todolist.mtodoResponse=='1'}">
              &nbsp;<span style="color: green;">Completed</span>
             </c:if>
              <c:if test="${todolist.mtodoResponse!='1'}">
               &nbsp;<span style="color: orange;">Pending</span>
              </c:if></div></td>
            <td><div class="th_class"><a onclick="doSendMail('${todolist.mtodoId}','${todolist.mtodoRef}')">Send Email</a></div></td> 
          </tr>
          </c:forEach>
        </tbody>
      </table>
      
     
      </form>
 </fieldset>
	  