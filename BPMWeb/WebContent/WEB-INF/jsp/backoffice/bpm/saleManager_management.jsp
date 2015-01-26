<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
<script type="text/javascript">
$(document).ready(function() { 
   getDepartment(); 
}); 
function assignUser(type){
	//var str="";
	var function_str="assignUserToDept()";
	var label_str="Assign to Department";
	var input_id="user_input";
	var input_hidden_id="bdeptUserId";
	var query="SELECT username,firstName,id  FROM "+SCHEMA_G+".user "+	
	  " where not exists ( "+	
	  " select * from "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user where dept_user.user_id=user.id "+	 
	  " and dept_user.bdept_id=${bdeptId} "+	
	  " ) "+
	//" and not exists ( "+
	//  " SELECT * FROM "+SCHEMA_G+".BPM_DEPARTMENT  where bdept_hdo_user_id=user.id "+
	//  ") "+
	" and username like ";
	//alert(type)
	if(type=='hod'){
		// str="";
		function_str="assignHOD()";
		label_str="Assign to HOD";
		input_id="hod_input";
		input_hidden_id="bdeptHOD";
		query="SELECT username,firstName,id  FROM "+SCHEMA_G+".user "+	
		  " where not exists ( "+	
		  " select * from "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user where dept_user.user_id=user.id "+	 
		  " and dept_user.bdept_id=${bdeptId} "+	
		  " ) and username like ";
	}
	var bt= "<span>&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
	 bootbox.dialog("<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+bt+"</span>",[{
		    "label" : "Cancel",
		    "class" : "btn-danger"
	 }]);
	 /*
	 , [{
		    "label" : "Success!",
		    "class" : "btn-success",
		    "callback": function() {
		        Example.show("great success");
		    }
		}]);
		*/
	 $("#"+input_id+"" ).autocomplete({
		  source: function( request, response ) {    
			  //$("#pjCustomerNo").val(ui.item.label); 
			  var queryiner=query+" '%"+request.term+"%' ";
				SynDomeBPMAjax.searchObject(queryiner,{
					callback:function(data){ 
						if(data.resultMessage.msgCode=='ok'){
							data=data.resultListObj;
						}else{// Error Code
							//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
							  bootbox.dialog(data.resultMessage.msgDesc,[{
								    "label" : "Close",
								     "class" : "btn-danger"
							 }]);
							 return false;
						}
						if(data!=null && data.length>0){
							response( $.map( data, function( item ) {
					          return {
					        	  label: item[0],
					        	  value: item[0] ,
					        	  id: item[2]
					          }
					        }));
						}else{
							var xx=[]; 
							response( $.map(xx));
						}
					}
			 });		  
		  },
		  minLength: 1,
		  select: function( event, ui ) { 
			  this.value = ui.item.label;
			  $("#"+input_hidden_id+"").val(ui.item.id); 
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		}); 
}
function assignHOD(){
	//alert( $("#bdeptHOD").val());
	var bdeptHOD=jQuery.trim($("#bdeptHOD").val());
	//alert(bdeptHOD.length);
	 if(bdeptHOD.length>0){
		var querys=[];  
		var query="update "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_HDO_USER_ID="+bdeptHOD+" where BDEPT_ID=${bdeptId}"; 
		querys.push(query); 
		SynDomeBPMAjax.executeQuery(querys,{
			callback:function(data){ 
				if(data.resultMessage.msgCode=='ok'){
					data=data.updateRecord;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=0){
					loadDynamicPage('dispatcher/page/department_management?bdeptId=${bdeptId}&mode=edit');
				}
			}
		});
	}
	bootbox.hideAll();
}
function assignUserToDept(){
	//alert( $("#bdeptUserId").val());
	var bdeptUserId=jQuery.trim($("#bdeptUserId").val());
	//alert(bdeptUserId.length);
	 if(bdeptUserId.length>0){
		var querys=[];
		var query="insert into "+SCHEMA_G+".BPM_DEPARTMENT_USER set USER_ID="+bdeptUserId+",BDEPT_ID=${bdeptId}";
		querys.push(query); 
		SynDomeBPMAjax.executeQuery(querys,{
			callback:function(data){ 
				if(data.resultMessage.msgCode=='ok'){
					data=data.updateRecord;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=0){
					searchUserList("1");
				}
			}
		});
	}
	bootbox.hideAll();
}
function getDepartment(){  
	var isEdit=false;
	var function_message="Add";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	$("#department_title").html("Department Management ("+function_message+")");
  if(isEdit){  
	  var query="SELECT dept.BDEPT_ID,dept.BDEPT_NAME,dept.BDEPT_DETAIL,dept.BDEPT_HDO_USER_ID, "+
		  " user.username,user.firstName,user.lastName from "+SCHEMA_G+".BPM_DEPARTMENT dept left join "+SCHEMA_G+".user user on dept.BDEPT_HDO_USER_ID=user.id where dept.BDEPT_ID=${bdeptId}";
		 		 
	   SynDomeBPMAjax.searchObject(query,{
			callback:function(data){ 
				if(data.resultMessage.msgCode=='ok'){
					data=data.resultListObj;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=null && data.length>0){
					$("#bdeptName").val(data[0][1]);
					$("#bdeptDetail").val(data[0][2]);
					$("#bdeptHOD").val(data[0][3]);   
					if(data[0][3]!=null){ 
						 $("#hodElement").html("<strong>"+data[0][4]+"</strong>"); 
						 $("#hodElement").css("cursor","pointer");   
					}else{
						$("#hodElement").html("Not set");
						$("#hodElement").css("color","red");
						$("#hodElement").css("cursor","pointer");  
					}
				}else{
					
				} 
				searchUserList("1");
			}
	 	  }); 
  }else{
	  $("#hodElement").html("Not set");
	  $("#hodElement").css("color","red");
	  $("#hodElement").css("cursor","pointer"); 
	 var str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		"<thead>"+
		"<tr> "+
		"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
		"</tr>"+
		"</thead>"+
		"<tbody></table> ";    
	//$("#user_section").html(str);
   }
}
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchUserList(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchUserList(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchUserList($("#pageNo").val());
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"pageSelect\" id=\"pageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val(); 
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	checkWithSet("pageSelect",$("#pageNo").val());;
}
function confirmDelete(id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
} 
function doAction(id){
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER where user_id="+id+" and BDEPT_ID=${bdeptId}"; 
	querys.push(query); 
	SynDomeBPMAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data.resultMessage.msgCode=='ok'){
				data=data.updateRecord;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			if(data!=0){
				searchUserList("1"); 
			}
		}
	});
} 
function searchUserList(_page){  
	$("#pageNo").val(_page); 
	var query="SELECT user.id,user.username,user.firstName,user.lastName ,user.email,user.mobile "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER  dept_user  left join  "+SCHEMA_G+".user on dept_user.USER_ID=user.id "+ 
		" where dept_user.BDEPT_ID=${bdeptId}";
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	SynDomeBPMAjax.searchObject(queryObject,{
		callback:function(data){
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			        "  		<th width=\"9%\"><div class=\"th_class\">Username</div></th> "+
			        "  		<th width=\"11%\"><div class=\"th_class\">First Name</div></th> "+  
			        "  		<th width=\"15%\"><div class=\"th_class\">Last Name</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Email</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Mobile</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+data[i][2]+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+((data[i][5]!=null)?data[i][5]:"")+"</td>  "+   
				        "    	<td style=\"text-align: center;\">"+   
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#user_section").html(str);
		}
	}); 
	SynDomeBPMAjax.searchObject(queryCount,{
		callback:function(data){ 
			if(data.resultMessage.msgCode=='ok'){
				data=data.resultListObj;
			}else{// Error Code
				//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
				  bootbox.dialog(data.resultMessage.msgDesc,[{
					    "label" : "Close",
					     "class" : "btn-danger"
				 }]);
				 return false;
			}
			 if(data==0) 
				 data=1;
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
} 
function doDepartmentAction(){  
 
	 var bdeptName=jQuery.trim($("#bdeptName").val());
	 var bdeptDetail=jQuery.trim($("#bdeptDetail").val());
	 var bdeptHOD=jQuery.trim($("#bdeptHOD").val());  
	 var bdeptHOD_str="null";
	// var position=jQuery.trim($("#position").val());
	 
	 if(bdeptName.length==0){
		 alert("กรุณากรอก Name.");
		 $("#bdeptName").focus();
		 return false;
	 } 
	 <c:if test="${mode=='edit'}">
	  if(bdeptHOD.length==0){
		 alert("กรุณากำหนด HOD.");
		// $("#bdeptHOD").focus();
		 return false;
	 }
	  bdeptHOD_str=bdeptHOD;   
	  </c:if>
	
	var querys=[]; 
	var query="insert into "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str;
	if($("#mode").val()=='edit'){
		 query="update "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str+" where BDEPT_ID=${bdeptId}";
	}
	querys.push(query); 
	var list_values=[];
		var values=[];
		values.push(bdeptName);
		values.push(bdeptDetail); 
		//values.push(position);
		
		list_values.push(values);
	SynDomeBPMAjax.executeQueryWithValues(querys,list_values,{
			callback:function(data){ 
				if(data.resultMessage.msgCode=='ok'){
					data=data.updateRecord;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=0){
					
					loadDynamicPage("dispatcher/page/department_search");
				}
			}
		});
  }
 
</script>  
<div id="dialog-confirmDelete" title="Delete User Mapping" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete User Mapping ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="bdeptId" id="bdeptId"  value="${bdeptId}"/> 
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="department_title"></strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Name :</span></td>
    					<td width="75%" colspan="2"> 
    					    <c:if test="${mode=='edit'}">
    							<input type="text" name="bdeptName" id="bdeptName" readonly="readonly" style="height: 30;"/>
    						</c:if>
    						<c:if test="${mode=='add'}">
    							<input type="text" name="bdeptName" id="bdeptName"  style="height: 30;"/>
    						</c:if>
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Detail :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="bdeptDetail" id="bdeptDetail" style="height: 30;"/>
    					</td>
    				</tr> 
    				<c:if test="${mode=='edit'}">
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">HOD :</span></td>
    					<td width="75%" colspan="2"> 
    					 <input type="hidden" id="bdeptHOD" name="bdeptHOD"/>
    					 <span id="hodElement" onclick="assignUser('hod')"></span>
    					</td>
    				</tr> 
    				</c:if>
    			</table> 
    			</fieldset> 
    			<div align="center" style="padding-top: 10px">
						<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/department_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doDepartmentAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
						</div>
			  </form>   
			  <c:if test="${mode=='edit'}">
			   <div  class="well">
			  <table border="0" width="100%" style="font-size: 13px">
	    					<tbody>
	    					<tr>
	    					<td align="left" width="70%">  
	    					<span><strong>User List</strong></span>
	    					</td><td align="right" width="30%"> 
	    					</td>
	    					</tr>
	    					<tr>
	    					<td align="left" width="70%">   
	    					<a class="btn btn-primary"  onclick="assignUser('user')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Add</span></a>
	    					</td><td align="right" width="30%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="pageSelect" id="pageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
	    					<%--
	    					<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            	 	<th width="5%"><div class="th_class">No.</div></th>
            		<th width="15%"><div class="th_class">Name</div></th> 
            		<th width="15%"><div class="th_class">SLA Limit/Day</div></th>  
            		<th width="57%"><div class="th_class">Detail</div></th> 
            		<th width="8%"><div class="th_class"></div></th> 
            		 
          		</tr>
        	</thead>
        	<tbody> 
        	
          	<tr>  
            	<td>1. 	 
            	</td>
            	<td>1 วัน
            	</td> 
            	<td>1
            	</td>
            	<td>
            	 ภายใน กทม.</td>
            	 <td style="text-align: center;">
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=1&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				           	<i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				           	</td>
          	</tr> 
          	<tr>  
            	<td>2.
            	</td>
            	<td>2 วัน
            	</td> 
            	<td>2
            	</td>
            	<td>
            	ต่างจังหวัด</td>
            	<td style="text-align: center;"> 
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=2&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				        <i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				</td>
          	</tr> 
          	 
        	</tbody>
      </table> 
      </div>
      --%>
			 <div  id="user_section"> 
    		 </div> 
			</div>
			</c:if>
</fieldset>