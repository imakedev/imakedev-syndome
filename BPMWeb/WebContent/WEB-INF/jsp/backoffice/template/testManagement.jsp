<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	$('#tabs').tabs();
	$('#tabs').bind('tabsselect', function(event, ui) {

	    // Objects available in the function context:
	   /*  ui.tab     // anchor element of the selected (clicked) tab
	    ui.panel   // element, that contains the selected/clicked tab contents
	    ui.index   // zero-based index of the selected (clicked) tab */
	   //alert("index="+ui.index+",panel="+ui.panel+",tab="+ui.tab)
	   if(ui.index==1){
		 // /exam/{meId}/questions
		// alert("test/exam/"+$("#_meId").val()+"/questions");
		 if($("#_meId").val().length>0){
		  $.ajax({
			  type: "get",
			  url: "test/exam/"+$("#_meId").val()+"/questions",
			  cache: false
			 // data: { name: "John", location: "Boston" }
			}).done(function( data ) {
				if(data!=null){
					appendContentWithId(data,"tabs-3")
					// $("#tabs-3").html(data);
				  }
			});
		 }
	   }else{
		   $("#tabs-3").html("");
	   }

	});
  //   $("fieldset.collapsibleClosed").collapse( { closed : true } );
	$('#tabs').tabs('select', parseInt($("#_test_section").val()));
	
});
function doAction(action,formID,sectionID){
	//alert($("#maCustomizePassMessage").val());
	$("#meIntroduction").val(CKEDITOR.instances["meIntroduction"].getData());
	$("#meInstruction").val(CKEDITOR.instances["meInstruction"].getData());
/* 	$("#maCustomizeRejectMessage").val(CKEDITOR.instances["maCustomizeRejectMessage"].getData());
	$("#maCustomizeRetestMessage").val(CKEDITOR.instances["maCustomizeRetestMessage"].getData()); */
	//alert($("#maCustomizePassMessage").val());
	//$("#_miss_section").val(sectionID);
	//alert(formID)
	$.post("test/"+action+"/"+sectionID,$("#"+formID).serialize(), function(data) {
		    appendContent(data);
		    if(formID=='testForm_fixanswer')
		    	$('#tabs').tabs('select', 1);
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
    <input type="hidden" id="_meId" name="_meId" value="${testForm.missExam.meId}"/>
    <input type="hidden" id="_test_section" name="_test_section" value="${testForm.missExam.section}"/>
            <div id="tabs">
			<ul>
				<li><a href="#tabs-1">Information</a></li>
				<!-- <li><a href="#tabs-2">Evaluations</a></li> -->
				<li><a href="#tabs-3">Questions</a></li>
			</ul>
			<div id="tabs-1" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<!-- <form class="well"> -->
			<form:form  id="testForm_account" name="testForm_account" modelAttribute="testForm"   method="post" action="">
			     <strong style="font-family: sans-serif;color: rgb(51,51,51)">Test Information</strong>
			    <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			    <table border="0" width="100%" style="font-size: 12px">
			       <!-- <tr>
    					<td width="100%" colspan="2"><strong>Test Information</strong></td> 
    				</tr> -->
   		 			<tr>
    					<td width="20%" align="right">Test Name:</td>
    					<td width="80%">
    					<form:input path="missExam.meName" id="meName"/>
    					</td> 
    				</tr>
    				<tr>
    					<td width="20%" align="right">Group:</td>
    					<td width="80%">
    					<form:select path="missExam.missExamGroup.megId">
    						<%--  <form:option value="-1">-- Select Series --</form:option> --%>
    						 <form:options items="${missExamGroups}" itemLabel="megName" itemValue="megId"></form:options>
	    					     
    					</form:select>
    					<!-- <select name="bpsGroupId" id="bpgGroupId"> 
											 <option value="0">Group1</option>
											 <option value="20">Group2</option>
	    					</select> -->
	    					</td> 
    				</tr>
    				<tr>
    					<td width="20%" align="right">Time Limit:</td>
    					<td width="80%">
    					<form:input path="missExam.meTimeLimit" id="meTimeLimit" cssStyle="width:50px"/>
    					 minutes</td> 
    				</tr>
    			</table>  
    			<!-- </pre>  --> 			
			<%-- </form:form>
			<form:form  id="testForm_account" name="testForm_account" modelAttribute="testForm" cssClass="well"  method="post" action=""> --%>
			   <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			    <table border="0" width="100%" style="font-size: 12px">
			       <tr>
    					<td width="100%" colspan="2"><strong>Introduction:</strong></td> 
    				</tr>
   		 			<tr>
    					<td width="100%" colspan="2">
    					<form:textarea path="missExam.meIntroduction" cols="4" rows="4" id="meIntroduction"/>
    					<script>
    					if (CKEDITOR.instances['meIntroduction']) {
    			            CKEDITOR.remove(CKEDITOR.instances['meIntroduction']);
    			         }
    					CKEDITOR.replace( 'meIntroduction',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					<!-- <textarea cols="4" rows="4" id="editor1"></textarea>
    					<script>
    					if (CKEDITOR.instances['editor1']) {
    			            CKEDITOR.remove(CKEDITOR.instances['editor1']);
    			         }
    					CKEDITOR.replace( 'editor1',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script> -->
    					
    					</td> 
    				</tr>
    				<tr>
    					<td width="100%" colspan="2"><strong>Instruction:</strong></td> 
    				</tr>
   		 			<tr>
    					<td width="100%" colspan="2">
    					<form:textarea path="missExam.meInstruction" cols="4" rows="4" id="meInstruction"/>
    					<script>
    					if (CKEDITOR.instances['meInstruction']) {
    			            CKEDITOR.remove(CKEDITOR.instances['meInstruction']);
    			         }
    					CKEDITOR.replace( 'meInstruction',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script>
    					<!-- <textarea cols="4" rows="4" id="editor2"></textarea>
    					<script>
    					if (CKEDITOR.instances['editor2']) {
    			            CKEDITOR.remove(CKEDITOR.instances['editor2']);
    			         }
    					CKEDITOR.replace( 'editor2',
    						    {
    						        toolbar : 'Basic',
    						      //  uiColor : '#9AB8F3'
    						    });
    					</script> -->
						</td> 
    				</tr>
    			</table>    		
    			<!-- </pre>	 -->
			</form:form>
			<div align="center">
			<div align="center">
			<a class="btn btn-primary"  onclick="doAction('action','testForm_account','0')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			
			<!-- <a class="btn btn-danger"><i class="icon-trash icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Delete</span></a> -->
			
			</div>
			
			<!-- <input type="button" value="Save" /><input type="button" value="Delete" /> -->
			</div>
			    </div>
			    <%--
			<div id="tabs-2">
			<form:form  id="testForm_evaluation" name="testForm_evaluation" modelAttribute="testForm" cssClass="well"  method="post" action="">
			    <table border="1" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="4"><strong>Evaluations</strong></td>
    				</tr>
   		 			 
    				 
    			</table>
			</form:form> 
			
			</div>
			 --%>
			<div id="tabs-3" style="background: url(<c:url value='/resources/images/${UserMissContact.missTheme.mtWaterWall}'/>) no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}">
			<%--
			<form:form  id="testForm_question" name="testForm_question" modelAttribute="testForm" cssClass="well"  method="post" action="">
			<strong>Question List</strong>
    				<div>${testForm.missExam.meName}</div>
    				
    		</form:form>	
    		<div align="right"><a class="btn btn-primary"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Add</span></a></div>	
    	 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class">Order</div></th>
            		<th width="85%"><div class="th_class">Question</div></th> 
            		<th width="10%"><div class="th_class">Action</div></th>            		 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>1</td>
            	<td>Question1</td> 
            	<td><a href="<c:url value='/test/exam/1/question/2'/>">Edit</a> Delete</td> 
          	</tr>
          	<tr>
            	<td>2</td>
            	<td>Question2</td> 
            	<td><a href="<c:url value='/test/exam/1/question/2'/>">Edit</a> Delete</td> 
          	</tr>
          	<tr>
            	<td>3</td>
            	<td>Question3</td> 
            	<td><a href="<c:url value='/test/exam/1/question/2'/>">Edit</a> Delete</td> 
          	</tr>
          	<tr>
            	<td>4</td>
            	<td>Question4</td> 
            	<td><a href="<c:url value='/test/exam/1/question/2'/>">Edit</a> Delete</td> 
          	</tr>
        	</tbody>
      </table>
			
			<div>
			<!-- <input type="checkbox"> -->
			<form:form  id="testForm_fixanswer" name="testForm_fixanswer" modelAttribute="testForm" cssClass="well"  method="post" action="">
			<form:checkbox path="missExam.meFixAnswerOrder" value="1"/> Fix Answering Order
			</form:form>
			</div>
			<!-- <div align="center"><input type="button" class="btn" value="Save"/></div> -->
			<div align="center">
			<a class="btn btn-primary" onclick="doAction('action','testForm_fixanswer','2')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
			 --%>
			</div>
			
		</div>