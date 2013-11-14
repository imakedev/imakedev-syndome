<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	/* renderPageSelect();
	if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 } */
	/*  $("#pdName").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchPstDepartMent();
		   } 
		}); */ 
	 searchMaintenanceHistory();
	// getPstModel('1');
	// getPstModel('2');
	// getPstStatus();
});
function goBackMaintenance(){
	 
	  $.ajax({
		  type: "get",
		  url: "maintenance/page/maintenance_roadpump_search",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
} 
function goToUpdateMaintenance(prpId,checkTime){
	 $.ajax({
		  type: "get",
		  url: "maintenance/item/"+prpId+"/"+checkTime,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		}); 
} 
function confirmDelete(prp_id,pmaintenance_doc_no,pmaintenance_check_time){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doDelete(prp_id,pmaintenance_doc_no,pmaintenance_check_time);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
}
function doDelete(prp_id,pmaintenance_doc_no,pmaintenance_check_time){
	 var querys=[]; 
	 var query="DELETE FROM "+SCHEMA_G+".PST_MAINTENANCE_TRAN where PRP_ID='"+prp_id+"' "+
	 " and PMAINTENANCE_CHECK_TIME='"+pmaintenance_check_time+"' and PMAINTENANCE_DOC_NO='"+pmaintenance_doc_no+"'";

	 querys.push(query);
	 PSTAjax.executeQuery(querys,{
			callback:function(data){ 
				if(data!=0){
					searchMaintenanceHistory();
				}
			}
		});
}
function searchMaintenanceHistory(){
	//" DATE_FORMAT(pump.PRP_CHECK_MAINTENANCE,'%d/%m/%Y %H:%i:%s'), "+
	//" IFNULL(DATE_FORMAT(pump.PRP_CHECK_MAINTENANCE,'%d/%m/%Y'),''), "+
	var query=" select "+ 
	 " tran.prp_id, "+
	// " tran.pmaintenance_check_time, "+
	" IFNULL(DATE_FORMAT(tran.pmaintenance_check_time,'%d/%m/%Y'),''), "+
	 " IFNULL(tran.pmaintenance_doc_no,''), "+
	 " IFNULL(pump.prp_no,'')  , "+
	 " IFNULL(DATE_FORMAT(tran.pmaintenance_check_time,'%Y_%m_%d_%H_%i_%s'),'') ,  "+
	 " IFNULL(DATE_FORMAT(tran.pmaintenance_check_time,'%H:%i:%s'),'') ,  "+
	 " IFNULL(DATE_FORMAT(tran.pmaintenance_check_time,'%Y-%m-%d %H:%i:%s'),'') "+
	 " from "+SCHEMA_G+".PST_MAINTENANCE_TRAN tran "+
	 " left join "+SCHEMA_G+".PST_ROAD_PUMP pump on tran.prp_id=pump.prp_id "+
	 " where tran.prp_id =${pstRoadPump.prpId} order by tran.pmaintenance_check_time desc "; 
	 //alert(query)
	  
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			var haveData=false;
			
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        " 			<th width=\"20%\"><div class=\"th_class\">เลขที่เอกสาร</div></th>"+
			        "   		<th width=\"70%\"><div class=\"th_class\">วันที่ดำเนินการ</div></th>"+
			        "   		<th width=\"10%\"><div class=\"th_class\">รายละเอียด</div></th>"+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			      
			   if(data!=null && data.length>0){
				   haveData=true;
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				        "  		<td style=\"text-align: left;\">&nbsp;"+data[i][2]+" </td>"+    //เลขที่เอกสาร
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][1]+"&nbsp;&nbsp;&nbsp;"+data[i][5]+"</td>  "+   //วันที่ดำเนินการ 
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Check\" onclick=\"goToUpdateMaintenance('"+data[i][0]+"','"+data[i][4]+"')\"  style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"','"+data[i][2]+"','"+data[i][6]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			      str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"3\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#maintenance_history_section").html(str);
			if(haveData)
				$("#search_table").slideDown("slow"); 
		}
	}); 
}
</script>
<fieldset style="font-family: sans-serif;padding-top:5px">
	         
           <!-- <legend  style="font-size: 13px">Criteria</legend> -->
           <!-- <div style="position:relative;right:-94%;">  </div> --> 
           <!-- 
           
          SELECT 
