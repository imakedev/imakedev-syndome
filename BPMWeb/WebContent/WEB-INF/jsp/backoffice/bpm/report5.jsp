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
	 
});
function viewReport(){ 
	 var load_str="<fieldset style=\"font-family: sans-serif;padding-top:5px\">"+    
	 "<div style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 10px\"> <img src='${url}resources/images/loading.gif' /></div></fieldset>";
 $("#search_section").html(load_str); 
	     var START_DATE_PICKER_values=$("#START_DATE_PICKER").val();
	     var END_DATE_PICKER_values=$("#END_DATE_PICKER").val();
	     if(START_DATE_PICKER_values.length>0 && END_DATE_PICKER_values.length>0){
	    	 var START_DATE_PICKER_array=START_DATE_PICKER_values.split("/");
	    	 var END_DATE_PICKER_array=END_DATE_PICKER_values.split("/"); 
	    	 var start_date=START_DATE_PICKER_array[2]+"-"+START_DATE_PICKER_array[1]+"-"+START_DATE_PICKER_array[0];
	    	 var end_date=END_DATE_PICKER_array[2]+"-"+END_DATE_PICKER_array[1]+"-"+END_DATE_PICKER_array[0];
	    	   SynDomeBPMAjax.getReportSO(start_date,end_date,{ 
	    	  // SynDomeBPMAjax.searchObject(query,{ 
					//SynDomeBPMAjax.searchObject(queryObject,{
						callback:function(data){
							if(data.resultMessage.msgCode=='ok'){
								data=data.resultListObj;
							}else{// Error Code
								//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
								  bootbox.dialog(data.resultMessage.msgDesc,[{
									    "label" : "Close",
									     "class" : "btn-danger"
									    //	"class" : "class-with-width"
								 }]);
								 return false;
							}
							var so_all=0;
							var so_1=0;
							var so_2=0;
							var so_3=0;
							var so_4=0;
							var so_5=0;
							var so_unit=0;
							var so_price=0;
							var so_cost=0;
							var so_profit=0;
							var sla_column="SLA Limit";
							var is_supervisor=false;
							var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
					        "	<thead> 	"+
					        "  		<tr> "+
					        "  		<th width=\"7%\"><div class=\"th_class\">วันที่</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">SO ทั้งหมด</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">SO (ส่งของ)</div></th> "+   
					        "  		<th width=\"5%\"><div class=\"th_class\">SO (ติดตั้ง)</div></th> "+ 
					        "  		<th width=\"5%\"><div class=\"th_class\">SO (ส่งของ,ติดตั้ง)</div></th> "+
					        "  		<th width=\"5%\"><div class=\"th_class\">SO (ส่งของพร้อมติดตั้ง)</div></th> "+  
					        "  		<th width=\"5%\"><div class=\"th_class\">SO (ไม่ส่งของ)</div></th> "+
					        "  		<th width=\"10%\"><div class=\"th_class\">จำนวนเครื่อง</div></th> "+
					        "  		<th width=\"10%\"><div class=\"th_class\">ยอดขาย</div></th> "+ 
					        "  		<th width=\"10%\"><div class=\"th_class\">ต้นทุน</div></th> "+ 
					        "  		<th width=\"10%\"><div class=\"th_class\">กำไร</div></th> "+   
					        " 		</tr>"+
					        "	</thead>"+
					        "	<tbody>   ";  
							 
							   if(data!=null && data.length>0){
								   for(var i=0;i<data.length;i++){ 
									    so_all=so_all+data[i][1];
									    so_1=so_1+data[i][2];
									     
										so_2=so_2+data[i][3];
										so_3=so_3+data[i][4];
										so_4=so_4+data[i][5];
										so_5=so_5+data[i][6];
										so_unit=so_unit+data[i][7];
										so_price=so_price+data[i][8];
										so_cost=so_cost+data[i][9];
										so_profit=so_profit+data[i][10];
								       str=str+ "  	<tr >"+
								       "  <td style=\"text-align: center;\"><span> "+data[i][0]+"</span>"; 
								           str=str+ " </td>"+
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][1]+"", {format:"#,###.##", locale:"us"})+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][2]+"", {format:"#,###.##", locale:"us"})+"</td>"+    
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][3]+"", {format:"#,###.##", locale:"us"})+"</td>"+   
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][4]+"", {format:"#,###.##", locale:"us"})+ "</td>"+    
										   "  		<td style=\"text-align: center;\">"+$.formatNumber(data[i][5]+"", {format:"#,###.##", locale:"us"})+"</td>"+  
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][6]+"", {format:"#,###.##", locale:"us"})+"</td>  "+ 
									        "    	<td style=\"text-align: center;\">"+$.formatNumber(data[i][7]+"", {format:"#,###.##", locale:"us"})+"</td>  "+ 
									        "    	<td style=\"text-align: right;\">"+$.formatNumber(data[i][8]+"", {format:"#,###.00", locale:"us"})+"</td>  "+
									        "    	<td style=\"text-align: right;\">"+$.formatNumber(data[i][9]+"", {format:"#,###.00", locale:"us"})+"</td>  "+ 
									         "    	<td style=\"text-align: right;\">"+$.formatNumber(data[i][10]+"", {format:"#,###.00", locale:"us"})+"</td>  "; 
									        str=str+ "  	</tr>  "; 
								   }
								   str=str+ "   		<tr> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">รวม</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_all+"", {format:"#,###.##", locale:"us"})+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_1+"", {format:"#,###.##", locale:"us"})+"</div></th> "+   
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_2+"", {format:"#,###.##", locale:"us"})+"</div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_3+"", {format:"#,###.##", locale:"us"})+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_4+"", {format:"#,###.##", locale:"us"})+"</div></th> "+  
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_5+"", {format:"#,###.##", locale:"us"})+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C\"><div class=\"th_class\">"+$.formatNumber(so_unit+"", {format:"#,###.##", locale:"us"})+"</div></th> "+
							        "  		<th style=\"background-color:#DCDF9C;\"><div style=\"text-align: right;\"><span>"+$.formatNumber(so_price+"", {format:"#,###.00", locale:"us"})+"</span></div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C;\"><div style=\"text-align: right;\"><span>"+$.formatNumber(so_cost+"", {format:"#,###.00", locale:"us"})+"</span></div></th> "+ 
							        "  		<th style=\"background-color:#DCDF9C;\"><div style=\"text-align: right;\"><span>"+$.formatNumber(so_profit+"", {format:"#,###.00", locale:"us"})+"</span></div></th> "+  
							        " 		</tr>";
							   }else{
								 str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
						    		"<thead>"+
						    		"<tr> "+
					      			"<th colspan=\"9\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
					      		"</tr>"+
					    	"</thead>"+
					    	"<tbody>"; 
							   }
							        str=str+  " </tbody>"+
									   "</table> "; 
							$("#search_section").html(str);
						}
					});

	     }else{
	    	 alert("กรุณาใส่เวลา.");
	    	 $("#search_section").html("");
	     }
	    
} 
function exportReport5(){   
	  var START_DATE_PICKER_array=$("#START_DATE_PICKER").val().split("/");
	    var END_DATE_PICKER_array=$("#END_DATE_PICKER").val().split("/");
	    var start_date=START_DATE_PICKER_array[0]+"_"+START_DATE_PICKER_array[1]+"_"+START_DATE_PICKER_array[2];
	    var end_date=END_DATE_PICKER_array[0]+"_"+END_DATE_PICKER_array[1]+"_"+END_DATE_PICKER_array[2]; 
	var src = "report/exportReport5/"+start_date+"/"+end_date;
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
	    					<span><strong>รายงาน SO</strong></span>
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
										<input id="START_DATE_PICKER" value="${time}"  readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 <span style="padding-left: 20px;font-size: 13px;">End Date</span> 
									<span style="padding: 5px;">
										<input id="END_DATE_PICKER" value="${time}" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 10px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="viewReport()">&nbsp;View&nbsp;</a>
										</span>
									 <span id="exportReport_element" style="padding-left: 10px;">
										  
									<a class="btn" style="margin-top: -10px;"
									onclick="exportReport5()">&nbsp;Export&nbsp;</a>
									    
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
	    					
	    					</tbody></table>  
	    					<div  id="search_section"> 
    						</div>
      </div>
      </fieldset> 