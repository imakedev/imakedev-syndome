<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<style>
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
</style> 
<script type="text/javascript">
var intRegex = /^\d+$/;
//var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+))$/;
var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+)|(-\d+(\.\d *)?)|((-\d*\.)?\d+))$/;

$(document).ready(function() {
	$('#tabs_1').tabs();
	$('#tabs_2').tabs();
	$('#tabs_3').tabs();
	$('#tabs_4').tabs();
 	$('#tabs_5').tabs(); 
	/*  $('#tabs_3').tabs();
	$('#tabs_4').tabs(); */ 
	/*  $( "#accordion" ).accordion({
	      collapsible: true
	    });
	    $('.accordion .head').click(function() {
	        $(this).next().toggle();
	        return false;
	    }).next().hide(); */
	$("#pjCreatedTime" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	    if($("#mode").val()=='edit'){ 
	    	  renderPart('4');
	    	  renderPart('3');
	    	  $("#tabs_2").slideUp("slow"); 
	    	//  renderPart('2');
	    	  renderPart('1');
	    	  $("#element_detail").slideDown("slow"); 
	    	  
	    }
	     $("#pjCustomerNo" ).autocomplete({
		  source: function( request, response ) {    
			  //$("#pjCustomerNo").val(ui.item.label);
			   $("#pcId").val(""); 
			   $("#pjCustomerName").val("");	
			   listDivision(false);
				var query="SELECT pc_id,pc_no ,pc_name FROM "+SCHEMA_G+".PST_CUSTOMER where pc_no like '%"+request.term+"%'   ";		
				PSTAjax.searchObject(query,{
					callback:function(data){ 
						if(data!=null && data.length>0){
							response( $.map( data, function( item ) {
					          return {
					        	  label: item[1],
					        	  value: item[0] ,
					        	  name: item[2]
					          }
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
			   $("#pjCustomerNo").val(ui.item.label);
			   $("#pcId").val(ui.item.value); 
			   $("#pjCustomerName").val(ui.item.name);			   
			   listDivision(false);
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		}); 
	     $("#pjCustomerName" ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label);
				   $("#pcId").val(""); 
				   $("#pjCustomerNo").val("");	
				   listDivision(false);
					var query="SELECT pc_id,pc_no ,pc_name FROM "+SCHEMA_G+".PST_CUSTOMER where pc_name like '%"+request.term+"%'   ";		
					PSTAjax.searchObject(query,{
						callback:function(data){ 
							if(data!=null && data.length>0){
								response( $.map( data, function( item ) {
						          return {
						        	  label: item[2],
						        	  value: item[0] ,
						        	  name: item[1]
						          }
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
				 //this.value = ui.item.name;
				   $("#pjCustomerNo").val(ui.item.name);
				   $("#pcId").val(ui.item.value); 
				   $("#pjCustomerName").val(ui.item.label);			   
				   listDivision(false);
			      return false;
			  },
			  open: function() {
			    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			  },
			  close: function() {
			    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			  }
			}); 
	     var mode=$("#mode").val();
	     // alert(mode)
	     if(mode=='edit'){
	    	 listDivision(true);
	    	/*  var pcId=jQuery.trim($("#pcId").val());
	    	 alert(pcId); */ // $('select.foo option:selected').val(); 
	    	 renderJobEmployee($("#pstJob\\.pstRoadPump\\.prpId").val(),$("#pstJob\\.pstRoadPump\\.prpId option:selected").text());
	    	 loadPstCost();
	     }
	    
});
function loadPstCost(){
	//pstJob.pstRoadPump.prpId
	var prp_id=$("#pstJob\\.pstRoadPump\\.prpId").val();
	 
//	var costType=jQuery.trim($("#costType").val());
	//alert(costType)
	var str="<select id=\"pstJobPay_pcId\" >"; 
	//var  query="SELECT pc_id,pc_uid,pc_name  FROM "+SCHEMA_G+".PST_COSTS where pc_type='"+costType+"'";
	var query=" select costs.pc_id,costs.pc_uid,costs.pc_name  from "+SCHEMA_G+".PST_COSTS costs left join  "+SCHEMA_G+".PST_ROAD_PUMP_TYPE p_type "+
	  " on costs.pc_type=p_type.prpt_id "+
	  " where pc_type=(select pump.prpt_id FROM "+SCHEMA_G+".PST_ROAD_PUMP pump "+ 
	  " where pump.prp_id="+prp_id+") ";
	PSTAjax.searchObject(query,{
		callback:function(data){
			//alert(data) 
			//var str="<select id=\"pcdId\" onchange=\"listContact()\" style=\"width:170px\">";
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					str=str+"<option value=\""+data[i][0]+"\">"+data[i][1]+" - "+data[i][2]+"</option>";
				}
			}
			str=str+"</select>";
			$("#pstJobPay_pcId_section").html(str); 
		}
	});
}
function listDivision(isInit){
	var pcId=jQuery.trim($("#pcId").val());
	//alert(pcId);
	var str="<select id=\"pcdIdSelect\" onchange=\"listContact(false)\" style=\"width:170px\">";
	if(pcId.length>0){
		var query="SELECT pcd_id,pcd_name  FROM "+SCHEMA_G+".PST_CUSTOMER_DIVISION where pc_id="+pcId;
		PSTAjax.searchObject(query,{
			callback:function(data){
				//alert(data)
				//var str="<select id=\"pcdId\" onchange=\"listContact()\" style=\"width:170px\">";
				if(data!=null && data.length>0){
					for(var i=0;i<data.length;i++){
						str=str+"<option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
					}
				}
				str=str+"</select>";
				$("#customerDepartmentElement").html(str); 
				if(isInit)
					$("#pcdIdSelect").val($("#pcdId").val());
				listContact(isInit);
			}
		});
	}else{
		str=str+"</select>";
		$("#customerDepartmentElement").html(str); 
		listContact(isInit);
	}
}
function listContact(isInit){
	 
  var pcdId=jQuery.trim($("#pcdIdSelect").val());
	//alert(pcId);
	var str="<select id=\"pccIdSelect\" onchange=\"setMobileNo()\" style=\"width:170px\">";
	if(pcdId.length>0){ 
		var query="SELECT pcc_id,pcc_name,pcc_mobile_no  FROM "+SCHEMA_G+".PST_CUSTOMER_CONTACT where pcd_id="+pcdId;
		PSTAjax.searchObject(query,{
			callback:function(data){
				//alert(data)
				
				if(data!=null && data.length>0){
					for(var i=0;i<data.length;i++){
						str=str+"<option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
					}
				}
				str=str+"</select>";
				$("#contractNameElement").html(str); 
				if(isInit)
					$("#pccIdSelect").val($("#pccId").val());
				setMobileNo();
			}
		});
	}else{
		str=str+"</select>";
		$("#contractNameElement").html(str); 
		setMobileNo();
	} 
}
function setMobileNo(){ 
	  var pccId=jQuery.trim($("#pccIdSelect").val()); 
		if(pccId.length>0){ 
			var query="SELECT pcc_id,pcc_name,pcc_mobile_no  FROM "+SCHEMA_G+".PST_CUSTOMER_CONTACT where pcc_id="+pccId;
			PSTAjax.searchObject(query,{
				callback:function(data){
					if(data.length>0)
						$("#pjContractMobileNo").val(data[0][2]);
   			    }
			});
		}else{
			$("#pjContractMobileNo").val("");
		}
	}
function goBackJob(){
 
	  $.ajax({
		  type: "get",
		  url: "job/init",
		  cache: false
		 // data: { name: "John", location: "Boston" }
		}).done(function( data ) {
			if(data!=null){
				 appendContent(data);
				// $("#tabs-3").html(data);
			  }
		});
}
function doCheckDuplicate(action,mode,id){
	//alert(mode);
	
	if(mode=='new'){
		//check duplicate 
		var jobNo=jQuery.trim($("#pjJobNo").val());
		//alert(jobNo);
		if(jobNo.length>0){
		 var query_duplicate="SELECT count(*)  FROM "+SCHEMA_G+".PST_JOB where PJ_JOB_NO='"+jobNo+"'";
		 
			PSTAjax.searchObject(query_duplicate,{ 
				callback:function(data){
					if(data>0){
						alert(" เลขที่งานซ้ำ กรุณากรอกเลขที่งานใหม่. ");
						$("#pjJobNo").focus();
						$("#pjJobNo_span").addClass("error");
						return false;
					}else{
						$("#pjJobNo_span").removeClass("error");
						doJobAction(action,mode,id);
					}
				}
			});
		}else
			doJobAction(action,mode,id);
		//alert(jQuery.trim($("#pjJobNo").val()));
	}else{
		doJobAction(action,mode,id);
	}
}
function doJobAction(action,mode,id){
	
	 var isBank=checkBank(jQuery.trim($("#pjJobNo").val()));
	 if(isBank){
		 alert('กรุณากรอก เลขที่งาน');  
		 $("#pjJobNo").focus();
		 $("#pjJobNo_span").addClass("error");
		 return false;	 
	 }else{
		 $("#pjJobNo_span").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pjCreatedTime").val()));
	 if(isBank){
		 alert('กรุณากรอก วันที่ ');  
		  $("#pjCreatedTime").focus();
		  $("#pjCreatedTime_span").addClass("error");
		  
		 return false;	 
	 }else{
		 $("#pjCreatedTime_span").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pjCustomerNo").val()));
	 if(isBank){
		 alert('กรุณากรอก รหัสลูกค้า');  
		  $("#pjCustomerNo").focus();
		  $("#pjCustomerNo_span").addClass("error");
		 return false;	 
	 }else{
		 $("#pjCustomerNo_span").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pjCustomerName").val()));
	 if(isBank){
		 alert('ชื่อลูกค้า');  
		  $("#pjCustomerName").focus();
		  $("#pjCustomerName_span").addClass("error");
		 return false;	 
	 }else{
		 $("#pjCustomerName_span").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pcdIdSelect").val()));
	 if(isBank){
		 alert('กรุณากรอก หน่วยงาน');  
		  $("#pcdIdSelect").focus();
		  $("#customerDepartmentElement").addClass("error");
		 return false;	 
	 }else{
		 $("#customerDepartmentElement").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pccIdSelect").val()));
	 if(isBank){
		 alert('กรุณากรอก ชื่อผู้ติดต่อ');  
		  $("#pccIdSelect").focus();
		  $("#contractNameElement").addClass("error");
		 return false;	 
	 }else{
		 $("#contractNameElement").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pjContractMobileNo").val()));
	 if(isBank){
		 alert('กรุณากรอก โทรศัพท์');  
		  $("#pjContractMobileNo").focus();
		  $("#pjContractMobileNo_span").addClass("error"); 
		 return false;	 
	 }else{
		 $("#pjContractMobileNo_span").removeClass("error");
	 }
	 isBank=checkBank(jQuery.trim($("#pjTimeUsed").val()));
	 if(isBank){
		 alert('กรุณากรอก เวลาที่ใช้');  
		  $("#pjTimeUsed").focus();
		  $("#pjTimeUsed_span").addClass("error"); 
		 return false;	 
	 }else{
		 $("#pjTimeUsed_span").removeClass("error");
	 }
	 
	 var isNumber=checkNumber(jQuery.trim($("#pjTimeUsed").val()));
		
	 if(isNumber){  
		 alert('กรุณากรอก  เวลาที่ใช้ เป็นตัวเลข.');  
		 $("#pjTimeUsed").focus();
		 $("#pjTimeUsed_span").addClass("error"); 
		 return false;	  
	 } else{
		 $("#pjTimeUsed_span").removeClass("error");
	 } 
	
	 /* var pjContractMobileNo=jQuery.trim($("#pjContractMobileNo").val());
	 if(pjContractMobileNo.length>0)
		 if(!(intRegex.test(pjContractMobileNo) || floatRegex.test(pjContractMobileNo))) {
	        alert('Please fill Number !!!'); 
	        $("#pjContractMobileNo").focus(); 
	        $("#pjContractMobileNo_span").addClass("error"); 
	       // alert($("#pjContractMobileNo_span").attr("class"));
	        return false;
	     }else{
			 $("#pjContractMobileNo_span").removeClass("error");
		 } */
		 
	 $("#pjContractName").val($("#pccIdSelect option:selected").text());
	 $("#pjCustomerDepartment").val($("#pcdIdSelect option:selected").text()); 
	 
	 $("#pccId").val($("#pccIdSelect").val());
	 $("#pcdId").val($("#pcdIdSelect").val()); 
	$("#pjRemark").val(CKEDITOR.instances["pjRemark"].getData());
	submit_part1(mode);
	/* var target="job"; 
 	$.post(target+"/action/job",$("#jobForm").serialize(), function(data) {
		  // alert(data);
		  appendContent(data);
		   //appendContentWithId(data,"tabs-3");
		  // alert($("#_content").html());
		}); */
  }
 function renderPart1(data2){ 
	 var query_break_down="SELECT pbd_id,pbd_name FROM "+SCHEMA_G+".PST_BREAK_DOWN ";
	 var obj_break_down=[];
	
	 
		PSTAjax.searchObject(query_break_down,{ 
			callback:function(data){
				obj_break_down=data;  
				var str="<table id=\"table_part1\" class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
			 	  "<thead>"+
			 		"<tr>"+ 
						"<th>จำนวน(คิว)</th>"+ 
						"<th>เลขไมค์</th>"+ 
						"<th>ชม.การทำงาน</th>"+ 
						"<th>ต่อท่อ(เมตร)</th>"+ 
						"<th>Break down/สาเหตุ</th>"+
						"<th>Concrete Spoil</th>"+
						//"<th>ลบ</th>"+ 
					"</tr>"+
					"</thead>"+
					"<tbody>";
					var sum_pjwCubicAmount=0;
					var sum_pjwMile=0;
					var sum_pjwHoursOfWork=0;
					var sum_pjwTube=0;
					var sum_pjwConcreteSpoil=0; 
			 for(var i=0;i<data2[1].length;i++){
				 // alert(data2[1][i].pstBreakDown);
				  //pstRoadPump.prpCarNo  
											  		//<option value="-1">---</option>  
											  		  
				  str=str+"<tr>"+
						//"<td>"+(i+1)+"</td>"+
					 	//"<td><input type=\"hidden\" name=\"prpId_input\" value=\""+data2[1][i].pstRoadPump.prpId+"\"/><input type=\"hidden\" name=\"mode_input\" value=\"edit\"/>"+
					 //	"<span style=\"cursor: pointer;text-decoration: underline;\"  onClick=\"renderJobEmployee('"+data2[1][i].pstRoadPump.prpId+"','"+data2[1][i].pstRoadPump.prpNo+"')\">"+((data2[1][i].pstRoadPump!=null)?data2[1][i].pstRoadPump.prpNo:"")+"</span></td>"+ 
						"<td><input type=\"text\" name=\"pjwCubicAmount_input\" style=\"width: 65px;text-align: right;\" value=\""+(data2[1][i].pjwCubicAmount!=null?data2[1][i].pjwCubicAmount:"")+"\"/></td>"+
						"<td><input type=\"text\"  name=\"pjwMile_input\" style=\"width: 65px;text-align: right;\" value=\""+(data2[1][i].pjwMile!=null?data2[1][i].pjwMile:"")+"\"/></td>"+
						"<td><input type=\"text\"  name=\"pjwHoursOfWork_input\" style=\"width: 65px;text-align: right;\" value=\""+(data2[1][i].pjwHoursOfWork!=null?data2[1][i].pjwHoursOfWork:"")+"\"/></td>"+
						"<td><input type=\"text\"  name=\"pjwTube_input\" style=\"width: 65px;text-align: right;\" value=\""+(data2[1][i].pjwTube!=null?data2[1][i].pjwTube:"")+"\"/></td>"+
						
						"<td>";
					 var str_break_down="<select name=\"pbdId_input\"><option value=\"-1\">---</option> ";
						if(obj_break_down!=null && obj_break_down.length>0){
							for(var j=0;j<obj_break_down.length;j++){
								var selected=""; 
								if(data2[1][i].pstBreakDown!=null && data2[1][i].pstBreakDown.pbdId==obj_break_down[j][0]){
									selected=" selected=\"selected\" ";
								}
								str_break_down=str_break_down+"<option value=\""+obj_break_down[j][0]+"\" "+selected+">"+obj_break_down[j][1]+"</option> ";
							}
						} 
						str_break_down=str_break_down+"</select>";
						//alert(str_break_down)
						//"<select name=\"pbdId_input\"></select>"+
					str=str+str_break_down+
						//(data2[1][i].pstBreakDown!=null?data2[1][i].pstBreakDown.pbdName:"---")+""+  
						//"<input type=\"hidden\" name=\"pbdId_input\" value=\""+(data2[1][i].pstBreakDown!=null?data2[1][i].pstBreakDown.pbdId:"-1")+"\">
						"</td>"+ 
						"<td><input type=\"text\"  name=\"pjwConcreteSpoil_input\" style=\"width: 65px;text-align: right;\" value=\""+(data2[1][i].pjwConcreteSpoil!=null?data2[1][i].pjwConcreteSpoil:"")+"\"/></td>"+
						//"<td><i title=\"Delete\" onclick=\"confirmDelete('1','delete','"+data2[1][i].prpId+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
					"</tr>";
					sum_pjwCubicAmount=sum_pjwCubicAmount+data2[1][i].pjwCubicAmount;
					sum_pjwMile=sum_pjwMile+data2[1][i].pjwMile;
					sum_pjwHoursOfWork=sum_pjwHoursOfWork+data2[1][i].pjwHoursOfWork;
					sum_pjwTube=sum_pjwTube+data2[1][i].pjwTube;
					sum_pjwConcreteSpoil=sum_pjwConcreteSpoil+parseFloat(data2[1][i].pjwConcreteSpoil);
				//  sum=sum+0;
			 }  
			/*  str=str+"</tbody>"+
					"<thead>"+ */
					/*
					str=str+"<tr>"+
					"	<td></td>"+
					"	<td>ยอดรวม</td>"+
					"	<td style=\"width: 65px;text-align: right;\">"+sum_pjwCubicAmount+"</td>"+
					"	<td style=\"width: 65px;text-align: right;\">"+sum_pjwMile+"</td>"+
					"	<td style=\"width: 65px;text-align: right;\">"+sum_pjwHoursOfWork+"</td>"+
					"	<td style=\"width: 65px;text-align: right;\">"+sum_pjwTube+"</td>"+
					"	<td></td>"+
					"	<td style=\"width: 65px;text-align: right;\">"+sum_pjwConcreteSpoil+"</td>"+
					"	<td></td>"+
					"</tr>"+
					*/
				//	"</thead>"+
				"</tbody>"+
				"</table> ";
				//alert(str);
				$("#job_part1_element").html(str);
			}
		});
	 
	  
 } 
function renderJobEmployee(prpId,prpNo){
	var pjId=$("#pjId").val();
	  //alert(pjId);
	  $.get("job/payext_get_employee/"+pjId+"/"+prpId, function(data2) {
		  //alert(data2)
			  renderPart2(data2,prpId,prpNo);			  
	  }); 
} 	
function renderPart2(data2,prpId,prpNo){
	var str="<table id=\"table_part2\" class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
	  "<thead>"+
		"<tr>"+
			"<th>รหัส</th>"+
			"<th>ชื่อ-นามสกุล</th>"+ 
			"<th>ตำแหน่ง</th>"+ 
			"<th>Exclude/Include</th>"+ 
			"<th>%คิว</th>"+ 
			"<th>จำนวนเงิน</th>"+ 
			"<th>ลบ</th>"+ 
		"</tr>"+
		"</thead>"+
		"<tbody>";
		//var sum=0;
    if(data2!=null && data2.length>0){
		for(var i=0;i<data2.length;i++){
	var extInc="<input name=\"pjeExcInc_"+data2[i].peId+"\" value=\"1\" type=\"radio\">/<input  name=\"pjeExcInc_"+data2[i].peId+"\" value=\"2\" checked=\"checked\" type=\"radio\">";
	  if(data2[i].pjeExcInc!=null && data2[i].pjeExcInc=='1'){
		  extInc="<input name=\"pjeExcInc_"+data2[i].peId+"\" value=\"1\" checked=\"checked\" type=\"radio\">/<input  name=\"pjeExcInc_"+data2[i].peId+"\" value=\"2\" type=\"radio\">";
	  }
	  str=str+"<tr>"+
			"<td><input type=\"hidden\" name=\"part2_mode_input\" value=\"edit\"/><input type=\"hidden\" name=\"peId_input\" value=\""+data2[i].peId+"\"/><input type=\"hidden\" name=\"prpId_job_input\" value=\""+data2[i].prpId+"\"/>"+data2[i].pstEmployee.peUid+"</td>"+
			"<td>"+data2[i].pstEmployee.pstTitle.ptName+" "+data2[i].pstEmployee.peFirstName+" "+data2[i].pstEmployee.peLastName+"</td>"+
			"<td>"+(data2[i].pstEmployee.pstPosition!=null?data2[i].pstEmployee.pstPosition.ppName:"")+"</td>"+
			"<td>"+extInc+"</td>"+
			"<td><input type=\"text\" name=\"pjePercentCubic_input\" value=\""+data2[i].pjePercentCubic+"\" style=\"width: 65px;text-align: right;\"></td>"+
			"<td><input type=\"text\" name=\"pjeAmount_input\" value=\""+data2[i].pjeAmount+"\" readonly=\"true\" style=\"width: 65px;text-align: right;\"></td>"+
			"<td><i title=\"Delete\" onclick=\"confirmDeleteEmployee('"+data2[i].peId+"','"+data2[i].prpId+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
		"</tr>";
}
    }
str=str+"</tbody>"+ 
	"</table> ";
	$("#job_part2_element").html(str);
	$("#road_pump_id_element").val(prpId);
	//$("#road_pump_no_element").html(prpNo);
	  $("#tabs_2").slideDown("slow"); 
	/*	 
for(var i=0;i<data2[1].length;i++){
	var extInc="<input name=\"pjeExcInc_"+data2[1][i].peId+"\" value=\"1\" type=\"radio\">/<input  name=\"pjeExcInc_"+data2[1][i].peId+"\" value=\"2\" checked=\"checked\" type=\"radio\">";
	  if(data2[1][i].pjeExcInc!=null && data2[1][i].pjeExcInc=='1'){
		  extInc="<input name=\"pjeExcInc_"+data2[1][i].peId+"\" value=\"1\" checked=\"checked\" type=\"radio\">/<input  name=\"pjeExcInc_"+data2[1][i].peId+"\" value=\"2\" type=\"radio\">";
	  }
	  str=str+"<tr>"+
			"<td><input type=\"hidden\" name=\"part2_mode_input\" value=\"edit\"/><input type=\"hidden\" name=\"peId_input\" value=\""+data2[1][i].peId+"\"/>"+data2[1][i].pstEmployee.peUid+"</td>"+
			"<td>"+data2[1][i].pstEmployee.pstTitle.ptName+" "+data2[1][i].pstEmployee.peFirstName+" "+data2[1][i].pstEmployee.peLastName+"</td>"+
			"<td>"+(data2[1][i].pstEmployee.pstPosition!=null?data2[1][i].pstEmployee.pstPosition.ppName:"")+"</td>"+
			"<td>"+extInc+"</td>"+
			"<td><input type=\"text\" name=\"pjePercentCubic_input\" value=\""+data2[1][i].pjePercentCubic+"\" style=\"width: 65px;text-align: right;\"></td>"+
			"<td><input type=\"text\" name=\"pjeAmount_input\" value=\""+data2[1][i].pjeAmount+"\" readonly=\"true\" style=\"width: 65px;text-align: right;\"></td>"+
			"<td><i title=\"Delete\" onclick=\"confirmDeleteEmployee('"+data2[1][i].peId+"','"+data2[1][i].prpId+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
		"</tr>";
}  
str=str+"</tbody>"+ 
	"</table> ";
	$("#job_part2_element").html(str);
	  $("#tabs_2").slideDown("slow"); 
	  */
 }
function ReplaceNumberWithCommas(yourNumber) {
    //Seperates the components of the number
    var n= yourNumber.toString().split(".");
    //Comma-fies the first part
    n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    //Combines the two sections
    return n.join(".");
}
function renderPart3(data2){
	var str="<table id=\"table_part3\" class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
	  "<thead>"+
		"<tr>"+
			"<th>No</th>"+
			"<th>รหัสการจ่าย-คำอธิบาย</th>"+ 
			"<th>หน่วยละ</th>"+
			"<th>หน่วย</th>"+
			"<th>จำนวน</th>"+
			"<th>รวมเงิน</th>"+
			"<th>ลบ</th>"+
		"</tr>"+
		"</thead>"+
		"<tbody>";
		var sum=0;
	  for(var i=0;i<data2[1].length;i++){
		  var sumIner= (data2[1][i].pstCost!=null)?(data2[1][i].pstCost.pcAmount*data2[1][i].pjpAmount):0;
		 // $.format.number(7456.2, '#,##0.00#');
		/*   var pjpAmount=$.format.number(data2[1][i].pjpAmount,'#,##0.00#');
		  alert(pjpAmount); */
		  //pjeAmount.toFixed(2);
		  str=str+"<tr>"+
 			"<td><input type=\"hidden\" name=\"pcId_input\" value=\""+data2[1][i].pstCost.pcId+"\"/>"+(i+1)+"</td>"+
 			"<td>"+(data2[1][i].pstCost!=null?(data2[1][i].pstCost.pcUid+" - "+data2[1][i].pstCost.pcName):"")+"</td>"+
 			"<td style=\"text-align: right;\">"+(data2[1][i].pstCost!=null?(ReplaceNumberWithCommas(data2[1][i].pstCost.pcAmount)):"")+"</td> "+
 			"<td>"+(data2[1][i].pstCost!=null?data2[1][i].pstCost.pcUnit:"")+"</td>"+
 			"<td style=\"text-align: right;\">"+(data2[1][i].pjpAmount!=null?(ReplaceNumberWithCommas(data2[1][i].pjpAmount)):"")+"</td> "+
 			"<td style=\"text-align: right;\">"+(ReplaceNumberWithCommas(sumIner.toFixed(2)))+"</td> "+
 			"<td><i title=\"Delete\" onclick=\"confirmDelete('3','delete','"+data2[1][i].pcId+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
 		"</tr>";
		  sum=sum+sumIner;
	  }
	/*   str=str+"</tbody>"+
 		"<thead>"+ */
 		str=str+"<tr>"+
 		"	<th></th>"+
 		"	<th>ยอดรวม</th>"+
 		"	<th></th>"+
 		"	<th></th>"+
 		"	<th></th>"+
 		"	<th style=\"text-align: right;\">"+(ReplaceNumberWithCommas(sum.toFixed(2)))+"</th>"+
 		"	<th> </th>   "+
 		"</tr>"+
 		"</tbody>"+
 		//"</thead>"+
 	"</table> ";
 	$("#job_part3_element").html(str);
}
function renderPart4(data2){
	var str="<table id=\"table_part4\" class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\">"+
	  "<thead>"+
		"<tr>"+
			"<th style=\"width: 5%\">No</th>"+
			"<th style=\"width: 80%\">รายละเอียด</th>"+ 
			"<th style=\"width: 10%\">รวมเงิน</th> "+
			"<th style=\"width: 5%\">ลบ</th>"+
		"</tr>"+
		"</thead>"+
		"<tbody>";
		var sum=0;
for(var i=0;i<data2[1].length;i++){
	  str=str+"<tr>"+
			"<td>"+(i+1)+"</td>"+
			"<td>"+(data2[1][i].pjpeName!=null?data2[1][i].pjpeName:"")+"</td>"+
			"<td style=\"text-align: right;\">"+(data2[1][i].pjpeAmount!=null?(ReplaceNumberWithCommas(data2[1][i].pjpeAmount)):"")+"</td> "+
			"<td><i title=\"Delete\" onclick=\"confirmDelete('4','delete','"+data2[1][i].pjpeNo+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
		"</tr>";
	  sum=sum+data2[1][i].pjpeAmount;
}

/* str=str+"</tbody>"+
		"<thead>"+ */
		str=str+"<tr>"+
		"	<th></th>"+
		"	<th>ยอดรวม</th>"+
		"	<th style=\"text-align: right;\">"+ReplaceNumberWithCommas(sum)+"</th>"+
		"	<th> </th>   "+
		"</tr>"+
		//"</thead>"+
		"</tbody>"
	"</table> ";
	$("#job_part4_element").html(str);
	//$("#pjpeNo").val(str);
	
}
 function renderPart(part){
	  var pjId=$("#pjId").val();
	  //alert(pjId);
	  $.get("job/payext_get/"+part+"/"+pjId, function(data2) {
		  //alert(data2); 
		  if(data2[0]=='4'){
			  renderPart4(data2);
		  }else  if(data2[0]=='3'){
			  renderPart3(data2);
		  }else   if(data2[0]=='2'){ 
			  renderPart2(data2);			  
		  }else   if(data2[0]=='1'){  
			  renderPart1(data2);
		  }
	  }); 
 }
 function confirmDelete(part,mode,id){ 
	 var pjId=$("#pjId").val();
	 //alert("part->"+part+",pjId->"+pjId+",id->"+id)
	 $.get("job/payext_delete/"+part+"/"+pjId+"/"+id,function(data) {
		 renderPart(part);
	 });
 }
 function confirmDeleteEmployee(id,prpId){
	 var pjId=$("#pjId").val();
	 $.get("job/payext_delete_employee/"+pjId+"/"+id+"/"+prpId,function(data) {
		 renderPart2(data);	
	 });
 }
 ///"<td><i title=\"Delete\" onclick=\"confirmDelete('1','delete','"+data2[1][i].pjId+"','"+data2[1][i].prpId+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i></td>"+
 function confirmDelete_part1(part,mode,id1,id2){ 
	  var pjId=$("#pjId").val();
	 $.get("job/payext_delete/"+part+"/"+pjId+"/"+id,function(data) {
		 renderPart(part);
	 });
}
 function callDetail(part){   
	 $.post("job/payext_save/"+part,$("#jobForm").serialize(), function(data) { 
		   renderPart(data); 
		});
	    
 }
 function addRow_part1() {
	 var query_break_down="SELECT pbd_id,pbd_name FROM "+SCHEMA_G+".PST_BREAK_DOWN ";
	 var obj_break_down=[];
	 var str_break_down="<select name=\"pbdId_input\"><option value=\"-1\">---</option> ";
	 
		PSTAjax.searchObject(query_break_down,{ 
			callback:function(data){
				obj_break_down=data;
				if(obj_break_down!=null && obj_break_down.length>0){
					for(var i=0;i<obj_break_down.length;i++){
						str_break_down=str_break_down+"<option value=\""+obj_break_down[i][0]+"\">"+obj_break_down[i][1]+"</option> ";
					}
				}
				str_break_down=str_break_down+"</select>";
				 var table = document.getElementById("table_part1");

				    var rowCount = table.rows.length;
				    //alert(rowCount);
				  var prpId= $("#prpId").val();
				  var prpName = $("#prpId option:selected").text();
				  var haveDup=false;
				  var prpId_input = document.getElementsByName("prpId_input");
				  if(prpId_input!=null && prpId_input){
					  for(var i=0;i<prpId_input.length;i++){
						  if(prpId_input[i].value==prpId){
							//  alert("หมายเลขรถ ซ้ำกับที่เลือกไว้.");
							  haveDup=true;
							  break; 
						  }
					  }
				  }
				  if(haveDup){
					  alert("หมายเลขรถ ซ้ำกับที่เลือกไว้.");
					  return false;
				  }
				 // var pbdId = $("#pbdId").val();
				  //var pbdName  =$("#pbdId option:selected").text(); 
				
				     
					
				    var row = table.insertRow(rowCount-1);

				  //  var colCount = table.rows[0].cells.length;
				    var newcell1 = row.insertCell(0); 
				    newcell1.innerHTML=rowCount-1;
				    
				   // alert(prpName)  
						
				    var newcell2 = row.insertCell(1);
				     newcell2.innerHTML="<input type=\"hidden\" name=\"prpId_input\" value=\""+prpId+"\"/><input type=\"hidden\" name=\"mode_input\" value=\"add\"/>"+prpName;
				      
				    var newcell3 = row.insertCell(2);	    
				    newcell3.innerHTML="<input type=\"text\"   name=\"pjwCubicAmount_input\" style=\"width: 65px;text-align: right;\" value=\"\"/>";
				    
				    var newcell4 = row.insertCell(3);
				    newcell4.innerHTML="<input type=\"text\"   name=\"pjwMile_input\" style=\"width: 65px;text-align: right;\" value=\"\"/>";
				    var newcell5 = row.insertCell(4);
				    newcell5.innerHTML="<input type=\"text\"  name=\"pjwHoursOfWork_input\" style=\"width: 65px;text-align: right;\" value=\"\"/>";
				    var newcell6 = row.insertCell(5);
				    newcell6.innerHTML="<input type=\"text\"  name=\"pjwTube_input\" style=\"width: 65px;text-align: right;\" value=\"\"/>";
				    
				    var newcell7 = row.insertCell(6);
				   // newcell7.innerHTML="<input type=\"hidden\" name=\"pbdId_input\" value=\""+pbdId+"\">"+pbdName;
				   newcell7.innerHTML=str_break_down;
				   
				    var newcell8 = row.insertCell(7);
				    newcell8.innerHTML="<input type=\"text\"  name=\"pjwConcreteSpoil_input\" style=\"width: 65px;text-align: right;\" value=\"\">";
				    
				    var newcell9 = row.insertCell(8);
				    newcell9.innerHTML="";  
				
			}
		});
	   
	}
 function addRow_part2() {
	   var table = document.getElementById("table_part2");

	  var rowCount = table.rows.length;
	 
	   //var road_pump_id_val=$("#road_pump_id_element").val();
	   var road_pump_id_val=$("#pstJob\\.pstRoadPump\\.prpId").val();
	   
	    //alert(rowCount);
	  var pjId=$("#pjId").val();
	  var peId=$("#peId").val();
	  var prpId= $("#prpId").val();
	  //var prpName = $("#prpId option:selected").text();
	  var prpName = $("#pstJob\\.pstRoadPump\\.prpId option:selected").text();
	  
	  var haveDup=false;
	  var peId_input = document.getElementsByName("peId_input");
	  if(peId_input!=null && peId_input){
		  for(var i=0;i<peId_input.length;i++){
			  if(peId_input[i].value==peId){
				//  alert("หมายเลขรถ ซ้ำกับที่เลือกไว้.");
				  haveDup=true;
				  break; 
			  }
		  }
	  }
	  if(haveDup){
		  alert("พนังงาน ซ้ำกับที่เลือกไว้.");
		  return false;
	  }  
	  var query_max="SELECT emp.pe_id,emp.pe_uid,emp.pe_first_name,emp.pe_last_name,pos.pp_name FROM "+SCHEMA_G+".PST_EMPLOYEE emp left join PST_DB.PST_POSITION pos "+
	   "  on emp.pp_id=pos.pp_id where pe_id="+peId;
		PSTAjax.searchObject(query_max,{ 
			callback:function(data){
				 
				 var row = table.insertRow(rowCount);

				  //  var colCount = table.rows[0].cells.length;
				    var newcell1 = row.insertCell(0); 
				    newcell1.innerHTML="<input type=\"hidden\" name=\"part2_mode_input\" value=\"add\"/><input type=\"hidden\" name=\"peId_input\" value=\""+data[0][0]+"\"/><input type=\"hidden\" name=\"prpId_job_input\" value=\""+road_pump_id_val+"\"/>"+data[0][1]; 
					
				    var newcell2 = row.insertCell(1);
				     newcell2.innerHTML=data[0][2]+" "+data[0][3];
				      
				    var newcell3 = row.insertCell(2);	    
				    newcell3.innerHTML=data[0][4];
				    
				    var newcell4 = row.insertCell(3);
				    newcell4.innerHTML="<input name=\"pjeExcInc_"+data[0][0]+"\" value=\"1\" type=\"radio\">/<input  name=\"pjeExcInc_"+data[0][0]+"\" value=\"2\" checked=\"checked\" type=\"radio\">";
				    var newcell5 = row.insertCell(4);
				    newcell5.innerHTML="<input type=\"text\" name=\"pjePercentCubic_input\" value=\"\" style=\"width: 65px;text-align: right;\">";
				    var newcell6 = row.insertCell(5);
				    newcell6.innerHTML="<input type=\"text\" name=\"pjeAmount_input\" value=\"\" readonly=\"true\" style=\"width: 65px;text-align: right;\">";
				    
				    var newcell7 = row.insertCell(6);
				    newcell7.innerHTML=""; 
				    
			}
		});
	return false;
	   
	  
	} 
 
 function addRow_part3() {
	 
	 var pjId=$("#pjId").val();
	  var pstJobPay_pcId= $("#pstJobPay_pcId").val();
	 // alert(pstJobPay_pcId)
	  /* if(pstJobPay_pcId==null)
		  alert("value is null") */
	  if(pstJobPay_pcId==null){
			  alert("กรุณาเลือกรหัสการจ่าย-คำอธิบาย.");
			  return false;
	  } 
	  var pjpAmount=$("#pjpAmount").val(); 
	  var haveDup=false;
	  var pcId_input = document.getElementsByName("pcId_input");
	  if(pcId_input!=null && pcId_input){
		  for(var i=0;i<pcId_input.length;i++){
			  if(pcId_input[i].value==pstJobPay_pcId){
				//  alert("หมายเลขรถ ซ้ำกับที่เลือกไว้.");
				  haveDup=true;
				  break; 
			  }
		  }
	  }
	
	  if(haveDup){
		  alert("รหัสการจ่าย ซ้ำกับที่เลือกไว้.");
		  return false;
	  } 
				 var isBank=checkBank(jQuery.trim(pjpAmount));
				 if(isBank){
					// alert('Please fill Value !!!');  
					 alert('กรุณากรอก  จำนวนเงิน.');  
					$("#pjpAmount").focus();
					 return false;	 
				 } 
				 	 
				 var isNumber=checkNumber(jQuery.trim(pjpAmount));
				
				 if(isNumber){  
					 alert('กรุณากรอก  จำนวนเงิน เป็นตัวเลข.');  
					 $("#pjpAmount").focus();
					 return false;	
					  
				 }  
				  
				 var querys=[]; 
					 var query="insert into "+SCHEMA_G+".PST_JOB_PAY set PJ_ID="+pjId+", PC_ID="+pstJobPay_pcId+",PJP_AMOUNT="+pjpAmount;
						 
					 querys.push(query);
				 
			  // alert(querys)
				PSTAjax.executeQuery(querys,{
					callback:function(data){ 
						if(data!=0){
							renderPart("3"); 
							//$( "#dialog-form" ).dialog("close");
						}
					}
				});
	  
	}
 function addRow_part4() {
	 var pjId=$("#pjId").val();
	 var pjpeName= $("#pjpeName").val();
	  var pjpeAmount=$("#pjpeAmount").val();
	  var isBank=checkBank(jQuery.trim(pjpeName));
		 if(isBank){
			 alert('กรุณากรอกรายละเอียด.');  
			 $("#pjpeName").focus();
			 return false;	  
		 } 
	   isBank=checkBank(jQuery.trim(pjpeAmount));
		 if(isBank){
			 alert('กรุณากรอกจำนวนเงิน.');  
			 $("#pjpeAmount").focus();
			 return false;	  
		 } 
		 
		 var isNumber=checkNumber(jQuery.trim(pjpeAmount));
		 
		 if(isNumber){
			 alert('กรุณากรอกจำนวนเงินเป็นตัวเลข.');  
			 $("#pjpeAmount").focus();
			 return false;  
		 }   
			 
				 
				 var query_max="SELECT max(pjpe_no) FROM "+SCHEMA_G+".PST_JOB_PAY_EXT where pj_id="+pjId;
					PSTAjax.searchObject(query_max,{ 
						callback:function(data){
							var no=0;
						    if(data[0]!=null)
						    	no=data[0]+1;
						    	//alert(no)
							  var querys=[]; 
							 var query="insert into "+SCHEMA_G+".PST_JOB_PAY_EXT set PJ_ID="+pjId+", PJPE_NAME='"+jQuery.trim(pjpeName)+"',PJPE_AMOUNT="+jQuery.trim(pjpeAmount)+", pjpe_no="+no;
								 
							 querys.push(query);
							 
					   // alert(querys)
						PSTAjax.executeQuery(querys,{
							callback:function(data){ 
								if(data!=0){
									renderPart("4"); 
									//$( "#dialog-form" ).dialog("close");
								}
							}
						  });   
						}
					});
				
	}
function submit_part1(mode){
	  var pjId=$("#pjId").val();
	  var mode_input=document.getElementsByName("mode_input");
	//  var prpId_input=document.getElementsByName("prpId_input");
	var prpId_input=$("#pstJob\\.pstRoadPump\\.prpId").val();
	  var pjwCubicAmount_input=document.getElementsByName("pjwCubicAmount_input");
	  var pjwMile_input=document.getElementsByName("pjwMile_input");
	  var pjwHoursOfWork_input=document.getElementsByName("pjwHoursOfWork_input");
	  var pjwTube_input=document.getElementsByName("pjwTube_input");
	  var pbdId_input=document.getElementsByName("pbdId_input");
	  var pjwConcreteSpoil_input=document.getElementsByName("pjwConcreteSpoil_input");
	  var pjFeedBackScore=$("#pjFeedBackScore").val();
	 // alert("pjFeedBackScore->"+pjFeedBackScore)
	  //alert(mode)
	 // alert(pjwHoursOfWork_input)
	  var mode_array=[];
	  var pbdId_array=[];
	  var prpId_array=[];
	  var pjwCubicAmount_array=[];
	  var pjwMile_array=[];
	  var pjwHoursOfWork_array=[];
	  var pjwTube_array=[];
	  var pjwConcreteSpoil_array=[];
	  var isBreak=false;
		 if(mode_input!=null && mode_input.length>0){
			 for(var i=0;i<mode_input.length;i++){  
				 mode_array.push(jQuery.trim(mode_input[i].value));
			 }
		 } 
		 if(pbdId_input!=null && pbdId_input.length>0){
			 for(var i=0;i<pbdId_input.length;i++){ 
				 pbdId_array.push(jQuery.trim(pbdId_input[i].value));
			 }
		 } 
	  
		/*  if(prpId_input!=null && prpId_input.length>0){
			 for(var i=0;i<prpId_input.length;i++){ 
				 prpId_array.push(jQuery.trim(prpId_input[i].value));
			 }
		 } */
		  
		 
		 if(pjwCubicAmount_input!=null && pjwCubicAmount_input.length>0){
			 for(var i=0;i<pjwCubicAmount_input.length;i++){
				 
				
				 var isBank=checkBank(jQuery.trim(pjwCubicAmount_input[i].value));
				 if(!isBank){
					 var isNumber=checkNumber(jQuery.trim(pjwCubicAmount_input[i].value));
					 if(isNumber){
						 alert('กรุณากรอกจำนวน(คิว)เป็นตัวเลข.');  
						 $("input[name=pjwCubicAmount_input]").get(i).focus(); 
						 isBreak=true; 
						 break; 
					 }
					 pjwCubicAmount_array.push(jQuery.trim(pjwCubicAmount_input[i].value));
				 }else
					 pjwCubicAmount_array.push('null');
				// var weigth=parseFloat(pjwCubicAmount_input[i].value);
				// sum=sum+weigth;
				
			 }
		 }
		 if(isBreak)
			 return false;
		    
		 if(pjwMile_input!=null && pjwMile_input.length>0){
			 for(var i=0;i<pjwMile_input.length;i++){
				 var isBank=checkBank(jQuery.trim(pjwMile_input[i].value));
				 if(!isBank){
				 	var isNumber=checkNumber(jQuery.trim(pjwMile_input[i].value));
				 	if(isNumber){  
						 alert('กรุณากรอกเลขไมค์เป็นตัวเลข.');  
					 $("input[name=pjwMile_input]").get(i).focus();
					 isBreak=true; 
					 break; 
				 }  
				 pjwMile_array.push("'"+jQuery.trim(pjwMile_input[i].value+"'"));
			   }else
				  pjwMile_array.push(jQuery.trim('null'));
				// alert("isBreak->"+isBreak);
			 }
		 }
		    if(isBreak)
			 return false;  
		// alert("xx->"+pjwHoursOfWork_input)
		 if(pjwHoursOfWork_input!=null && pjwHoursOfWork_input.length>0){
		
			 for(var i=0;i<pjwHoursOfWork_input.length;i++){
				 var isBank=checkBank(jQuery.trim(pjwHoursOfWork_input[i].value));
				 if(!isBank){ 
					 var isNumber=checkNumber(jQuery.trim(pjwHoursOfWork_input[i].value));
					 if(isNumber){
						 alert('กรุณากรอก ชม.การทำงานเป็นตัวเลข.');  
						 $("input[name=pjwHoursOfWork_input]").get(i).focus();
						 isBreak=true; 
						 break; 
				 	} 
				 pjwHoursOfWork_array.push(jQuery.trim(pjwHoursOfWork_input[i].value));
				}else
				 pjwHoursOfWork_array.push('null');	
			 }
		 }
		 if(isBreak)
			 return false;
		 
		 if(pjwTube_input!=null && pjwTube_input.length>0){
			 for(var i=0;i<pjwTube_input.length;i++){
				 var isBank=checkBank(jQuery.trim(pjwTube_input[i].value));
				 if(!isBank){ 
				 	var isNumber=checkNumber(jQuery.trim(pjwTube_input[i].value));
				 	if(isNumber){
						 alert('กรุณากรอก ต่อท่อ(เมตร)เป็นตัวเลข.');  
					 	$("input[name=pjwTube_input]").get(i).focus();
					 	isBreak=true; 
						 break; 
				 	}
					 pjwTube_array.push(jQuery.trim(pjwTube_input[i].value));
				 }else
					 pjwTube_array.push('null');
			 }
		 }
		 if(isBreak)
			 return false;
		 
		 
		 if(pjwConcreteSpoil_input!=null && pjwConcreteSpoil_input.length>0){
			 for(var i=0;i<pjwConcreteSpoil_input.length;i++){
				 var isBank=checkBank(jQuery.trim(pjwConcreteSpoil_input[i].value));
				 if(!isBank){ 
				 	var isNumber=checkNumber(jQuery.trim(pjwConcreteSpoil_input[i].value));
				 	if(isNumber){
					 //alert('Please fill Number pjwConcreteSpoil !!!');  
						 alert('กรุณากรอก Concrete Spoil เป็นตัวเลข.');  
						 $("input[name=pjwConcreteSpoil_input]").get(i).focus();
						 isBreak=true; 
						 break; 
				 	} 
				 	pjwConcreteSpoil_array.push("'"+jQuery.trim(pjwConcreteSpoil_input[i].value+"'"));
				 }else
					pjwConcreteSpoil_array.push("null"); 
			 }
		 }
		// alert(pjFeedBackScore)
		 if(pjFeedBackScore!=null && pjFeedBackScore.length>0){  
				 
				 var isNumber=checkNumber(jQuery.trim(pjFeedBackScore));
				 if(isNumber){
					 //alert('Please fill Number pjwConcreteSpoil !!!');  
					 alert('กรุณากรอก คะแนน เป็นตัวเลข.');  
					 $("#pjFeedBackScore").focus();
					 isBreak=true;  
				 }  
		 	 }
		 if(isBreak)
			 return false;
		 
	var querys=[];
	// querys.push("DELETE FROM "+SCHEMA_G+".PST_JOB_WORK WHERE PJ_ID="+pjId);
	// for(var i=0;i<mode_array.length;i++){ 
		 var query=""; 
		/*  query="insert into "+SCHEMA_G+".PST_JOB_WORK set PJ_ID="+pjId+", PRP_ID="+prpId_input+",PJW_CUBIC_AMOUNT="+pjwCubicAmount_array[0]+",PJW_MILE="+pjwMile_array[0]+",PJW_HOURS_OF_WORK="+pjwHoursOfWork_array[0]+", PJW_TUBE="+pjwTube_array[0]+",PJW_CONCRETE_SPOIL="+pjwConcreteSpoil_array[0]+"";
		 if(pbdId_array[0]!='-1')
			 query=query+" ,PBD_ID="+pbdId_array[0];
		 else
			 query=query+" ,PBD_ID=null "; */
	 
		 /*  if(mode_array[i]=='add'){
			 query="insert into "+SCHEMA_G+".PST_JOB_WORK set PJ_ID="+pjId+", PRP_ID="+prpId_input+",PJW_CUBIC_AMOUNT="+pjwCubicAmount_array[i]+",PJW_MILE='"+pjwMile_array[i]+"',PJW_HOURS_OF_WORK="+pjwHoursOfWork_array[i]+", PJW_TUBE="+pjwTube_array[i]+",PJW_CONCRETE_SPOIL='"+pjwConcreteSpoil_array[i]+"'";
			 if(pbdId_array[i]!='-1')
				 query=query+" ,PBD_ID="+pbdId_array[i];
			 else
				 query=query+" ,PBD_ID=null ";
		 }else{	 
			query="update  "+SCHEMA_G+".PST_JOB_WORK set PJW_CUBIC_AMOUNT="+pjwCubicAmount_array[i]+",PJW_MILE='"+pjwMile_array[i]+"',PJW_HOURS_OF_WORK="+pjwHoursOfWork_array[i]+", PJW_TUBE="+pjwTube_array[i]+",PJW_CONCRETE_SPOIL='"+pjwConcreteSpoil_array[i]+"'";
			 if(pbdId_array[i]!='-1')
				 query=query+" ,PBD_ID="+pbdId_array[i];
			 else
				 query=query+" ,PBD_ID=null ";
			 query=query+" where PJ_ID="+pjId+" and PRP_ID="+prpId_input+""; 
		 }  */	
		 if(mode=='edit'){
			// query="insert into "+SCHEMA_G+".PST_JOB_WORK set PJ_ID="+pjId+", PRP_ID="+prpId_input+",PJW_CUBIC_AMOUNT="+pjwCubicAmount_array[0]+",PJW_MILE="+pjwMile_array[0]+",PJW_HOURS_OF_WORK="+pjwHoursOfWork_array[0]+", PJW_TUBE="+pjwTube_array[0]+",PJW_CONCRETE_SPOIL="+pjwConcreteSpoil_array[0]+"";
			 query="update  "+SCHEMA_G+".PST_JOB_WORK set PJW_CUBIC_AMOUNT="+pjwCubicAmount_array[0]+",PJW_MILE="+pjwMile_array[0]+",PJW_HOURS_OF_WORK="+pjwHoursOfWork_array[0]+", PJW_TUBE="+pjwTube_array[0]+",PJW_CONCRETE_SPOIL="+pjwConcreteSpoil_array[0]+"";
			 if(pbdId_array[0]!='-1')
				 query=query+" ,PBD_ID="+pbdId_array[0];
			 else
				 query=query+" ,PBD_ID=null ";
			 query=query+" where PJ_ID="+pjId;
			 querys.push(query);
		 }   
	 // }
	 
   //alert(querys.length)
    if(mode=='edit'){
    	if(querys.length>0){
    	//	alert(querys[0]);
    		PSTAjax.executeQuery(querys,{
    			callback:function(data){  
    				postFormAction();
    			}
    		});
    	}else{
    		postFormAction();
    	}
    }else{
    	postFormAction();   
    }
}
function postFormAction(){
	var target="job"; 
 	$.post(target+"/action/job",$("#jobForm").serialize(), function(data1) { 
		  appendContent(data1); 
		});
}
function loadPart2(){ 
	 if($("#mode").val()=='edit'){
		submit_part2();
		loadPstCost(); 
	 }
}
function submit_part2(){
  //if($("#mode").val()=='edit'){ 
	  var pjId=$("#pjId").val();
	  var sum_percent=0;
		 //var pjId=$("#pjId").val();
		 var pjCubicAmount=document.getElementById("pjCubicAmount");
		  var part2_mode_input=document.getElementsByName("part2_mode_input");
		  var peId_input=document.getElementsByName("peId_input");
		 // var prpId_job_input=document.getElementsByName("prpId_job_input");
		var pstJob_pstRoadPump_prpId=$("#pstJob\\.pstRoadPump\\.prpId").val();
		 //var pjeExcInc_=document.getElementsByName("pjeExcInc_");
		  var pjePercentCubic_input=document.getElementsByName("pjePercentCubic_input");
		  var pjeAmount_input=document.getElementsByName("pjeAmount_input"); 
		  
		  
		  var isBank=checkBank(jQuery.trim(pjCubicAmount.value));
			 if(isBank){  
				 alert('กรุณากรอก ค่าคิว.');  
				 $("#pjCubicAmount").focus();
				 return false;	  
			 } 
			 
		var isNumber=checkNumber(jQuery.trim(pjCubicAmount.value));
			 if(isNumber){
				 alert('กรุณากรอก ค่าคิว เป็นตัวเลข.');  
				 $("#pjCubicAmount").focus();
				 return false;	  
			 } 
		  var mode_array=[];
		  var peId_array=[]; 
		  var prpId_array=[]; 
		  var pjePercentCubic_array=[];
		  var pjeAmount_array=[];
		  var pjeExcInc_array=[];
		  var isBreak=false;
			 if(part2_mode_input!=null && part2_mode_input.length>0){
				 for(var i=0;i<part2_mode_input.length;i++){  
					 mode_array.push(jQuery.trim(part2_mode_input[i].value));
				 }
			 } 
			 if(peId_input!=null && peId_input.length>0){
				 for(var i=0;i<peId_input.length;i++){ 
					 peId_array.push(jQuery.trim(peId_input[i].value));
					// prpId_array.push(jQuery.trim(prpId_job_input[i].value));
					 prpId_array.push(pstJob_pstRoadPump_prpId);
					 var pjeExcInc=document.getElementsByName("pjeExcInc_"+peId_input[i].value);
					// alert(pjeExcInc.length+","+peId_input[i].value)
					 for(var j=0;j<pjeExcInc.length;j++){
						 if(pjeExcInc[j].checked){
							 pjeExcInc_array.push(pjeExcInc[j].value);
							 break; 
						 }  
						 
					 }
				 }
			 } 
		   
			 
			 if(pjePercentCubic_input!=null && pjePercentCubic_input.length>0){
				 for(var i=0;i<pjePercentCubic_input.length;i++){ 
					 var isNumber=checkNumber(jQuery.trim(pjePercentCubic_input[i].value));
					 if(isNumber){ 
						 alert('กรุณากรอก %คิว เป็นตัวเลข.');  
						 $("input[name=pjePercentCubic_input]").get(i).focus();
						 isBreak=true; 
						 break; 
					 } 
					 pjePercentCubic_array.push(jQuery.trim(pjePercentCubic_input[i].value));
				 }
			 }
			 if(isBreak)
				 return false;
			 
			
			  
			 for(var i=0;i<pjeExcInc_array.length;i++){
				 if(pjeExcInc_array[i]=='2'){
					 sum_percent=sum_percent+parseFloat(pjePercentCubic_array[i]); 
				 }
			 }
			if(sum_percent!=100){ 
				 alert('กรุณากรอก %คิว ให้ถึง 100%.');  
				 //$("input[name=pjePercentCubic_input]").get(i).focus();
				 return false;
			} 
			for(var i=0;i<pjePercentCubic_array.length;i++){
				var pjeAmount=(parseFloat(pjePercentCubic_array[i])*parseFloat(pjCubicAmount.value))/100;
				pjeAmount_input[i].value=pjeAmount.toFixed(2);
				pjeAmount_array.push(pjeAmount_input[i].value);
				 /* if(pjeExcInc_array[i]=='2'){
					 sum_percent=sum_percent+parseFloat(pjePercentCubic_array[i]); 
				 } */
			 } 
			  if(pjeAmount_input!=null && pjeAmount_input.length>0){
			 for(var i=0;i<pjeAmount_input.length;i++){ 
				 var isBank=checkBank(jQuery.trim(pjeAmount_input[i].value));
				 if(isBank){ 
					 alert('กรุณากรอกกดปุ่ม Calculate.');   
					 return false;	  
				 } 
				 //pjeAmount_array.push(jQuery.trim(pjeAmount_input[i].value));
			 }
		 }
		 if(isBreak)
			 return false;  
	var querys=[];
	/*  for(var i=0;i<mode_array.length;i++){
		 var query="";
		 if(mode_array[i]=='add'){
			 //alert(prpId_array[i])
			 query="insert into "+SCHEMA_G+".PST_JOB_EMPLOYEE set PJ_ID="+pjId+", PE_ID="+peId_array[i]+", PRP_ID="+prpId_array[i]+",PJE_EXC_INC="+pjeExcInc_array[i]+",PJE_PERCENT_CUBIC="+pjePercentCubic_array[i]+",PJE_AMOUNT="+pjeAmount_array[i];
			 
		 }else{	 
			query="update  "+SCHEMA_G+".PST_JOB_EMPLOYEE set PJE_EXC_INC="+pjeExcInc_array[i]+",PJE_PERCENT_CUBIC="+pjePercentCubic_array[i]+",PJE_AMOUNT="+pjeAmount_array[i];
			 
			 query=query+" where PJ_ID="+pjId+" and PE_ID="+peId_array[i]+" and  PRP_ID="+prpId_array[i]+" "; 
		 }	
		 querys.push(query);
	 } */
	 //alert("pjId-->"+pjId)
	 querys.push("DELETE FROM "+SCHEMA_G+".PST_JOB_EMPLOYEE WHERE PJ_ID="+pjId);
	for(var i=0;i<mode_array.length;i++){
		 var query="";
	//	 if(mode_array[i]=='add'){
			 //alert(prpId_array[i])
			 query="insert into "+SCHEMA_G+".PST_JOB_EMPLOYEE set PJ_ID="+pjId+", PE_ID="+peId_array[i]+", PRP_ID="+prpId_array[i]+",PJE_EXC_INC="+pjeExcInc_array[i]+",PJE_PERCENT_CUBIC="+pjePercentCubic_array[i]+",PJE_AMOUNT="+pjeAmount_array[i];
			 
		/*  }else{	 
			query="update  "+SCHEMA_G+".PST_JOB_EMPLOYEE set PJE_EXC_INC="+pjeExcInc_array[i]+",PJE_PERCENT_CUBIC="+pjePercentCubic_array[i]+",PJE_AMOUNT="+pjeAmount_array[i];
			 
			 query=query+" where PJ_ID="+pjId+" and PE_ID="+peId_array[i]+" and  PRP_ID="+prpId_array[i]+" "; 
		 }	 */
		 querys.push(query);
	 } 
	PSTAjax.executeQuery(querys,{
		callback:function(data){ 
			if(data!=0){ 
				renderJobEmployee($("#pstJob\\.pstRoadPump\\.prpId").val(),$("#pstJob\\.pstRoadPump\\.prpId option:selected").text()); 
			}
		}
	});
  //}
}
function calculate_part2(){
	 
	var sum_percent=0;
	 //var pjId=$("#pjId").val();
	 var pjCubicAmount=document.getElementById("pjCubicAmount");
	  var part2_mode_input=document.getElementsByName("part2_mode_input");
	  var peId_input=document.getElementsByName("peId_input");
	  //var pjeExcInc_=document.getElementsByName("pjeExcInc_");
	  var pjePercentCubic_input=document.getElementsByName("pjePercentCubic_input");
	  var pjeAmount_input=document.getElementsByName("pjeAmount_input"); 
	  
	  
	  var isBank=checkBank(jQuery.trim(pjCubicAmount.value));
		 if(isBank){
			// alert('Please fill ค่าคิว !!!');  
			 alert('กรุณากรอก ค่าคิว.');  
			// $("input[name=pjwConcreteSpoil_input]").get(i).focus();
			$("#pjCubicAmount").focus();			
			 return false;	  
		 } 
		 
	var isNumber=checkNumber(jQuery.trim(pjCubicAmount.value));
		 if(isNumber){
			// alert('Please fill Number ค่าคิว !!!');  
			 alert('กรุณากรอก ค่าคิว เป็นตัวเลข.');  
				// $("input[name=pjwConcreteSpoil_input]").get(i).focus();
				$("#pjCubicAmount").focus();		
			 return false;	  
		 } 
	  var mode_array=[];
	  var peId_array=[]; 
	  var pjePercentCubic_array=[];
	  var pjeAmount_array=[];
	  var pjeExcInc_array=[];
	  var isBreak=false;
		 if(part2_mode_input!=null && part2_mode_input.length>0){
			 for(var i=0;i<part2_mode_input.length;i++){  
				 mode_array.push(jQuery.trim(part2_mode_input[i].value));
			 }
		 } 
		 if(peId_input!=null && peId_input.length>0){
			 for(var i=0;i<peId_input.length;i++){ 
				 peId_array.push(jQuery.trim(peId_input[i].value));
				 var pjeExcInc=document.getElementsByName("pjeExcInc_"+peId_input[i].value);
				// alert(pjeExcInc.length+","+peId_input[i].value)
				 for(var j=0;j<pjeExcInc.length;j++){
					 if(pjeExcInc[j].checked){
						 pjeExcInc_array.push(pjeExcInc[j].value);
						 break; 
					 }  
					 
				 }
			 }
		 } 
	   
		 
		 if(pjePercentCubic_input!=null && pjePercentCubic_input.length>0){
			 for(var i=0;i<pjePercentCubic_input.length;i++){ 
				 var isNumber=checkNumber(jQuery.trim(pjePercentCubic_input[i].value));
				 if(isNumber){
					// alert('Please fill Number Percent Cubic !!!');  
					 alert('กรุณากรอก %คิว เป็นตัวเลข.');  
						$("input[name=pjePercentCubic_input]").get(i).focus();
						//$("#pjCubicAmount").focus();	
					 isBreak=true; 
					 break; 
				 } 
				 pjePercentCubic_array.push(jQuery.trim(pjePercentCubic_input[i].value));
			 }
		 }
		 if(isBreak)
			 return false;
		 
		/*  if(pjeAmount_input!=null && pjeAmount_input.length>0){
			 for(var i=0;i<pjeAmount_input.length;i++){ 
				 var isNumber=checkNumber(jQuery.trim(pjeAmount_input[i].value));
				 if(isNumber){
					 alert('Please fill Number Percent Cubic !!!');  
					 isBreak=true; 
					 break; 
				 } 
				 pjeAmount_array.push(jQuery.trim(pjeAmount_input[i].value));
			 }
		 }
		 if(isBreak)
			 return false; */
		  
		 for(var i=0;i<pjeExcInc_array.length;i++){
			 if(pjeExcInc_array[i]=='2'){
				 sum_percent=sum_percent+parseFloat(pjePercentCubic_array[i]); 
			 }
		 }
		if(sum_percent!=100){
			// alert('Please fill  Percent Cubic to 100%');  
			 alert('กรุณากรอก %คิว ให้ถึง 100%.');   
				 
			 return false;
		} 
		
		for(var i=0;i<pjePercentCubic_array.length;i++){
			var pjeAmount=(parseFloat(pjePercentCubic_array[i])*parseFloat(pjCubicAmount.value))/100;
			pjeAmount_input[i].value=pjeAmount.toFixed(2);
			 /* if(pjeExcInc_array[i]=='2'){
				 sum_percent=sum_percent+parseFloat(pjePercentCubic_array[i]); 
			 } */
		 }
}
function checkNumber(txtVal){
	// alert(txtVal) 
	 if(!(intRegex.test(txtVal) || floatRegex.test(txtVal))) {
	      //  alert('Please fill Number !!!');
	      return true; 
	    }
	 return false;
 } 
 function checkBank(txtVal){
	 if(txtVal.length==0){
	      //  alert('Please fill Number !!!');
	      return true;
	    }
	 return false;
 }
</script>
<style>
legend {font-size: 14px}
</style>
<div style="${display};padding-top:10px">
 <div class="alert alert-success" style="${display}">    
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
  </div>
<fieldset style="font-family: sans-serif;padding-top:5px">
	    <form:form id="jobForm" name="jobForm" modelAttribute="jobForm"  cssClass="well" cssStyle="border:2px solid #B3D2EE;background: #F9F9F9" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${jobForm.pstJob.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${jobForm.pstJob.mcontactType}" id="mcontactType"/> --%> 
			  <form:hidden path="mode"/>
			  <form:hidden path="pstJob.pjId" id="pjId" />
			  <form:hidden path="pstJob.pjContractName" id="pjContractName" />
			  <form:hidden path="pstJob.pjCustomerDepartment" id="pjCustomerDepartment" />
			  <form:hidden path="pstJob.pccId" id="pccId" />
			  <form:hidden path="pstJob.pcdId" id="pcdId" /> 
			   
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong>Job</strong><br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="6"></td>
    				</tr>
    				<tr valign="middle">
    					<td width="10%" align="right"><span style="font-size: 13px;padding: 5px">เลขที่งาน :</span></td>
    					<td width="15%" colspan="1"> 
    					<span id="pjJobNo_span" class="control-group">
    						<form:input path="pstJob.pjJobNo" id="pjJobNo" cssStyle="height: 30;width:80px"/><span style="color: red;padding-left: 5px">*</span>
    						</span>
    					</td> 
    					<td width="12%" align="right"><span style="font-size: 13px;padding: 5px">หมายเลขรถ :</span></td>
    					<td width="25%" colspan="1"> 
    					<form:select path="pstJob.pstRoadPump.prpId" cssStyle="width:100px" onchange="loadPart2()">
	    					      	  <form:options itemValue="prpId" itemLabel="prpNo" items="${pstRoadPumpNos}"/> 
	    	                </form:select>
    						<span style="color: red;padding-left: 5px">*</span>
    					</td>
    					<td width="13%" align="right"><span style="font-size: 13px;padding: 5px">คอนกรีตที่ใช้ :</span></td>
    					<td width="25%" colspan="1"> 
    						<form:select path="pstJob.pstConcrete.pconcreteId" cssStyle="width:170px">
	    						      <form:option value="-1">---</form:option>
	    					      	  <form:options itemValue="pconcreteId" itemLabel="pconcreteName" items="${pstConcretes}"/> 
	    	                </form:select>
    						
    					</td>
    				</tr>
    				<tr valign="middle">
    					<td width="10%" align="right"><span style="font-size: 13px;padding: 5px">รหัสลูกค้า :</span></td>
    					<td width="15%" colspan="1">  
    					<!-- <input type="hidden" id="pcId" /> -->
    					<form:hidden path="pstJob.pcId" id="pcId"/>
    					<span id="pjCustomerNo_span"  class="control-group">
    					<form:input path="pstJob.pjCustomerNo" id="pjCustomerNo" cssStyle="height: 30;width:80px"/>
    					</span>
    						<%-- <form:input path="pstJob.pstConcrete.pconcreteId" id="pconcreteId" cssStyle="height: 30;width:80px"/> --%>
    					<span style="color: red;padding-left: 2px">*</span>
    					</td> 
    					<td width="12%" align="right"><span style="font-size: 13px;padding: 5px">ชื่อลูกค้า :</span></td>
    					<td width="25%" colspan="1"> 
    						 <span id="pjCustomerName_span"  class="control-group">
    						<form:input path="pstJob.pjCustomerName" id="pjCustomerName" cssStyle="height: 30;width:157px"/>
    						</span>
    						<span style="color: red;padding-left: 2px">*</span>
    					</td>
    					<td width="13%" align="right"><span style="font-size: 13px;padding: 5px">หน่วยงาน :</span></td>
    					<td width="25%" colspan="1"> 
    					  <span id="customerDepartmentElement"  class="control-group"> 
	         
    					  	<select id="pcdIdSelect" style="width:170px"></select>
    					  </span>
    					  
    				<%-- 	<form:input path="pstJob.pjCustomerDepartment" id="pjCustomerDepartment" cssStyle="height: 30;width:167px"/> --%>
    					
    						<span style="color: red;padding-left: 2px">*</span>
    					</td>
    				</tr>
    				<tr valign="middle"> <!--  10 15 12 25 13 25 -->
    					<td width="10%" align="right"><span style="font-size: 13px;padding: 5px">วันที่ :</span></td>
    					<td width="15%" >
    						<span id="pjCreatedTime_span"  class="control-group">
    						<form:input path="pjCreatedTime" id="pjCreatedTime"  cssStyle="height: 30;width:85px" readonly="true"/>
    						</span>
    						<span style="color: red;padding-left: 2px">*</span>
    					</td> 
    					<td width="12%" align="right"><span style="font-size: 13px;padding: 5px">ชื่อผู้ติดต่อ :</span></td>
    					<td width="25%" colspan="1"> 
    					 <span id="contractNameElement"  class="control-group">
    					  	<select id="pccIdSelect" style="width:170px"></select>
    					  </span>
    						<span style="color: red;padding-left: 2px">*</span>
    					</td> 
    					<td width="13%" align="right"><span style="font-size: 13px;padding: 5px">
    					โทรศัพท์ :</span></td>
    					<td width="25%" colspan="1"> 
    						 <span id="pjContractMobileNo_span" class="control-group">
    						<form:input path="pstJob.pjContractMobileNo"  id="pjContractMobileNo" cssStyle="height: 30;width:120px"/>
    						</span>
    					</td>
    				</tr>
    				<tr valign="middle"> <!--  10 15 12 25 13 25 -->
    					<td width="10%" align="right"><span style="font-size: 13px;padding: 5px">เวลาที่ใช้ :</span></td>
    					<td width="15%" >
    						<span id="pjTimeUsed_span"  class="control-group">
    							<form:input path="pstJob.pjTimeUsed" id="pjTimeUsed"  cssStyle="height: 30px;width: 90px;text-align: right"/>
    						</span>
    						<span style="color: red;padding-left: 2px">*</span>
    					</td> 
    					<td width="75%" colspan="4" align="right"></td>
    					 
    				</tr>
    				
    				<tr valign="top">
    					<td width="10%" align="right"><span style="font-size: 13px;padding: 5px">หมายเหตุ :</span></td>
    					<td width="20%" colspan="5"> 
    					<form:textarea path="pstJob.pjRemark" id="pjRemark" rows="4" cols="4"></form:textarea>
    					<script>
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
    						                     // 	{ name: 'others', items: [ '-' ] },
    						                      //	{ name: 'about', items: [ 'About' ] }
    						                      ],
    						        height:"100"
    						        //, width:"200"
    						      //  uiColor : '#9AB8F3'
    						    });
    					//CKEDITOR.instances['pjRemark'].resize( '100%', '50' );
    					</script>
    					</td> 
    				</tr>
    			</table> 
    			<br/>
    			<div id="element_detail" style="display: none;font-family: sans-serif;font-size: 13px" >
    			<table border="0" width="100%" style="font-size: 13px">
			    	 <tr>
    					<td width="100%" colspan="6">
    					 	<div id="tabs_1">
								<ul>			 
									<li><a href="#tabs_1-1">รายการรถออกงาน</a></li> 
								</ul>
								<div id="tabs_1-1" > 
								  <div>รายการออกรถ</div>  
								   <!--  PST_JOB_WORK  -->
								   <div id="job_part1_element">  
								   </div> 
								</div>
							</div>
							
    					</td>
    				</tr>  
    				</table>
    				<table border="0" width="100%" style="font-size: 12px">
			    	 <tr>
    					<td width="100%" colspan="6">
    					 	<div id="tabs_2">
								<ul>	 
								  <input type="hidden" id="road_pump_id_element"/>
									<li><a href="#tabs_2-1">พนักงานประจำรถ&nbsp;&nbsp;<span id="road_pump_no_element"></span></a></li> 
								</ul>
								<div id="tabs_2-1" >  
								<div>รหัส ชื่อ-นามสกุล พนง. 
								<form:select path="pstJobEmployee.peId" id="peId">
								  		<!-- <option value="-1">---</option>   -->
								  		 <c:forEach items="${pstEmployeeList}" var="pstEmployee" varStatus="loop"> 
								  		 	<option value="${pstEmployee.peId}">${pstEmployee.peUid} ${pstEmployee.peFirstName} ${pstEmployee.peLastName}</option>  
								  		 </c:forEach> 
	    	            		  </form:select>
								 <a  class="btn" style="position: relative;top: -4px" onclick="addRow_part2()">Add</a>
								 <a  class="btn" style="position: relative;top: -4px;right: -10px" onclick="calculate_part2()">Calculate</a>
								 <a  class="btn" style="position: relative;top: -4px;right: -10px" onclick="submit_part2()">Submit</a> 
								 </div>  
								  
								  <div>
								  ค่าคิว :&nbsp;<form:input path="pstJob.pjCubicAmount" id="pjCubicAmount" cssStyle="height: 30;width:80px;text-align: right;"/>&nbsp;บาท
								  </div>
								   <!--  PST_JOB_EMPLOYEE  -->
								   <div id="job_part2_element"> 
								   </div>
							</div>
							</div>
    					</td>
    				</tr>  
    				</table>
    				<table border="0" width="100%" style="font-size: 12px">
			    	 <tr>
    					<td width="100%" colspan="6">
    					 	<div id="tabs_3">
								<ul>			 
									<!-- <li><a href="#tabs_3-1">รายงานจ่ายค่าคิว หมายเลขรถ</a></li> --> 
									<li><a href="#tabs_3-1">รายงานจ่ายค่าคิว</a></li>
								</ul>
								<div id="tabs_3-1" >
								 <div> 
	    	            		  &nbsp;รหัสการจ่าย-คำอธิบาย
	    	            		  <span id="pstJobPay_pcId_section"> 
	    	            		  </span>
	    	            		   &nbsp;จำนวน <form:input path="pstJobPay.pjpAmount" id="pjpAmount" cssStyle="width: 65px;text-align: right;height: 30px"/> <a  class="btn" style="position: relative;top: -4px" onclick="addRow_part3()">Add</a></div>  
								  <!-- PST_JOB_PAY -->
								   <div id="job_part3_element"> 
									</div>
							 </div>
							 </div> 
    					</td>
    				</tr>  
    				</table>
    			 <table border="0" width="100%" style="font-size: 12px">
			    	 <tr>
    					<td width="100%" colspan="6">
    					 	<div id="tabs_4">
								<ul>			 
									<li><a href="#tabs_4-1">รายการค่าใช้จ่ายอื่นๆ</a></li> 
								</ul>
								<div id="tabs_4-1" >   
								 <div>รายละเอียด <form:input path="pstJobPayExt.pjpeName" id="pjpeName" cssStyle="height: 30px;" />จำนวนเงิน <form:input path="pstJobPayExt.pjpeAmount" id="pjpeAmount" cssStyle="width: 65px;text-align: right;height: 30px;" /><a  class="btn" style="position: relative;top: -4px;left:3px" onclick="addRow_part4()">Add</a></div>   
								  <!-- PST_JOB_PAY_EXT --> 
								   <div id="job_part4_element"> 
								   </div>
							   </div> 
							  </div>
    					</td>
    				</tr>  
    				<tr>
    					<td width="100%" colspan="6">  
    					</td>
    				</tr> 
    			</table>
    			<table border="0" width="100%" style="font-size: 12px">
			    	 <tr>
    					<td width="100%" colspan="6">
    					 	<div id="tabs_5">
								<ul>			 
									<li><a href="#tabs_5-1">คะแนน Feedback</a></li> 
								</ul>
								<div id="tabs_5-1" >   
								 <div>คะแนน &nbsp;&nbsp;&nbsp;&nbsp;<form:input path="pstJob.pjFeedBackScore"  id="pjFeedBackScore" cssStyle="height: 30px;width: 90px;text-align: right" /></div>   
								 </div>
							</div> 
    					</td>
    				</tr>  
    				<tr>
    					<td width="100%" colspan="6">  
    					</td>
    				</tr> 
    			</table>
    			</div>
    			</fieldset> 
			  </form:form>  
			<div align="center">
			<a class="btn btn-info"  onclick="goBackJob()"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>	
    					 <a class="btn btn-primary"  onclick="doCheckDuplicate('action','${jobForm.mode}','${jobForm.pstJob.pjId}')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save</span></a>
			</div>
</fieldset>