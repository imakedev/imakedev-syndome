<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authentication var="username" property="principal.username"/> 
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	searchPMMA("1");
	 $("#PMMA_START_DATE" ).datepicker({
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
		$("#keyword_search").keypress(function(event) {
			  if ( event.which == 13 ) {
			     event.preventDefault();
			     searchPMMA('1');
			   } 
			});
		
	 
});
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
function editDetail(bpmj_no){
	
	var query=" SELECT  IFNULL(so.BSO_INSTALLATION_SITE_LOCATION,'') as c0, "+
	" IFNULL(so.BSO_INSTALLATION_CONTACT,'') as c1, "+
	" IFNULL(so.BSO_INSTALLATION_TEL_FAX,'') as c2, "+ 
	" IFNULL(so.BSO_INSTALLATION_ADDR1,'') as c3, "+
	" IFNULL(so.BSO_INSTALLATION_ADDR2,'') as c4, "+
	" IFNULL(so.BSO_INSTALLATION_ADDR3,'') as c5, "+ 
	" IFNULL(so.BSO_INSTALLATION_PROVINCE,'') as c6, "+
	" IFNULL(so.BSO_INSTALLATION_ZIPCODE,'') as c7 ,  "+ 
	 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'')  as c8,  "+
	 " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'')  as c9 "+
	" 	  FROM "+SCHEMA_G+".BPM_SALE_ORDER so "+ 
	" 	where so.BSO_ID="+bpmj_no;
	//alert(query)
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
				//alert(data[0][9])
				 var str=" <div id=\"bsoType_2\" style=\"border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;\"> "+
				   " <table style=\"width: 100%;font-size:13px\" border=\"0\">" +
				 <%-- 
				   " 	<tr>" +
				   " 	<td width=\"30%\">" +
				   " 			<span>" +
				   " 				กำหนดติดตั้ง" +
				   " 			</span>" +
				   " 	</td>" +
				   " 	<td width=\"70%\">" +
				   " 		<span style=\"padding-left: 3px\">" +
				   " 			<input type=\"text\" value=\""+data[0][8]+"\" readonly=\"readonly\" style=\"width:100px; height: 30px;\" id=\"BSO_INSTALLATION_TIME_PICKER\" />" +
				   " 		</span>" +
				   		
				   	" 		<span style=\"padding-left: 5px\">ระบุเวลา " +
				   	" 		<input type=\"text\"   value=\""+data[0][9]+"\" readonly=\"readonly\"  style=\"cursor:pointer;width:50px; height: 30px;\" id=\"BSO_INSTALLATION_TIME_TIME_PICKER\" />" +
				   	" 		</span>" +
				   				
				   	" 		</td>" +
				   	" 	</tr>" +
				   	--%>
				   	" 	<tr>" +
				   	" 		<td width=\"25%\">" +
				   	" 			<span> "+
				   	" 				ชื่อผู้ติดต่อ" +
				   	" 			</span>" +
				   	" 	</td>" +
				   	" 		<td width=\"75%\">" +
				   	" 			<span style=\"padding-left: 3px\">" +
				   	" 			<input type=\"text\" value=\""+data[0][1]+"\" style=\"width:300px; height: 30px;\" id=\"BSO_INSTALLATION_CONTACT\" />" +
				   	" 		</span>" +
				   	" 		</td>" +
				   	" 	</tr>" +
				   	" 	<tr>" +
				   	" 	<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				ระบุชื่อ Site งาน" +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\">" +
				   	" 			<input type=\"text\" value=\""+data[0][0]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_SITE_LOCATION\" />" +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" </tr>" +
				   	" <tr valign=\"top\">" +
				   	" 		<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				ที่อยู่" +
				   	" 			</span>" +
				   	" 	</td> " +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\"> " +
				   	" 		 <input type=\"text\"  value=\""+data[0][3]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_ADDR1\" /> " +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" </tr>" +
				   	" <tr valign=\"top\">" +
				   	" 	<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				แขวง/ตำบล" +
				   	" 		</span>" +
				   	" </td> " +
				   	" <td width=\"80%\">" +
				   	" 	<span style=\"padding-left: 3px\"> " +
				   	" 	 <input type=\"text\" value=\""+data[0][4]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_ADDR2\" /> " +
				   	" 	</span>" +
				   	" </td>" +
				   	" </tr>" +
				   	" <tr valign=\"top\">" +
				   	" 	<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				เขต/อำเภอ" +
				   	" 			</span>" +
				   	" 	</td> " +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\"> " +
				   	" 		 <input type=\"text\" value=\""+data[0][5]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_ADDR3\" /> " +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" </tr>" +
				   	" <tr valign=\"top\">" +
				   	" 		<td width=\"20%\">" +
				   	" 				<span>" +
				   	" 				จังหวัด" +
				   	" 			</span>" +
				   	" 	</td> " +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\"> " +
				   	" 		 <input type=\"text\" value=\""+data[0][6]+"\"  style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_PROVINCE\" /> " +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" </tr>" +
				   	" 		<tr valign=\"top\">" +
				   	" 	<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				รหัสไปรษณีย์" +
				   	" 			</span>" +
				   	" 	</td> " +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\"> " +
				   	" 		 <input type=\"text\" value=\""+data[0][7]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_ZIPCODE\" /> " +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" 	</tr>" +
				   	" <tr>" +
				   	" 	<td width=\"20%\">" +
				   	" 			<span>" +
				   	" 				เบอร์โทร/แฟกซ์" +
				   	" 			</span>" +
				   	" 	</td>" +
				   	" 	<td width=\"80%\">" +
				   	" 		<span style=\"padding-left: 3px\">" +
				   	" 		 <input type=\"text\"  value=\""+data[0][2]+"\" style=\"height: 30px;width: 320px\" id=\"BSO_INSTALLATION_TEL_FAX\" />  " +
				   	" 		</span>" +
				   	" 	</td>" +
				   	" </tr> " +
					" <tr>" +
				   	" 	<td align=\"center\" width=\"100%\" colspan=\"2\">" +
				   	"<a class=\"btn btn-primary\"  onclick=\"doUpdateLocation('"+bpmj_no+"')\"> <span style=\"font-weight:bold;color:  white;\">Ok</span></a> "+
				   	"<a class=\"btn btn-danger\"  onclick=\"hideAllDialog()\"> <span style=\"padding-left:10px;font-weight:bold;color:  white;\">Cancel</span></a> "+
				   	" 	</td>" + 
				   	" </tr> " +
				   	" 	</table>" +
				   	" </div>" ;	
				 //  	alert(str)
				 bootbox.dialog(str);
				  autoInstallationLocation("BSO_INSTALLATION_SITE_LOCATION");
				 autoProvince("BSO_INSTALLATION_PROVINCE");
				  autoAmphur("BSO_INSTALLATION_ADDR3");
			}
		}
	});
}
function doUpdateLocation(bpmj_no){
	//alert("ss")
	var BSO_INSTALLATION_SITE_LOCATION=jQuery.trim($("#BSO_INSTALLATION_SITE_LOCATION").val()); 
	var BSO_INSTALLATION_CONTACT=jQuery.trim($("#BSO_INSTALLATION_CONTACT").val());
	var BSO_INSTALLATION_TEL_FAX=jQuery.trim($("#BSO_INSTALLATION_TEL_FAX").val());
	var BSO_INSTALLATION_ADDR1=jQuery.trim($("#BSO_INSTALLATION_ADDR1").val());
	var BSO_INSTALLATION_ADDR2=jQuery.trim($("#BSO_INSTALLATION_ADDR2").val());
	var BSO_INSTALLATION_ADDR3=jQuery.trim($("#BSO_INSTALLATION_ADDR3").val());
	var BSO_INSTALLATION_PROVINCE=jQuery.trim($("#BSO_INSTALLATION_PROVINCE").val());
	var BSO_INSTALLATION_ZIPCODE=jQuery.trim($("#BSO_INSTALLATION_ZIPCODE").val());
	 
	var querys=[];
	var query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_INSTALLATION_SITE_LOCATION='"+BSO_INSTALLATION_SITE_LOCATION+"'"+
	     ",BSO_INSTALLATION_CONTACT='"+BSO_INSTALLATION_CONTACT+"' ,BSO_INSTALLATION_TEL_FAX='"+BSO_INSTALLATION_TEL_FAX+"' "+
	     ",BSO_INSTALLATION_ADDR1='"+BSO_INSTALLATION_ADDR1+"' ,BSO_INSTALLATION_ADDR2='"+BSO_INSTALLATION_ADDR2+"' "+
	     ",BSO_INSTALLATION_ADDR3='"+BSO_INSTALLATION_ADDR3+"' ,BSO_INSTALLATION_PROVINCE='"+BSO_INSTALLATION_PROVINCE+"' "+
	     ",BSO_INSTALLATION_ZIPCODE='"+BSO_INSTALLATION_ZIPCODE+"' where BSO_ID="+bpmj_no;
	 
	 querys.push(query); 
	 query="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_LOCATION='"+BSO_INSTALLATION_SITE_LOCATION+"'"+
     ",BPMJ_CONTACT_NAME='"+BSO_INSTALLATION_CONTACT+"' ,BPMJ_CONTACT_MOBILE='"+BSO_INSTALLATION_TEL_FAX+"'  ,BPMJ_TEL_FAX='"+BSO_INSTALLATION_TEL_FAX+"' "+
     ",BPMJ_ADDR1='"+BSO_INSTALLATION_ADDR1+"' ,BPMJ_ADDR2='"+BSO_INSTALLATION_ADDR2+"' "+
     ",BPMJ_ADDR3='"+BSO_INSTALLATION_ADDR3+"' ,BPMJ_PROVINCE='"+BSO_INSTALLATION_PROVINCE+"' "+
     ",BPMJ_ZIPCODE='"+BSO_INSTALLATION_ZIPCODE+"' where BPMJ_NO="+bpmj_no;
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
			 
			//if(data!=0){
				searchPMMA("1");
				bootbox.hideAll();
			//}
		},errorHandler:function(errorString, exception) { 
			alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
		}
	});
}
function searchPMMA(_page){  
	$("#pageNo").val(_page); 
	var keyword_search=jQuery.trim($("#keyword_search").val().replace(/'/g,"''"));
	var query=" SELECT pmma.bpmj_no as c0 ,so.bso_type_no as c1 ,armas.CUSCOD as c2,armas.CUSNAM as c3, "+
        
	" CONCAT(IFNULL(so.BSO_INSTALLATION_SITE_LOCATION ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR1 ,''),' ',  "+
	"        IFNULL(so.BSO_INSTALLATION_ADDR2 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR3 ,'') , ' ',  "+
	" IFNULL(so.BSO_INSTALLATION_PROVINCE ,''),' ',IFNULL(so.BSO_INSTALLATION_ZIPCODE ,'') )  "+
	" 			     	 as c4 , "+
	" 	CONCAT(IFNULL(so.BSO_INSTALLATION_CONTACT ,''),' ',IFNULL(so.BSO_INSTALLATION_TEL_FAX ,'')) as c5,  "+
	" 	CONCAT(DATE_FORMAT(min(pmma.BPMJ_DUEDATE),'%d/%m/%Y'),' ', ifnull(DATE_FORMAT(min(pmma.BPMJ_DUEDATE_START_TIME),'%H:%i'),'') )  as c6 , "+
	" (select count(*) from "+SCHEMA_G+".BPM_PM_MA_JOB pmma2 where pmma.bpmj_no=pmma2.bpmj_no ) as c7 "+
	" 	  FROM "+SCHEMA_G+".BPM_PM_MA_JOB pmma "+
	" 	left join "+SCHEMA_G+".BPM_SALE_ORDER so on pmma.bpmj_no=so.bso_id "+
	" 	left join "+SCHEMA_G+".BPM_ARMAS armas on armas.CUSCOD=so.CUSCOD "+
	" 	where pmma.bpmj_job_status=0 ";
	if(keyword_search.length>0)
		query=query+" and  concat(so.bso_type_no,IFNULL(armas.CUSNAM,''),IFNULL(so.BSO_INSTALLATION_SITE_LOCATION ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR1 ,''),' ',  "+
				"        IFNULL(so.BSO_INSTALLATION_ADDR2 ,''),' ',IFNULL(so.BSO_INSTALLATION_ADDR3 ,'') , ' ',  "+
				" IFNULL(so.BSO_INSTALLATION_PROVINCE ,'') ,IFNULL(so.BSO_INSTALLATION_CONTACT ,'') )   like '%"+keyword_search+"%' ";
	query=query+" group by bpmj_no order by pmma.BPMJ_DUEDATE asc  ";
		  
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
			       // "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			        "  		<th width=\"12%\"><div class=\"th_class\">Sale Order No</div></th> "+
			        "  		<th width=\"20%\"><div class=\"th_class\">ชื่อลูกค้า</div></th> "+  
			        "  		<th width=\"30%\"><div class=\"th_class\">สถานที่ PM/MA</div></th> "+ 
			        "  		<th width=\"15%\"><div class=\"th_class\">ชื่อผู้ติดต่อ</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+  
			        "  		<th width=\"5%\"><div class=\"th_class\">PM (ครั้ง)</div></th> "+
			       "  		<th width=\"8%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			        
			        
			        
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){ 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   //"  		<td style=\"text-align: left;\">"+(limitRow+i+1)+" </td>"+     
					  //  "  		<td style=\"text-align: left;\"> <span style=\"text-decoration: underline;\" onclick=\"loadDynamicPage('dispatcher/page/pm_ma_management?bpmmaId="+data[i][0]+"&mode=edit')\">"+data[i][1]+"</span> </td>"+
					    "  		<td style=\"text-align: left;\"> <span style=\"text-decoration: underline;\" onclick=\"editDetail('"+data[i][0]+"')\">"+data[i][1]+"</span> </td>"+
				        "    	<td style=\"text-align: left;\">"+data[i][3]+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+data[i][4]+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+data[i][5]+"</td>  "+
				         "    	<td style=\"text-align: left;\">"+data[i][6]+"</td>  "+
				         "    	<td style=\"text-align: center;\">"+data[i][7]+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+  
				        "<a class=\"btn\"  onclick=\"showTeam("+data[i][0]+")\"><span style=\"font-weight:bold;\">Planing</span></a> "+
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
			$("#search_section_pmma").html(str);
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
function showTeam(jobNo){
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
					  /*  role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   } */
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][0]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+"</td>  "+  
				        "  		<td style=\"text-align: left;\"> "+data[i][6]+" </td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeam('"+jobNo+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Planing</span></a></div>";
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
function doAssignTeam(jobNo){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	/*
	var pmma_id_array=[];
	var pmma_id_list=document.getElementsByName("pmma_id"); 
	for(var j=0;j<pmma_id_list.length;j++){
		if(pmma_id_list[j].checked){
			pmma_id_array.push(pmma_id_list[j].value);
			break;	
		}
	} 
	*/
	bootbox.hideAll();
	 
	//return false;
	//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
	//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
	var btdl_type='3';var btdl_state='wait_for_operation';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูก Planing เรียบร้อยแล้ว';var message_todolist='PM/MA wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];  
	/*
	if(pmma_id_array>0){
		for(var i=0;i<pmma_id_array.length;i++){
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('"+pmma_id_array[i]+"','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	null,'"+hide_status+"','username}','"+pmma_id_array[i]+"',(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00'))) ) ";
			 querys.push(query); 
		}
	}
	  
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='bsoId}' and "+
		"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='state}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
		 querys.push(query2); 
	  */
		 query2="update "+SCHEMA_G+".BPM_PM_MA_JOB set BPMJ_CENTER='"+owner+"',BPMJ_JOB_STATUS=1 where BPMJ_NO='"+jobNo+"' and BPMJ_JOB_STATUS=0 "; 
		  querys.push(query2); 
	  
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
	    					<%--
	    					<tr>  
	    					<td align="left" width="70%">   
	    					 <span><strong>Start Date :</strong></span>
	    					 <span style="padding-left:5px">
	    					 	 	<input   readonly="readonly" style="cursor:pointer;width:90px; height: 30px;" id="PMMA_START_DATE" type="text">
	    					 	 	<i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
							  </span>
							  <span style="padding-left:20px"><strong>End Date :</strong></span>
	    					  <span style="padding-left:5px"> 
	    					  		<input   readonly="readonly" style="cursor:pointer;width:90px; height: 30px;" id="PMMA_END_DATE" type="text">
	    					  		<i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
							   </span>
							   <span style="padding-left:20px"><strong>ศูนย์ :</strong></span>
	    					  <span style="padding-left:5px"> 
	    					 	 <select name="service_type" id="service_type" onchange="getTodolist('1')" class="span2">
	    					  		<option value="0">All</option>
							        <option value="1">นครราชสีมา</option>
							        <option value="2">สุราษฎร์ธานี</option>
							        <option value="3">เชียงใหม่</option>
							        <option value="4">นครสวรรค์</option>
							        <option value="4">อุบลราชธานี</option>
							        <option value="4">ภูเก็ต</option>
							         <option value="4">พิษณุโลก</option>
							          <option value="4">ขอนแก่น</option>
							           <option value="4">ระยอง</option>
							            <option value="4">สงขลา</option>
							      </select> 
							   </span>
	    					</td><td align="right" width="30%"></td>
	    					</tr> 
	    					--%>
	    					<tr>
	    					<td align="left" width="70%">  
	    					<span style="padding-left: 20px;font-size: 13px;">ระบุ key word</span> 
									<span style="padding: 5px;">
										<input id="keyword_search" type="text" style="height: 30; width: 150px" />
									</span> 
	    					 <%--
	    					<a class="btn btn-primary"  onclick=""><i class="icon-ok icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Assign Job</span></a>
	    					  --%>
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
	    					<div  id="search_section_pmma"> 
    						</div> 
      </div>
      </fieldset> 