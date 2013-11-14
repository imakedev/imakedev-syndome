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
	 searchMaintenance('init',1);
	 getPstModel('1');
	 getPstModel('2');
	 getPstStatus();
});
function renderPageSelect(pageCount){
	 
	var pageStr="<select name=\"breakdownPageSelect\" id=\"breakdownPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	//var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("breakdownPageSelect").value=$("#pageNo").val();
}
function getPstModel(id){ 
	var query="SELECT pm_id,pm_name  FROM "+SCHEMA_G+".PST_MODEL where pm_type="+id+" order by pm_name "; 
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <select name=\"modelSelect_"+id+"\" id=\"modelSelect_"+id+"\" style=\"width: 120px\"> "+
			        "";  
			str=str+ " <option value=\"-1\">---</option>";
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ " <option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
				   }
			   }
			        str=str+  " </select>";
			$("#model_section_"+id).html(str); 
		}
	}); 
}
function getPstStatus(){  
	var query="SELECT PRPS_ID,PRPS_NAME  FROM "+SCHEMA_G+".PST_ROAD_PUMP_STATUS  ";// order by pm_name 
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data)
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <select name=\"pstStatusSelect\" id=\"pstStatusSelect\" style=\"width: 120px\"> "+
			        "";  
			str=str+ " <option value=\"-1\">---</option>";
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ " <option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
				   }
			   }
			        str=str+  " </select>";
			$("#status_section").html(str);
		}
	}); 
}
function goPrev(){
	//alert($("#pageNo").val());
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchMaintenance('search',prev);
		//doAction('search','0');
	}
}
function goNext(){
	//alert("next->"+next);
	var next=parseInt($("#pageNo").val());
	//alert("next->"+next+",$(\"pageNo\").val()->"+$("#pageNo").val());
	//alert("$(\"pageCount\").val()->"+$("#pageCount").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchMaintenance('search',next); 
		//doAction('search','0');
	}
} 
function goToPage(){ 
	//alert($("#pageNo").val());
	$("#pageNo").val(document.getElementById("breakdownPageSelect").value); 
	searchMaintenance('search',$("#pageNo").val()); 
	//doAction('search','0');
}
function goToHistory(prpId){
	 $.ajax({
		  type: "get",
		  url: "maintenance/history/"+prpId,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		}); 
}
function goToNewMaintenance(prpId){
	 $.ajax({
		  type: "get",
		  url: "maintenance/new/"+prpId,
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		}); 
}
 
