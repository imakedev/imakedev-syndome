<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	searchDeliveryInstallation("1");
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
function searchDeliveryInstallation(_page){  
	$("#pageNo").val(_page); 
	var sqlWhere="";
	var soNumSearch = jQuery.trim($("#soNumSearch").val());
	var cusCodSearch = jQuery.trim($("#cusCodSearch").val());
	var saleNameSearch = jQuery.trim($("#saleNameSearch").val()); 

	var haveWhere = false;
	//alert("model_section_1->"+model_section_1)
	if (soNumSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				+ " lower(so.BSO_TYPE_NO) like lower('%" + soNumSearch + "%')";
		haveWhere = true;
	}
	if (cusCodSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				+ " lower(so.CUSCOD) like lower('%"
				+ cusCodSearch + "%')";
		haveWhere = true;
	}
	if (saleNameSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				+ " lower(so.BSO_SALE_ID) like lower('%"
				+ saleNameSearch + "%')";
		haveWhere = true;
	}
	if(!haveWhere){
		sqlWhere = sqlWhere +
		" where so.BSO_CREATED_DATE between DATE_FORMAT(now(),'%Y-%m-%d 00:00:00') and DATE_FORMAT(now(),'%Y-%m-%d 23:59:59') ";
	}
	var query=" SELECT "+
	" so.BSO_ID, "+
	" so.CUSCOD, "+
	" so.BSO_SALE_ID, "+
	" so.BSO_IS_DELIVERY, "+
	" so.BSO_IS_INSTALLATION, "+
	" so.BSO_DELIVERY_DUE_DATE, "+
	" so.BSO_DELIVERY_LOCATION, "+
	" so.BSO_DELIVERY_CONTACT, "+
	" so.BSO_INSTALLATION_SITE_LOCATION, "+
	" so.BSO_INSTALLATION_CONTACT, "+
	" so.BSO_INSTALLATION_TEL_FAX, "+
	" so.BSO_INSTALLATION_DUE_DATE, "+
	" so.BSO_LEVEL, "+
	" so.BSO_DOC_CREATED_DATE, "+
	" so.BSO_CUSTOMER_TYPE, "+
	" so.BSO_PO_NO, "+
	" so.BSO_PAYMENT_TERM, "+
	" so.BSO_PAYMENT_TERM_DESC, "+
	" so.BSO_BORROW_TYPE, "+
	" so.BSO_BORROW_EXT, "+
			   " so.BSO_BORROW_DURATION, "+
			   " so.BSO_IS_WARRANTY, "+
			   " so.BSO_WARRANTY, "+
			   " so.BSO_IS_PM_MA, "+
			   " so.BSO_OPTION, "+
			   " so.BSO_TYPE, "+
			   " so.BSO_TYPE_NO ,"+ // id=26
			   " armas.CUSNAM, "+
			   " so.BSO_CREATED_BY ,"+
			   " so.BSO_UPDATED_BY ,"+  
			   " IFNULL(DATE_FORMAT(so.BSO_CREATED_DATE,'%Y-%m-%d %H:%i:%s'),'') ,"+
			   " IFNULL(DATE_FORMAT(so.BSO_UPDATED_DATE,'%Y-%m-%d %H:%i:%s'),'') "+
			   " FROM "+SCHEMA_G+".BPM_SALE_ORDER so left join "+
			   " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+ 
				sqlWhere+
			   "order by  so.BSO_CREATED_DATE desc ";
	 
	// alert(query)
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	SynDomeBPMAjax.searchObject(queryObject,{
		callback:function(data){
			  
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Sale Order No</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Customer Code</div></th> "+  
			        "  		<th width=\"53%\"><div class=\"th_class\">Customer Name</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">Create date</div></th> "+ 
			        //"  		<th width=\"20%\"><div class=\"th_class\">Status</div></th> "+ 
			        "  		<th width=\"8%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					  // alert(data[i][30])
					   var date_created = (data[i][30]!=null && data[i][30].length>0)? $.format.date(data[i][30], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][26]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][1]!=null)?data[i][1]:"&nbsp;")+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][27]!=null)?data[i][27]:"&nbsp;")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+date_created+"</td>  "+
				       // "    	<td style=\"text-align: left;\">"+((data[i][1]!=null)?data[i][1]:"&nbsp;")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/delivery_install_management?bsoId="+data[i][0]+"&mode=edit')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        <c:if test="${isSaleOrder}">
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        </c:if>
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section").html(str);
		}
	}); 
	SynDomeBPMAjax.searchObject(queryCount,{
		callback:function(data){
			//alert(data)
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
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
	    					<span><strong>ส่งเครื่องใหม่/ติดตั้ง</strong></span>
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
									<span style="padding-left: 10px;font-size: 13px;">Sale Order No</span> 
									<span style="padding: 5px;">
										<input id="soNumSearch" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">Customer Code</span> 
									<span style="padding: 5px;">
										<input id="cusCodSearch" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">Sale Name</span> 
									<span style="padding: 5px;">
										<input id="saleNameSearch" type="text" style="height: 30; width: 100px" />
									</span> 
									<span style="padding-left: 50px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="searchDeliveryInstallation(1)"><i
										class="icon-search"></i>&nbsp;Search</a>
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
	    					<tr>
	    					<td align="left" width="70%">   
	    					 <c:if test="${isSaleOrder}">
	    					<a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/delivery_install_management?bsoId=0&mode=add')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Create Job</span></a>
	    					</c:if>
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
	    					<div  id="search_section"> 
    						</div> 
      </div>
      </fieldset> 