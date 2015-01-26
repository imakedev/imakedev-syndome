<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authentication var="username" property="principal.username"/> 
<%--  
<script src="<c:url value='/resources/js/bootstrap-datepicker.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/bootstrap-timepicker.js'/>" type="text/javascript"></script> 
<link rel="stylesheet" href="<c:url value='/resources/css/datepicker.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap-timepicker.css'/>"> 
--%>
<fmt:formatDate var="time2" value="${date}" pattern="dd/MM/yyyy"/>	
<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}
.ui-datepicker-trigger{cursor: pointer;}
.ui-datepicker-calendar {
  /*  display: none; */
}​
.datepicker{
z-index: 3000;
}
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:1000px}
 .modal.fade.in{top:1%}
 .aoe_small{width: 500px !important;margin-left:-250px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
</style>
 
<script>
$(document).ready(function() {  
	_perpageG=100;
	initPMMA();
	 autoProvince("pmma_province_search");
	 autoCustomerPMMA("pmma_customer_search");
	 $("#pmma_province_search").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchPMMA('1');
		   } 
		});
	 $("#pmma_customer_search").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchPMMA('1');
		   } 
		});
	 $("#pmma_jobno_search").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchPMMA('1');
		   } 
		});
	 $("#PMMA_SELECT_DATE_START" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 $("#PMMA_SELECT_DATE_END" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 /*
	 $('#PMMA_SELECT_DATE_START').datepicker();
	  $('#PMMA_SELECT_DATE_END').datepicker();
	  */
	  /*
	 $('#PMMA_SELECT_DATE_START').datepicker({
	     changeMonth: true,
	     changeYear: true,
	     dateFormat: 'mm/yy',
	     showOn: "button",
	 	buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
	     onClose: function() {
	        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	       // alert(iMonth+","+iYear)
	        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	     },
	       
	     beforeShow: function() {
	    	 //alert($(this).val())
	    	 
	       if ((selDate = $(this).val()).length > 0) 
	       {
	    	  // alert("selDate-"+selDate)
	          iYear = selDate.substring(selDate.length - 4, selDate.length);
	        //  alert(iYear)
	        //  iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
	          iMonth=parseInt(selDate.substring(0, selDate.length - 5)-1);
			 // alert("iMonth->"+iMonth)
	          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
	           $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	       }
	    	
	    }
	  });
	 $('#PMMA_SELECT_DATE_END').datepicker({
	     changeMonth: true,
	     changeYear: true,
	     dateFormat: 'mm/yy',
	     showOn: "button",
	 	buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
	     onClose: function() {
	        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	       // alert(iMonth+","+iYear)
	        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	     },
	       
	     beforeShow: function() {
	    	 //alert($(this).val())
	    	 
	       if ((selDate = $(this).val()).length > 0) 
	       {
	    	  // alert("selDate-"+selDate)
	          iYear = selDate.substring(selDate.length - 4, selDate.length);
	        //  alert(iYear)
	        //  iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
	          iMonth=parseInt(selDate.substring(0, selDate.length - 5)-1);
			 // alert("iMonth->"+iMonth)
	          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
	           $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	       }
	    	
	    }
	  });
	 */
	/*
	 $("#duedate_change" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 $("#PMMA_END_DATE" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
	 */
});
function initPMMA(){
	 
   var query="SELECT u.id,u.username,u.firstName,u.lastName ,u.email,u.mobile ,center.bc_name "+
	" FROM "+SCHEMA_G+".BPM_CENTER  center  left join  "+SCHEMA_G+".user u on center.uid=u.id "+ 
	"  ";
  
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
		var str="	 <select name=\"pmma_center\" id=\"pmma_center\" onchange=\"searchPMMA('1')\" style=\"width:180px\"> "+
		        "	<option value=\"0\">All</option>	";
		         
		   if(data!=null && data.length>0){
			   for(var i=0;i<data.length;i++){
				   str=str+ " <option value=\""+data[i][0]+"\">"+data[i][6]+"("+data[i][2]+")</option>";
			   }
		   } 
		        str=str+  " </select>";
		$("#pmma_center_element").html(str);
		 searchPMMA("1");
	}
}); 
}
function autoCustomerPMMA(dealer_element_id){  
	   var query="SELECT cust.CUSCOD,cust.CUSNAM  FROM "+SCHEMA_G+".BPM_PM_MA_JOB pmma left join bpm_armas cust on pmma.BPMJ_CUST_CODE=cust.CUSCOD where cust.CUSNAM like "; 
	   $("#"+dealer_element_id ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%'  group by cust.CUSCOD  order by cust.CUSNAM limit 15";
				 // alert(queryiner)
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
						        	  label: item[1],
						        	  value: item[1],
						        	  location: item[1]
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
				  this.value = ui.item.label;
				  $("#"+dealer_element_id).val(ui.item.location);  
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
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchPMMA(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchPMMA(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchPMMA($("#pageNo").val());
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
	checkWithSet("pageSelect",$("#pageNo").val());
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
	var query="DELETE FROM "+SCHEMA_G+".BPM_PM_MA where BPMMA_ID="+id; 
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
				searchPMMA("1"); 
			}
		}
	});
} 
function  checkAll(){
	// alert($("#pm_check_all").prop('checked'))
	 $('input[name="pm_check"]').prop('checked',$("#pm_check_all").prop('checked'));
}
function searchPMMA(_page){  
	//alert($('#PMMA_SELECT_DATE').val())
	
	$("#pageNo").val(_page); 
	var PMMA_SELECT_DATE_START=jQuery.trim($("#PMMA_SELECT_DATE_START").val());
	var PMMA_SELECT_DATE_END=jQuery.trim($("#PMMA_SELECT_DATE_END").val());
	var pmma_center=jQuery.trim($("#pmma_center").val()); 
	var pmma_province_search=jQuery.trim($("#pmma_province_search").val());
	var pmma_customer_search=jQuery.trim($("#pmma_customer_search").val());
	 var pmma_jobno_search=jQuery.trim($("#pmma_jobno_search").val());
	//alert(PMMA_SELECT_DATE)
	var query_where="";
	if(pmma_center!='0'){
		query_where=query_where+" and pmma.BPMJ_CENTER='"+pmma_center+"'";
	}
	if(pmma_province_search.length>0){
		query_where=query_where+" and pmma.BPMJ_PROVINCE like '%"+pmma_province_search+"%'";
	}
	if(pmma_customer_search.length>0){
		query_where=query_where+" and armas.CUSNAM like '%"+pmma_customer_search+"%'";
	}
	if(pmma_jobno_search.length>0){
		query_where=query_where+" and concat(ifnull(pmma.BPMJ_SO_NO,''),IFNULL(BPMJ_SERAIL,'')) like '%"+pmma_jobno_search+"%'";
	}
	//if(PMMA_SELECT_DATE_START.length>0){
		var PMMA_SELECT_DATE_START_array=PMMA_SELECT_DATE_START.split("/");
		var PMMA_SELECT_DATE_END_array=PMMA_SELECT_DATE_END.split("/"); 
		query_where=query_where+" and pmma.BPMJ_DUEDATE between '"+PMMA_SELECT_DATE_START_array[2]+"-"+PMMA_SELECT_DATE_START_array[1]+"-"+PMMA_SELECT_DATE_START_array[0]+" 00:00:00' "+
		" and '"+PMMA_SELECT_DATE_END_array[2]+"-"+PMMA_SELECT_DATE_END_array[1]+"-"+PMMA_SELECT_DATE_END_array[0]+" 23:59:59' ";
	//}
		 
	var query=" SELECT pmma.bpmj_no as c0 ,so.bso_type_no as c1 ,armas.CUSCOD as c2,armas.CUSNAM as c3, "+
    
	" CONCAT(IFNULL(so.BSO_INSTALLATION_SITE_LOCATION ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR1 ,''),' ',  "+
	"        IFNULL(so.BSO_INSTALLATION_ADDR2 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR3 ,'') , ' ',  "+
	" IFNULL(so.BSO_INSTALLATION_PROVINCE ,''),' ',IFNULL(so.BSO_INSTALLATION_ZIPCODE ,'') )  "+
	" 			     	 as c4 , "+
	" 	CONCAT(IFNULL(so.BSO_INSTALLATION_CONTACT ,''),' ',IFNULL(so.BSO_INSTALLATION_TEL_FAX ,'')) as c5,  "+
	" case when ( pmma.BPMJ_DUEDATE_START_TIME is null and pmma.BPMJ_DUEDATE is not null )  "+
	" then  ifnull(DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y [%a]'),'') "+
	" when (pmma.BPMJ_DUEDATE is not null and pmma.BPMJ_DUEDATE_START_TIME is not null ) "+
	" then    CONCAT(DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y'),' ', DATE_FORMAT(pmma.BPMJ_DUEDATE_START_TIME,'%H:%i'),' [',DATE_FORMAT(pmma.BPMJ_DUEDATE,'%a'),']' ) "+
	" else "+
	" '' "+
	" end as c6 ,  "+
	// " 	CONCAT(DATE_FORMAT(pmma.BPMJ_DUEDATE,'%d/%m/%Y'),' ', DATE_FORMAT(pmma.BPMJ_DUEDATE_START_TIME,'%H:%i') )  as c6 , "+
	" CONCAT(IFNULL(BPMJ_SERAIL,''),'/',IFNULL(BPMJ_UPS_MODEL,'')) as c7, "+ 
	// " '' as c8 "+
	" CONCAT(CAST(BPMJ_ORDER as CHAR(50)),'/',CAST((select count(*) from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma_inner where pmma_inner.BPMJ_NO=pmma.BPMJ_NO  ) as CHAR(50)) ) as c8, "+
	" pmma.BPMJ_SERAIL as c9, "+
	" pmma.BPMJ_ORDER as c10, "+
	" concat(center.bc_name,'(',user.firstname,')') as c11 ,  "+
	"  user.id  as c12, "+
	"  user.username  as c13 ,"+
	" user.bpm_role_id as c14 , "+
	" DATE_FORMAT(pmma.BPMJ_DUEDATE,'%Y-%m-%d') as c15 "+
	" 	  FROM "+SCHEMA_G+".BPM_PM_MA_JOB pmma "+
	" 	left join "+SCHEMA_G+".BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+
	" 	left join "+SCHEMA_G+".BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD "+
	"  left join "+SCHEMA_G+".user user on user.id=pmma.BPMJ_CENTER "+
	"  left join "+SCHEMA_G+".BPM_CENTER center on center.uid=user.id "+ 
	" 	where pmma.bpmj_job_status=1  "+query_where+
	 " order by pmma.BPMJ_DUEDATE,pmma.BPMJ_ORDER asc  ";
	// alert(query)
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	// alert(queryObject)
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
			        "  		<th width=\"4%\"><div class=\"th_class\"><input type=\"checkbox\" id=\"pm_check_all\" onclick=\"checkAll()\"/>No.</div></th> "+
			        "  		<th width=\"8%\"><div class=\"th_class\">SO No/PM ครั้งที่</div></th> "+ 
			        "  		<th width=\"24%\"><div class=\"th_class\">หมายเลขเคร่ือง/Model</div></th> "+ 
			       "  		<th width=\"12%\"><div class=\"th_class\">ชื่อลูกค้า</div></th> "+ 
			         "  		<th width=\"28%\"><div class=\"th_class\">สถานที่ PM/MA</div></th> "+ 
			         "  		<th width=\"10%\"><div class=\"th_class\">ชื่อผู้ติดต่อ</div></th> "+ 
			          "  		<th width=\"7%\"><div class=\"th_class\">ศูนย์</div></th> "+ 
			         "  		<th width=\"7%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+ 
			     //  "  		<th width=\"5%\"><div class=\"th_class\">PM ครั้งที่</div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			        
			        
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"checkbox\" name=\"pm_check\" value=\""+data[i][0]+","+data[i][9]+","+data[i][10]+","+data[i][1]+","+data[i][13]+","+data[i][14]+","+data[i][15]+"\"/>"+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> <span style=\"text-decoration: underline;\" onclick=\"loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId="+data[i][0]+"_"+data[i][9]+"_"+data[i][10]+"&mode=edit')\">"+data[i][1]+"</span><span> ( "+ data[i][8]+" )</span> </td>"+    
					   "    	<td style=\"text-align: left;\">"+data[i][7]+"</td>  "+   
					   "    	<td style=\"text-align: left;\">"+data[i][3]+"</td>  "+  
				         
				        "    	<td style=\"text-align: left;\">"+data[i][4]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+  
				        "    	<td style=\"text-align: left;\"><span style=\"text-decoration: underline;\" onclick=\"showTeam('"+data[i][12]+"','"+data[i][0]+"','"+data[i][9]+"','"+data[i][10]+"')\">"+data[i][11]+"</span></td>  "+
				         "    	<td style=\"text-align: left;\">"+data[i][6]+"</td>  "+
				      //  "    	<td style=\"text-align: center;\">"+  
				      //  data[i][8]+
				      //  "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"5\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#search_section_pmma_plan").html(str);
		}
	}); 
	/*
	SynDomeBPMAjax.searchObject(queryCount,{
		callback:function(data){
			//alert(data)
			//alert(calculatePage(_perpageG,data))
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
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
	*/
}  
function showTeam(userid,BPMJ_NO,BPMJ_SERAIL,BPMJ_ORDER){
	/*
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod , user.detail FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where dept.BDEPT_ID=10 ";
	*/
	  var query="SELECT u.id,u.username,u.firstName,u.lastName ,u.email,u.mobile ,center.bc_name "+
		" FROM "+SCHEMA_G+".BPM_CENTER  center  left join  "+SCHEMA_G+".user u on center.uid=u.id "+ 
		"  ";
	<%-- 
		" where user_hod.username='${username}' "; 
		 --%>
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
			    "  		<th width=\"35%\"><div class=\"th_class\">Name</div></th> "+  
			    "  		<th width=\"30%\"><div class=\"th_class\">ศูนย์</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){
					   var  checked_str="";
					   if(data[i][0]==userid)
						   checked_str="checked";
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" "+checked_str+" value=\""+data[i][0]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "  		<td style=\"text-align: left;\"> "+data[i][6]+" </td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignCenter('"+BPMJ_NO+"','"+BPMJ_SERAIL+"','"+BPMJ_ORDER+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a></div>";
				// alert(str)
				 bootbox.classes("aoe_small");
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function doAssignCenter(BPMJ_NO,BPMJ_SERAIL,BPMJ_ORDER){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	 
	bootbox.hideAll();
	 
	var btdl_type='3';var btdl_state='wait_for_operation';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูก Assign เรียบร้อยแล้ว';var message_todolist='PM/MA wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];   
		 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_CENTER='"+owner+"',BPMJ_JOB_STATUS=1 where BPMJ_NO='"+BPMJ_NO+"' and BPMJ_SERAIL='"+BPMJ_SERAIL+"' and BPMJ_ORDER="+BPMJ_ORDER; 
		  querys.push(query2); 
	if(username_team.length>0)  
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
				showDialog(message_created);
				searchPMMA('1');
			}
		}
	});

}
function doAssignTeam(){
	var querys=[]; 
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';
	//$('input[name="pm_check"]').prop('checked',$("#pm_check_all").prop('checked'));
	$('input[name="pm_check"]:checked').each(function () { 
   // pmma.bpmj_no 0, pmma.BPMJ_SERAIL  1 , pmma.BPMJ_ORDER 2
        var id = $(this).attr("value");
        var ids= $(this).val().split(",");
       // alert("Do something for: " + id + ", " + answer);
        var btdl_type='3';var btdl_state='wait_for_pmma_assign_to_team';
        var message_todolist='PM/MA wait for Assign';
        if(ids[5]!='3'){
        	btdl_state='wait_for_operation_pmma';
        	message_todolist='PM/MA wait for Operation';
        }
    	var owner=ids[4];var owner_type="1";
    	var hide_status='1';
    	var duedate=ids[6];
    	var query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
    			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
    			"('"+ids[0]+"_"+ids[1]+"_"+ids[2]+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	null,'"+hide_status+"','${username}','"+ids[3]+"',(SELECT (DATE_FORMAT(('"+duedate+"' +  INTERVAL 0 DAY),'%Y-%m-%d 20:00:00'))) ) ";
    	 querys.push(query); 
    	 query="UPDATE  "+SCHEMA_G+".BPM_PM_MA_JOB SET  BPMJ_JOB_STATUS=2 WHERE BPMJ_NO='"+ids[0]+"'   AND BPMJ_SERAIL='"+ids[1]+"'  AND BPMJ_ORDER="+ids[2]+"";
    	 querys.push(query);
    });
	if(querys.length>0)
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
				showDialog(message_created);
				searchPMMA("1");
			}
		}
	});
	bootbox.hideAll(); 
	return false;

}