function searchMaintenance(mode,_page){
	 $("#pageNo").val(_page);
	var sqlWhere="";
	if(mode!='init'){
	var prpNo =jQuery.trim($("#prpNo").val());
	var prpRegister =jQuery.trim($("#prpRegister").val());
	var model_section_1=$("#modelSelect_1").val();
	var model_section_2=$("#modelSelect_2").val();
	var status_section=$("#pstStatusSelect").val();

	var haveWhere=false;
	//alert("model_section_1->"+model_section_1)
	if(prpNo.length>0){
		sqlWhere=sqlWhere+((haveWhere)?" and ":" where ")+" lower(pump.prp_no) like lower('%"+prpNo+"%')" ;
		haveWhere=true;
	}
	if(prpRegister.length>0){
		sqlWhere=sqlWhere+((haveWhere)?" and ":" where ")+" lower(pump.prp_register) like lower('%"+prpRegister+"%')" ;
		haveWhere=true;
	} 
	if(model_section_1!='-1'){
		sqlWhere=sqlWhere+((haveWhere)?" and ":" where ")+" pump.PM_ROAD_MODEL ="+model_section_1+"" ;
		haveWhere=true;
	}
	if(model_section_2!='-1'){
		sqlWhere=sqlWhere+((haveWhere)?" and ":" where ")+" pump.PM_PUMP_MODEL="+model_section_2+"" ;
		haveWhere=true;
	}
	if(status_section!='-1'){
		sqlWhere=sqlWhere+((haveWhere)?" and ":" where ")+" pump.PRPS_ID="+status_section+"" ;
		haveWhere=true;
	}
 }
	var query="SELECT IFNULL(pump.prp_no,''),"+
	//	-- brand_road.pb_name as brand_road,
	//	-- brand_pump.pb_name as brand_pump,
	  	"IFNULL(model_road.pm_name,'') as model_road, "+
		" IFNULL(model_pump.pm_name,'')  as model_pump, "+
		" IFNULL(pump.prp_register,''), "+
		" IFNULL(pump.PRP_CUBIC_AMOUNT,0), "+
		" IFNULL(pump.PRP_MILE,0), "+
		" IFNULL(pump.PRP_HOURS_OF_WORK,0), "+
		" IFNULL(pump.PRP_DAYS_OF_WORK,0), "+
		//" pump.PRP_CHECK_MAINTENANCE, "+
		//" DATE_FORMAT(pump.PRP_CHECK_MAINTENANCE,'%d/%m/%Y %H:%i:%s'), "+
		" IFNULL(DATE_FORMAT(pump.PRP_CHECK_MAINTENANCE,'%d/%m/%Y'),''), "+
		" IFNULL(pump_status.prps_name,'') as status_name, "+
		" IFNULL(pump_type.prpt_name,'') as pump_type, "+
		" ( SELECT  count(*)  FROM "+SCHEMA_G+".PST_CHECKING_MAPPING  mapping "+  
		" where mapping.PCM_TYPE='1' and mapping.PCM_REF_TYPE_NO=model_road.pm_id ) as count_1, "+
		" ( SELECT  count(*)  FROM "+SCHEMA_G+".PST_CHECKING_MAPPING  mapping   "+
		" where mapping.PCM_TYPE='2' and mapping.PCM_REF_TYPE_NO=model_pump.pm_id ) as count_2 ,"+
		" pump.PRP_ID "+
		//" pump.* 
		" FROM "+SCHEMA_G+".PST_ROAD_PUMP pump left join  "+
		" "+SCHEMA_G+".PST_BRAND brand_road on pump.pb_road_brand=brand_road.pb_id "+ 
		" left join  "+
		" "+SCHEMA_G+".PST_BRAND brand_pump on pump.pm_pump_brand=brand_pump.pb_id "+ 
		" left join  "+
		" "+SCHEMA_G+".PST_MODEL model_road on pump.pm_road_model=model_road.pm_id "+ 
		" left join  "+
		" "+SCHEMA_G+".PST_MODEL model_pump on pump.pm_pump_model=model_pump.pm_id "+ 
		" left join  "+
		" "+SCHEMA_G+".PST_ROAD_PUMP_STATUS pump_status on pump.prps_id=pump_status.prps_id "+ 
		" left join  "+
		" "+SCHEMA_G+".PST_ROAD_PUMP_TYPE pump_type on pump.prpt_id=pump_type.prpt_id "+sqlWhere;
	
	var limitRow=(_page>1)?((_page-1)*_perpageG):0;
	//alert(limitRow);
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
	var queryCount=" select count(*) from (  "+query+" ) as x";
	//alert(queryObject)
	PSTAjax.searchObject(queryObject,{
		callback:function(data){
		//	alert(data)
			
			//var str="<div align=\"left\" style=\"padding-bottom: 4px;width:1070px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        " 			<th width=\"8%\"><div class=\"th_class\">หมายเลข</div></th>"+
			        "   		<th width=\"10%\"><div class=\"th_class\">รุ่นรถ</div></th>"+
			        "   		<th width=\"10%\"><div class=\"th_class\">รุ่นปั๊ม</div></th>"+
			        "   		<th width=\"10%\"><div class=\"th_class\">ทะเบียนรถ</div></th>"+ 
			        "   		<th width=\"10%\"><div class=\"th_class\">เลขไมค์</div></th>"+ 
			        "   		<th width=\"10%\"><div class=\"th_class\">ชม.การทำงาน</div></th>"+ 
			        "   		<th width=\"15%\"><div class=\"th_class\">วันตรวจรับล่าสุด</div></th>"+ 
			        "   		<th width=\"10%\"><div class=\"th_class\">รายการตรวจรับตามรุ่นรถ/รุ่นปั๊ม</div></th>"+ 
			        "   		<th width=\"10%\"><div class=\"th_class\">สถนนะปัจจุบัน</div></th>"+ 
			        "    		<th width=\"7%\"><div class=\"th_class\">ตรวจสภาพ</div></th>     "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			      
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				        "  		<td style=\"text-align: left;text-decoration: underline;\"><span onClick=\"goToHistory('"+data[i][13]+"')\">"+data[i][0]+"</span></td>"+    //หมายเลข
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][1]+"</td>  "+   //รุ่นรถ
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][2]+"</td>  "+    //รุ่นปั๊ม
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][3]+"</td>  "+   //ทะเบียนรถ
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][5]+"</td>  "+   //เลขไมค์
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][6]+"</td>  "+   //ชม.การทำงา
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][8]+"</td>  "+   //วันตรวจรับล่าสุด
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][11]+"/"+data[i][12]+"</td>  "+   //รายการตรวจรับตามรุ่นรถ
				        "    	<td style=\"text-align: left;\">&nbsp;"+data[i][9]+"</td>  "+   //สถนนะปัจจุบัน
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Check\" onclick=\"goToNewMaintenance('"+data[i][13]+"')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				       // "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  ";
				   }
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			      str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"10\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
	      		"</tr>"+
	    	"</thead>"+
	    	"<tbody>"; 
			   }
			        str=str+  " </tbody>"+
					   "</table> "; 
			$("#maintenance_section").html(str);
		}
	}); 
	PSTAjax.searchObject(queryCount,{
		callback:function(data){
			//alert(data)
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect(pageCount);
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
             
            <form id="candidateForm" name="candidateForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" action="/MISSExamBackOffice/candidate/search?_=1353519467506" method="post">
               
            <input id="mode" name="mode" type="hidden" value="">
            <input id="mcaId" name="missCandidate.mcaId" type="hidden" value="">
            <input id="mcaIdArray" name="mcaIdArray" type="hidden" value="">
            <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <div align="left">
            <strong>ตรวจสภาพรถ</strong>
            </div> 
              <!-- <div align="left" style="padding: 10px 60px"> -->
               <div align="left" style="padding-left: 15px;padding-top: 10px">
                <table width="100%" border="0">
                	<tr valign="top">
                		<td width="25%">
                		 <table width="100%">
                			<tr>
                				<td>
                		<span style="font-size: 13px;">หมายเลขรถ</span> 
            	<!-- <span style="padding: 20px"> -->
            	 <span>  
            	<input id="prpNo" type="text" style="height: 30;width: 100px"/> 
            	</span> 
                				</td> 
                			</tr>
                			<tr>
                				<td>
                		<span style="font-size: 13px;">ทะเบียนรถ</span> 
            	<span style="padding: 7px"><input id="prpRegister" type="text" style="height: 30;width: 100px"/> </span>  
                				</td> 
                			</tr>
                			
                			</table>
                		</td>
                		<td width="75%">
                		 <table width="100%">
                			<tr>
                				<td>
                		<span style="font-size: 13px;">รุ่นรถ</span> 
            	<span style="padding: 5px" id="model_section_1"> 
            	</span> 
                				</td> 
                				<td>
                		<span style="font-size: 13px;">รุ่นปั๊ม</span> 
            	<span style="padding: 5px" id="model_section_2"> </span> 
                				</td>
                				<td>
                		<span style="font-size: 13px;">สถานะ</span> 
            	<span style="padding: 5px" id="status_section">  
            	</span> 
                				</td>
                			</tr>
                			<tr>
                			 <td colspan="3" align="left">
                			 <a class="btn btn-primary" onclick="searchMaintenance('search',1)"><i class="icon-search icon-white"></i>&nbsp;Search</a>
                			 </td>
                			</tr>
                			</table>
                		</td>
                	</tr>
                </table> 
	    			  
            </div>  
	   </form>  
	   <table border="0" width="100%" style="font-size: 13px">
	    					<tbody><tr>
	    					<td align="left" width="50%">
	    					
	    					<!-- <a class="btn btn-primary"  ><i class="icon-plus-sign icon-white"></i>&nbsp;Create</a>&nbsp; -->
	    					<!-- <a class="btn btn-danger" onclick="doDeleteItems()"><i class="icon-trash icon-white"></i>&nbsp;Delete</a> -->
	    					</td>
	    					<td align="right" width="50%">  
	    					<a onclick="goPrev()">Prev</a>&nbsp;|&nbsp;
	    					<span id="pageElement">
	    					<select name="breakdownPageSelect" id="breakdownPageSelect" onchange="goToPage()" style="width: 50px"><option value="1">1</option></select>
	    					</span>&nbsp;|&nbsp;<a onclick="goNext()">Next</a>&nbsp;
	    					<!-- <a class="btn btn-primary" onclick="searchMaintenance('search',1)"><i class="icon-search icon-white"></i>&nbsp;Search</a> -->
	    					</td>
	    					</tr>
	    					</tbody></table>
	    					<div  id="maintenance_section">
	 							 
    						</div>
      </fieldset> 