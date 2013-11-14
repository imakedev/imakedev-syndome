<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<script type="text/javascript">
var indexRow=parseInt('${testForm.mcSize}')+1;
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
	new AjaxUpload('question_img', {
        action: 'upload/questionImg/${testForm.missQuestion.mqId}',
		onSubmit : function(file , ext){
            // Allow only images. You should add security check on the server-side.
			//if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
			if (ext && /^(jpg|png|jpeg|gif|JPG|GIF)$/.test(ext)){
				/* Setting data */
				this.setData({
					'key': 'This string will be send with the file',
					'test':'chatchai'
				});					
			//$('#contact_photo').attr('src', _path+"resources/images/ui-anim_basic_16x16.gif");
			//$('#contact_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only images are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			var obj = jQuery.parseJSON(response); //obj.hotlink
			var _src="getfile/questionImg/${testForm.missQuestion.mqId}/"+obj.hotlink;
			$("#mqImgTh1").val(_src);
			$("#_upload_image").html("<img alt=\"\" src=\""+_src+"\" />");
		 /*
				var editor_data =CKEDITOR.instances['mqNameTh1']; //alert(editor2) // [obj]
				var selection = editor_data.getSelection();//alert(selection) // [obj]
				var text = selection.getNative();//alert(text) // ""
				var ranges = selection.getRanges();// alert(ranges) //[obj]
				var type = selection.getType();// alert(type) // 2 
			var	 newElement=CKEDITOR.dom.element.createFromHtml( '<img alt=\"\" src=\"getfile/questionImg/${testForm.missQuestion.mqId}/'+obj.hotlink+'\" />');
				 ranges[0].deleteContents();
				 ranges[0].insertNode(newElement);
				 ranges[0].selectNodeContents( newElement ); 
		*/
		}		
	});
});
function clearImage(){
	$("#_upload_image").html("");
	$("#mqImgTh1").val("");
}
function addRow(tableID) {
	//alert(indexRow);
    var table = document.getElementById(tableID);

    var rowCount = indexRow;//table.rows.length;
    var row = table.insertRow(rowCount);
	//alert(rowCount)
    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
	
    element1.type = "checkbox";
    element1.value = "choice_add_"+rowCount;
    //element1.value = ""+rowCount;
    element1.name = "chk";
    cell1.appendChild(element1);
    //cell1.appendChild(rowCount + 1);
    var count = document.createTextNode(rowCount);
    cell1.appendChild(count);
    
  /*   var cell2 = row.insertCell(1);
    cell2.innerHTML = rowCount + 1; */

    var cell2 = row.insertCell(1);
    var element2 = document.createElement("input");
    element2.type = "text";
    element2.id = "choice_add_"+rowCount;
    cell2.appendChild(element2);
    indexRow++;
}

function deleteRow(tableID) {
    try {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;

    for(var i=0; i<rowCount; i++) {
        var row = table.rows[i];
        var chkbox = row.cells[0].childNodes[0];
        if(null != chkbox && true == chkbox.checked) {
           table.deleteRow(i);
          // alert(document.getElementsByName(chkbox.name)[0].value);
           //alert(chkbox.name);
            rowCount--;
            i--;
            indexRow--;
        }

    }
    }catch(e) {
        alert(e);
    }
}
function goBackQuestions(){
	  $.ajax({
		  type: "get",
		  url: "test/exam/${testForm.missExam.meId}/questions",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				appendContentWithId(data,"tabs-3")
				// $("#tabs-3").html(data);
			  }
		});
}
function doQuestionAction(action,mode,id){
	$("#mqNameTh1").val(CKEDITOR.instances["mqNameTh1"].getData());
	 
	$("#modeQuestion").val(mode);
	if(mode!='search'){
		$("#mqId").val(id);
	}else{
		$("#mqId").val("0");
	}
	var chkArray=document.getElementsByName("chk");
	var mcIdNewArray="";
	for(var i=0;i<chkArray.length;i++){
		 var chkValue=chkArray[i].value;
		 var chkappend="";
		 if(i != (chkArray.length - 1)){
			 chkappend="12345i6789";
		 }
		 if(chkValue.indexOf("edit")!=-1){//edit
			 mcIdNewArray=mcIdNewArray+chkValue.split("_")[2]+"9876i54321"+document.getElementById(chkArray[i].value).value+chkappend;
		 }else{// add
			 mcIdNewArray=mcIdNewArray+"09876i54321"+document.getElementById(chkArray[i].value).value+chkappend;
		 }
		 //mcId1@$@value1$$*$$mcId2@$@value2
	}
	//alert(mcIdNewArray)
	//return false;
	$("#mcIdNewArray").val(mcIdNewArray);
	//alert(mcIdNewArray)
	$.post("test/action/exam/question",$("#testForm_questionList").serialize(), function(data) {
		  // alert(data);
		   appendContentWithId(data,"tabs-3")
		  // alert($("#_content").html());
		});
  }
