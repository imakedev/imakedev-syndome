<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<style>
hr{
border-top:1px solid #B3D2EE;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
 	var prpId='${prpId}';
 	var checkTime='${checkTime}';
 /* 	alert("prpId->"+prpId)
 	alert("checkTime->"+checkTime); */
 	
 	if($("#mode").val()=='add'){
 		$("#pmaintenanceCheckTime" ).datepicker({
 			showOn: "button",
 			buttonImage: _path+"resources/images/calendar.gif",
 			buttonImageOnly: true,
 			dateFormat:"dd/mm/yy" ,
 			changeMonth: true,
 			changeYear: true
 		});
 	}
 	 
 	getMaintenance(prpId,checkTime);
});
function goBackMaintenance(){
	// /history/{prpId}
	var url="maintenance/page/maintenance_roadpump_search";
	if('${checkTime}'!='')
	  url= "maintenance/history/${prpId}";
	  $.ajax({
		  type: "get",
		  url:url,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
} 
function doActionMaintenance(){
	var pstMaintenanceArray=[];
	$('textarea[id^="detail_"]').each(function(){
		//alert($(this).attr("id"))
		var ids=$(this).attr("id").split("_");
		//   var id=data[i][0]+"_"+data[i][1];   mapping.pd_id,mapping.pwt_id
		
		//var detail= CKEDITOR.instances["#detail_"+ids[1]+"_"+ids[2]].getData();
		var detail= $("#detail_"+ids[1]+"_"+ids[2]).val();
		//alert(detail)
		var radioElement=document.getElementsByName("radio_"+ids[1]+"_"+ids[2]);
		var status="";
		for(var i=0;i<radioElement.length;i++){
			if(radioElement[i].checked)
				status=radioElement[i].value;
		}
		var pstMaintenance={
				prpId:$("#prpId").val(),
				pdId:ids[1],
				pwtId:ids[2],
				pmaintenanceStatus:status,
				pmaintenanceDetail:detail
		};
		pstMaintenanceArray.push(pstMaintenance);
		  
		//  alert("status->"+status)
	 });
	var pstMaintenanceTran={
			prpId:$("#prpId").val(),
			pmaintenanceDocNo:$("#pmaintenanceDocNo").val(),
			pmaintenanceMile:$("#pmaintenanceMile").val(),
			pmaintenanceHoursOfWork:$("#pmaintenanceHoursOfWork").val(),
			pmaintenanceCheckTimeStr:$("#pmaintenanceCheckTime").val(),
			pmaintenanceCheckTimeOldStr:$("#checkTime").val()
		};
	//alert(pstMaintenanceTran.prpId);
	/* var obj={
			mode:$("#mode").va(),
			pstMaintenanceTran:pstMaintenanceTran,  
			pstMaintenanceArray:pstMaintenanceArray
	   };  */
	  // return false;
	//alert($("#mode").val())
	var mode=$("#mode").val();
	PSTAjax.executeMaintenance(pstMaintenanceArray,pstMaintenanceTran,mode,{
		callback:function(data){
			//alert(data);
			var str="ไม่สามารถ บันทึกข้อมูลได้";
			if(data>0)
				str="บันทึกข้อมูลเรียบร้อยแล้ว";
				$("#dialog-maintenance-element").html(str);
			$( "#dialog-maintenance" ).dialog({
				//height: height_dialog, 
				height: "auto",
				//width:810,
				modal: true,
				buttons: {
					"Ok": function() { 
						$( this ).dialog( "close" );
						 
					}
				},
				beforeClose: function( event, ui ) { 
					$(this).remove();
					goBackMaintenance();
					//$("#dialog-setRoleReportTemplate").remove();
				}
			});
		}
	});
	 
	// $("#pjRemark").val(CKEDITOR.instances["pjRemark"].getData());
	
	/* var target="department"; 
 	$.post(target+"/action/department",$("#departmentForm").serialize(), function(data) {
		  // alert(data);
		  appendContent(data);
		   //appendContentWithId(data,"tabs-3");
		  // alert($("#_content").html());
		}); */
  }
function getMaintenance(prpId,checkTime){
	
	/*
	SELECT mapping.pd_id,mapping.pwt_id,dept.pd_name,work_type.pwt_name FROM PST_DB.PST_CHECKING_MAPPING mapping 
left join PST_DB.PST_WORK_TYPE  work_type on mapping.pwt_id=work_type.pwt_id
left join PST_DB.PST_DEPARTMENT dept on mapping.pd_id = dept.pd_id 
left join  PST_DB.PST_ROAD_PUMP pump on
 (mapping.pcm_type='1' and mapping.pcm_ref_type_no=pump.pm_road_model )
where pump.prp_id=1  
union 
SELECT mapping.pd_id,mapping.pwt_id,dept.pd_name,work_type.pwt_name  FROM PST_DB.PST_CHECKING_MAPPING mapping 
left join PST_DB.PST_WORK_TYPE  work_type on mapping.pwt_id=work_type.pwt_id
left join PST_DB.PST_DEPARTMENT dept on mapping.pd_id = dept.pd_id 
left join  PST_DB.PST_ROAD_PUMP pump on
 (mapping.pcm_type='2' and mapping.pcm_ref_type_no=pump.pm_pump_model )
where pump.prp_id=1  
order by pd_id ,pwt_id 

SELECT tran.pmaintenance_doc_no,tran.pmaintenance_mile,
tran.pmaintenance_hours_of_work,
tran.pmaintenance_check_time 
 FROM PST_DB.PST_MAINTENANCE_TRAN tran 
where tran.prp_id=1 and tran.pmaintenance_check_time='2013-06-08 01:42:28'
	*/
	var check_time_inner='null';
//	var check_time="";
	if(checkTime.length>0){
		var check_time_array=checkTime.split("_");
		check_time_inner="'"+check_time_array[0]+"-"+check_time_array[1]+"-"+check_time_array[2]+" "+check_time_array[3]+":"+check_time_array[4]+":"+check_time_array[5]+"'";
	//	check_time=" and tran.pmaintenance_check_time='"+check_time_array[0]+"-"+check_time_array[1]+"-"+check_time_array[2]+" "+check_time_array[3]+":"+check_time_array[4]+":"+check_time_array[5]+"'";
	}
	var query=" SELECT mapping.pd_id,mapping.pwt_id,IFNULL(dept.pd_name,''),IFNULL(work_type.pwt_name,'') "+
	" ,IFNULL(main_tenance.pmaintenance_status,'2'),IFNULL(main_tenance.pmaintenance_detail,'') FROM "+SCHEMA_G+".PST_CHECKING_MAPPING mapping "+ 
	" left join "+SCHEMA_G+".PST_WORK_TYPE  work_type on mapping.pwt_id=work_type.pwt_id "+
	" left join "+SCHEMA_G+".PST_DEPARTMENT dept on mapping.pd_id = dept.pd_id  "+
	" left join  "+SCHEMA_G+".PST_ROAD_PUMP pump on "+
	"  (mapping.pcm_type='1' and mapping.pcm_ref_type_no=pump.pm_road_model ) "+
	" left join    PST_DB.PST_MAINTENANCE main_tenance  on  "+
	" ( main_tenance.prp_id=pump.prp_id and main_tenance.pmaintenance_check_time="+check_time_inner+"  "+ 
	"  and mapping.pd_id=main_tenance.pd_id and mapping.pwt_id=main_tenance.pwt_id )  "+
	" where pump.prp_id="+prpId+
	" union  "+
	" SELECT mapping.pd_id,mapping.pwt_id,IFNULL(dept.pd_name,''),IFNULL(work_type.pwt_name,'') "+
	" ,IFNULL(main_tenance.pmaintenance_status,'2'),IFNULL(main_tenance.pmaintenance_detail,'') FROM "+SCHEMA_G+".PST_CHECKING_MAPPING mapping "+ 
	" left join "+SCHEMA_G+".PST_WORK_TYPE  work_type on mapping.pwt_id=work_type.pwt_id "+
	" left join "+SCHEMA_G+".PST_DEPARTMENT dept on mapping.pd_id = dept.pd_id  "+
	" left join  "+SCHEMA_G+".PST_ROAD_PUMP pump on "+
	"  (mapping.pcm_type='2' and mapping.pcm_ref_type_no=pump.pm_pump_model ) "+
	" left join    PST_DB.PST_MAINTENANCE main_tenance  on  "+
	" ( main_tenance.prp_id=pump.prp_id and main_tenance.pmaintenance_check_time="+check_time_inner+"  "+ 
	"  and mapping.pd_id=main_tenance.pd_id and mapping.pwt_id=main_tenance.pwt_id )  "+
	" where pump.prp_id="+prpId+
	" order by pd_id ,pwt_id  ";
	//alert(limitRow);
	//alert(query)
	var queryObject=query;   
	var queryTran=" SELECT tran.pmaintenance_doc_no,tran.pmaintenance_mile,"+
	        " tran.pmaintenance_hours_of_work, IFNULL(DATE_FORMAT(tran.pmaintenance_check_time,'%d/%m/%Y'),'') "+
	        " FROM PST_DB.PST_MAINTENANCE_TRAN tran "+
	        " where tran.prp_id="+prpId+" and tran.pmaintenance_check_time="+check_time_inner;
	PSTAjax.searchObject(queryObject,{
		callback:function(data){
			//alert(data)
			var ids=[];
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        " 			<th width=\"8%\"><div class=\"th_class\">ลำดับ</div></th>"+
			        "   		<th width=\"20%\"><div class=\"th_class\">แผนก</div></th>"+
			        "   		<th width=\"20%\"><div class=\"th_class\">รายการ</div></th>"+
			        "   		<th width=\"20%\"><div class=\"th_class\">บันทึก Maintenance</div></th>"+ 
			        "   		<th width=\"38%\"><div class=\"th_class\">บันทึกเพิ่มเติม</div></th>"+  
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			      
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   var id=data[i][0]+"_"+data[i][1];
					   ids.push(id);
					   var radioStr="<input type=\"radio\" value=\"1\"  name=\"radio_"+id+"\"/>ดำเนินการ<br/>"+
				        "<input type=\"radio\"  checked=\"checked\" value=\"2\" name=\"radio_"+id+"\"/>ไม่ได้ดำเนินการ";
				        if(data[i][4]=='1')
				        	radioStr="<input type=\"radio\"  checked=\"checked\" value=\"1\"   name=\"radio_"+id+"\"/>ดำเนินการ<br/>"+
					        "<input type=\"radio\"  value=\"2\"  name=\"radio_"+id+"\"/>ไม่ได้ดำเนินการ";
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				        "  		<td style=\"text-align: left;\">"+(i+1)+"</td>"+    //หมายเลข
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][2]+"</td>  "+   //รุ่นรถ
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][3]+"</td>  "+    //รุ่นปั๊ม
				        "    	<td style=\"text-align: left;\"> "+
				        radioStr+
				        "</td>  "+   //ทะเบียนรถ
				        "    	<td style=\"text-align: left;\"><textarea id=\"detail_"+id+"\">"+data[i][5]+"</textarea></td>  "+   //เลขไมค์ 
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
					  
			$("#maintenance_section").html(str);
			/* for(var i=0;i<ids.length;i++){
				if (CKEDITOR.instances['detail_'+ids[i]]) {
		            CKEDITOR.remove(CKEDITOR.instances['detail_'+ids[i]]);
		         } 
				CKEDITOR.replace( 'detail_'+ids[i],
					    { 
					        toolbar : [],
					        height:"70"
					});
			} */
			<%-- <script>
			if (CKEDITOR.instances['pjRemark']) {
	            CKEDITOR.remove(CKEDITOR.instances['pjRemark']);
	         } 
			CKEDITOR.replace( 'pjRemark',
				    { 
				        //toolbar : 'Basic',
				        toolbar : [
				                      	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ] },
				                      	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent' ] },
				                      	{ name: 'links', items: [ 'Link', 'Unlink' ] }
				                      ],
				        height:"100"
				    });
			//CKEDITOR.instances['pjRemark'].resize( '100%', '50' );
			</script> --%>
		}
	}); 
	 PSTAjax.searchObject(queryTran,{
		callback:function(data){
			
			 if(data!=null && data.length>0){
				 $("#pmaintenanceDocNo").val(data[0][0]);
				 $("#pmaintenanceMile").val(data[0][1]);
				 $("#pmaintenanceHoursOfWork").val(data[0][2]);
				 $("#pmaintenanceCheckTime").val(data[0][3]);
			 }
		}
	}); 
}