function changeDuedateGroup(){
	var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
    "	<thead> 	"+
    "  		<tr> "+
    "  		<th colspan='2' width=\"100%\"><div class=\"th_class\"></div></th> "+ 
    " 		</tr>"+
    "	</thead>"+
    "	<tbody>   ";    
		   str=str+ "  	<tr style=\"cursor: pointer;\">"+
		   "  		<td style=\"text-align: left;\">"+
		   " <span>เวลานัดหมาย <input  readonly=\"readonly\" data-date-format=\"dd/mm/yyyy\"  type=\"text\" value=\"\"  style=\"width:100px; height: 30px;\"  id=\"duedate_change\"> - ระบุเวลา"+
		   "<div class=\"input-append bootstrap-timepicker\"> "+
          " <input  style=\"cursor: pointer;width:50px; height: 30px;\" readonly=\"readonly\" id=\"duedate_time_change\" type=\"text\" class=\"input-small\">"+
          " <span class=\"add-on\"><i class=\"icon-time\"></i></span>"+
       "</div>"+
	   
		   //" <input readonly=\"readonly\"  style=\"cursor: pointer;width:50px; height: 30px;\" type=\"text\" value=\"\"  id=\"duedate_time_change\"> </span></td>"+     
 
	        "  	</tr>  "; 
	 
	   str=str+  " </tbody>"+
	   "</table> ";
	  str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doChangeDuedateGroup()\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">เปลี่ยนเวลา</span></a></div>";
		// alert(str)
		 bootbox.classes("aoe_small");
		   bootbox.dialog(str,[{
			    "label" : "Cancel",
			     "class" : "btn-danger"
			    //	"class" : "class-with-width"
		 }]);
		   $("#duedate_change" ).datepicker({
				showOn: "button",
				buttonImage: _path+"resources/images/calendar.gif",
				buttonImageOnly: true,
				dateFormat:"dd/mm/yy" ,
				changeMonth: true,
				changeYear: true
			});
		   $('#duedate_time_change').timepicker({
			    showPeriodLabels: false
		 });
		   /*
		   $("#duedate_change" ).datepicker( );
		   $("#duedate_time_change").timepicker({
               minuteStep: 1,
               template: 'modal',
               appendWidgetTo: 'body',
               showSeconds: false,
               showMeridian: false,
               defaultTime: false
           });
		   */
		/*
		   $("#duedate_change" ).datepicker({
				showOn: "button",
				buttonImage: _path+"resources/images/calendar.gif",
				buttonImageOnly: true,
				dateFormat:"dd/mm/yy" ,
				changeMonth: true,
				changeYear: true
			});
		   $('#duedate_time_change').timepicker({
			    showPeriodLabels: false
		 });
		   */
}
function showTeamGroup( ){
	 /*
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod , user.detail FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where dept.BDEPT_ID=10 "; 
	 */
	  var query="SELECT u.id,u.username,u.firstName,u.lastName ,u.email,u.mobile ,center.bc_name "+
		" FROM "+SCHEMA_G+".BPM_CENTER  center  left join  "+SCHEMA_G+".user u on center.uid=u.id "+ 
		"  ";
	  
	<%-- 
		" where user_hod.username='${username}' "; 
		 --%>
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
			    "  		<th width=\"35%\"><div class=\"th_class\">Name</div></th> "+  
			    "  		<th width=\"30%\"><div class=\"th_class\">ศูนย์</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\"  value=\""+data[i][0]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "  		<td style=\"text-align: left;\"> "+data[i][6]+" </td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignCenterGroup()\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a></div>";
				// alert(str)
				 bootbox.classes("aoe_small");
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function doAssignCenterGroup(){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	 
	bootbox.hideAll();
	 
	var btdl_type='3';var btdl_state='wait_for_operation';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูก Assign เรียบร้อยแล้ว';var message_todolist='PM/MA wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];   
	$('input[name="pm_check"]:checked').each(function () { 
		   // pmma.bpmj_no 0, pmma.BPMJ_SERAIL  1 , pmma.BPMJ_ORDER 2
		        var id = $(this).attr("value");
		        var ids= $(this).val().split(",");
		       // alert("Do something for: " + id + ", " + answer); 
		    	var owner=username_team; 
		    	 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_CENTER='"+owner+"'  where BPMJ_NO='"+ids[0]+"'   AND BPMJ_SERAIL='"+ids[1]+"'  AND BPMJ_ORDER="+ids[2]+""; 
				  querys.push(query2);
		    });
		  
	if(username_team.length>0)  
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
				showDialog(message_created);
				searchPMMA('1');
			}
		}
	});

}
function doChangeDuedateGroup(){

	bootbox.hideAll();
	 
	var message_created='ข้อมูลถูก เปลี่ยนเวลานัดหมาย เรียบร้อยแล้ว';
	var duedate_change=jQuery.trim($("#duedate_change").val()); 
	var duedate_time_change=jQuery.trim($("#duedate_time_change").val()); 
 if(duedate_change.length>0){  
	 var duedate_change_array=duedate_change.split("/");
	 if(duedate_time_change.length>0)
		 duedate_time_change="'"+duedate_time_change+":00'";
	 else
		 duedate_time_change='null';
	 // alert(duedate_time_change);
	  
	var querys=[];   
	$('input[name="pm_check"]:checked').each(function () { 
		   // pmma.bpmj_no 0, pmma.BPMJ_SERAIL  1 , pmma.BPMJ_ORDER 2
		        var id = $(this).attr("value");
		        var ids= $(this).val().split(",");
		       // alert("Do something for: " + id + ", " + answer); 
		    	
		    	 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set "+
		    	 " BPMJ_DUEDATE='"+duedate_change_array[2]+"-"+duedate_change_array[1]+"-"+duedate_change_array[0]+" 00:00:00' "+
		    	 " ,BPMJ_DUEDATE_START_TIME="+duedate_time_change+" where BPMJ_NO='"+ids[0]+"'   AND BPMJ_SERAIL='"+ids[1]+"'  AND BPMJ_ORDER="+ids[2]+""; 
				  querys.push(query2);
		    });
		  
	if(querys.length>0)  
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
				showDialog(message_created);
				searchPMMA('1');
			}
		}
	});
 }
}

