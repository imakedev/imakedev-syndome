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
	
});

function exportReport3(){
	var time_from =jQuery.trim($("#time_from").val()); 

	if(time_from.length==0){
		 alert('กรุณากรอก From');   
	        return false;
	    }
	var time_from_array=time_from.replace(/ /g,"_"); 
	
	var src = "report/export_report4";

	src=src+"?from="+time_from_array;
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
</script> 
<fieldset style="font-family: sans-serif;padding-top:5px">
 <form id="roadPumpForm" name="roadPumpForm" class="well" style="border:2px solid #B3D2EE;background: #F9F9F9" >
          
            <div align="left">
            <strong>สถิติเบรคดาวน์ประจำเดือน</strong>
            </div>
            <div align="left" style="padding: 10px 10px">
           <span style="font-size: 13px;">เลือกเดือน:</span> 
            	<span style="padding: 20px">
            	<input type="text"  id="time_from" style="height: 30;width:120px" readonly="true"/>
            	</span>  
            	<span style="padding-left: 10px">
            	<a class="btn btn-primary" style="margin-top:-12px;" onclick="exportReport3()">&nbsp;Export&nbsp;</a>
            	</span>
            </div>
	    					</form>  
      </fieldset> 