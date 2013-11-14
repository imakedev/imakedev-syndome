<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<style>
.ui-datepicker-trigger{cursor: pointer;}
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
</style>
<script>
$(document).ready(function() {
	renderPageSelect();
	if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 }
	$("#pjCreatedTime" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	/* $( "#periodDesc" ).autocomplete({
		  source: function( request, response ) {  
			  var periodWhere=""; 
				var periodNo =jQuery.trim($("#periodNo").val());
				var year =jQuery.trim($("#year").val());
			    if(year.length>0)
			    	periodWhere=periodWhere+" and year like  '%"+year+"%'   ";	
			    if(periodNo.length>0)
			    	periodWhere=periodWhere+" and period_no like  '%"+periodNo+"%'   ";	
				var query="SELECT period_no,period_desc  FROM "+SCHEMA_G+".period where period_desc like '%"+request.term+"%'   "+periodWhere;		
				KPIAjax.searchObject(query,{
					callback:function(data){ 
						if(data!=null && data.length>0){
							response( $.map( data, function( item ) {
					          return {
					        	  label: item[1],
					        	  value: item[0] 
					          }
					        }));
						}else{
							var xx=[]; 
							response( $.map(xx));
						}
					}
			 });		  
		  },
		  minLength: 2,
		  select: function( event, ui ) { 
			  this.value = ui.item.label;
			   $("#periodDesc").val(ui.item.label);
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		}); */
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		doAction('search','0');
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		doAction('search','0');
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("jobPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"jobPageSelect\" id=\"jobPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("jobPageSelect").value=$("#pageNo").val();
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
	doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#pjIdArray").val(id);
	}else if(mode!='search'){
		$("#pjId").val(id);
	}else {
		$("#pjId").val("0");
	}
	//alert($("#pjCreatedTime").val())
	$.post("job/search",$("#jobForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
function clearValueById(id){
	$("#"+id).val("");
}
</script>
<div id="dialog-confirmDelete" title="Delete Job" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Job ?
</div>
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
           
             <form:form id="jobForm" name="jobForm" modelAttribute="jobForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
           
             <form:hidden path="mode"/>
            <form:hidden path="pjIdArray"/>
             <form:hidden path="pstJob.pjId" id="pjId"/>
             <form:hidden path="paging.pageNo" id="pageNo"/>
              <form:hidden path="paging.pageSize" id="pageSize"/>
              <form:hidden path="pageCount"/>
           
            <div align="left">
            <strong>Job</strong>
            </div>
            <div align="left" style="padding: 10px 10px">
            	<span style="font-size: 13px;">เลขที่งาน</span> 
            	<span style="padding: 20px">
            	 <form:input path="pstJob.pjJobNo" cssStyle="height: 30;width:80px"/>
            	<!-- <input type="text" style="height: 30px;width:80px">  -->
            	</span>  
	    		<span style="font-size: 13px;">วันที่</span> 
            	<span style="padding: 20px">            	
            	<!-- <input type="text" style="height: 30px;width:150px"> --> 
            	<form:input path="pjCreatedTime" id="pjCreatedTime" cssStyle="height: 30;width:85px" readonly="true"/>
            	 <i class="icon-refresh" style="cursor: pointer;" onclick="clearValueById('pjCreatedTime')"></i>
            	</span>  
            </div>
             <div align="left" style="padding: 10px 10px">
            	<span style="font-size: 13px;">รหัสลูกค้า</span> 
            	<span style="padding: 20px">
            	<!-- <input type="text" style="height: 30px;width:80px">  -->
            	 <form:input path="pstJob.pjCustomerNo" cssStyle="height: 30;width:80px"/>
            	</span>  
	    		<span style="font-size: 13px;">ชื่อลูกค้า</span> 
            	<span style="padding: 20px">
            	<!-- <input type="text" style="height: 30px;width:150px">  -->
            	 <form:input path="pstJob.pjCustomerName" cssStyle="height: 30;"/>
            	</span>  
            	<span style="font-size: 13px;">หน่วยงาน</span> 
            	<span style="padding-left: 10px"> 
	 			<form:input path="pstJob.pjCustomerDepartment" cssStyle="height: 30px;width:150px"/>
            	<!-- <input type="text" style="height: 30px;width:150px">  -->
            	 
            	</span>
            </div>
             <div align="left" style="padding: 10px 10px">
            	<span style="font-size: 13px;">คอนกรีตที่ใช้</span> 
            	<span style="padding: 20px"> 
            	<form:select path="pstJob.pstConcrete.pconcreteId" cssStyle="width:170px">
	    						      <form:option value="-1">---</form:option>
	    					      	  <form:options itemValue="pconcreteId" itemLabel="pconcreteName" items="${pstConcretes}"/> 
	    	    </form:select>	
            	<!-- <select id="mcaStatus" name="mcaStatus">
	    					      <option value="-1">-- เลือก --</option>
	    					      <option value="1">1</option>
	    					      <option value="2">2</option>
	    		</select> -->
            	</span>  
	    		<span style="font-size: 13px;">หมายเลขรถที่ใช้</span> 
	    		<span style="padding: 20px">
	    		<%--  <form:input path="pstJob.prpNo" cssStyle="height: 30;width:80px"/> --%>
	    		 <form:select path="pstJob.prpNo"  cssStyle="width:100px">
								  		 <option value="">---</option>
								  		   <form:options itemValue="prpNo" itemLabel="prpNo" items="${pstRoadPumpNos}"/> 
								  		<%--  <c:forEach items="${pstRoadPumpNos}" var="pstRoadPumpNo" varStatus="loop"> 
								  		 	<option value="${pstRoadPumpNo.prpNo}">${pstRoadPumpNo.prpNo}</option>  
								  		 </c:forEach>  --%>
	    	        </form:select>
            	<!-- <input type="text" style="height: 30px;width:150px"/> -->  
            	</span>
            	<a class="btn btn-primary" style="margin-top: -10px" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a>
            </div>
            <!-- 
            <table border="0" width="100%" style="font-size: 13px">
              				<tbody><tr>
	    					 <td align="left" width="17%" colspan="6"><strong>Candidate Search</strong></td>
	    					
	    					</tr> 
	    					<tr valign="top">
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Status:</td>
	    					 <td align="left" width="17%">    	
	    					    <select id="mcaStatus" name="mcaStatus">
	    					      <option value="-1">-- Select Status --</option>
	    					      <option value="1">Used</option>
	    					      <option value="2">Available</option>
	    					    </select>	 
	    					 </td>
	    					<td align="left" width="17%">Series:</td>
	    					<td align="left" width="17%">
	    					 <select id="mcaSeries" name="mcaSeries">
	    					      <option value="-1">-- Select Series --</option>
	    					      <option value="10">MC9T</option><option value="12">EPT: Trait Detector</option><option value="13">MT: Customer Mind Test</option><option value="14">SAT: Service attitude</option><option value="15">4FT: The four factor</option><option value="17">SPP: Sales Test</option><option value="18">Leadership Assessment Series</option><option value="19">World around us</option><option value="20">Logic Test</option><option value="21">EPT Plus: Work Wheel</option><option value="22">MCLeader: Leader Test series</option><option value="23">English Test</option><option value="24">MecHT: Mechanical test</option><option value="25">MCLeader: Leader Test series</option><option value="26">MAT: Management Test series</option><option value="27">MC_TMT: Talent Management</option>
	    					      
	    					    </select>	 
	    						</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr>
	    					<tr valign="top">
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Username:</td>
	    					 <td align="left" width="17%">
	    					 <input id="mcaUsername" name="mcaUsername" type="text" value=""> 
	    					 </td>
	    					<td align="left" width="17%">Password:</td>
	    					<td align="left" width="17%">
	    					 <input id="mcaPassword" name="mcaPassword" type="text" value=""> 
	    					</td>
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr> 
	    					<tr valign="top">
	    					 <td align="left" width="17%">&nbsp;</td>
	    					 <td align="left" width="17%">Company Name:</td>
	    					 <td align="left" colspan="3" width="51%">     
	    					  <input id="mcaCompanyName" name="mcaCompanyName" style="width:100%" type="text" value="">	 
	    					 </td> 
	    					<td align="left" width="15%">&nbsp;</td>
	    					</tr> 
	    					</tbody></table> 
	    					-->
	    					</form:form> 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<a class="btn btn-primary" onclick="loadDynamicPage('job/new')"><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp;
	    					<a class="btn btn-info" onclick="loadDynamicPage('customer/init')"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage ลูกค้า</a>&nbsp;
	    					<a class="btn btn-info" onclick="loadDynamicPage('concrete/init')"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage คอนกรีต</a>&nbsp;
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;<span id="pageElement">
	    					<select name="seriesPageSelect" id="seriesPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select></span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doAction('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
	    					<!-- 
	    					<table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">  
	    					<a class="btn btn-info" onclick="exportCandidat()"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage Employee</a>&nbsp;
	    					<a class="btn btn-info" onclick="exportCandidat()"><i class="icon-circle-arrow-up icon-white"></i>&nbsp;Manage Status</a>&nbsp; 
	    					</td><td align="right" width="50%"> 
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;<span id="pageElement"><select name="candidatePageSelect" id="candidatePageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option></select></span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;<a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a></td>
	    					</tr>
	    					</tbody></table>  
	    					 --> 
		<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            		<th width="7%"><div class="th_class">เลขที่</div></th>
            		<th width="8%"><div class="th_class">วันที่</div></th> 
            		<th width="15%"><div class="th_class">ชื่อลูกค้า</div></th> 
            		<th width="25%"><div class="th_class">หน่วยงาน</div></th>
            		<th width="10%"><div class="th_class">คอนกรีตที่ใช้</div></th> 
            		<th width="7%"><div class="th_class">จำนวนคิว</div></th> 
            		<th width="10%"><div class="th_class">ยอดรวมสุทธิ</div></th>
            		<th width="6%"><div class="th_class">Feedback</div></th>  
            		<th width="5%"><div class="th_class">Action</div></th> 
          		</tr>
        	</thead>
        	<tbody>   
        	<c:if test="${not empty pstJobs}"> 
        	 <c:forEach items="${pstJobs}" var="pstJob" varStatus="loop">  
          	<tr>  
            	<td>&nbsp;${pstJob.pjJobNo}</td>
            	
            	<td>&nbsp;<fmt:formatDate pattern="dd/MM/yyyy" value="${pstJob.pjCreatedTime}"/></td> 
            	<td>&nbsp;${pstJob.pjCustomerName}</td>
            	<td>&nbsp;${pstJob.pjCustomerDepartment}</td>
            	<td>&nbsp;${pstJob.pstConcrete.pconcreteName}</td>
            	<td style="text-align: right;">&nbsp;<fmt:formatNumber  pattern="#,###,###,###.##"  
     value="${pstJob.cubicAmount}" /> 
            	</td>
            	<td style="text-align: right;">&nbsp;<fmt:formatNumber   pattern="#,###,###,###.##"  
     value="${pstJob.payAll}" />
            	</td>
            	<td style="text-align: right;">&nbsp;<fmt:formatNumber   pattern="#,###,###,###.##"  
     value="${pstJob.pjFeedBackScore}" />
            	</td>
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('job/item/${pstJob.pjId}')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','${pstJob.pjId}')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	</c:forEach>
          	</c:if>
          	<c:if test="${empty pstJobs}"> 
          	<tr>
          		<td colspan="8" style="text-align: center;">&nbsp;Not Found&nbsp;</td>
          	</tr>
          </c:if>
          
          	<%--
          	 <tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	<tr>  
            	<td>3701</td>
            	<td>20/12/2012</td> 
            	<td>บมจ.ปูนซีเมนต์ นครหลวง</td>
            	<td></td>
            	<td>cpac</td>
            	<td>192
            	</td> 
            	<td style="text-align: center;"> 
            	 <i title="Edit" onclick="loadDynamicPage('series/item/15')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
            	 <i title="Delete" onclick="confirmDelete('delete','15')" style="cursor: pointer;" class="icon-trash"></i>
            	</td>
          	</tr> 
          	 --%>
        	</tbody>
      </table> 
      </fieldset> 