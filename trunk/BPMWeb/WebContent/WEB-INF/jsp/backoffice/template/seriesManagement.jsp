<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
   var missSeriesMap=$("#missSeriesMap").val();
   //alert(missSeriesMap);
   if(missSeriesMap.length>0){
	   var missSeriesMapArray=missSeriesMap.split(",");
	   //alert("size="+missSeriesMapArray.length);
	    // meid|filename|hotlink|module|path
	   for(var i=0;i<missSeriesMapArray.length;i++){
		  //  var missSeriesMapArrayValues=missSeriesMapArray[i].split("|");
		   var indexStr=(i+1)+"_";
		   //document.getElementsByName("missExam_mapping")[i].value=indexStr+missSeriesMapArray[i];
		  // document.getElementsByName("missExam_mapping")[i].value=indexStr+missSeriesMapArrayValues[0];
		   document.getElementsByName("missExam_mapping")[i].value=indexStr+missSeriesMapArray[i];
		   //document.getElementsByName("eval_file_attached_"(i+1)).value=indexStr+missSeriesMapArrayValues[0];
		   //document.getElementsByName("eval_file_attached_"(i+1)).value=indexStr+missSeriesMapArrayValues[0];
		  /*  if(missSeriesMapArrayValues[1]!='noFile'){
		   var path_file='getFileAttached("getfile/evaluation/${seriesForm.missSery.msId}_'+missSeriesMapArrayValues[0]+"/"+missSeriesMapArrayValues[2]+'")';
			$('#eval_file_attached_'+(i+1)).attr('onclick',path_file);
			$('#eval_file_attached_'+(i+1)).html(missSeriesMapArrayValues[1]);
			$('#eval_file_attached_'+(i+1)).attr('style','cursor: pointer;');
	     } */
	   }
   }
   new AjaxUpload('template_file', {
       action: 'upload/template/${seriesForm.missSery.msId}',
		onSubmit : function(file , ext){
           // Allow only images. You should add security check on the server-side.
			if (ext && /^(jasper)$/.test(ext)){
				/* Setting data */
				this.setData({
				});					
			//$('#contact_photo').attr('src', _path+"resources/images/ui-anim_basic_16x16.gif");
			//$('#contact_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only jasper are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			//alert(file+","+response);
			var obj = jQuery.parseJSON(response);
			var path_file='getFileAttached("getfile/template/${seriesForm.missSery.msId}/'+obj.hotlink+'")';
			//$('#template_file_attached').attr('onclick',path_file);
			$('#template_file_attached').html(file);
			//$('#template_file_attached').attr('style','cursor: pointer;');	
		}		
	});
   new AjaxUpload('eval_file', {
       action: 'upload/evaluation/${seriesForm.missSery.msId}',
		onSubmit : function(file , ext){
           // Allow only images. You should add security check on the server-side. 
			if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
				 this.setData({
					//'meId': document.getElementsByName("missExam_mapping")[1-1].value.split("_")[1],
					'msId': document.getElementById("msId").value
				});					
			} else {					
				// extension is not allowed
				alert('Error: only xls are allowed') ;
				// cancel upload
				return false;				
			}	
		},
		onComplete : function(file, response){
			var obj = jQuery.parseJSON(response);
			//alert(file+","+obj.hotlink);
			var path_file='getFileAttached("getfile/evaluation/${seriesForm.missSery.msId}/'+obj.hotlink+'")';
			$('#eval_file_attached').attr('onclick',path_file);
			$('#eval_file_attached').html(file);
			$('#eval_file_attached').attr('style','cursor: pointer;');
			//$('#example2 .text').text('Uploaded ' + file);		
		}		
	});
   
   new AjaxUpload('manual_file', {
       action: 'upload/attachManual/${seriesForm.missSery.msId}',
		onSubmit : function(file , ext){
           // Allow only images. You should add security check on the server-side.
			if (ext && /^(pdf|PDF)$/.test(ext)){
				/* Setting data */
				this.setData({
				});					
			//$('#contact_photo').attr('src', _path+"resources/images/ui-anim_basic_16x16.gif");
			//$('#contact_photo').attr('src', _path+"resources/images/loading.gif");
			} else {					
				// extension is not allowed
				alert('Error: only pdf are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){
			var obj = jQuery.parseJSON(response);
			//alert(file+","+obj.hotlink);
			var path_file='getFileAttached("getfile/attachManual/${seriesForm.missSery.msId}/'+obj.hotlink+'")';
			$('#manual_file_attached').attr('onclick',path_file);
			$('#manual_file_attached').html(file);
			$('#manual_file_attached').attr('style','cursor: pointer;');
			//$('#example2 .text').text('Uploaded ' + file);		
		}		
	});
   
 //  for(var i=1;i<=5;i++){ 
	 //  new AjaxUpload('evaluation_file_'+i,  {
		 /*
		   new AjaxUpload('evaluation_file_1', {
	       action: 'upload/evaluation/seriesForm.missSery.msId',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
					 this.setData({
						'meId': document.getElementsByName("missExam_mapping")[1-1].value.split("_")[1],
						'msId': document.getElementById("msId").value
					});					
				} else {					
					// extension is not allowed
					alert('Error: only xls are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				var meId= document.getElementsByName("missExam_mapping")[1-1].value.split("_")[1];
				//alert(meId);
				var path_file='getFileAttached("getfile/evaluation/seriesForm.missSery.msId_'+meId+"/"+obj.hotlink+'")';
				$('#eval_file_attached_1').attr('onclick',path_file);
				$('#eval_file_attached_1').html(file);
				$('#eval_file_attached_1').attr('style','cursor: pointer;');
			}		
		});
   //}
	   new AjaxUpload('evaluation_file_2', {
	       action: 'upload/evaluation/seriesForm.missSery.msId',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
					 this.setData({
						'meId': document.getElementsByName("missExam_mapping")[2-1].value.split("_")[1] ,
						'msId': document.getElementById("msId").value
					});	 				
				} else {					
					// extension is not allowed
					alert('Error: only xls are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				var meId= document.getElementsByName("missExam_mapping")[2-1].value.split("_")[1];
				var path_file='getFileAttached("getfile/evaluation/seriesForm.missSery.msId_'+meId+"/"+obj.hotlink+'")';
				$('#eval_file_attached_2').attr('onclick',path_file);
				$('#eval_file_attached_2').html(file);
				$('#eval_file_attached_2').attr('style','cursor: pointer;');
			}		
		});
	   new AjaxUpload('evaluation_file_3', {
	       action: 'upload/evaluation/seriesForm.missSery.msId',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
					 this.setData({
						'meId': document.getElementsByName("missExam_mapping")[3-1].value.split("_")[1] ,
						'msId': document.getElementById("msId").value
					});	 			
				} else {					
					// extension is not allowed
					alert('Error: only xls are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				var meId= document.getElementsByName("missExam_mapping")[3-1].value.split("_")[1];
				var path_file='getFileAttached("getfile/evaluation/seriesForm.missSery.msId_'+meId+"/"+obj.hotlink+'")';
				$('#eval_file_attached_3').attr('onclick',path_file);
				$('#eval_file_attached_3').html(file);
				$('#eval_file_attached_3').attr('style','cursor: pointer;');
			}		
		});
	   new AjaxUpload('evaluation_file_4', {
	       action: 'upload/evaluation/seriesForm.missSery.msId',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
					 this.setData({
						'meId': document.getElementsByName("missExam_mapping")[4-1].value.split("_")[1] ,
						'msId': document.getElementById("msId").value
					});	 
				} else {					
					// extension is not allowed
					alert('Error: only xls are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				var meId= document.getElementsByName("missExam_mapping")[4-1].value.split("_")[1];
				var path_file='getFileAttached("getfile/evaluation/seriesForm.missSery.msId_'+meId+"/"+obj.hotlink+'")';
				$('#eval_file_attached_4').attr('onclick',path_file);
				$('#eval_file_attached_4').html(file);
				$('#eval_file_attached_4').attr('style','cursor: pointer;');
			}		
		});
	   new AjaxUpload('evaluation_file_5', {
	       action: 'upload/evaluation/seriesForm.missSery.msId',
			onSubmit : function(file , ext){
	           // Allow only images. You should add security check on the server-side.
				if (ext && /^(xls|XLS|xlsx|XLSX)$/.test(ext)){
					 this.setData({
						'meId': document.getElementsByName("missExam_mapping")[5-1].value.split("_")[1] ,
						'msId': document.getElementById("msId").value
					});	 
				} else {					
					// extension is not allowed
					alert('Error: only xls are allowed') ;
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file, response){
				var obj = jQuery.parseJSON(response);
				var meId= document.getElementsByName("missExam_mapping")[5-1].value.split("_")[1];
				var path_file='getFileAttached("getfile/evaluation/seriesForm.missSery.msId_'+meId+"/"+obj.hotlink+'")';
				$('#eval_file_attached_5').attr('onclick',path_file);
				$('#eval_file_attached_5').html(file);
				$('#eval_file_attached_5').attr('style','cursor: pointer;');
			}		
		});
	   */
});
function getFileAttached(path){
	// alert(path)
    var div = document.createElement("div");
    document.body.appendChild(div);
    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + path + "'></iframe>";
	  // Create an IFRAME.
}
function doAction(action,mode,id){
	$("#mode").val(mode);
	if(mode!='search'){
		$("#msId").val(id);
	}else{
		$("#msId").val("0");
	}
	var missSeriesMapStr="";
	 var element = document.getElementsByName("missExam_mapping");
	 for(var i=0;i<element.length;i++){
		 if(element[i].value!=0)
			 missSeriesMapStr=missSeriesMapStr+element[i].value+",";
	 }
	//alert(missSeriesMapStr);
	missSeriesMapStr=missSeriesMapStr.substring(0, missSeriesMapStr.length-1);
	//alert(missSeriesMapStr);
	$("#missSeriesMap").val(missSeriesMapStr);
	//alert(action)
	$.post("series/"+action,$("#seriesForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
  }
 function setElementValue(obj_select,index){
	 //alert(obj_select.value+",index="+index);
	 var values=obj_select.value.split("_");
	$("#eval_file_value_"+index).val(values[1]);
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
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
          <!-- <form class="well"> -->
          <form:form  id="seriesForm" name="seriesForm" modelAttribute="seriesForm" cssClass="well" cssStyle="border:2px solid ${UserMissContact.missTheme.mtBgColor};background: url('/MISSExamBackOffice/resources/images/${UserMissContact.missTheme.mtWaterWall}') no-repeat scroll right top ${UserMissContact.missTheme.mtBgColor}" method="post" action="">
            <form:hidden path="mode"/>
          <form:hidden path="missSery.msId" id="msId"/> 
            <%--  <form:input path="missSery.msId" id="msId"/> --%>
            <input type="hidden" id="missSeriesMap" name="missSeriesMap" value="${missSeriesMap}"/>
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="left" width="100%" colspan="6"><strong>Series&nbsp;
	    					 <c:if test="${seriesForm.mode=='new'}">
	    					 New
	    					 </c:if>
	    					 <c:if test="${seriesForm.mode=='edit'}">
	    					 Edit
	    					 </c:if>
	    					 </strong></td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Series Name:</td>
	    					 <td align="left" width="17%">    					
	    						<!-- <input type="text"/>  -->
	    						<form:input path="missSery.msSeriesName" id="msSeriesName"/>
	    					 </td>
	    					<td align="left" width="17%"></td>
	    					<td align="left" width="17%">
	    					<!-- <input type="text" name="registerNo" class="height_input"/></td> -->
	    					
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Unit Cost:</td>
	    					 <td align="left" width="17%">    					
	    						<!-- <input type="text"/>  -->
	    						<form:input path="missSery.msUnitCost" id="msUnitCost" cssStyle="width:50px"/>
	    					 </td>
	    					<td align="left" width="17%"></td>
	    					<td align="left" width="17%">
	    					<!-- <input type="text" name="registerNo" class="height_input"/></td> -->
	    					
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Template File:</td>
	    					 <td align="left" width="51%" colspan="3">   
	    					  <c:if test="${seriesForm.mode=='new'}">					
		    					<a class="btn" id="template_file" disabled><i class="icon-file"></i>&nbsp;<span style="">Upload Template</span></a>
		    					(You must save before)
		    				  </c:if> 
		    				   <c:if test="${seriesForm.mode=='edit'}">					
		    					<a class="btn" id="template_file"><i class="icon-file"></i>&nbsp;<span style="">Upload Template</span></a>
		    				  </c:if>
		    					<%--
		    					<span id="template_file_attached" style="cursor: pointer;" onclick="getFileAttached('getfile/template/${seriesForm.missSery.msId}/${seriesForm.missSery.templateFileHotlink}')">
	    				${seriesForm.missSery.templateFile}</span>
	    				 		--%>
	    				 		<span id="template_file_attached">
	    				${seriesForm.missSery.templateFile}</span>
	    					 </td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Evaluation File:</td>
	    					 <td align="left" width="51%" colspan="3">    	
	    					 <c:if test="${seriesForm.mode=='new'}">		
	    						<a class="btn" id="eval_file"><i class="icon-file"></i>&nbsp;<span style="">Upload Evaluation</span></a>
	    					 	(You must save before)
	    					 </c:if>
	    					  <c:if test="${seriesForm.mode=='edit'}">					
		    					<a class="btn" id="eval_file"><i class="icon-file"></i>&nbsp;<span style="">Upload Evaluation</span></a>
		    				  </c:if>
	    						<span id="eval_file_attached" style="cursor: pointer;" onclick="getFileAttached('getfile/evaluation/${seriesForm.missSery.msId}/${seriesForm.missSery.evalFileHotlink}')">
	    						${seriesForm.missSery.evalFile}</span>
	    					 </td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr>
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Manual File:</td>
	    					 <td align="left" width="51%" colspan="3">    	
	    					 <c:if test="${seriesForm.mode=='new'}">		
	    						<a class="btn" id="manual_file"><i class="icon-file"></i>&nbsp;<span style="">Upload Manual</span></a>
	    					 	(You must save before)
	    					 </c:if>		
	    					 <c:if test="${seriesForm.mode=='edit'}">					
		    					<a class="btn" id="manual_file"><i class="icon-file"></i>&nbsp;<span style="">Upload Manual</span></a>
		    				  </c:if>
	    						<span id="manual_file_attached" style="cursor: pointer;" onclick="getFileAttached('getfile/attachManual/${seriesForm.missSery.msId}/${seriesForm.missSery.manualFileHotlink}')">
	    						${seriesForm.missSery.manualFile}</span>
	    					 </td>
	    					 
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					</table> 
	    					<input type="hidden" id="eval_file_value_1" />
	    					<input type="hidden" id="eval_file_value_2" />
	    					<input type="hidden" id="eval_file_value_3" />
	    					<input type="hidden" id="eval_file_value_4" />
	    					<input type="hidden" id="eval_file_value_5" />
	    		</form:form>
	    					<table  border="0" width="100%" style="font-size: 13px">
	    					<tr>
	    					<td align="left" width="100%">
	    					<strong>Test</strong>
	    					</td>
	    					</tr>
	    					</table> 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="10%"><div class="th_class">Order</div></th>
            		<th width="90%"><div class="th_class">Test</div></th>             		        		 
          		</tr>
        	</thead>
        	<tbody>
          	<tr>
            	<td>1</td>
            	<td>
            	<!-- <select name="missExam_mapping" id="1_missExam_mapping"> -->
            	 <select name="missExam_mapping" onchange="setElementValue(this,'1')">
											 <option value="0">--- Select ---</option>
											 <!-- <option value="1">MCCT</option> -->
											  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 				<option  value="<c:out value="1_${missExam.meId}"></c:out>"><c:out value="${missExam.meName}"></c:out></option>
	    								 	  </c:forEach>
	    		</select>&nbsp;   
	    		  				<%--	
	    						<a class="btn" id="evaluation_file_1"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a>
	    							<span id="eval_file_attached_1" style="cursor: pointer;">
	    						</span> (Evaluation File)
	    						 --%>
	    						</td>
          	</tr>
          	<tr>
            	<td>2</td>
            	<td>
            	<select name="missExam_mapping" >
											 <option value="0">--- Select ---</option>
											 <!-- <option value="1">MCCT</option> -->
											  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 				<option  value="<c:out value="2_${missExam.meId}"></c:out>"><c:out value="${missExam.meName}"></c:out></option>
	    								 	  </c:forEach>
	    		</select>&nbsp;  
	    		<%--   					
	    						<a class="btn" id="evaluation_file_2"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a> 
	    						<span id="eval_file_attached_2" style="cursor: pointer;">
	    						</span> (Evaluation File)
	    						--%>
	    		</td>
          	</tr>
          	<tr>
            	<td>3</td>
            	<td>
            	<select name="missExam_mapping">
											 <option value="0">--- Select ---</option>
											 <!-- <option value="1">MCCT</option> -->
											  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 				<option  value="<c:out value="3_${missExam.meId}"></c:out>"><c:out value="${missExam.meName}"></c:out></option>
	    								 	  </c:forEach>
	    		</select>&nbsp;   
	    		<%--  					
	    						<a class="btn" id="evaluation_file_3"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a>
	    						<span id="eval_file_attached_3" style="cursor: pointer;">
	    						</span> (Evaluation File)
	    						 --%>
	    		</td>
          	</tr>
          	<tr>
            	<td>4</td>
            	<td>
            	<select name="missExam_mapping" >
											 <option value="0">--- Select ---</option>
											 <!-- <option value="1">MCCT</option> -->
											  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 				<option  value="<c:out value="4_${missExam.meId}"></c:out>"><c:out value="${missExam.meName}"></c:out></option>
	    								 	  </c:forEach>
	    		</select>&nbsp;     	
	    		<%--				
	    						<a class="btn" id="evaluation_file_4"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a> 
	    						<span id="eval_file_attached_4" style="cursor: pointer;">
	    						</span> (Evaluation File)
	    						 --%>
	    		</td>
          	</tr>
          	<tr>
            	<td>5</td>
            	<td>
            	<select name="missExam_mapping" >
											 <option value="0">--- Select ---</option>
											 <!-- <option value="1">MCCT</option> -->
											  <c:forEach items="${missExams}" var="missExam" varStatus="loop"> 
	    					 		 				<option  value="<c:out value="5_${missExam.meId}"></c:out>"><c:out value="${missExam.meName}"></c:out></option>
	    								 	  </c:forEach>
	    		</select>&nbsp;
	    		<%--     					
	    						<a class="btn" id="evaluation_file_5"><i class="icon-file"></i>&nbsp;<span style="">Upload</span></a> 
	    						<span id="eval_file_attached_5" style="cursor: pointer;">
	    						</span> (Evaluation File)
	    						 --%>
	    		</td>
          	</tr>
          	
        	</tbody>
      </table>
      <div align="center"><a class="btn btn-info"  onclick="doAction('search','doBack','0')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a> <a class="btn btn-primary"  onclick="doAction('action','${seriesForm.mode}','${seriesForm.missSery.msId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a></div>
      
</fieldset>