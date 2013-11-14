<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>

$(document).ready(function() {
	/* renderPageSelect();
	if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 } */
	getModel('1','init');
	//getDepartment();
	//getRenderMapping(1);
});
function getModel(id,mode){ 
	var query="SELECT pm_id,pm_name  FROM "+SCHEMA_G+".PST_MODEL where pm_type="+id+" order by pm_name "; 
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <select name=\"modelSelect\" id=\"modelSelect\" onchange=\"getRenderMapping(1)\" style=\"width: 190px\"> "+
			        "";  
			//str=str+ " <option value=\"-1\">---</option>";
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ " <option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
				   }
			   }
			        str=str+  " </select>"+
			$("#model_section").html(str);
			if(mode=='init')
				getDepartment(mode);
			
		}
	}); 
}
function getDepartment(mode){ 
	var query="SELECT pd_id,pd_name FROM  "+SCHEMA_G+".PST_DEPARTMENT order by pd_name "; 
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <select name=\"departmentSelect\" id=\"departmentSelect\" onchange=\"getRenderMapping(1)\" style=\"width: 190px\"> "+
			        "";  
			//str=str+ " <option value=\"-1\">---</option>";
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ " <option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
				   }
			   }
			        str=str+  " </select>"+
			$("#department_section").html(str);
			        if(mode=='init')
			        	 getRenderMapping(1);
		}
	}); 
}

