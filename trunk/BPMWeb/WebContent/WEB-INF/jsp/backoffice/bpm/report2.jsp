<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/> 
<jsp:useBean id="date" class="java.util.Date"/>
<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	  $("#START_DATE_PICKER" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	  $("#END_DATE_PICKER" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 <%--   var query="SELECT firstName, "+
	         " lastName,"+
	         " username  FROM "+SCHEMA_G+".user where bpm_role_id=7  and username like ";
	  $("#EMP" ).autocomplete({
		  source: function( request, response ) {    
			  var queryiner=query+" '%"+request.term+"%' limit 15";
				SynDomeBPMAjax.searchObject(queryiner,{
					callback:function(data){ 
						if(data!=null && data.length>0){
							response( $.map( data, function( item ) {
					          return {
					        	  label: item[0] +" "+item[1],
					        	  value: item[2] ,
					        	  id: item[2]
					        	
					          };
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
			  this.value = ui.item.value;
			  $("#EMP").val(ui.item.value);   
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		});  --%>
});
function exportReport1(){ 
	 
		var src = "report/repport1";
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
function showTeam(){
	$("#EMP").val("");
	$("#emp_name").html(""); 
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod ,dept.bdept_id , "+
		" (SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST  where btdl_owner=user.username and btdl_hide='1' ) "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where user_hod.username='${username}' "; 
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
				
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Username</div></th> "+
			    "  		<th width=\"65%\"><div class=\"th_class\">Name </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){
					  /*  role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   } */
					    
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" onclick=\"doSelectDept()\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\">"+
					   " <input type=\"hidden\" value=\""+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"\"  name=\"emp_name_select\"> "+
					   "</td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   //str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doSelectDept()\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Select</span></a>"+
				 
				   "</div>";
				// alert(str)
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function doSelectDept(){
	var username_team=""; 
	var emp_name_select="";
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	var emp_name_select_list=document.getElementsByName("emp_name_select");
	
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			emp_name_select=emp_name_select_list[j].value;
			break;	
		}
	} 
	//alert(username_team);
	$("#EMP").val(username_team);
	$("#emp_name").html(emp_name_select); 
	bootbox.hideAll();
}
</script>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
            <form id="slaForm" name="slaForm" style="display: none">
           <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            </form>
			   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px"> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody> 
	    					<tr>
	    					<td align="left" width="70%">  
	    					<span><strong>รายงาน การเข้าระบบง</strong></span>
	    					</td><td align="right" width="30%"> 
	    					</td>
	    					</tr>
	    					<tr>
	    					<td width="100%"  colspan="2">
	    					<div align="left" style="padding-left: 15px; padding-top: 10px">
			<table width="100%" border="0">
				<tr valign="top">
					<td width="25%">
						<table width="100%">
							<tr>
								<td> 
									<span style="padding-left: 20px;font-size: 13px;">Start Date</span> 
									<span style="padding: 5px;">
										<input id="START_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 <span style="padding-left: 20px;font-size: 13px;">End Date</span> 
									<span style="padding: 5px;">
										<input id="END_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport1()">&nbsp;View&nbsp;</a>
										</span>
									 <%-- 
									<span style="padding-left: 50px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="exportDailyReport()"><i
										class="icon-ok"></i>&nbsp;Export</a>
										</span>
										 --%>
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	    					</td>
	    					</tr>
	    					
	    					</tbody></table>  
      </div>
      </fieldset> 