<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 

<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	  $("#DUE_DATE_PICKER" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	  var query="SELECT firstName, "+
	         " lastName,"+
	         " username  FROM "+SCHEMA_G+".user where bpm_role_id=7  and username like ";
	  $("#EMP" ).autocomplete({
		  source: function( request, response ) {    
			  //$("#pjCustomerNo").val(ui.item.label); 
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
		}); 
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchDeliveryInstallation(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchDeliveryInstallation(next);
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("pageSelect").value);
//	doAction('search','0');
	searchDeliveryInstallation($("#pageNo").val());
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
	document.getElementById("pageSelect").value=$("#pageNo").val();
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
	var query="DELETE FROM "+SCHEMA_G+".BPM_SALE_ORDER where BSO_ID="+id; 
	querys.push(query); 
	SynDomeBPMAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data!=0){
				searchDeliveryInstallation("1"); 
			}
		}
	});
} 


function exportDailyReport(){ 
	var usr=jQuery.trim($("#EMP").val());
    if(!usr.length>0){
			  alert("กรุณาใส่ ชื่อพนักงาน");
			  $("#EMP").focus();
			  return false;
	}
	var duedate=jQuery.trim($("#DUE_DATE_PICKER").val());
	if(!duedate.length>0){
		  alert("กรุณาใส่ Due Date");
		  $("#DUE_DATE_PICKER").focus();
		  return false;
   }
	var duedate_array=duedate.split("/");

		var src = "report/dailyReport/"+usr+"/"+duedate_array[0]+"_"+duedate_array[1]+"_"+duedate_array[2];
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
</script>
<div id="dialog-confirmDelete" title="Delete Job" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Job ?
</div>
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
	    					<span><strong>รายงานประจำวัน</strong></span>
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
									<span style="padding-left: 10px;font-size: 13px;">ชื่อ พนักงาน</span> 
									<span style="padding: 5px;">
										<input id="EMP" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">Due Date</span> 
									<span style="padding: 5px;">
										<input id="DUE_DATE_PICKER" readonly="readonly" type="text" style="height: 30; width: 100px" />
									</span>
									 
									<span style="padding-left: 50px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="exportDailyReport()"><i
										class="icon-search"></i>&nbsp;Export</a>
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
      </div>
      </fieldset> 