function doUpdateMapping(){
	//<td style=\"text-align: left;\"><input type=\"checkbox\" name=\"pwtNameCheckbox\" "+checked+" value=\""+pcm_type+"_"+pcm_ref_type_no+"_"+data[i][7]+"_"+data[i][1]+"\"/>&nbsp;&nbsp;"+(limitRow+i+1)+" </td>"+
	var pwtNameCheckboxArray=document.getElementsByName("pwtNameCheckbox");
	var pwtNameCheckboxDelete=[];
	var pwtNameCheckboxUpdate=[];
	for(var i=0;i<pwtNameCheckboxArray.length;i++){
		if(pwtNameCheckboxArray[i].checked){
			pwtNameCheckboxUpdate.push(pwtNameCheckboxArray[i].value);
		}else
			pwtNameCheckboxDelete.push(pwtNameCheckboxArray[i].value);
	}
	PSTAjax.executeQueryUpdate(pwtNameCheckboxDelete,pwtNameCheckboxUpdate,{
		callback:function(data){ 
		   	//alert(data)
		   	
		  if(data>0){
			//  alert("more than 0")
			 // alert($("#message_element > strong").html().length)
		   //	if($("#message_element > strong").html().length>0){
				 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
				 $("#message_element").slideDown("slow"); 
				 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
			// }
		   	}
		}
	});
	/* if(pwtNameCheckboxDelete.length>0){
		PSTAjax.executeQueryDelete(pwtNameCheckboxDelete,{
			callback:function(data){ 
			   	
			}
		});
	}
	if(pwtNameCheckboxUpdate.length>0){
		PSTAjax.executeQueryUpdate(pwtNameCheckboxDelete,pwtNameCheckboxUpdate,{
			callback:function(data){ 
			   	
			}
		});
	} */
	/* alert("pwtNameCheckboxDelete->"+pwtNameCheckboxDelete.length);
	alert("pwtNameCheckboxUpdate->"+pwtNameCheckboxUpdate.length); */
}
function getRenderMapping(_page){ 
	/*
	SELECT (select count(*) from PST_DB.PST_CHECKING_MAPPING c_mapping 
		-- where  c_mapping.pcm_type=1 and c_mapping.pcm_ref_type_no=1
		) as count_map,
		w_type.pwt_name FROM PST_DB.PST_WORK_TYPE w_type left join 
		 PST_DB.PST_CHECKING_MAPPING c_mapping on w_type.pwt_id=c_mapping.pwt_id 
		-- where w_type.pd_id=2
		*/
   $("#pageNo").val(_page);
   var pd_id=$("#departmentSelect").val();
   var pcm_ref_type_no=$("#modelSelect").val();
   var pcm_type=$('input:radio[name=checkname]:checked').val();
	//alert("pcm_type->"+pcm_type+"pd_id->"+pd_id+",pcm_ref_type_no->"+pcm_ref_type_no);
	//var query=" SELECT (select count(*) from PST_DB.PST_CHECKING_MAPPING c_mapping ";
	var query="  SELECT (select count(*) from PST_DB.PST_CHECKING_MAPPING c_mapping ";
			//" FROM  "+SCHEMA_G+".PST_DEPARTMENT order by pd_name "; 
	var haveWhere=false;
	if(pcm_type!='-1'){
		query=query+((haveWhere)?" and ":" where ")+" c_mapping.pcm_type="+pcm_type;
		haveWhere=true;
	}
	if(pcm_ref_type_no!='-1'){
		query=query+((haveWhere)?" and ":" where ")+" c_mapping.pcm_ref_type_no="+pcm_ref_type_no;
		haveWhere=true;
	}
	if(pd_id!='-1'){
		query=query+((haveWhere)?" and ":" where ")+" c_mapping.pd_id="+pd_id;
		haveWhere=true;
	}
	query=query+((haveWhere)?" and ":" where ")+" c_mapping.pwt_id= w_type.pwt_id ";
	query=query+" ) as count_map,  w_type.pwt_id,w_type.pwt_name,w_type.pwt_period,w_type.pwt_concrete,"+ 
	" w_type.pwt_mile,w_type.pwt_hours_of_work, dept.pd_id,dept.pd_name  FROM "+SCHEMA_G+".PST_WORK_TYPE w_type "+
	" left join PST_DB.PST_DEPARTMENT dept on w_type.pd_id=dept.pd_id  ";
	
	//" left join "+SCHEMA_G+".PST_CHECKING_MAPPING c_mapping on w_type.pwt_id=c_mapping.pwt_id ";
	if(pd_id!='-1'){
		query=query+" where w_type.pd_id="+pd_id;
		//haveWhere=true;
	}
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(limitRow);
	var queryObject="  "+query+" order by w_type.pwt_name limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	//alert(queryObject);
 	PSTAjax.searchObject(queryObject,{
		callback:function(data){
			//alert(data);
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var update_section=" <a class=\"btn btn-primary\"  onclick=\"doUpdateMapping()\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Update</span></a>";
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        //<input type=\"checkbox\" id=\"mcaIdCheckboxAll\" onclick=\"toggleCheckbox()\"/>
			        "  		<th width=\"10%\"><div class=\"th_class\">ลำดับ</div></th> "+
			        "  		<th width=\"31%\"><div class=\"th_class\">รายการตรวจเช็ค</div></th> "+
			        "  		<th width=\"24%\"><div class=\"th_class\">แผนก</div></th>  "+
			        "  		<th width=\"10%\"><div class=\"th_class\">ระยะเวลา(วัน)</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\">คอนกรีต(คิว)</div></th>  "+
			        "  		<th width=\"10%\"><div class=\"th_class\">เลขไมค์(กม)</div></th>  "+
			        "  		<th width=\"10%\"><div class=\"th_class\">ชม.การทำงาน(ชม)</div></th> "+  
			       // "  		<th width=\"8%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			      /*   `PCM_TYPE` varchar(1) NOT NULL COMMENT '1=ตามรุ่นรถ/\\n2=ตามรุ่นปั๊ม', pcm_type
			        `PCM_REF_TYPE_NO` int(11) NOT NULL, pcm_ref_type_no
			        `PD_ID` int(11) NOT NULL,
			        `PWT_ID` int(11) NOT NULL, */
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   var checked="";
					   if(data[i][0]>0)
						   checked= "checked=\"checked\" "; 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"checkbox\" name=\"pwtNameCheckbox\" "+checked+" value=\""+pcm_type+"_"+pcm_ref_type_no+"_"+data[i][7]+"_"+data[i][1]+"\"/>&nbsp;&nbsp;"+(limitRow+i+1)+" </td>"+  
				        "  		<td style=\"text-align: left;\"> "+(data[i][2]!=null?data[i][2]:"")+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+(data[i][8]!=null?data[i][8]:"")+"</td>  "+
				        "    	<td style=\"text-align: right;\">"+(data[i][3]!=null?data[i][3]:"")+"</td>  "+
				        "    	<td style=\"text-align: right;\">"+(data[i][4]!=null?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: right;\">"+(data[i][5]!=null?data[i][5]:"")+"</td>  "+
				        "    	<td style=\"text-align: right;\">"+(data[i][6]!=null?data[i][6]:"")+"</td>  "+
				      /*   "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPageWithMode('edit','maintenance/page/maintenance_dept_management','"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+ */
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			 //   var str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    //		"<thead>"+
		    	str=str+ "<tr> "+
	      			"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>";
	    	/* "</thead>"+
	    	"<tbody>";  */
		    	update_section="";
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#check_section").html(str);
			$("#update_section").html(update_section);
			
		}
	}); 
 	
	//alert(queryCount);
	PSTAjax.searchObject(queryCount,{
		callback:function(data){
			//alert(data)
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect(pageCount);
		}
	});
}

function goPrev(){
	//alert($("#pageNo").val());
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		getRenderMapping(prev);
		//doAction('search','0');
	}
}
function goNext(){
	//alert("next->"+next);
	var next=parseInt($("#pageNo").val());
	//alert("next->"+next+",$(\"pageNo\").val()->"+$("#pageNo").val());
	//alert("$(\"pageCount\").val()->"+$("#pageCount").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		getRenderMapping(next);
		//doAction('search','0');
	}
} 
function goToPage(){ 
	//alert($("#pageNo").val());
	$("#pageNo").val(document.getElementById("breakdownPageSelect").value);
	getRenderMapping($("#pageNo").val());
	//doAction('search','0');
}
function renderPageSelect(pageCount){
	 
	var pageStr="<select name=\"breakdownPageSelect\" id=\"breakdownPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	//var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("breakdownPageSelect").value=$("#pageNo").val();
}
function confirmDelete(mode,id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(mode,id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
}
function doSearch(mode,id){
	$("#pageNo").val("1");
	//doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#pbdIdArray").val(id);
	}else if(mode!='search'){
		$("#pbdId").val(id);
	}else {
		$("#pbdId").val("0");
	}
	$.post("breakdown/search",$("#breakdownForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
</script>
<div id="dialog-confirmDelete" title="Delete Breakdown" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Breakdown ?
</div>
  <%-- <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div> --%>
  <div id="message_element" class="alert alert-success" style="display: none;padding-top:10px">
     <button class="close" onclick="$('.alert').hide();"><span style="font-size: 12px">x</span></button> 
    <strong>Update success !</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px"> 
            <form id="breakdownForm" name="breakdownForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post"> 
           <%--  <form:form id="breakdownForm" name="breakdownForm" modelAttribute="breakdownForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post"> --%>
            <input type="hidden" id="mode"/>
            <input type="hidden" id="pbdIdArray"/>
            <input type="hidden" id="pbdId"/>
            <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
           
            <!-- <input id="mode" name="mode" type="hidden" value="">
            <input id="mcaId" name="missCandidate.mcaId" type="hidden" value="">
            <input id="mcaIdArray" name="mcaIdArray" type="hidden" value="">
            <input id="pageNo" name="paging.pageNo" type="hidden" value="1">
            <input id="pageSize" name="paging.pageSize" type="hidden" value="20"> 
            <input id="pageCount" name="pageCount" type="hidden" value="8">  -->
            <div align="left">
            <strong>จัดการรายการตรวจเช็ค</strong>
            </div>
            <div align="left" style="padding-left: 10px">
            	<span style="font-size: 13px;">ตรวจเช็คตาม:</span> 
            	<span style="padding: 20px">
            	<%-- <form:input path="pstBreakDown.pbdUid" cssStyle="height: 30;width:80px"/> --%>
            	 <input type="radio" value="1" checked="checked" name="checkname" onclick="getModel('1','init')"/>&nbsp;รุ่นรถ&nbsp;&nbsp;/
            	 <input type="radio" value="2"  name="checkname" onclick="getModel('2','init')"/>&nbsp;รุ่นปั๊ม
            	</span>  
	    		 <span style="font-size: 13px;">รุ่น:</span> 
            	<span style="padding: 20px" id="model_section">  
            	</span>  
            	 <span style="font-size: 13px;">แผนก:</span> 
            	<span style="padding: 20px" id="department_section"> 
            	  <!-- <input type="text" style="height: 30;">  -->
            	</span> 
            </div>
			</form>
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					<!-- <a class="btn btn-danger"  ><i class="icon-minus-sign icon-white"></i>&nbsp;Delete</a>&nbsp;
	    					<a class="btn btn-primary"  ><i class="icon-plus-sign icon-white"></i>&nbsp;Add</a>&nbsp; -->
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="breakdownPageSelect" id="breakdownPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					<!-- <a class="btn btn-primary" onclick="getRenderMapping(1)"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					
	    					</td>
	    					</tr>
	    					</tbody></table>
	    					<div  id="check_section">
	 							 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">ลำดับ</div></th>
            		<th width="27%"><div class="th_class">รายการตรวจเช็ค</div></th>
            		<th width="20%"><div class="th_class">แผนก</div></th> 
            		<th width="10%"><div class="th_class">ระยะเวลา(วัน)</div></th> 
            		<th width="5%"><div class="th_class">คอนกรีต(คิว)</div></th> 
            		<th width="10%"><div class="th_class">เลขไมค์(กม)</div></th> 
            		<th width="10%"><div class="th_class">ชม.การทำงาน(ชม)</div></th>  
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	</tbody>
        	</table>
    						</div>
    						<div align="center" id="update_section">
			
			</div>
    						<%-- 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="10%"><div class="th_class">ลำดับ</div></th>
            		<th width="27%"><div class="th_class">รายการตรวจเช็ค</div></th>
            		<th width="20%"><div class="th_class">แผนก</div></th> 
            		<th width="10%"><div class="th_class">ระยะเวลา(วัน)</div></th> 
            		<th width="5%"><div class="th_class">คอนกรีต(คิว)</div></th> 
            		<th width="10%"><div class="th_class">เลขไมค์(กม)</div></th> 
            		<th width="10%"><div class="th_class">ชม.การทำงาน(ชม)</div></th>  
            		<th width="8%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody> 
        	<c:if test="${not empty pstBreakDowns}"> 
        	 <c:forEach items="${pstBreakDowns}" var="pstBreakDown" varStatus="loop"> 
          	<tr> 
            	<td>${pstBreakDown.pbdUid}</td>
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td>${pstBreakDown.pbdName}</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('breakdown/item/${pstBreakDown.pbdId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstBreakDown.pbdId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstBreakDowns}"> 
          	<tr>
          		<td colspan="8" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
        	</tbody>
      </table> 
       --%>
      </fieldset> 