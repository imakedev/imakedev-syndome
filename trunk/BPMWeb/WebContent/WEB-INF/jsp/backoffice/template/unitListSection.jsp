<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript">
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
});
function doSurvey(){ 
	$.get("survey/init/${companyForm.missAccount.maId}", function(data) {
		if(data!=null){
			appendContentWithId(data,"tabs-4"); 
		  } 
	});
}
function doOrder(msId){ 
	var value=parseInt($("#_order_"+msId).val())*parseInt($("#_unitCost_"+msId).val());
		$.get("company/item/unit/${companyForm.missAccount.maId}/"+msId+"/"+value, function(data) {
			// alert(data)
			 	/* var obj = jQuery.parseJSON(data);
				 $("#maTotalUnitElement").html(obj.maTotalUnit);
				 $("#maUsedUnitElement").html(obj.maUsedUnit);
				 $("#maAvailableUnitElement").html(obj.maAvailableUnit);
				 $("#refill").val(""); */
			if(data!=null){
				appendContentWithId(data,"tabs-4");
				// $("#tabs-3").html(data);
			  }
			 //  alert(data.updateRecord);
			 /*   var myJSONText = JSON.stringify(data, replacer);
			   alert(myJSONText)  */
			   //  appendContent(data);
			  // alert($("#_content").html());
		});
}
function doRefill(){
	 $.get("company/item/refile/${companyForm.missAccount.maId}/"+$("#refill").val(), function(data) {
		// alert(data)
		 	var obj = jQuery.parseJSON(data);
			 $("#maTotalUnitElement").html(obj.maTotalUnit);
			 $("#maUsedUnitElement").html(obj.maUsedUnit);
			 $("#maAvailableCandidateElement").html(obj.maAvailableCandidate);
			 $("#refill").val("");
				 
		 //  alert(data.updateRecord);
		 /*   var myJSONText = JSON.stringify(data, replacer);
		   alert(myJSONText)  */
		   //  appendContent(data);
		  // alert($("#_content").html());
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
<form:form  id="companyForm_unit" name="companyForm_unit" modelAttribute="companyForm"   method="post" action="">
			  <fieldset style="font-family: sans-serif;">   
	     <h6><strong>Company - Unit</strong></h6> 
			   <div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<!-- <tr>
    					<td width="100%" colspan="3"><strong>Company Unit</strong></td>
    				</tr> -->
   		 			<tr valign="top">
    					<td width="20%">&nbsp;</td>
    					<td width="15%">Total (unit): </td>
    					<td width="45%"><span id="maTotalUnitElement">${companyForm.missAccount.maTotalUnit}</span></td>
    					 <td width="20%">&nbsp;</td> 
    				</tr>
    				<tr valign="top">
    					<td width="20%">&nbsp;</td>
    					<td width="15%">Used (unit): </td>
    					<td width="45%"><span id="maUsedUnitElement">${companyForm.missAccount.maUsedUnit}</span></td>
    					 <td width="20%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="20%">&nbsp;</td>
    					<td width="15%">Balance (Available): </td>
    					<%-- <td width="48%"><span id="maAvailableUnitElement">${companyForm.missAccount.maAvailableUnit}</span></td> --%>
    					<td width="45%"><span id="maAvailableCandidateElement">${companyForm.missAccount.maAvailableCandidate}</span>&nbsp;&nbsp;candidate</td>
    					 <td width="20%">&nbsp;</td>
    				</tr>
    				<tr valign="top">
    					<td width="20%">&nbsp;</td>
    					<td width="15%">Re-fill </td>
    					<td width="45%"><form:input path="refill"/><input type="button" value="Re-fill" onclick="doRefill()"></td>
    					 <td width="20%">&nbsp;</td>
    				</tr>
    				
    			</table>
    			 
    			</div>
    			 </fieldset>
    			 </form:form>
    			<div>
    			 <div align="right"><a class="btn btn-primary" onclick="doSurvey();"><span style="color: white;font-weight: bold;">Survey</span></a></div>
    			 <table class="table stable-striped table-bordered table-condensed" border="0" style="font-size: 12px">
        	<thead>
          		<tr>
            		<th width="20%"><div class="th_class">Series</div></th> 
            		<th width="10%"><div class="th_class">Group</div></th>
            		<th width="45%"><div class="th_class">Test</div></th>
            		<th width="5%"><div class="th_class">Unit</div></th> 
            		<th width="5%"><div class="th_class">Available (Candidate)</div></th>
            		<th width="15%"><div class="th_class">Order</div></th> 
          		</tr>
        	</thead>
        	<tbody>
        	 <c:forEach items="${companyForm.missAccount.missSeryList}" var="missAccountSeriesMap" varStatus="loop"> 
        	 	<tr>
            	<td>&nbsp;${missAccountSeriesMap.msSeriesName}</td>
            	<td>&nbsp;${missAccountSeriesMap.groupStr}</td>
            	<td>&nbsp;${missAccountSeriesMap.testStr}</td>
            	<td>&nbsp;${missAccountSeriesMap.msUnitCost}
            	<input type="hidden" id="_unitCost_${missAccountSeriesMap.msId}" value="${missAccountSeriesMap.msUnitCost}" />
            	</td>
            	<%-- <td>&nbsp;${missAccountSeriesMap.masmAvailable}</td>  --%>
            	<td>&nbsp;${missAccountSeriesMap.masmCandidateAvailable}</td> 
            	<td><div><input type="text" id="_order_${missAccountSeriesMap.msId}" style="width:40px">&nbsp;&nbsp;<a class="btn btn-primary" onclick="doOrder('${missAccountSeriesMap.msId}');"><span style="color: white;font-weight: bold;">Order</span></a></div></td> 
          	</tr>
        	 </c:forEach>
          	<!-- <tr>
            	<td>Series1</td>
            	<td>Personality Aptitude</td>
            	<td>2</td>
            	<td>20</td>
            	<td><input type="text"></td> 
          	</tr>
          	<tr>
            	<td>Series2</td>
            	<td>Motivation Management</td>
            	<td>2</td>
            	<td>20</td>
            	<td><input type="text"></td> 
          	</tr>
          	<tr>
            	<td>Survey</td>
            	<td>Survey</td>
            	<td>2</td>
            	<td>30</td>
            	<td><input type="text"></td> 
          	</tr> -->
    				</table>
    				</div>
			
			<!-- <div align="center"><input type="button" class="btn" value="Order"/></div> onclick="doAction('action','companyForm_unit','7')"-->
			<div align="center">
			<%--
			<a class="btn btn-primary" ><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Order</span></a>
			 --%>
			</div>