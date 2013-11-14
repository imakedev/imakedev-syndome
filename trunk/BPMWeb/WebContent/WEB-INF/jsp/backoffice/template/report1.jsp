<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<style>
.ui-datepicker-trigger{cursor: pointer;}
.ui-datepicker-calendar {
    display: none;
}​
</style>
<script>
$(document).ready(function() {
	//renderPageSelect();
	 if($("#message_element > strong").html().length>0){
		 $('html, body').animate({ scrollTop: 0 }, 'slow'); 
		 $("#message_element").slideDown("slow"); 
		 setTimeout(function(){$("#message_element").slideUp("slow")},5000);
	 }
	 $('#time_from').datepicker({
	     changeMonth: true,
	     changeYear: true,
	     dateFormat: 'MM yy',
	     showOn: "button",
	 	buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
	     onClose: function() {
	        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	       // alert("iMonth->"+iMonth+",iYear->"+iYear);
	     },
	       
	     beforeShow: function() {
	       if ((selDate = $(this).val()).length > 0) 
	       {
	          iYear = selDate.substring(selDate.length - 4, selDate.length);
	          iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
	          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
	           $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
	       }
	    }
	  });
	 /* $("#time_from" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		}); */
	 $("#time_to" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
});
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		doAction('search','0');
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		doAction('search','0');
	}
} 
function goToPage(){ 
	$("#pageNo").val(document.getElementById("roadpumpPageSelect").value);
	doAction('search','0');
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"roadpumpPageSelect\" id=\"roadpumpPageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val();
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	document.getElementById("roadpumpPageSelect").value=$("#pageNo").val();
}
function confirmDelete(mode,id){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(mode,id);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
}
function doSearch(mode,id){
	$("#pageNo").val("1");
	doAction(mode,id);
}
function doAction(mode,id){
	$("#mode").val(mode);
	if(mode=='deleteItems'){
		$("#prpIdArray").val(id);
	}else if(mode!='search'){
		$("#prpId").val(id);
	}else {
		$("#prpId").val("0");
	}
	$.post("roadpump/search",$("#roadPumpForm").serialize(), function(data) {
		  // alert(data);
		    appendContent(data);
		  // alert($("#_content").html());
		});
}
function exportReport1(){
	var time_from =jQuery.trim($("#time_from").val()); 
	//alert(time_from)
//	return false;
	if(time_from.length==0){
		 alert('กรุณากรอก From');   
	        return false;
	    }
	/* var time_to =jQuery.trim($("#time_to").val()); 
	if(time_to.length==0){
		 alert('กรุณากรอก To');   
	        return false;
	    }
	  */
/* 	var time_from_array=time_from.replace(/\//g,"_"); 
	var time_to_array=time_to.replace(/\//g,"_"); */
	var time_from_array=time_from.replace(/ /g,"_"); 
	// var time_to_array=time_to.replace(/\//g,"_");
	//alert(time_from_array)
	//alert(time_from_array+","+time_to_array)
	// return false;
	var src = "report/export_report1";
	//var src = "report/export_report2";
	//src=src+"?from="+time_from_array+"&to="+time_to_array;
	src=src+"?from="+time_from_array;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
</script> 
  <div id="message_element" class="alert alert-${message_class}" style="display: none;padding-top:10px">
    <button class="close" data-dismiss="alert"><span style="font-size: 12px">x</span></button>
    <strong>${message}</strong> 
  </div>
<div id="dialog-confirmDelete" title="Delete Costs" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Road pump ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
 <form id="roadPumpForm" name="roadPumpForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" >
          
            <div align="left">
            <strong>สรุปค่าแรงพนักงานรายวัน</strong>
            </div>
            <div align="left" style="padding: 10px 10px">
            	<span style="font-size: 13px;">เลือกเดือน:</span> 
            	<span style="padding: 20px">
            	<input type="text"  id="time_from" style="height: 30;width:120px" readonly="true"/>
            	</span>  
	    	<!-- 	<span style="font-size: 13px;">To:</span> 
            	<span style="padding: 20px">
            		<input type="text"  id="time_to" style="height: 30;width:85px" readonly="true"/>
            	</span>  
            	<span style="font-size: 13px;"></span>  -->
            	<span style="padding-left: 10px">
            	<a class="btn btn-primary" style="margin-top:-12px;" onclick="exportReport1()">&nbsp;Export&nbsp;</a>
            	<%-- <form:select path="pstRoadPump.pstRoadPumpStatus.prpsId">
    						 <form:option value="0">-- Select Status --</form:option>
    						 <form:options items="${pstRoadPumpStatuses}" itemLabel="prpsName" itemValue="prpsId"></form:options>
	    					     
    			</form:select> --%>
            	<!-- <select id="mcaStatus" name="mcaStatus">
	    					      <option value="-1">-- เลือก --</option>
	    					      <option value="1">1</option>
	    					      <option value="2">2</option>
	    		</select> -->
            	</span>
            </div>
	    					</form>  
      </fieldset> 