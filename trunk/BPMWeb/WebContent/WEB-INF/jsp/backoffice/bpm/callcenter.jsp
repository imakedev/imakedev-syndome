<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<style>
.ui-datepicker-trigger{cursor: pointer;}
table > thead > tr > th
{
background	:#e5e5e5;
}

</style>
 
<script>
$(document).ready(function() { 
	/*
	new AjaxUpload('stock_element', {
		  action: 'upload/stock/1',
		onSubmit : function(file , ext){
	      // Allow only images. You should add security check on the server-side.
				if (ext && /^(jpg|png|jpeg|gif|xls|xlsx|XLS|XLSX|pdf|PDF|docx|doc|DOCX|DOC)$/.test(ext)){
				 
				this.setData({
					'key': 'This string will be send with the file',
					'test':'chatchai'
				});					  
			} else {					
				// extension is not allowed
				alert('Error: only images are allowed') ;
				// cancel upload
				return false;				
			}		
		},
		onComplete : function(file, response){ 
			var obj = jQuery.parseJSON(response);
			  bootbox.dialog("Upload Stock เรียบร้อยแล้ว",[{
				    "label" : "Close",
				     "class" : "btn-danger"
			 }]);
			 return false;
		}		
	}); 
	
	 'use strict';
	// Change this to the location of your server-side upload handler:
    var url =  'upload/stock/1';
    $('#fileupload').fileupload({
        url: url,
        dataType: 'json',
        done: function (e, data) {
        	alert(data)
        	 
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo('#files');
            });
        	 
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
    */
	$("#bccNoSearch").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchCallCenter('1');
		   } 
		});
	$("#BCC_SERIALSearch").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchCallCenter('1');
		   } 
		});
	$("#locationSearch").keypress(function(event) {
		  if ( event.which == 13 ) {
		     event.preventDefault();
		     searchCallCenter('1');
		   } 
		});
	setSpanClass("width");
	searchCallCenter("1");
	 
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchCallCenter(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchCallCenter(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	$("#pageNo").val($("#pageSelect").val());
//	doAction('search','0');
	searchCallCenter($("#pageNo").val());
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
	$("#pageSelect").val($("#pageNo").val());
	//document.getElementById("pageSelect").value=$("#pageNo").val();
}

function cancelAction(id){
	//alert( $("#bdeptUserId").val());
	var BCC_CANCEL_CAUSE=jQuery.trim($("#BCC_CANCEL_CAUSE").val());
	 
	if(!BCC_CANCEL_CAUSE.length>0){
		 alert('กรุณาระบุ สาเหตุการยกเลิก.');  
		 $("#BCC_CANCEL_CAUSE").focus(); 
		 return false;	
	}  

	var querys=[];
				var query="UPDATE   "+SCHEMA_G+".BPM_CALL_CENTER  SET BCC_STATE='cancel' ,BCC_CANCEL_CAUSE='"+BCC_CANCEL_CAUSE+"' where BCC_NO='"+id+"'";
				 
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
							searchCallCenter("1");
							bootbox.hideAll();
						}
					},errorHandler:function(errorString, exception) { 
						alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
					}
				});
		 
}