function doViewJob(){

	var viewValue=$("#viewSelect").val();
	var PMMA_VIEW_DATE_START=jQuery.trim($("#PMMA_VIEW_DATE_START").val()).split("/");
	var PMMA_VIEW_DATE_END=jQuery.trim($("#PMMA_VIEW_DATE_END").val()).split("/");
	var query="";
	var title="";
	if(viewValue=='1'){ //query_center
		query=" SELECT "+
		" concat(user.detail,'(',user.firstname,')')  as c0  ,"+
		" (select count(*) from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma2 "+
		" where pmma2.bpmj_job_status=1  and pmma2.BPMJ_DUEDATE  "+
		   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
		    " and pmma.BPMJ_CENTER=pmma2.BPMJ_CENTER) as c1 "+ 
		// " where pmma2.BPMJ_NO=pmma.BPMJ_NO and pmma2.BPMJ_CENTER=pmma.BPMJ_CENTER) as c1 "+
		"  FROM SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma   "+
		" 	left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+ 
		"  	left join SYNDOME_BPM_DB.BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD   "+
		" 	left join SYNDOME_BPM_DB.user user on user.id=pmma.BPMJ_CENTER "+
		" 	where pmma.bpmj_job_status=1   "+
		"  and pmma.BPMJ_DUEDATE "+
		   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
		" group by pmma.BPMJ_CENTER  "+
		"  order by  concat(user.detail,'(',user.firstname,')') ";
		title="ศุนย์";
	}else	if(viewValue=='2'){ //query_provice
		query=" SELECT "+ 
		" so.BSO_INSTALLATION_PROVINCE  ,"+
		" (select count(*) from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma2 "+
		" left join SYNDOME_BPM_DB.BPM_SALE_ORDER so2 on pmma2.bpmj_no=so2.bso_id  "+
	   " where pmma2.bpmj_job_status=1  and pmma2.BPMJ_DUEDATE  "+
	   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
	    " and so.BSO_INSTALLATION_PROVINCE=so2.BSO_INSTALLATION_PROVINCE) as c1 "+ 
		//" left join SYNDOME_BPM_DB.BPM_SALE_ORDER so2 on pmma2.bpmj_no=so2.bso_id "+
		//"  where pmma2.BPMJ_NO=pmma.BPMJ_NO and so.BSO_INSTALLATION_PROVINCE=so2.BSO_INSTALLATION_PROVINCE) as c1 "+ 
		" 	  FROM SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma  "+
		" 		left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+
		" 	  	left join SYNDOME_BPM_DB.BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD  "+
		" 		left join SYNDOME_BPM_DB.user user on user.id=pmma.BPMJ_CENTER "+
		" 	where pmma.bpmj_job_status=1   "+
		" 	  and pmma.BPMJ_DUEDATE "+
		   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
		" 	group by so.BSO_INSTALLATION_PROVINCE  "+
		" 	 order by  so.BSO_INSTALLATION_PROVINCE ";
		title="จังหวัด";
	}else 	if(viewValue=='3'){//query_cust
		query=" SELECT "+  
		" 	armas.CUSNAM ,"+ 
		" 	(select count(*) from SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma2 "+ 
		" 	left join SYNDOME_BPM_DB.BPM_SALE_ORDER so2 on pmma2.bpmj_no=so2.bso_id "+ 
		" 	left join SYNDOME_BPM_DB.BPM_ARMAS armas2 on armas2.CUSCOD=so2.CUSCOD "+ 
		" where pmma2.bpmj_job_status=1  and pmma2.BPMJ_DUEDATE  "+
		   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
		    " and armas.CUSCOD=armas2.CUSCOD) as c1 "+ 
	//	" 	 where pmma2.BPMJ_NO=pmma.BPMJ_NO and armas.CUSCOD=armas2.CUSCOD) as  c1  "+  
		" 		  FROM SYNDOME_BPM_DB.BPM_PM_MA_JOB pmma  "+ 
		" 		left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+ 
		" 	 	left join SYNDOME_BPM_DB.BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD  "+ 
		" 		left join SYNDOME_BPM_DB.user user on user.id=pmma.BPMJ_CENTER "+ 
		" 		where pmma.bpmj_job_status=1   "+ 
		" 	  and pmma.BPMJ_DUEDATE "+ 
		   " 	 between '"+PMMA_VIEW_DATE_START[2]+"-"+PMMA_VIEW_DATE_START[1]+"-"+PMMA_VIEW_DATE_START[0]+" 00:00:00'  and '"+PMMA_VIEW_DATE_END[2]+"-"+PMMA_VIEW_DATE_END[1]+"-"+PMMA_VIEW_DATE_END[0]+" 23:59:59' "+
		" 	group by armas.CUSCOD  "+ 
		" 	 order by  armas.CUSNAM";
		title="ลูกค้า";
	}  
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
			var str= "	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    "	<thead> 	"+
		    "  		<tr> "+
		    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
		    "  		<th width=\"80%\"><div class=\"th_class\">"+title+"</div></th> "+
		    "  		<th width=\"15%\"><div class=\"th_class\">จำนวนงาน</div></th> "+ 
		    " 		</tr>"+
		    "	</thead>"+
		    "	<tbody>   "; 
			if(data!=null && data.length>0){    
				   for(var i=0;i<data.length;i++){ 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\">"+(i+1)+"</td>"+     
					   "  		<td style=\"text-align: left;\">"+data[i][0]+"</td>"+      
				        "  		<td style=\"text-align: center;\">"+data[i][1]+"</td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
			 }else{
				 str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"3\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			 }
			  $("#view_element").html(str);
		}
	});
	 
}
function viewJob(){ 
	 var str="<div><span><strong>ระบุเดือน :</strong></span>"+
	 "<span style=\"padding-left:5px\">"+ 
	 "		 <input  data-date-format=\"mm/yyyy\" data-date-viewmode=\"years\" data-date-minviewmode=\"months\"  readonly=\"readonly\"  style=\"cursor:pointer;width:90px; height: 30px;\"   type=\"text\" id=\"PMMA_VIEW_DATE_START\" value=\"${time}\">"+
	 "</span>"+
	  " <span  style=\"padding-left:2px\"><strong> ถึง </strong></span>"+
	 "<span style=\"padding-left:5px\">"+
	 " <input  data-date-format=\"mm/yyyy\" data-date-viewmode=\"years\" data-date-minviewmode=\"months\"  readonly=\"readonly\"  style=\"cursor:pointer;width:90px; height: 30px;\"   type=\"text\" id=\"PMMA_VIEW_DATE_END\" value=\"${time}\"> "+
	 " </span>"+
	 "<span style=\"padding-left:50px\">"+
	 "View By : <select name=\"viewSelect\" style=\"width:75px\" id=\"viewSelect\"   ><option value=\"1\">ศุนย์</option><option value=\"2\">จังหวัด</option><option value=\"3\">ลูกค้า</option></select></span>"+
	 "<span style=\"padding-left:10px\"><a class=\"btn btn-success\" style=\"margin-top:-10px\" onclick=\"doViewJob()\"><span style=\"color: white;font-weight: bold;\">View</span></a> </span></div>"+
	 "<div id=\"view_element\"></div>";
	  bootbox.classes("aoe_width");
				   bootbox.dialog(str,[{
					 
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]); 
				   $("#PMMA_VIEW_DATE_START" ).datepicker({
						showOn: "button",
						buttonImage: _path+"resources/images/calendar.gif",
						buttonImageOnly: true,
						dateFormat:"dd/mm/yy" ,
						changeMonth: true,
						changeYear: true
					});
				   $("#PMMA_VIEW_DATE_END" ).datepicker({
						showOn: "button",
						buttonImage: _path+"resources/images/calendar.gif",
						buttonImageOnly: true,
						dateFormat:"dd/mm/yy" ,
						changeMonth: true,
						changeYear: true
					});
				//$('#PMMA_VIEW_DATE_START').datepicker();
				//$('#PMMA_VIEW_DATE_END').datepicker();
				 		    
				
}
</script>
<div id="dialog-confirmDelete" title="Delete PM/MA" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete PM/MA ?
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
	    					<td align="left" colspan="2" width="100%">   
	    					 	
	    					 <span><strong>ระบุเดือน :</strong></span>
	    					 <span style="padding-left:5px"> 
	    					 		 <input  data-date-format="mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months"  readonly="readonly"  style="cursor:pointer;width:90px; height: 30px;"   type="text" id="PMMA_SELECT_DATE_START" value="${time}">
  								
	    					 		 <%-- <i class="icon-calendar"> --%>
	    					 		 
									<%--
	    					 	 	<input   readonly="readonly" style="cursor:pointer;width:120px; height: 30px;" value="${time}" id="PMMA_SELECT_DATE_STARTs" type="text">
	    					 	   --%>
							  </span>
							   <span  style="padding-left:2px"><strong> ถึง </strong></span>
	    					 <span style="padding-left:5px">
	    					  <input  data-date-format="mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months"  readonly="readonly"  style="cursor:pointer;width:90px; height: 30px;"   type="text" id="PMMA_SELECT_DATE_END" value="${time}">
  								 
							  </span>
							   
							  <%-- 
							  <span style="padding-left:20px"><strong>End Date :</strong></span>
	    					  <span style="padding-left:5px"> 
	    					  		<input   readonly="readonly" style="cursor:pointer;width:90px; height: 30px;" id="PMMA_END_DATE" type="text">
	    					  		<i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
							   </span>
							    --%>
							   <span style="padding-left:20px"><strong>ศูนย์ :</strong></span>
	    					  <span style="padding-left:5px" id="pmma_center_element"> 
							   </span> 
							    <span style="padding-left:20px"><strong>จังหวัด :</strong></span>
	    					  <span style="padding-left:5px"> 
	    					 	  <input type="text" id="pmma_province_search" style="cursor:pointer;width:120px; height: 30px;"/>
							   </span>
							    <span style="padding-left:20px"><strong>ลูกค้า :</strong></span>
	    					  <span style="padding-left:5px"> 
	    					 	  <input type="text" id="pmma_customer_search" style="cursor:pointer;width:200px; height: 30px;"/>
							   </span> 
							     <span style="padding-left:10px"><strong>SO / Serial No:</strong></span>
	    					  <span style="padding-left:5px"> 
	    					 	  <input type="text" id="pmma_jobno_search" style="cursor:pointer;width:70px; height: 30px;"/>
							   </span>   
							    <span style="padding-left:15px"> 
	    					 	 <a class="btn"  style="padding-left:15px;margin-top:-10px" onclick="searchPMMA('1')"><i class="icon-search"></i>&nbsp;<span style="font-weight:bold;">Search</span></a>
	    					 </span>
	    					
	    					</td> 
	    					</tr> 
	    					<tr>
	    					<td align="left" width="70%">   
	    					 <span>
	    						<a class="btn btn-primary"   onclick="doAssignTeam()"><i class="icon-ok icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Assign Job</span></a>
	    					 </span>
	    					 <span style="padding-left:15px">
	    					 	<a class="btn btn-primary"  onclick="changeDuedateGroup()"><i class="icon-check icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">เปลี่ยนเวลานัดหมาย</span></a>
	  						 </span>
	  						  <span style="padding-left:15px">
	    					 	<a class="btn btn-primary"  onclick="showTeamGroup()"><i class="icon-check icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">เปลี่ยนศูนย์</span></a>
	  						 </span>
	    					 <span style="padding-left:15px">
	    					 	<a class="btn btn-primary"  onclick="viewJob()"><i class="icon-check icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">View Job</span></a>
	  						 </span>
	  						 
	    					</td><td align="right" width="30%"> 
	    					<%--
	    					<span id="pageMaxElement" style="padding-right:20px">
	    					จำนวน item/หน้า <select name="pageMax" id="pageMax" onchange="" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					 --%>
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="pageSelect" id="pageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>
	    					&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="doSearch('search','0')"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>  
	    					<div  id="search_section_pmma_plan"> 
    						</div> 
      </div>
      </fieldset> 