<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_PENDING_SC')" var="isVeiwReportPendingSCAccount"/> 
<sec:authorize access="hasAnyRole('ROLE_VIEW_REPORT_PENDING_IT')" var="isVeiwReportPendingITAccount"/>   
<sec:authentication var="username" property="principal.username"/> 
<jsp:useBean id="date" class="java.util.Date"/>
<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:500px}
 .modal.fade.in{top:1%}
 .aoe_small{width: 500px !important;margin-left:-250px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
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
});

function exportReport(){   
	var dept = "";
	<c:if test="${isVeiwReportPendingSCAccount}">
		dept = "SC";
	</c:if>
	<c:if test="${isVeiwReportPendingITAccount}">
		dept = "IT";
	</c:if>
	var src = "report/exportReportPending/"+dept;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
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
	    					<span><strong>รายงานสรุปงานค้าง </strong></span>
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

									<!-- <span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
										</span>  -->
										<span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport()">&nbsp;Export&nbsp;</a>
									    
										</span>
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	    					</td>
	    					</tr>
	    					
	    					</tbody></table>   <div  id="search_section"> 
    						</div>
      </div>
      </fieldset> 