</script>
<div id="dialog-maintenance" title="บันทึกข้อมูล" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
  <div id="dialog-maintenance-element">
  </div>
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	   <form id="candidateForm" name="candidateForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="/MISSExamBackOffice/candidate/search?_=1353519467506" method="post">
               
            <input id="mode" name="mode" type="hidden" value="${mode}"> 
             <input id="prpId" name="prpId" type="hidden" value="${prpId}"> 
              <input id="checkTime" name="checkTime" type="hidden" value="${checkTime}"> 
            <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
	   
			  <fieldset style="font-family: sans-serif;">   
			  <div align="left">
           	 <strong>ตรวจสภาพรถเบอร์ ${pstRoadPump.prpNo}</strong>
           	 
            	</div>
    			</fieldset> 
			  </form>  
			  <div  id="maintenance_section">
	    	  </div>
	    	  <hr/>
			<table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="3"><strong style="font-size: 14px;text-decoration: underline;">บันทึกค่าใหม่</strong></td>
    				</tr> 		
    				<tr valign="middle">
    					<td width="100%">
    					    <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
			         			<thead>
			        				<tr>  
			       						<th width="25%"><div class="th_class">เลขที่เอกสาร</div></th>
			        					<th width="25%"><div class="th_class">เลขไมค์</div></th>
			        					<th width="25%"><div class="th_class">ชม.การทำงาน</div></th>
			        					<th width="25%"><div class="th_class">วันที่ดำเนินการ</div></th>  
			         				</tr>
			      				</thead>
			        		<tbody>
			        		<tr style="cursor: pointer;">
				        		<td style="text-align: left;">
				        		<c:if test="${mode!='add'}">
				        			<input type="text" id="pmaintenanceDocNo" readonly="readonly"  style="height: 30;"/>
				        		</c:if>
				        		  <c:if test="${mode=='add'}">
				        			<input type="text" id="pmaintenanceDocNo"  style="height: 30;"/>
				        		</c:if> 
				        		</td>
				        		<td style="text-align: left;"><input type="text" id="pmaintenanceMile" style="height: 30;text-align: right;"/></td>     
				        		<td style="text-align: left;"><input type="text" id="pmaintenanceHoursOfWork" style="height: 30;text-align: right;"/></td>      
				        		<td style="text-align: left;"><input type="text" id="pmaintenanceCheckTime" style="height: 30;width:85px" readonly="true"/></td>     
				        	</tr>
				        	</tbody>
				        	</table>
    					</td>
    				</tr>
			</table>
			<div align="center">
			 <a class="btn btn-info"  onclick="goBackMaintenance()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a> 	
    		 <a class="btn btn-primary"  onclick="doActionMaintenance()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>