pump.prp_no,
-- brand_road.pb_name as brand_road,
-- brand_pump.pb_name as brand_pump,
model_road.pm_name as model_road,
model_pump.pm_name  as model_pump,
pump.prp_register,
pump.PRP_CUBIC_AMOUNT,
pump.PRP_MILE,
pump.PRP_HOURS_OF_WORK,
pump.PRP_DAYS_OF_WORK,
pump.PRP_CHECK_MAINTENANCE,
pump_status.prps_name as status_name,
pump_type.prpt_name as pump_type,
( SELECT  count(*)  FROM PST_DB.PST_CHECKING_MAPPING  mapping  
where mapping.PCM_TYPE='1' and mapping.PCM_REF_TYPE_NO=model_road.pm_id ) as count_1,
( SELECT  count(*)  FROM PST_DB.PST_CHECKING_MAPPING  mapping  
where mapping.PCM_TYPE='2' and mapping.PCM_REF_TYPE_NO=model_pump.pm_id ) as count_2,
pump.* FROM PST_DB.PST_ROAD_PUMP pump left join 
PST_DB.PST_BRAND brand_road on pump.pb_road_brand=brand_road.pb_id 
left join 
PST_DB.PST_BRAND brand_pump on pump.pm_pump_brand=brand_pump.pb_id 
left join 
PST_DB.PST_MODEL model_road on pump.pm_road_model=model_road.pm_id 
left join 
PST_DB.PST_MODEL model_pump on pump.pm_pump_model=model_pump.pm_id 
left join 
PST_DB.PST_ROAD_PUMP_STATUS pump_status on pump.prps_id=pump_status.prps_id 
left join 
PST_DB.PST_ROAD_PUMP_TYPE pump_type on pump.prpt_id=pump_type.prpt_id

           
           
           SELECT 
road_model.pm_name as road_name,
pump_model.pm_name as pump_name,
mapping.* FROM PST_DB.PST_CHECKING_MAPPING  mapping 
left join 
PST_DB.PST_MODEL  road_model on (mapping.pcm_ref_type_no=road_model.pm_id and mapping.pcm_type=1)
left join 
PST_DB.PST_MODEL  pump_model on (mapping.pcm_ref_type_no=pump_model.pm_id and mapping.pcm_type=2)


SELECT  count(*)  FROM PST_DB.PST_CHECKING_MAPPING  mapping  
where mapping.PCM_TYPE='1' and mapping.PCM_REF_TYPE_NO=1 



            -->
<div id="dialog-confirmDelete" title="ลบ ประวัติการตรวจสภาพรถ" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>     
            <form id="candidateForm" name="candidateForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="/MISSExamBackOffice/candidate/search?_=1353519467506" method="post">
               
            <input id="mode" name="mode" type="hidden" value="">
            <input id="mcaId" name="missCandidate.mcaId" type="hidden" value="">
            <input id="mcaIdArray" name="mcaIdArray" type="hidden" value="">
            <input id="pageNo" name="paging.pageNo" type="hidden" value="1">
            <input id="pageSize" name="paging.pageSize" type="hidden" value="20"> 
            <input id="pageCount" name="pageCount" type="hidden" value="8"> 
            <div align="left">
            <strong>ประวัติการตรวจสภาพรถเบอร์ ${pstRoadPump.prpNo}</strong>
            </div>  
	   </form>  
	   <table id="search_table" border="0" width="100%" style="font-size: 13px;display: none">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<!-- <a class="btn btn-primary"  ><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp; -->
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="breakdownPageSelect" id="breakdownPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;<a class="btn btn-primary" onclick="searchMaintenance('search')"><i class="icon-search icon-white"></i>&nbsp;Search</a></td>
	    					</tr>
	    					</tbody></table>
	    					<div  id="maintenance_history_section">
	 							 
    						</div>
    						<div align="left">
						<a class="btn btn-info"  onclick="goBackMaintenance()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					
					</div>
      </fieldset> 