function confirmDelete(id){
	var queryCheck=" SELECT "+ 
    " IFNULL((select BTDL_STATE  FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+
  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by BTDL_CREATED_TIME desc limit 1 ) ,'') as c0, "+
  	 " (select BTDL_OWNER  FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+
	  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by BTDL_CREATED_TIME desc limit 1 ) as c1, "+
	 " IFNULL(call_center.BCC_STATE ,'') as c2, "+	
	 " IFNULL(call_center.BCC_SERIAL ,'') as c3 , "+	
	 " ( select count(*) from BPM_SERVICE_ITEM_MAPPING where BCC_NO='"+id+"' ) as c4 "+
	   " FROM "+SCHEMA_G+".BPM_CALL_CENTER call_center where call_center.BCC_NO='"+id+"'";
	SynDomeBPMAjax.searchObject(queryCheck,{
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
				   var bcc_state=data[0][2];
				   if(bcc_state=='cancel'){
					   bootbox.dialog("ข้อมูลถูกยกเลิกไปแล้ว",[{
						    "label" : "Close",
						     "class" : "btn-danger"
					    }]);
				  // }else if((data[0][0]=='wait_for_assign_to_team' || jQuery.trim(data[0][3]).length==0 ) && data[0][3]==0) {// can cancel
					   }else if((data[0][0]=='wait_for_assign_to_team' || jQuery.trim(data[0][3]).length==0 ) || data[0][3]==0) {// can cancel
					   var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"cancelAction('"+id+"')\"><span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		                  "<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\"><span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
						bootbox.dialog("<div>ระบุ สาเหตุการยกเลิก</div><textarea  id=\"BCC_CANCEL_CAUSE\" cols=\"100\" rows=\"3\" class=\"span7\"></textarea><div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
		
				   }else{ // can not cancel
					   bootbox.dialog("ไม่สามารถยกเลิกได้",[{
						    "label" : "Close",
						     "class" : "btn-danger"
					    }]);
				   }
				  
			   }  
		}
	});
	 
} 
function doAction(id){
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_CALL_CENTER where BCC_NO="+id; 
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
				querys=[]; 
				 query="DELETE FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='"+id+"' "; 
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
							searchCallCenter("1"); 
						}
					});
				
			}
		}
	});
} 
function searchCallCenter(_page){  
	$("#pageNo").val(_page); 
	var sqlWhere="";
	// var bccNoSearch = jQuery.trim($("#bccNoSearch").val());
	//var BCC_SERIALSearch = jQuery.trim($("#BCC_SERIALSearch").val());
	//var locationSearch = jQuery.trim($("#locationSearch").val()); 
	var bccNoSearch = jQuery.trim($("#bccNoSearch").val().replace(/'/g,"''"));
	var BCC_SERIALSearch = jQuery.trim($("#BCC_SERIALSearch").val().replace(/'/g,"''"));
	var locationSearch=jQuery.trim($("#locationSearch").val().replace(/'/g,"''"));
	var haveWhere = false;
	//alert("model_section_1->"+model_section_1)
	if (bccNoSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				+ " lower(call_center.BCC_NO) like lower('%" + bccNoSearch + "%')";
		haveWhere = true;
	}
	if (BCC_SERIALSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				+ " lower(concat(call_center.BCC_SERIAL,'',call_center.BCC_MODEL)) like lower('%"
				+ BCC_SERIALSearch + "%')";
		haveWhere = true;
	} 
	if (locationSearch.length > 0) {
		sqlWhere = sqlWhere + ((haveWhere) ? " and " : " where ")
				//+ " lower(call_center.BCC_SALE_ID) like lower('%"
					+"	 lower(concat(call_center.BCC_CONTACT,'',call_center.BCC_TEL,'',call_center.BCC_LOCATION,'',call_center.BCC_ADDR1,'',call_center.BCC_ADDR2,'',call_center.BCC_ADDR3,'',call_center.BCC_PROVINCE)) like lower('%"
				+ locationSearch + "%')";
		haveWhere = true;
	}
	/* if(!haveWhere){
		sqlWhere = sqlWhere +
		" where so.BSO_CREATED_DATE between DATE_FORMAT(now(),'%Y-%m-%d 00:00:00') and DATE_FORMAT(now(),'%Y-%m-%d 23:59:59') ";
		//" where so.BSO_CREATED_DATE between DATE_FORMAT(now(),'%Y-%m-%d 00:00:00') and DATE_FORMAT(now(),'%Y-%m-%d 23:59:59') ";
	} */
	var query=" SELECT "+
	    " call_center.BCC_NO ,"+//1
	    " IFNULL(call_center.BCC_SERIAL,'') ,"+//2
	    " IFNULL(call_center.BCC_MODEL,'') ,"+//3
	    " IFNULL(call_center.BCC_CAUSE,'') ,"+//4
	    "  call_center.BCC_CREATED_TIME  ,"+//5
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') ,"+//6
	    " IFNULL(call_center.BCC_SLA,'') ,"+//7
	    " IFNULL(call_center.BCC_IS_MA ,'') ,"+//8
	    " IFNULL(call_center.BCC_MA_NO ,'') ,"+//9
	    " IFNULL(call_center.BCC_MA_START ,'') ,"+//10
	    " IFNULL(call_center.BCC_MA_END ,'') ,"+//11
	    " IFNULL(call_center.BCC_STATUS ,'') ,"+//12
	    " IFNULL(call_center.BCC_REMARK ,'') ,"+//13
	    " IFNULL(call_center.BCC_USER_CREATED ,'') ,"+//14
	    " IFNULL(call_center.BCC_DUE_DATE ,'') ,"+//15
	    " IFNULL(call_center.BCC_CONTACT ,'') ,"+//16
	    " IFNULL(call_center.BCC_TEL ,'') ,"+//17
	    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') ,"+ //18
	    " IFNULL(call_center.BCC_ADDR1 ,'') ,"+//19
	    " IFNULL(call_center.BCC_ADDR2 ,'') ,"+//20
	    " IFNULL(call_center.BCC_ADDR3 ,'') ,"+//21
	    " IFNULL(call_center.BCC_LOCATION ,'') ,"+//22
	    " IFNULL(call_center.BCC_PROVINCE ,'') ,"+//23
	    " IFNULL(call_center.BCC_ZIPCODE ,'') ,"+//24
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') , "+ //25
	    
	  	//--------------Begin aui edit tunning query[11/03/2015]----------------	    
	   /* " ifnull(param.VALUE,'') as param, "+
	    " concat(ifnull(u.firstName,''),' ',ifnull(u.lastName,'')) as user_fullname,"+*/
	    
	    " IFNULL((select ifnull(param.VALUE,'')   FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+ 
	    " left join  "+SCHEMA_G+".BPM_SYSTEM_PARAM param on ( param.PARAM_NAME='STATE' and todo.BTDL_STATE=param.key ) "+
	  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' "+	  	
	  	" order by BTDL_CREATED_TIME desc limit 1 ) ,''), "+//26
	  	
	  	" IFNULL((select concat(ifnull(u.firstName,''),' ',ifnull(u.lastName,''))  FROM  "+SCHEMA_G+".BPM_TO_DO_LIST todo  "+	  			
	     " left join  "+SCHEMA_G+".user u on "+
		    " (u.username=todo.BTDL_OWNER ) "+
		  	"  where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2' order by BTDL_CREATED_TIME desc limit 1 ) ,''), "+//27
		  	
		//--------------Begin aui edit tunning query[11/03/2015]----------------	    
		" IFNULL(j_status.BJS_STATUS,'') ,"+//28
	 	" IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') , "+//29
	 	" IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') , "+ //30
	 	" IFNULL(call_center.BCC_BRANCH,'') "+//31
	 	
	    " FROM "+SCHEMA_G+".BPM_CALL_CENTER call_center left join "+ 
	    " "+SCHEMA_G+".BPM_SERVICE_JOB  sv  on( call_center.BCC_NO=sv.BCC_NO) "+
	    " left join  "+SCHEMA_G+".BPM_JOB_STATUS j_status on "+
	    " (sv.SBJ_JOB_STATUS=j_status.BJS_ID and j_status.BJS_TYPE=2 ) "+
	    //--------------Begin aui add tunning query[11/03/2015]----------------	    
		/*" left join (select todo.btdl_ref,todo.BTDL_STATE,todo.BTDL_OWNER ,todo.BTLD_AI "+
		" from SYNDOME_BPM_DB.BPM_TO_DO_LIST todo "+
		" where todo.btdl_type='2' and "+
		" todo.BTLD_AI in (SELECT MAX(BTLD_AI) from SYNDOME_BPM_DB.BPM_TO_DO_LIST where BTDL_TYPE=2 group by BTDL_REF)) as todo2 "+
		" on (todo2.btdl_ref=call_center.BCC_NO) "+
		" left join SYNDOME_BPM_DB.user u  "+
		" on (u.username=todo2.BTDL_OWNER ) "+
		" left join  SYNDOME_BPM_DB.BPM_SYSTEM_PARAM param "+
		" on ( param.PARAM_NAME='STATE' and todo2.BTDL_STATE=param.key ) "+*/
		//--------------End aui add tunning query[11/03/2015]----------------	    
	 
				sqlWhere+
	    "order by  call_center.BCC_NO desc ";
	 
	 // alert(query)
	_perpageG = 50;
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
			        "  		<th width=\"7%\"><div class=\"th_class\">เลขที่แจ้งซ่อม</div></th> "+
			        "  		<th width=\"15%\"><div class=\"th_class\">หมายเลขเครื่อง/Model</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">อาการเสีย</div></th> "+  
			        "  		<th width=\"23%\"><div class=\"th_class\">สถานที่ซ่อม</div></th> "+
			        "  		<th width=\"10%\"><div class=\"th_class\">เวลานัดหมาย</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\">วันที่เปิดเอกสาร</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\">Status Assign</div></th> "+ 
			        "  		<th width=\"10%\"><div class=\"th_class\">Status Job</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   for(var i=0;i<data.length;i++){
					  // alert(data[i][30])
					   var date_created = (data[i][30]!=null && data[i][30].length>0)? $.format.date(data[i][30], "dd/MM/yyyy  HH:mm"):"&nbsp;";
					 /*   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+(limitRow+i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][26]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][1]!=null)?data[i][1]:"&nbsp;")+"</td>  "+  
				        "    	<td style=\"text-align: left;\">"+((data[i][27]!=null)?data[i][27]:"&nbsp;")+"</td>  "+
				        "    	<td style=\"text-align: left;\">"+date_created+"</td>  "+ 
				        "    	<td style=\"text-align: center;\">"+  
				        "    	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/delivery_install_management?bsoId="+data[i][0]+"&mode=edit')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        "  	</tr>  "; */
				     var BCC_STATE=data[i][27];
				        var BCC_BRANCH="";
				        if(BCC_STATE!='cancel')
				        	BCC_STATE=data[i][25];
				       str=str+ "  	<tr style=\"cursor: pointer;\">"+  
						   "  		<td style=\"text-align: left;\"><span  style=\"text-decoration: underline;\"  onclick=\"loadDynamicPage('dispatcher/page/callcenter_job?bccNo="+data[i][0]+"&mode=edit')\">"+data[i][0]+"</span></td>"+     
						   "  		<td style=\"text-align: left;\">"+data[i][1]+"/"+data[i][2]+"</td>"+    
						   "  		<td style=\"text-align: left;\">"+data[i][3]+"</td>"+     
					        "    	<td style=\"text-align: left;\">"+data[i][21]+" "+data[i][30]+" "+data[i][18]+" "+data[i][19]+" "+data[i][20]+" "+data[i][22]+" "+data[i][23]+" "+data[i][15]+" "+data[i][16]+"</td>  "+  
					        "    	<td style=\"text-align: left;\">"+data[i][24]+" "+data[i][28]+"-"+data[i][29]+"</td>  "+
					        "    	<td style=\"text-align: left;\">"+data[i][5]+" ["+data[i][13]+"]</td>  "+ 
					        "    	<td style=\"text-align: left;\">"+data[i][26]+"</td>  "+ 
					        "    	<td style=\"text-align: left;\">"+BCC_STATE+" ["+data[i][27]+"]</td>  "+ 
					        //+" ["+data[i][13]+"]
					        "    	<td style=\"text-align: center;\">"+  
					        <c:if test="${!isStoreAccount}">
					        "    	<i title=\"Edit\" onclick=\"loadDynamicPage('dispatcher/page/callcenter_job?bccNo="+data[i][0]+"&mode=edit')\" style=\"cursor: pointer;\" class=\"icon-edit\"></i>&nbsp;&nbsp;"+
					        "    	<i title=\"Cancel\" onclick=\"confirmDelete('"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
					       </c:if>
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
					   
			$("#search_section_callcenter").html(str);
		}
	}); 
	/*
	SynDomeBPMAjax.searchObject(queryCount,{
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
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
	*/
} 
</script>
<div id="dialog-confirmDelete" title="Delete Job" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Job ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px;padding-left:2px;">
	         
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
	    					<span><strong>แจ้งซ่อม</strong></span>
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
									<span style="padding-left: 10px;font-size: 13px;">เลขที่แจ้งซ่อม</span> 
									<span style="padding: 5px;">
										<input id="bccNoSearch" type="text" style="height: 30; width: 100px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">หมายเลขเครื่อง/Model</span> 
									<span style="padding: 5px;">
										<input id="BCC_SERIALSearch" type="text" style="height: 30; width: 150px" />
									</span>
									<span style="padding-left: 20px;font-size: 13px;">สถานที่ซ่อม</span> 
									<span style="padding: 5px;">
										<input id="locationSearch" type="text" style="height: 30; width: 350px" />
									</span> 
									<span style="padding-left: 50px;">
									<a class="btn" style="margin-top: -10px;"
									onclick="searchCallCenter(1)"><i
										class="icon-search"></i>&nbsp;Search</a>
										</span>
										<%--
										 <span class="btn btn-success fileinput-button">
        <i class="glyphicon glyphicon-plus"></i>
        <span>Select files...</span>
        <!-- The file input field used as target for the file upload widget -->
        <input id="fileupload" type="file"   multiple>
    </span>
     <!-- The global progress bar -->
    <div id="progress" class="progress">
        <div class="progress-bar progress-bar-success"></div>
    </div>
    <!-- The container for the uploaded files -->
    <div id="files" class="files"></div>
     --%>
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
	    					<c:if test="${!isStoreAccount}">
	    					<a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/callcenter_job?bccNo=0&mode=add')"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">เปิด job แจ้งซ่อม</span></a>
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
	    					<div  id="search_section_callcenter"> 
    						</div> 
      </div>
      </fieldset> 