function test(){
	var editor_data =CKEDITOR.instances['mqNameTh1']; //alert(editor2) // [obj]
	var selection = editor_data.getSelection();//alert(selection) // [obj]
	var text = selection.getNative();//alert(text) // ""
	var ranges = selection.getRanges();// alert(ranges) //[obj]
	var type = selection.getType();// alert(type) // 2 
var	 newElement=CKEDITOR.dom.element.createFromHtml( '<img alt="" src="http://10.2.0.76:10000/BPSDownloadServlet/DownloadServlet?id=" />');
	 ranges[0].deleteContents();
	 ranges[0].insertNode(newElement);
	 ranges[0].selectNodeContents( newElement ); 
	// CKEDITOR.dialog.getCurrent().hide();
}
function changeQuestionLang(){
	var value=document.getElementById("question_lang").value;
	alert(value);
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
<form:form  id="testForm_questionList" name="testForm_questionList" modelAttribute="testForm"   method="post" action="">
			<form:hidden path="modeQuestion"/>
            <form:hidden path="missQuestion.mqId"/>
            <form:hidden path="mcIdArray"/>
             <form:hidden path="missQuestion.mqImgEng1" id="mqImgEng1"/>
            <form:hidden path="missQuestion.mqImgTh1" id="mqImgTh1"/>
             <form:hidden path="mcIdNewArray"/>
			<strong>Question&nbsp;
							 <c:if test="${testForm.modeQuestion=='new'}">
	    					 New
	    					 </c:if>
	    					 <c:if test="${testForm.modeQuestion=='edit'}">
	    					 Edit
	    					 </c:if>
			</strong>
    		 <table border="0" width="100%" style="font-size: 12px;">
			    	<tr>
    					<td width="25%" align="right">Test&nbsp;:&nbsp;</td>
    					<td width="75%">${testForm.missExam.meName}</td>
    				</tr>
    				
    				<tr>
    					<td width="25%" align="right">Template&nbsp;:&nbsp;</td>
    					<td width="75%">
    					
    					<form:select path="missQuestion.missTemplate.mtId">
    						<form:option value="1" label="Template 1"></form:option>
    						<form:option value="2" label="Template 2"></form:option>
    					</form:select>
    					</td>
    				</tr>
    				<tr>
    					<td width="25%" align="right">Language&nbsp;:&nbsp;</td>
    					<td width="75%">
    					<c:if test="${testForm.lang=='TH'}">
    					Thai
    					</c:if>
    					<c:if test="${testForm.lang=='EN'}">
    					English
    					</c:if>
    					
    					  <!-- 	<select name="question_lang" id="question_lang" onchange="changeQuestionLang()"> 
											 <option value="1">Thai</option>
											 <option value="2">Eng</option>
	    					</select> -->
	    					
	    				</td>
    				</tr>
    				<tr>
    					<td width="25%" align="right"><!-- Question&nbsp;:&nbsp; --></td>
    					<td width="75%"></td>
    				</tr>
    				<tr style="padding: 2pt">
    					<td width="25%" align="left" colspan="2">
    					 <span id="_upload_image">
    					   <c:if test="${not empty testForm.missQuestion.mqImgTh1}"> 
    					     <img alt="" src="${testForm.missQuestion.mqImgTh1}" />    				      
    					   </c:if> 
    					 </span>
    					 </td> 
    				</tr>
    				<tr style="padding: 2pt">
    					<td width="25%" align="left" colspan="2">
    					<a class="btn" id="question_img"><i class="icon-picture"></i>&nbsp;<span style="">Upload Image</span></a> | 
    					<a class="btn" id="question_img_delete">&nbsp;<span style="" onclick="clearImage()">Clear Image</span></a><br/>
    					 </td> 
    				</tr>
    				 
    				<tr>
    					<td width="25%" align="left" colspan="2">
    					<form:textarea path="missQuestion.mqNameTh1" cols="4" rows="4" id="mqNameTh1"/>  
    					<!-- <textarea cols="4" rows="4" id="mqName"></textarea> -->
    					<script>
    					if (CKEDITOR.instances['mqNameTh1']) {
    						//alert("remove ")
    			            CKEDITOR.remove(CKEDITOR.instances['mqNameTh1']);
    			         }
    				 
						var editor0=CKEDITOR.replace( 'mqNameTh1',
									{
										// Defines a simpler toolbar to be used in this sample.
										// Note that we have added out "MyButton" button here.
										//height : 50,
										//Preview - 
										//toolbar : [ [ 'Source', '-', 'Bold', 'Italic', 'Underline', 'Strike','-','Link' ] ]
								toolbar : [
										    { name: 'document', items : [ 'Source','-','Preview','-'] }, 
											{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike',] },
											{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
											{ name: 'links', items : [ 'Link','Unlink'] },
											{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
											'/',
									  	 	{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
											{ name: 'colors', items : [ 'TextColor','BGColor'] } 
											//{ name: 'tools', items : [ 'MyButton' ] }
										]
									});
						 
					 
    					</script>
    					 
    					</td> 
    				</tr>
    				<tr>
    					<td   align="left" colspan="2">Multiple Choose &nbsp;:&nbsp;
    					<form:input path="missQuestion.mqChoose" cssStyle="width:30px"></form:input>
    					</td> 
    				</tr> 
    		</table>
</form:form>
			<div> Choices:</div>
			
			<table id="dataTable" class="table stable-striped table-bordered table-condensed" border="0" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="5%"><div class="th_class">Order</div></th>
            		<th width="95%"><div class="th_class">Text</div></th>             		 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:if test="${testForm.modeQuestion=='edit'}">
        	     <c:if test="${not empty testForm.missQuestion.missChoices}"> 
        	     	<c:forEach items="${testForm.missQuestion.missChoices}" var="missChoice" varStatus="loop"> 
	    					<tr>
	    					 		  <td><INPUT type="checkbox" name="chk" value="choice_edit_${missChoice.mcNo}"/>${loop.index+1}</td>
            						<td><input type="text" id="choice_edit_${missChoice.mcNo}" value="${missChoice.mcName}"/></td>  
	    	 				</tr>
	    	 		</c:forEach>
        	     </c:if>
        	 	
	    	</c:if>
	    	<c:if test="${testForm.modeQuestion=='new'}">
	    		<tr>
            		<td><INPUT type="checkbox" name="chk" value="choice_add_1"/>1</td>
            		<td><input type="text" id="choice_add_1" value=""/></td>
          		</tr>
          	<!-- <tr>
            	<td><INPUT type="checkbox" name="chk"/>2</td>
            	<td><input type="text" value="BB"/></td> 
          	</tr>
          	<tr>
            	<td><INPUT type="checkbox" name="chk"/>3</td>
            	<td><input type="text" value="CC"/></td>
          	</tr>
          	<tr>
            	<td><INPUT type="checkbox" name="chk"/>4</td>
            	<td><input type="text" value="DD"/></td>
          	</tr> -->
	    	</c:if>
             
        	</tbody>
      </table>
			<INPUT type="button" value="Add Choice" onclick="addRow('dataTable')" />
 
    <INPUT type="button" value="Delete Choice" onclick="deleteRow('dataTable')" />
			<div align="center">
			<a class="btn btn-info"  onclick="goBackQuestions()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doQuestionAction('action','${testForm.modeQuestion}','${testForm.missQuestion.mqId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
			 <!-- <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="50%" align="right">
    					<input type="button" class="btn" value="Delete"/>
    					<a class="btn btn-info"  onclick="doAction('search','doBack','0')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					</td>
    					<td width="50%" align="left">
    					<input type="button" class="btn" value="Save"/>
    					 <a class="btn btn-primary"  onclick="doAction('action','mode','msId')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
    					</td>
    				</tr>
				</table> -->
</fieldset>