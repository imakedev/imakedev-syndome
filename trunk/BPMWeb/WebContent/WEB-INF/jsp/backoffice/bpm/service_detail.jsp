<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authorize access="hasAnyRole('ROLE_QUOTATION_ACCOUNT')" var="isQuotationAccount"/>  

<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  }  
table > thead > tr > th
{
background	:#e5e5e5;
} 
 .bootbox { width: 1000px !important;}
 .modal{margin-left:-500px}
 .modal-body{max-height:550px}
 .modal.fade.in{top:1%}
  .aoe_small{width: 594px !important;margin-left:-290px}
 .aoe_width{width: 1000px !important;margin-left:-500px}
</style>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.printPage.js'/>"></script>
<script type="text/javascript">
function updateJobServicesConfirm(){
	bootbox.dialog("ต้องการแก้ใขข้อมูล ?",[{
	    "label" : "Ok",
	    "class" : "btn-primary",
	    "callback": function() {
	    	updateJobServices();
	    }
	 },
	 {
		 "label" : "Close",
	     "class" : "btn-danger"
		 }]);
}
function updateJobServices(){
	 var BCC_CUSTOMER_NAME = jQuery.trim($("#BCC_CUSTOMER_NAME").val());
	 var BCC_CONTACT = jQuery.trim($("#BCC_CONTACT").val());
	 var BCC_TEL = jQuery.trim($("#BCC_TEL").val());
	 var BCC_LOCATION = jQuery.trim($("#BCC_LOCATION").val());
	 var BCC_ADDR1 = jQuery.trim($("#BCC_ADDR1").val());
	 var BCC_ADDR2 = jQuery.trim($("#BCC_ADDR2").val());
	 var BCC_ADDR3 = jQuery.trim($("#BCC_ADDR3").val());
	 var BCC_PROVINCE = jQuery.trim($("#BCC_PROVINCE").val());
	 var BCC_ZIPCODE = jQuery.trim($("#BCC_ZIPCODE").val());
	 
	 var BCC_DUE_DATE = jQuery.trim($("#BCC_DUE_DATE").val());
	 BCC_DUE_DATE=changeDateToStr(BCC_DUE_DATE);
		 
	 var BCC_DUE_DATE_START = jQuery.trim($("#BCC_DUE_DATE_START").val());
	 var BCC_DUE_DATE_END = jQuery.trim($("#BCC_DUE_DATE_END").val());
	 var BCC_REMARK = jQuery.trim($("#BCC_REMARK").val());
	 
	var query=" UPDATE "+SCHEMA_G+".BPM_CALL_CENTER SET "+ 
	 " BCC_CUSTOMER_NAME   = '"+BCC_CUSTOMER_NAME+"' , "+  
	// On Site
	 " BCC_CONTACT   = '"+BCC_CONTACT+"' , "+ 
	 " BCC_TEL    = '"+BCC_TEL+"' , "+ 
	 " BCC_LOCATION  = '"+BCC_LOCATION+"' , "+ 
	 " BCC_ADDR1    = '"+BCC_ADDR1+"' , "+  
	 " BCC_ADDR2   = '"+BCC_ADDR2+"' , "+ 
	  " BCC_ADDR3    = '"+BCC_ADDR3+"' , "+  
	 " BCC_PROVINCE  = '"+BCC_PROVINCE+"' , "+
	" BCC_REMARK    = '"+BCC_REMARK+"' , "; 
	 //duedate
	 if(BCC_DUE_DATE.length>0){
			query=query+" BCC_DUE_DATE='"+BCC_DUE_DATE+"' , ";
		}else
			query=query+" BCC_DUE_DATE=null  , ";
	 	 
	 if(BCC_DUE_DATE_START.length>0){
			query=query+" BCC_DUE_DATE_START='"+BCC_DUE_DATE_START+"' , ";
		}else
			query=query+" BCC_DUE_DATE_START=null  , ";
	 if(BCC_DUE_DATE_END.length>0){
			query=query+" BCC_DUE_DATE_END='"+BCC_DUE_DATE_END+"' , ";
		}else
			query=query+" BCC_DUE_DATE_END=null  , ";
	 
	 query=query+" BCC_ZIPCODE    = '"+BCC_ZIPCODE+"'   ";
	  
		query=query+" WHERE BCC_NO = '${bccNo}' "; 
	 
		 var SBJ_ONSITE_DETECTED = jQuery.trim($("#SBJ_ONSITE_DETECTED").val());
		 var SBJ_ONSITE_CAUSE = jQuery.trim($("#SBJ_ONSITE_CAUSE").val());
		 var SBJ_ONSITE_SOLUTION = jQuery.trim($("#SBJ_ONSITE_SOLUTION").val());
		 var SBJ_ONSITE_IS_GET_BACK = jQuery.trim($("input[id=SBJ_ONSITE_IS_GET_BACK]:checked" ).val());
		 SBJ_ONSITE_IS_GET_BACK=(SBJ_ONSITE_IS_GET_BACK.length>0)?SBJ_ONSITE_IS_GET_BACK:"0";
		 
		 var SBJ_ONSITE_IS_REPLACE = jQuery.trim($("input[id=SBJ_ONSITE_IS_REPLACE]:checked" ).val());
		 SBJ_ONSITE_IS_REPLACE=(SBJ_ONSITE_IS_REPLACE.length>0)?SBJ_ONSITE_IS_REPLACE:"0";
		 
		 var SBJ_ONSITE_IS_SPARE = jQuery.trim($("input[id=SBJ_ONSITE_IS_SPARE]:checked" ).val());
		 SBJ_ONSITE_IS_SPARE=(SBJ_ONSITE_IS_SPARE.length>0)?SBJ_ONSITE_IS_SPARE:"0";
		  
		 var SBJ_ONSITE_BATTERY_AMOUNT = jQuery.trim($("#SBJ_ONSITE_BATTERY_AMOUNT").val());
		 var SBJ_ONSITE_BATTERY_YEAR = jQuery.trim($("#SBJ_ONSITE_BATTERY_YEAR").val());
		 var SBJ_ONSITE_IS_BATTERRY = jQuery.trim($("input[id=SBJ_ONSITE_IS_BATTERRY]:checked" ).val());
		 SBJ_ONSITE_IS_BATTERRY=(SBJ_ONSITE_IS_BATTERRY.length>0)?SBJ_ONSITE_IS_BATTERRY:"0";
		  
		 // SC
		  var SBJ_SC_DETECTED = jQuery.trim($("#SBJ_SC_DETECTED").val());
		 var SBJ_SC_CAUSE = jQuery.trim($("#SBJ_SC_CAUSE").val());
		 var SBJ_SC_SOLUTION = jQuery.trim($("#SBJ_SC_SOLUTION").val());
		 var SBJ_SC_IS_CHANGE_ITEM   = jQuery.trim($("input[id=SBJ_SC_IS_CHANGE_ITEM]:checked" ).val());
		 SBJ_SC_IS_CHANGE_ITEM=(SBJ_SC_IS_CHANGE_ITEM.length>0)?SBJ_SC_IS_CHANGE_ITEM:"0";
		 
		 var SBJ_SC_IS_CHARGE   = jQuery.trim($("input[id=SBJ_SC_IS_CHARGE]:checked" ).val());
		 SBJ_SC_IS_CHARGE=(SBJ_SC_IS_CHARGE.length>0)?SBJ_SC_IS_CHARGE:"0";
		 
		 var SBJ_SC_IS_RECOMMEND= jQuery.trim($("input[id=SBJ_SC_IS_RECOMMEND]:checked" ).val());
		 SBJ_SC_IS_RECOMMEND=(SBJ_SC_IS_RECOMMEND.length>0)?SBJ_SC_IS_RECOMMEND:"0";
		 
		 // รับเครื่องกลับ
		 var SBJ_GET_BACK_1 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_1"]:checked').val());  
		 var SBJ_GET_BACK_2 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_2"]:checked').val());  
		 var SBJ_GET_BACK_3 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_3"]:checked').val());  
		 var SBJ_GET_BACK_4 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_4"]:checked').val());  
		 var SBJ_GET_BACK_EXT = jQuery.trim($("#SBJ_GET_BACK_EXT").val());
		
		 // ยืม 
		 var SBJ_BORROW_ACTOR = jQuery.trim($("#SBJ_BORROW_ACTOR").val());
		 var SBJ_BORROW_APPROVER = jQuery.trim($("#SBJ_BORROW_APPROVER").val());
		 var SBJ_BORROW_SENDER = jQuery.trim($("#SBJ_BORROW_SENDER").val());
		 var SBJ_BORROW_RECEIVER = jQuery.trim($("#SBJ_BORROW_RECEIVER").val());
		 var SBJ_BORROW_ACTOR_DATE = jQuery.trim($("#SBJ_BORROW_ACTOR_DATE").val());
		 var SBJ_BORROW_SERAIL = jQuery.trim($("#SBJ_BORROW_SERAIL").val());
		 SBJ_BORROW_ACTOR_DATE=changeDateToStr(SBJ_BORROW_ACTOR_DATE);
		  
		 var SBJ_BORROW_APPROVER_DATE = jQuery.trim($("#SBJ_BORROW_APPROVER_DATE").val());
		 SBJ_BORROW_APPROVER_DATE=changeDateToStr(SBJ_BORROW_APPROVER_DATE);
		 
		 var SBJ_BORROW_SENDER_DATE = jQuery.trim($("#SBJ_BORROW_SENDER_DATE").val());
		 SBJ_BORROW_SENDER_DATE=changeDateToStr(SBJ_BORROW_SENDER_DATE);
		 
		 var SBJ_BORROW_RECEIVER_DATE = jQuery.trim($("#SBJ_BORROW_RECEIVER_DATE").val());
		 SBJ_BORROW_RECEIVER_DATE=changeDateToStr(SBJ_BORROW_RECEIVER_DATE);
		 
		 var SBJ_BORROW_IS_REPAIR_SITE = jQuery.trim($("input[id=SBJ_BORROW_IS_REPAIR_SITE]:checked" ).val());
		 SBJ_BORROW_IS_REPAIR_SITE=(SBJ_BORROW_IS_REPAIR_SITE.length>0)?SBJ_BORROW_IS_REPAIR_SITE:"0";
		 
		 var SBJ_BORROW_IS_SPARE = jQuery.trim($("input[id=SBJ_BORROW_IS_SPARE]:checked" ).val());
		 SBJ_BORROW_IS_SPARE=(SBJ_BORROW_IS_SPARE.length>0)?SBJ_BORROW_IS_SPARE:"0";
		 
		 var SBJ_BORROW_IS_CHANGE = jQuery.trim($("input[id=SBJ_BORROW_IS_CHANGE]:checked" ).val());
		 SBJ_BORROW_IS_CHANGE=(SBJ_BORROW_IS_CHANGE.length>0)?SBJ_BORROW_IS_CHANGE:"0";
		 
		 
		 // ตรวจเช็ค
		  var SBJ_CHECKER_1_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_1_IS_PASS]:checked" ).val());
		  SBJ_CHECKER_1_IS_PASS=(SBJ_CHECKER_1_IS_PASS.length>0)?SBJ_CHECKER_1_IS_PASS:"0";
			 
		 var SBJ_CHECKER_1_VALUE = jQuery.trim($("#SBJ_CHECKER_1_VALUE").val());
		 var SBJ_CHECKER_2_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_2_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_2_IS_PASS=(SBJ_CHECKER_2_IS_PASS.length>0)?SBJ_CHECKER_2_IS_PASS:"0";
		 
		 var SBJ_CHECKER_2_VALUE = jQuery.trim($("#SBJ_CHECKER_2_VALUE").val());
		 var SBJ_CHECKER_3_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_3_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_3_IS_PASS=(SBJ_CHECKER_3_IS_PASS.length>0)?SBJ_CHECKER_3_IS_PASS:"0";
		 
		 var SBJ_CHECKER_3_VALUE = jQuery.trim($("#SBJ_CHECKER_3_VALUE").val());
		 var SBJ_CHECKER_4_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_4_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_4_IS_PASS=(SBJ_CHECKER_4_IS_PASS.length>0)?SBJ_CHECKER_4_IS_PASS:"0";
		 
		 var SBJ_CHECKER_4_VALUE = jQuery.trim($("#SBJ_CHECKER_4_VALUE").val());
		 var SBJ_CHECKER_5_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_5_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_5_IS_PASS=(SBJ_CHECKER_5_IS_PASS.length>0)?SBJ_CHECKER_5_IS_PASS:"0";
		 
		 var SBJ_CHECKER_5_VALUE = jQuery.trim($("#SBJ_CHECKER_5_VALUE").val());
		 var SBJ_CHECKER_6_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_6_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_6_IS_PASS=(SBJ_CHECKER_6_IS_PASS.length>0)?SBJ_CHECKER_6_IS_PASS:"0";
		 
		 var SBJ_CHECKER_6_VALUE = jQuery.trim($("#SBJ_CHECKER_6_VALUE").val());
		 var SBJ_CHECKER_7_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_7_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_7_IS_PASS=(SBJ_CHECKER_7_IS_PASS.length>0)?SBJ_CHECKER_7_IS_PASS:"0";
		 
		 var SBJ_CHECKER_7_VALUE = jQuery.trim($("#SBJ_CHECKER_7_VALUE").val());
		 var SBJ_CHECKER_8_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_8_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_8_IS_PASS=(SBJ_CHECKER_8_IS_PASS.length>0)?SBJ_CHECKER_8_IS_PASS:"0";
		 
		 var SBJ_CHECKER_8_VALUE = jQuery.trim($("#SBJ_CHECKER_8_VALUE").val());
		 var SBJ_CHECKER_9_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_9_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_9_IS_PASS=(SBJ_CHECKER_9_IS_PASS.length>0)?SBJ_CHECKER_9_IS_PASS:"0";
		 
		 var SBJ_CHECKER_10_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_10_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_10_IS_PASS=(SBJ_CHECKER_10_IS_PASS.length>0)?SBJ_CHECKER_10_IS_PASS:"0";
		 
		 var SBJ_CHECKER_11_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_11_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_11_IS_PASS=(SBJ_CHECKER_11_IS_PASS.length>0)?SBJ_CHECKER_11_IS_PASS:"0";
		 
		 var SBJ_CHECKER_12_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_12_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_12_IS_PASS=(SBJ_CHECKER_12_IS_PASS.length>0)?SBJ_CHECKER_12_IS_PASS:"0";
		 
		 var SBJ_CHECKER_13_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_13_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_13_IS_PASS=(SBJ_CHECKER_13_IS_PASS.length>0)?SBJ_CHECKER_13_IS_PASS:"0";
		 
		 var SBJ_CHECKER_14_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_14_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_14_IS_PASS=(SBJ_CHECKER_14_IS_PASS.length>0)?SBJ_CHECKER_14_IS_PASS:"0";
		 
		 var SBJ_CHECKER_15_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_15_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_15_IS_PASS=(SBJ_CHECKER_15_IS_PASS.length>0)?SBJ_CHECKER_15_IS_PASS:"0";
		 
		 var SBJ_CHECKER_16_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_16_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_16_IS_PASS=(SBJ_CHECKER_16_IS_PASS.length>0)?SBJ_CHECKER_16_IS_PASS:"0";
		 
		 var SBJ_CHECKER_17_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_17_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_17_IS_PASS=(SBJ_CHECKER_17_IS_PASS.length>0)?SBJ_CHECKER_17_IS_PASS:"0";
		 
		 var SBJ_CHECKER_18_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_18_IS_PASS]:checked" ).val());
		 SBJ_CHECKER_18_IS_PASS=(SBJ_CHECKER_18_IS_PASS.length>0)?SBJ_CHECKER_18_IS_PASS:"0";
		 
		 var SBJ_CHECKER_19_VALUE = jQuery.trim($("#SBJ_CHECKER_19_VALUE").val());
		 var SBJ_CHECKER_20_VALUE = jQuery.trim($("#SBJ_CHECKER_20_VALUE").val());
		 var SBJ_CHECKER_21_VALUE = jQuery.trim($("#SBJ_CHECKER_21_VALUE").val());
		 var SBJ_CHECKER_22_VALUE = jQuery.trim($("#SBJ_CHECKER_22_VALUE").val());
		 var SBJ_CHECKER_EXT_VALUE = jQuery.trim($("#SBJ_CHECKER_EXT_VALUE").val());
		 
		 // Sale
		  var SBJ_IS_REPAIR = jQuery.trim($('input:radio[name="SBJ_IS_REPAIR"]:checked').val()); 
		  var SBJ_CONFIRM_REPAIR_DATE = jQuery.trim($("#SBJ_CONFIRM_REPAIR_DATE").val());
		  SBJ_CONFIRM_REPAIR_DATE=changeDateToStr(SBJ_CONFIRM_REPAIR_DATE);
			
		  var SBJ_CUSTOMER_CONFIRM_REPAIR = jQuery.trim($("#SBJ_CUSTOMER_CONFIRM_REPAIR").val());
			
		 // Close Job
		  var SBJ_CLOSE_DATE = jQuery.trim($("#SBJ_CLOSE_DATE").val()); 
		  SBJ_CLOSE_DATE=changeDateToStr(SBJ_CLOSE_DATE);
		 var SBJ_CLOSE_ACTOR = jQuery.trim($("#SBJ_CLOSE_ACTOR").val());
		 
		 // Update Actor
		 var SBJ_SYNDOME_RECIPIENT = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT").val());
		 var SBJ_SYNDOME_RECIPIENT_DATE = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_DATE").val());
		 SBJ_SYNDOME_RECIPIENT_DATE=changeDateToStr(SBJ_SYNDOME_RECIPIENT_DATE);
			 
		 var SBJ_SYNDOME_RECIPIENT_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_TIME_IN").val());
		 var SBJ_SYNDOME_RECIPIENT_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_TIME_OUT").val());
		 var SBJ_CUSTOMER_SEND = jQuery.trim($("#SBJ_CUSTOMER_SEND").val());
		 var SBJ_CUSTOMER_SEND_DATE = jQuery.trim($("#SBJ_CUSTOMER_SEND_DATE").val());
		 SBJ_CUSTOMER_SEND_DATE=changeDateToStr(SBJ_CUSTOMER_SEND_DATE);
			
		 var SBJ_CUSTOMER_SEND_TIME_IN = jQuery.trim($("#SBJ_CUSTOMER_SEND_TIME_IN").val());
		 var SBJ_CUSTOMER_SEND_TIME_OUT = jQuery.trim($("#SBJ_CUSTOMER_SEND_TIME_OUT").val());
		 var SBJ_SYNDOME_ENGINEER = jQuery.trim($("#SBJ_SYNDOME_ENGINEER").val());
		 var SBJ_SYNDOME_ENGINEER_DATE = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_DATE").val());
		 SBJ_SYNDOME_ENGINEER_DATE=changeDateToStr(SBJ_SYNDOME_ENGINEER_DATE);
		 
		 var SBJ_SYNDOME_ENGINEER_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_TIME_IN").val());
		 var SBJ_SYNDOME_ENGINEER_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_TIME_OUT").val());
		 
		 var SBJ_SYNDOME_ENGINEER2 = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2").val());
		 var SBJ_SYNDOME_ENGINEER2_DATE = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_DATE").val());
		 SBJ_SYNDOME_ENGINEER2_DATE=changeDateToStr(SBJ_SYNDOME_ENGINEER2_DATE);
		 
		 var SBJ_SYNDOME_ENGINEER2_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_TIME_IN").val());
		 var SBJ_SYNDOME_ENGINEER2_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_TIME_OUT").val());
		 
		 var SBJ_SYNDOME_SEND = jQuery.trim($("#SBJ_SYNDOME_SEND").val());
		 var SBJ_SYNDOME_SEND_RFE_NO = jQuery.trim($("#SBJ_SYNDOME_SEND_RFE_NO").val());
		 var SBJ_SYNDOME_SEND_DATE = jQuery.trim($("#SBJ_SYNDOME_SEND_DATE").val());
		 SBJ_SYNDOME_SEND_DATE=changeDateToStr(SBJ_SYNDOME_SEND_DATE);
		 
		 var SBJ_SYNDOME_SEND_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_SEND_TIME_IN").val());
		 var SBJ_SYNDOME_SEND_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_SEND_TIME_OUT").val());
		 var SBJ_CUSTOMER_RECIPIENT = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT").val());
		 var SBJ_CUSTOMER_RECIPIENT_DATE = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_DATE").val());
		 SBJ_CUSTOMER_RECIPIENT_DATE=changeDateToStr(SBJ_CUSTOMER_RECIPIENT_DATE);
		 
		 var SBJ_CUSTOMER_RECIPIENT_TIME_IN = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_TIME_IN").val());
		 var SBJ_CUSTOMER_RECIPIENT_TIME_OUT = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_TIME_OUT").val());
		
		  //Status
		 // var SBJ_DEPT_ID = jQuery.trim($("#SBJ_DEPT_ID").val()); 
		  
		 var SBJ_DEPT_ID = jQuery.trim($("input[name=SBJ_DEPT_ID]:checked" ).val());
		 var SBJ_JOB_STATUS = jQuery.trim($("#SBJ_JOB_STATUS").val());
		 var BSJ_REMARK = jQuery.trim($("#BSJ_REMARK").val());
		 
		var query2=" UPDATE "+SCHEMA_G+".BPM_SERVICE_JOB SET "+ 
		 " BSJ_REMARK   = '"+BSJ_REMARK+"' , "+  
		// On Site
		 " SBJ_ONSITE_DETECTED   = '"+SBJ_ONSITE_DETECTED+"' , "+ 
		 " SBJ_ONSITE_CAUSE    = '"+SBJ_ONSITE_CAUSE+"' , "+ 
		 " SBJ_ONSITE_SOLUTION  = '"+SBJ_ONSITE_SOLUTION+"' , "+ 
		 " SBJ_ONSITE_IS_GET_BACK    = '"+SBJ_ONSITE_IS_GET_BACK+"' , "+  
		 " SBJ_ONSITE_IS_REPLACE   = '"+SBJ_ONSITE_IS_REPLACE+"' , "+ 
		  " SBJ_ONSITE_IS_SPARE    = '"+SBJ_ONSITE_IS_SPARE+"' , "+  
		 " SBJ_ONSITE_BATTERY_AMOUNT  = '"+SBJ_ONSITE_BATTERY_AMOUNT+"' , "+ 
		 " SBJ_ONSITE_BATTERY_YEAR    = '"+SBJ_ONSITE_BATTERY_YEAR+"' , "+ 
		 " SBJ_ONSITE_IS_BATTERRY    = '"+SBJ_ONSITE_IS_BATTERRY+"' , "+ 
		  
		 // SC
		  " SBJ_SC_DETECTED  = '"+SBJ_SC_DETECTED+"' , "+ 
		  " SBJ_SC_CAUSE =    '"+SBJ_SC_CAUSE+"' , "+ 
		  " SBJ_SC_SOLUTION =   '"+SBJ_SC_SOLUTION+"' , "+ 
		  " SBJ_SC_IS_CHANGE_ITEM    = '"+SBJ_SC_IS_CHANGE_ITEM+"' , "+   
		 " SBJ_SC_IS_CHARGE    = '"+SBJ_SC_IS_CHARGE+"' , "+   
		 " SBJ_SC_IS_RECOMMEND = '"+SBJ_SC_IS_RECOMMEND+"' , "+  
		 
		 // รับเครื่องกลับ
		 " SBJ_GET_BACK_1 = '"+SBJ_GET_BACK_1+"' , "+ 
		 " SBJ_GET_BACK_2 = '"+SBJ_GET_BACK_2+"' , "+ 
		 " SBJ_GET_BACK_3 = '"+SBJ_GET_BACK_3+"' , "+ 
		 " SBJ_GET_BACK_4 = '"+SBJ_GET_BACK_4+"' , "+ 
		 " SBJ_GET_BACK_EXT = '"+SBJ_GET_BACK_EXT+"' , "+ 
		
		 // ยืม
	     " SBJ_BORROW_ACTOR = '"+SBJ_BORROW_ACTOR+"' , "+ 
	     " SBJ_BORROW_APPROVER = '"+SBJ_BORROW_APPROVER+"' , "+ 
	     " SBJ_BORROW_SENDER = '"+SBJ_BORROW_SENDER+"' , "+ 
	     " SBJ_BORROW_RECEIVER = '"+SBJ_BORROW_RECEIVER+"' , ";
	     if(SBJ_BORROW_ACTOR_DATE.length>0){
	    	 query2=query2+" SBJ_BORROW_ACTOR_DATE='"+SBJ_BORROW_ACTOR_DATE+"' , ";
		}else
			query2=query2+" SBJ_BORROW_ACTOR_DATE=null  , ";
	    
	     if(SBJ_BORROW_APPROVER_DATE.length>0){
	    	 query2=query2+" SBJ_BORROW_APPROVER_DATE='"+SBJ_BORROW_APPROVER_DATE+"' , ";
			}else
				query2=query2+" SBJ_BORROW_APPROVER_DATE=null  , ";
		   
	     if(SBJ_BORROW_SENDER_DATE.length>0){
	    	 query2=query2+" SBJ_BORROW_SENDER_DATE='"+SBJ_BORROW_SENDER_DATE+"' , ";
			}else
				query2=query2+" SBJ_BORROW_SENDER_DATE=null  , ";
	      
		 if(SBJ_BORROW_RECEIVER_DATE.length>0){
			 query2=query2+" SBJ_BORROW_RECEIVER_DATE='"+SBJ_BORROW_RECEIVER_DATE+"' , ";
			}else
				query2=query2+" SBJ_BORROW_RECEIVER_DATE=null  , ";
		  
		 query2=query2+" SBJ_BORROW_IS_REPAIR_SITE = '"+SBJ_BORROW_IS_REPAIR_SITE+"' , "+ 
		  
		 " SBJ_BORROW_IS_SPARE = '"+SBJ_BORROW_IS_SPARE+"' , "+ 
		  
		 " SBJ_BORROW_IS_CHANGE = '"+SBJ_BORROW_IS_CHANGE+"' , "+ 
		 " SBJ_BORROW_SERAIL = '"+SBJ_BORROW_SERAIL+"' , "+ 
		 
		  
		 // ตรวจเช็ค
		  " SBJ_CHECKER_1_IS_PASS = '"+SBJ_CHECKER_1_IS_PASS+"' , "+  
		  " SBJ_CHECKER_1_VALUE = '"+SBJ_CHECKER_1_VALUE+"' , "+ 
		  " SBJ_CHECKER_2_IS_PASS = '"+SBJ_CHECKER_2_IS_PASS+"' , "+  
		 " SBJ_CHECKER_2_VALUE = '"+SBJ_CHECKER_2_VALUE+"' , "+ 
		 " SBJ_CHECKER_3_IS_PASS = '"+SBJ_CHECKER_3_IS_PASS+"' , "+   
		 " SBJ_CHECKER_3_VALUE = '"+SBJ_CHECKER_3_VALUE+"' , "+ 
		 " SBJ_CHECKER_4_IS_PASS = '"+SBJ_CHECKER_4_IS_PASS+"' , "+   
		 " SBJ_CHECKER_4_VALUE = '"+SBJ_CHECKER_4_VALUE+"' , "+ 
		 " SBJ_CHECKER_5_IS_PASS = '"+SBJ_CHECKER_5_IS_PASS+"' , "+   
		 " SBJ_CHECKER_5_VALUE = '"+SBJ_CHECKER_5_VALUE+"' , "+ 
		 " SBJ_CHECKER_6_IS_PASS = '"+SBJ_CHECKER_6_IS_PASS+"' , "+   
		 " SBJ_CHECKER_6_VALUE = '"+SBJ_CHECKER_6_VALUE+"' , "+ 
		 " SBJ_CHECKER_7_IS_PASS = '"+SBJ_CHECKER_7_IS_PASS+"' , "+   
		 " SBJ_CHECKER_7_VALUE = '"+SBJ_CHECKER_7_VALUE+"' , "+ 
		 " SBJ_CHECKER_8_IS_PASS = '"+SBJ_CHECKER_8_IS_PASS+"' , "+   
		 " SBJ_CHECKER_8_VALUE = '"+SBJ_CHECKER_8_VALUE+"' , "+ 
		 " SBJ_CHECKER_9_IS_PASS = '"+SBJ_CHECKER_9_IS_PASS+"' , "+   
		 " SBJ_CHECKER_10_IS_PASS = '"+SBJ_CHECKER_10_IS_PASS+"' , "+   
		 " SBJ_CHECKER_11_IS_PASS = '"+SBJ_CHECKER_11_IS_PASS+"' , "+   
		 " SBJ_CHECKER_12_IS_PASS = '"+SBJ_CHECKER_12_IS_PASS+"' , "+   
		 " SBJ_CHECKER_13_IS_PASS = '"+SBJ_CHECKER_13_IS_PASS+"' , "+    
		 " SBJ_CHECKER_14_IS_PASS = '"+SBJ_CHECKER_14_IS_PASS+"' , "+   
		 " SBJ_CHECKER_15_IS_PASS = '"+SBJ_CHECKER_15_IS_PASS+"' , "+   
		 " SBJ_CHECKER_16_IS_PASS = '"+SBJ_CHECKER_16_IS_PASS+"' , "+   
		 " SBJ_CHECKER_17_IS_PASS = '"+SBJ_CHECKER_17_IS_PASS+"' , "+   
		 " SBJ_CHECKER_18_IS_PASS = '"+SBJ_CHECKER_18_IS_PASS+"' , "+   
		 " SBJ_CHECKER_19_VALUE = '"+SBJ_CHECKER_19_VALUE+"' , "+ 
		 " SBJ_CHECKER_20_VALUE = '"+SBJ_CHECKER_20_VALUE+"' , "+ 
		 " SBJ_CHECKER_21_VALUE = '"+SBJ_CHECKER_21_VALUE+"' , "+ 
		 " SBJ_CHECKER_22_VALUE = '"+SBJ_CHECKER_22_VALUE+"' , "+ 

		
		 // Sale
		  " SBJ_IS_REPAIR = '"+SBJ_IS_REPAIR+"' , ";
		 if(SBJ_CONFIRM_REPAIR_DATE.length>0){
			 query2=query2+" SBJ_CONFIRM_REPAIR_DATE='"+SBJ_CONFIRM_REPAIR_DATE+"' , ";
			}else
				query2=query2+" SBJ_CONFIRM_REPAIR_DATE=null  , "; 
		 
		 query2=query2+" SBJ_CUSTOMER_CONFIRM_REPAIR = '"+SBJ_CUSTOMER_CONFIRM_REPAIR+"' , ";
			
		 // Close Job
		 /*
		  if(SBJ_CLOSE_DATE.length>0){
			  query2=query2+" SBJ_CLOSE_DATE='"+SBJ_CLOSE_DATE+"' , ";
			}else
				query2=query2+" SBJ_CLOSE_DATE=null  , ";  
		 */
		  query2=query2+" SBJ_CLOSE_ACTOR = '"+SBJ_CLOSE_ACTOR+"' , "+  
		 
		 // Update Actor
		 " SBJ_SYNDOME_RECIPIENT = '"+SBJ_SYNDOME_RECIPIENT+"' , "; 
		 if(SBJ_SYNDOME_RECIPIENT_DATE.length>0){
			 query2=query2+" SBJ_SYNDOME_RECIPIENT_DATE='"+SBJ_SYNDOME_RECIPIENT_DATE+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_RECIPIENT_DATE=null  , ";
		 	 
		 if(SBJ_SYNDOME_RECIPIENT_TIME_IN.length>0){
			 query2=query2+" SBJ_SYNDOME_RECIPIENT_TIME_IN='"+SBJ_SYNDOME_RECIPIENT_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_RECIPIENT_TIME_IN=null  , ";
		 if(SBJ_SYNDOME_RECIPIENT_TIME_OUT.length>0){
			 query2=query2+" SBJ_SYNDOME_RECIPIENT_TIME_OUT='"+SBJ_SYNDOME_RECIPIENT_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_RECIPIENT_TIME_OUT=null  , ";
		  
		 query2=query2+" SBJ_CUSTOMER_SEND = '"+SBJ_CUSTOMER_SEND+"' , "; 
		 if(SBJ_CUSTOMER_SEND_DATE.length>0){
			 query2=query2+" SBJ_CUSTOMER_SEND_DATE='"+SBJ_CUSTOMER_SEND_DATE+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_SEND_DATE=null  , ";
		 	 
		 if(SBJ_CUSTOMER_SEND_TIME_IN.length>0){
			 query2=query2+" SBJ_CUSTOMER_SEND_TIME_IN='"+SBJ_CUSTOMER_SEND_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_SEND_TIME_IN=null  , ";
		 if(SBJ_CUSTOMER_SEND_TIME_OUT.length>0){
			 query2=query2+" SBJ_CUSTOMER_SEND_TIME_OUT='"+SBJ_CUSTOMER_SEND_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_SEND_TIME_OUT=null  , ";
		 query2=query2+" SBJ_SYNDOME_ENGINEER = '"+SBJ_SYNDOME_ENGINEER+"' , ";  
		 if(SBJ_SYNDOME_ENGINEER_DATE.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER_DATE='"+SBJ_SYNDOME_ENGINEER_DATE+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER_DATE=null  , ";
		   
		 if(SBJ_SYNDOME_ENGINEER_TIME_IN.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER_TIME_IN='"+SBJ_SYNDOME_ENGINEER_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER_TIME_IN=null  , ";
		 if(SBJ_SYNDOME_ENGINEER_TIME_OUT.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER_TIME_OUT='"+SBJ_SYNDOME_ENGINEER_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER_TIME_OUT=null  , ";
		 
		 query2=query2+" SBJ_SYNDOME_ENGINEER2 = '"+SBJ_SYNDOME_ENGINEER2+"' , ";  
		 if(SBJ_SYNDOME_ENGINEER2_DATE.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER2_DATE='"+SBJ_SYNDOME_ENGINEER2_DATE+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER2_DATE=null  , ";
		   
		 if(SBJ_SYNDOME_ENGINEER2_TIME_IN.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER2_TIME_IN='"+SBJ_SYNDOME_ENGINEER2_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER2_TIME_IN=null  , ";
		 if(SBJ_SYNDOME_ENGINEER2_TIME_OUT.length>0){
			 query2=query2+" SBJ_SYNDOME_ENGINEER2_TIME_OUT='"+SBJ_SYNDOME_ENGINEER2_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_ENGINEER2_TIME_OUT=null  , ";
		 
		 query2=query2+ " SBJ_SYNDOME_SEND = '"+SBJ_SYNDOME_SEND+"' , "+  
		 " SBJ_SYNDOME_SEND_RFE_NO = '"+SBJ_SYNDOME_SEND_RFE_NO+"' , ";
		 if(SBJ_SYNDOME_SEND_DATE.length>0){
			 query2=query2+" SBJ_SYNDOME_SEND_DATE='"+SBJ_SYNDOME_SEND_DATE+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_SEND_DATE=null  , "; 
		 if(SBJ_SYNDOME_SEND_TIME_IN.length>0){
			 query2=query2+" SBJ_SYNDOME_SEND_TIME_IN='"+SBJ_SYNDOME_SEND_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_SEND_TIME_IN=null  , ";
		 if(SBJ_SYNDOME_SEND_TIME_OUT.length>0){
			 query2=query2+" SBJ_SYNDOME_SEND_TIME_OUT='"+SBJ_SYNDOME_SEND_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_SYNDOME_SEND_TIME_OUT=null  , ";
		 query2=query2+" SBJ_CUSTOMER_RECIPIENT = '"+SBJ_CUSTOMER_RECIPIENT+"' , ";
		 if(SBJ_CUSTOMER_RECIPIENT_DATE.length>0){
			 query2=query2+" SBJ_CUSTOMER_RECIPIENT_DATE='"+SBJ_CUSTOMER_RECIPIENT_DATE+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_RECIPIENT_DATE=null  , "; 
		 if(SBJ_CUSTOMER_RECIPIENT_TIME_IN.length>0){
			 query2=query2+" SBJ_CUSTOMER_RECIPIENT_TIME_IN='"+SBJ_CUSTOMER_RECIPIENT_TIME_IN+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_RECIPIENT_TIME_IN=null  , ";
		 if(SBJ_CUSTOMER_RECIPIENT_TIME_OUT.length>0){
			 query2=query2+" SBJ_CUSTOMER_RECIPIENT_TIME_OUT='"+SBJ_CUSTOMER_RECIPIENT_TIME_OUT+"' , ";
			}else
				query2=query2+" SBJ_CUSTOMER_RECIPIENT_TIME_OUT=null  , ";
		
		/*
		  //Status
		  if(mode!='update'){
			  query2=query2+" SBJ_DEPT_ID = '"+SBJ_DEPT_ID+"' , "+  
		 	 " SBJ_JOB_STATUS = '"+SBJ_JOB_STATUS+"' ,  ";
		  }
		*/
		query2=query2+ " SBJ_CHECKER_EXT_VALUE = '"+SBJ_CHECKER_EXT_VALUE+"'  ";
		query2=query2+" WHERE BCC_NO = '${bccNo}' ";
	 	  
			
		var querys=[];
		//alert(query)
		querys.push(query);
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
						bootbox.dialog("แก้ใขข้อมูลเรียบร้อยแล้ว.",[{
						    "label" : "Ok",
						    "class" : "btn-primary",
						    "callback": function() {
						    	//loadDynamicPage('dispatcher/page/todolist')
						    }
						 }]);
					}
				}
			});
	 
}

function printJobServices(){
	 var src = "getJobServices/${bccNo}";
		//src=src+"?type="+type;
		window.open(src,"_bank");
		/*
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
		*/
}
$(document).ready(function() {  
	 var usernameG='${username}';
	 $(".btnPrint").printPage();
    getCallCenter(); 
    autoProvince("BCC_PROVINCE");
    $("#BCC_DUE_DATE" ).datepicker({
		showOn: "button",
		buttonImage: _path+"resources/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"dd/mm/yy" ,
		changeMonth: true,
		changeYear: true
	});
	 
	 $('#BCC_DUE_DATE_START').timepicker({
		    showPeriodLabels: false
	 });
	 $('#BCC_DUE_DATE_END').timepicker({
		    showPeriodLabels: false
	 }); 
	   
		 
	 $("#SBJ_SYNDOME_RECIPIENT_DATE" ).datepicker({
			showOn: "button",
			buttonImage: _path+"resources/images/calendar.gif",
			buttonImageOnly: true,
			dateFormat:"dd/mm/yy" ,
			changeMonth: true,
			changeYear: true
		});
		 
		 $('#SBJ_SYNDOME_RECIPIENT_TIME_IN').timepicker({
			    showPeriodLabels: false
		 });
		 $('#SBJ_SYNDOME_RECIPIENT_TIME_OUT').timepicker({
			    showPeriodLabels: false
		 }); 
		 
		 $("#SBJ_CUSTOMER_SEND_DATE" ).datepicker({
				showOn: "button",
				buttonImage: _path+"resources/images/calendar.gif",
				buttonImageOnly: true,
				dateFormat:"dd/mm/yy" ,
				changeMonth: true,
				changeYear: true
			});
			 
			 $('#SBJ_CUSTOMER_SEND_TIME_IN').timepicker({
				    showPeriodLabels: false
			 });
			 $('#SBJ_CUSTOMER_SEND_TIME_OUT').timepicker({
				    showPeriodLabels: false
			 }); 
			 
			 $("#SBJ_SYNDOME_ENGINEER_DATE" ).datepicker({
					showOn: "button",
					buttonImage: _path+"resources/images/calendar.gif",
					buttonImageOnly: true,
					dateFormat:"dd/mm/yy" ,
					changeMonth: true,
					changeYear: true
				});
				 
				 $('#SBJ_SYNDOME_ENGINEER_TIME_IN').timepicker({
					    showPeriodLabels: false
				 });
				 $('#SBJ_SYNDOME_ENGINEER_TIME_OUT').timepicker({
					    showPeriodLabels: false
				 });
				 
				 $("#SBJ_SYNDOME_ENGINEER2_DATE" ).datepicker({
						showOn: "button",
						buttonImage: _path+"resources/images/calendar.gif",
						buttonImageOnly: true,
						dateFormat:"dd/mm/yy" ,
						changeMonth: true,
						changeYear: true
					});
					 
					 $('#SBJ_SYNDOME_ENGINEER2_TIME_IN').timepicker({
						    showPeriodLabels: false
					 });
					 $('#SBJ_SYNDOME_ENGINEER2_TIME_OUT').timepicker({
						    showPeriodLabels: false
					 });
				 
				 $("#SBJ_SYNDOME_SEND_DATE" ).datepicker({
						showOn: "button",
						buttonImage: _path+"resources/images/calendar.gif",
						buttonImageOnly: true,
						dateFormat:"dd/mm/yy" ,
						changeMonth: true,
						changeYear: true
					});
					 
					 $('#SBJ_SYNDOME_SEND_TIME_IN').timepicker({
						    showPeriodLabels: false
					 });
					 $('#SBJ_SYNDOME_SEND_TIME_OUT').timepicker({
						    showPeriodLabels: false
					 }); 
					 $("#SBJ_CUSTOMER_RECIPIENT_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});
						 
					 $('#SBJ_CUSTOMER_RECIPIENT_TIME_IN').timepicker({
							    showPeriodLabels: false
						 });
					  $('#SBJ_CUSTOMER_RECIPIENT_TIME_OUT').timepicker({
							    showPeriodLabels: false
						 }); 
					  
					  $("#SBJ_CONFIRM_REPAIR_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});
					  $("#SBJ_BORROW_ACTOR_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});
					  $("#SBJ_BORROW_APPROVER_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});
					  $("#SBJ_BORROW_SENDER_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});
					  $("#SBJ_BORROW_RECEIVER_DATE" ).datepicker({
							showOn: "button",
							buttonImage: _path+"resources/images/calendar.gif",
							buttonImageOnly: true,
							dateFormat:"dd/mm/yy" ,
							changeMonth: true,
							changeYear: true
						});  
						 
	 var query=" SELECT mapping.SERIAL,product.IMA_ItemName , "+
	 " so.BSO_IS_DELIVERY,so.BSO_IS_INSTALLATION,so.BSO_IS_DELIVERY_INSTALLATION,so.BSO_IS_NO_DELIVERY ,so.BSO_IS_WARRANTY ,so.BSO_IS_PM_MA, "+
	 "  so.BSO_PM_MA,so.BSO_SLA "+
		"  ,so.BSO_DELIVERY_LOCATION "+
		"  ,so.BSO_DELIVERY_CONTACT "+
		"  ,so.BSO_DELIVERY_ADDR1 "+
		"  ,so.BSO_DELIVERY_ADDR2 "+
		"  ,so.BSO_DELIVERY_ADDR3 "+ 
		"  ,so.BSO_DELIVERY_PROVINCE "+
		"  ,so.BSO_DELIVERY_ZIPCODE  "+
		"  ,so.BSO_DELIVERY_TEL_FAX "+

		 " ,so.BSO_INSTALLATION_SITE_LOCATION "+
		"  ,so.BSO_INSTALLATION_CONTACT "+
		"  ,so.BSO_INSTALLATION_ADDR1 "+
		 "  ,so.BSO_INSTALLATION_ADDR2 "+
		"  ,so.BSO_INSTALLATION_ADDR3 "+
		"  ,so.BSO_INSTALLATION_PROVINCE "+
		"  ,so.BSO_INSTALLATION_ZIPCODE "+
		"  ,so.BSO_INSTALLATION_TEL_FAX "+
		" ,arms2.CUSNAM "+
		" ,so.CUSCOD "+ 
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_START,'%d/%m/%Y'),'')  "+
		" ,IFNULL(DATE_FORMAT(so.BSO_MA_END,'%d/%m/%Y'),'')  "+
		" ,IFNULL(so.BSO_MA_NO,'')  "+
		" ,datediff(IFNULL(DATE_FORMAT(so.BSO_MA_END,'%Y-%m-%d'),''),now())  "+ 
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping "+
	 " left join SYNDOME_BPM_DB.BPM_ARMAS  armas on "+
	 "  armas.cuscod=mapping.cuscod  "+
	 " left join SYNDOME_BPM_DB.BPM_SALE_ORDER so on  "+
	 "  so.BSO_ID= mapping.BSO_ID  "+
	 " left join SYNDOME_BPM_DB.BPM_PRODUCT product on "+
	 "   product.ima_itemid=mapping.ima_itemid "+
	 " left join SYNDOME_BPM_DB.BPM_ARMAS arms2 "+
	 " on so.CUSCOD=arms2.CUSCOD "+
	// " where auto_k=0 and serial like   ";
	 " where serial like   ";
	// var query="SELECT CUSCOD,CUSTYP,PRENAM,CUSNAM,ADDR01,ADDR02,ADDR03,ZIPCOD,TELNUM,CONTACT,CUSNAM2  FROM "+SCHEMA_G+".BPM_ARMAS where CUSCOD like "; 
	   $("#BCC_SERIAL" ).autocomplete({
			  source: function( request, response ) {    
				  //$("#pjCustomerNo").val(ui.item.label); 
				  var queryiner=query+" '%"+request.term+"%' limit 15";
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
						        	  label: item[0],
						        	  value: item[0] ,
						        	  IMA_ItemName: item[1],
						        	  BSO_IS_DELIVERY: item[2],
						        	  BSO_IS_INSTALLATION: item[3],
						        	  BSO_IS_DELIVERY_INSTALLATION: item[4],
						        	  BSO_IS_NO_DELIVERY: item[5],
						        	  BSO_IS_WARRANTY: item[6],
						        	  BSO_IS_PM_MA: item[7],
						        	  BSO_PM_MA: item[8],
						        	  BSO_SLA: item[9],
						        	  BSO_DELIVERY_LOCATION: item[10],
						        	  BSO_DELIVERY_CONTACT: item[11],
						        	  BSO_DELIVERY_ADDR1: item[12],
						        	  BSO_DELIVERY_ADDR2: item[13],
						        	  BSO_DELIVERY_ADDR3: item[14],
						        	  BSO_DELIVERY_PROVINCE: item[15],
						        	  BSO_DELIVERY_ZIPCODE: item[16],
						        	  BSO_DELIVERY_TEL_FAX: item[17],

						              BSO_INSTALLATION_SITE_LOCATION: item[18],
						        	  BSO_INSTALLATION_CONTACT: item[19],
						        	  BSO_INSTALLATION_ADDR1: item[20],
						        	  BSO_INSTALLATION_ADDR2: item[21],
						        	  BSO_INSTALLATION_ADDR3: item[22],
						        	  BSO_INSTALLATION_PROVINCE: item[23],
						        	  BSO_INSTALLATION_ZIPCODE: item[24],
						        	  BSO_INSTALLATION_TEL_FAX : item[25],
						        	  CUSNAM: item[26],
						              CUSCOD: item[27],
						              BSO_MA_START: item[28],
						              BSO_MA_END: item[29],
						              BSO_MA_NO: item[30],
						              datediff: item[31] 
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
				  $("#BCC_MODEL").val(ui.item.IMA_ItemName);
				  $("#BCC_CUSCODE").val(ui.item.CUSCOD);
				  
				  if(ui.item.datediff!=null && parseInt(ui.item.datediff)>0){ // อยู่ในประกัน 
					  if(ui.item.BSO_MA_NO!=''){ //have ma no  
						 // $("#BCC_IS_MA3").prop('checked', true);
						  $('input[name="radio1"][value="2"]').prop('checked', true);
					  
					  }else{ // not have ma no
						 // $("#BCC_IS_MA1").prop('checked', true); 
						  $('input[name="radio1"][value="1"]').prop('checked', true);
					  }
				  }else{
					  $('input[name="radio1"][value="0"]').prop('checked', true);
					  $('input[name="BCC_STATUS"][value="0"]').prop('checked', true);
					  
				  }
				  $("#BCC_MA_START").val(ui.item.BSO_MA_START);
				  $("#BCC_MA_END").val(ui.item.BSO_MA_END);
				  $("#BCC_MA_NO").val(ui.item.BSO_MA_NO);
				 /*
				  BSO_MA_START: item[28],
	              BSO_MA_END: item[29],
	              BSO_MA_NO: item[30],
	              datediff: item[31] 
				  BCC_MA_START
				  BCC_MA_END
				  BCC_MA_NO
				  */
				 /*
				  alert(ui.item.BSO_IS_DELIVERY);
				  alert(ui.item.BSO_IS_INSTALLATION)
				  alert(ui.item.BSO_IS_DELIVERY_INSTALLATION)
				  alert(ui.item.BSO_IS_NO_DELIVERY) 
				  alert(ui.item.BSO_IS_WARRANTY)
				  alert(ui.item.BSO_PM_MA)
				  */
				  var BCC_CONTACT="";
				  var BCC_TEL="";
				  var BCC_LOCATION="";
				  var BCC_ADDR1="";
				  var BCC_ADDR2="";
				  var BCC_ADDR3="";
				  var BCC_PROVINCE="";
				  var BCC_ZIPCODE="";
				  if(ui.item.BSO_IS_DELIVERY =='1'){
					  BCC_CONTACT=ui.item.BSO_DELIVERY_CONTACT;
					  BCC_TEL=ui.item.BSO_DELIVERY_TEL_FAX;
					  BCC_LOCATION=ui.item.BSO_DELIVERY_LOCATION;
					  BCC_ADDR1=  ui.item.BSO_DELIVERY_ADDR1 ;
					  BCC_ADDR2=  ui.item.BSO_DELIVERY_ADDR2 ;
					  BCC_ADDR3=  ui.item.BSO_DELIVERY_ADDR3 ;
					  BCC_PROVINCE=ui.item.BSO_DELIVERY_PROVINCE;
					  BCC_ZIPCODE=ui.item.BSO_DELIVERY_ZIPCODE;  

				  } 
				  else if(ui.item.BSO_IS_INSTALLATION =='1' || ui.item.BSO_IS_DELIVERY_INSTALLATION=='1'){ 
					  BCC_CONTACT=ui.item.BSO_INSTALLATION_CONTACT;
					  BCC_TEL=ui.item.BSO_INSTALLATION_TEL_FAX;
					  BCC_LOCATION=ui.item.BSO_INSTALLATION_SITE_LOCATION;
					  BCC_ADDR1=  ui.item.BSO_INSTALLATION_ADDR1 ;
					  BCC_ADDR2=  ui.item.BSO_INSTALLATION_ADDR2 ;
					  BCC_ADDR3=  ui.item.BSO_INSTALLATION_ADDR3 ;
					  BCC_PROVINCE=ui.item.BSO_INSTALLATION_PROVINCE;
					  BCC_ZIPCODE=ui.item.BSO_INSTALLATION_ZIPCODE;  
				  }
				
				  /* name="radio1"
					  id="BCC_IS_MA1"
					  */
				// $("input[name=radio1]").prop('checked', false);
				//  $("input[name=mygroup][value=" + value + "]").prop('checked', true);
				 
				//  alert(BSO_IS_PM_MA)
				   $("#BCC_SLA").val(ui.item.BSO_SLA);
				   $("#BCC_CUSTOMER_NAME").val(ui.item.CUSNAM);
				   $("#BCC_CONTACT").val(BCC_CONTACT); 
				   $("#BCC_TEL").val(BCC_TEL); 
				   $("#BCC_LOCATION").val(BCC_LOCATION); 
				   $("#BCC_ADDR1").val(BCC_ADDR1); 
				   $("#BCC_ADDR2").val(BCC_ADDR2);  
				   $("#BCC_ADDR3").val(BCC_ADDR3);  
				   $("#BCC_PROVINCE").val(BCC_PROVINCE);  
				   $("#BCC_ZIPCODE").val(BCC_ZIPCODE);  
				 /*  $("#CONTACT").val(ui.item.CONTACT); 
				  $("#CUSNAM").val(ui.item.CUSNAM); 
				  $("#ADDR01").val(ui.item.ADDR01+" "+ui.item.ADDR02);
				  $("#TELNUM").val(ui.item.TELNUM);   */
			      return false;
			  },
			  open: function() {
			    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			  },
			  close: function() {
			    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			  }
			}); 
	   for(var i=1 ;i<=7;i++){
			new AjaxUpload('SBJ_DOC_ATTACH_'+i, { 
		        action: 'upload/Services/${bccNo}_'+i,
				onSubmit : function(file , ext){
		            // Allow only images. You should add security check on the server-side.
				if (ext && /^(jpg|png|jpeg|gif|xls|xlsx|XLS|XLSX|pdf|PDF|docx|doc|DOCX|DOC)$/.test(ext)){
						/* Setting data */
						this.setData({
							'key': 'This string will be send with the file',
							'test':'chatchai'
						});					 
					//$('#candidate_photo').attr('src', _path+"resources/images/loading.gif");
					} else {					
						// extension is not allowed
						alert('Error: only images are allowed') ;
						// cancel upload
						return false;				
					}		
				},
				onComplete : function(file, response){ 
					var obj = jQuery.parseJSON(response);
					//alert(obj.filename)  
					//alert(obj.id)
					$("#SBJ_DOC_ATTACH_"+obj.id+"_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
					$("#SBJ_DOC_ATTACH_"+obj.id+"_SRC").html(obj.filename);
				     $("#SBJ_DOC_ATTACH_"+obj.id+"_SRC").attr("onclick","loadFile('getfile/Services/${bccNo}_"+obj.id+"/"+obj.hotlink+"')");
				     //alert($("#SBJ_DOC_ATTACH_"+i+"_SRC").html())
				}		
			}); 
		}	
}); 
function getCallCenter(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	} 
  if(isEdit){  
	  var query=" SELECT "+
	  " call_center.BCC_NO as c0 ,"+
	  " IFNULL(call_center.BCC_SERIAL,'') as c1,"+
	    " IFNULL(call_center.BCC_MODEL,'') as c2,"+
	    " IFNULL(call_center.BCC_CAUSE,'') as c3,"+
	    "  call_center.BCC_CREATED_TIME  as c4,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_CREATED_TIME,'%d/%m/%Y %H:%i'),'') as c5,"+
	    " IFNULL(call_center.BCC_SLA,'') as c6,"+
	    " IFNULL(call_center.BCC_IS_MA ,'') as c7,"+
	    " IFNULL(call_center.BCC_MA_NO ,'') as c8,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_START,'%d/%m/%Y'),'') as c9,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_MA_END,'%d/%m/%Y'),'') as c10,"+
	    " IFNULL(call_center.BCC_STATUS ,'') as c11,"+
	    " IFNULL(call_center.BCC_REMARK ,'') as c12,"+
	    " IFNULL(call_center.BCC_USER_CREATED ,'') as c13,"+
	    " IFNULL(call_center.BCC_DUE_DATE ,'') as c14,"+
	    " IFNULL(call_center.BCC_CONTACT ,'') as c15,"+
	    " IFNULL(call_center.BCC_TEL ,'') as c16,"+ 
	    //" IFNULL(arms.CUSNAM ,'') as c17,"+ //17
	    " IFNULL(call_center.BCC_CUSTOMER_NAME ,'') as c17,"+ //17
	    
	    " IFNULL(call_center.BCC_ADDR1 ,'') as c18,"+
	    " IFNULL(call_center.BCC_ADDR2 ,'') as c19,"+
	    " IFNULL(call_center.BCC_ADDR3 ,'') as c20,"+
	    " IFNULL(call_center.BCC_LOCATION ,'') as c21,"+
	    " IFNULL(call_center.BCC_PROVINCE ,'') as c22,"+
	    " IFNULL(call_center.BCC_ZIPCODE ,'') as c23,"+ 
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE,'%d/%m/%Y'),'') as c24, "+
	    " IFNULL(call_center.BCC_CUSCODE ,'') as c25,"+
	    " IFNULL(call_center.BCC_SALE_ID ,'') as c26,"+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_START,'%H:%i'),'') as c27, "+
	    " IFNULL(DATE_FORMAT(call_center.BCC_DUE_DATE_END,'%H:%i'),'') as c28, "+ 
	   " (select count(*)  FROM "+SCHEMA_G+".BPM_TO_DO_LIST todo "+ 
	   "	   where todo.btdl_ref=call_center.BCC_NO and todo.btdl_type='2') as c29, "+
	   " IFNULL(call_center.BCC_STATE ,'') as c30, "+
	   "IFNULL((select so.BSO_MA_TYPE from  "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING mapping    "+
	   " left join  "+SCHEMA_G+".BPM_SALE_ORDER so on   "+
	   " 	   so.BSO_ID= mapping.BSO_ID  where mapping.SERIAL=call_center.BCC_SERIAL "+
	   " and mapping.auto_k=0 ) ,'') as c31,"+
	    " IFNULL(service_job.BCC_NO ,'') as c32,"+
	    " IFNULL(service_job.BSJ_REMARK ,'') as c33,"+
	    " IFNULL(service_job.BSJ_FEEDBACK ,'') as c34,"+
	    " IFNULL(service_job.BSJ_RECOMMEND ,'') as c35,"+
	    " IFNULL(service_job.BSJ_CAUSE ,'') as c36,"+
	    " IFNULL(service_job.BSJ_SOLUTION ,'') as c37,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION1 ,'') as c38,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION2 ,'') as c39,"+
	    " IFNULL(service_job.BSJ_IS_SOLUTION3 ,'') as c40,"+
	    " IFNULL(service_job.BSJ_CREATED_TIME ,'') as c41,"+
	    " IFNULL(service_job.BSJ_STATE ,'') as c42 ,"+
	    " IFNULL(service_job.BSJ_STATUS ,'') as c43,"+
	    " IFNULL(service_job.SBJ_SYNDOME_RECIPIENT ,'') as c44,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_RECIPIENT_DATE,'%d/%m/%Y'),'') as c45, "+
	    " IFNULL(service_job.SBJ_SYNDOME_RECIPIENT_TIME_IN ,'') as c46,"+
	    " IFNULL(service_job.SBJ_SYNDOME_RECIPIENT_TIME_OUT ,'') as c47,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_SEND ,'') as c48,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_SEND_DATE,'%d/%m/%Y'),'') as c49, "+
	    " IFNULL(service_job.SBJ_CUSTOMER_SEND_TIME_IN ,'') as c50,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_SEND_TIME_OUT ,'') as c51,"+
	    " IFNULL(service_job.SBJ_SYNDOME_ENGINEER ,'') as c52,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_ENGINEER_DATE,'%d/%m/%Y'),'') as c53, "+
	    " IFNULL(service_job.SBJ_SYNDOME_ENGINEER_TIME_IN ,'') as c54,"+
	    " IFNULL(service_job.SBJ_SYNDOME_ENGINEER_TIME_OUT ,'') as c55,"+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND ,'') as c56,"+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND_RFE_NO ,'') as c57,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_SYNDOME_SEND_DATE,'%d/%m/%Y'),'') as c58, "+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND_TIME_IN ,'') as c59,"+
	    " IFNULL(service_job.SBJ_SYNDOME_SEND_TIME_OUT ,'') as c60,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_RECIPIENT ,'') as c61,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CUSTOMER_RECIPIENT_DATE,'%d/%m/%Y'),'') as c62, "+
	    " IFNULL(service_job.SBJ_CUSTOMER_RECIPIENT_TIME_IN ,'') as c63,"+
	    " IFNULL(service_job.SBJ_CUSTOMER_RECIPIENT_TIME_OUT ,'') as c64,"+ 
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CLOSE_DATE,'%d/%m/%Y'),'') as c65, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_CONFIRM_REPAIR_DATE,'%d/%m/%Y'),'') as c66, "+
	    " IFNULL(service_job.SBJ_CUSTOMER_CONFIRM_REPAIR ,'') as c67,"+
	    " IFNULL(service_job.SBJ_IS_REPAIR ,'') as c68,"+
	    " IFNULL(service_job.SBJ_CLOSE_ACTOR ,'') as c69,"+
	    " IFNULL(service_job.SBJ_GET_BACK_1 ,'') as c70,"+
	    " IFNULL(service_job.SBJ_GET_BACK_2 ,'') as c71,"+
	    " IFNULL(service_job.SBJ_GET_BACK_3 ,'') as c72,"+
	    " IFNULL(service_job.SBJ_GET_BACK_4 ,'') as c73,"+
	    " IFNULL(service_job.SBJ_GET_BACK_EXT ,'') as c74,"+
	    " IFNULL(service_job.SBJ_ONSITE_DETECTED ,'') as c75,"+
	    " IFNULL(service_job.SBJ_ONSITE_CAUSE ,'') as c76,"+
	    " IFNULL(service_job.SBJ_ONSITE_SOLUTION ,'') as c77,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_GET_BACK ,'') as c78,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_REPLACE ,'') as c79,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_SPARE ,'') as c80,"+
	    " IFNULL(service_job.SBJ_ONSITE_BATTERY_AMOUNT ,'') as c81,"+
	    " IFNULL(service_job.SBJ_ONSITE_BATTERY_YEAR ,'') as c82,"+
	    " IFNULL(service_job.SBJ_ONSITE_IS_BATTERRY ,'') as c83,"+
	    " IFNULL(service_job.SBJ_SC_DETECTED ,'') as c84,"+
	    " IFNULL(service_job.SBJ_SC_CAUSE ,'') as c85,"+
	    " IFNULL(service_job.SBJ_SC_SOLUTION ,'') as c86,"+
	    " IFNULL(service_job.SBJ_SC_IS_CHANGE_ITEM ,'') as c87,"+
	    " IFNULL(service_job.SBJ_SC_IS_CHARGE ,'') as c88,"+
	    " IFNULL(service_job.SBJ_SC_IS_RECOMMEND ,'') as c89,"+
	    " IFNULL(service_job.SBJ_BORROW_ACTOR ,'') as c90,"+
	    " IFNULL(service_job.SBJ_BORROW_APPROVER ,'') as c91,"+
	    " IFNULL(service_job.SBJ_BORROW_SENDER ,'') as c92,"+
	    " IFNULL(service_job.SBJ_BORROW_RECEIVER ,'') as c93,"+  
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_ACTOR_DATE,'%d/%m/%Y'),'') as c94, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_APPROVER_DATE,'%d/%m/%Y'),'') as c95, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_SENDER_DATE,'%d/%m/%Y'),'') as c96, "+
	    " IFNULL(DATE_FORMAT(service_job.SBJ_BORROW_RECEIVER_DATE,'%d/%m/%Y'),'') as c97, "+
	    " IFNULL(service_job.SBJ_BORROW_IS_REPAIR_SITE ,'') as c98,"+
	    " IFNULL(service_job.SBJ_BORROW_IS_SPARE ,'') as c99,"+
	    " IFNULL(service_job.SBJ_BORROW_IS_CHANGE ,'') as c100,"+
	    " IFNULL(service_job.SBJ_CHECKER_1_IS_PASS ,'') as c101,"+
	    " IFNULL(service_job.SBJ_CHECKER_1_VALUE ,'') as c102,"+
	    " IFNULL(service_job.SBJ_CHECKER_2_IS_PASS ,'') as c103,"+
	    " IFNULL(service_job.SBJ_CHECKER_2_VALUE ,'') as c104,"+
	    " IFNULL(service_job.SBJ_CHECKER_3_IS_PASS ,'') as c105,"+
	    " IFNULL(service_job.SBJ_CHECKER_3_VALUE ,'') as c106,"+
	    " IFNULL(service_job.SBJ_CHECKER_4_IS_PASS ,'') as c107,"+
	    " IFNULL(service_job.SBJ_CHECKER_4_VALUE ,'') as c108,"+
	    " IFNULL(service_job.SBJ_CHECKER_5_IS_PASS ,'') as c109,"+
	    " IFNULL(service_job.SBJ_CHECKER_5_VALUE ,'') as c110,"+
	    " IFNULL(service_job.SBJ_CHECKER_6_IS_PASS ,'') as c111,"+
	    " IFNULL(service_job.SBJ_CHECKER_6_VALUE ,'') as c112,"+
	    " IFNULL(service_job.SBJ_CHECKER_7_IS_PASS ,'') as c113,"+
	    " IFNULL(service_job.SBJ_CHECKER_7_VALUE ,'') as c114,"+
	    " IFNULL(service_job.SBJ_CHECKER_8_IS_PASS ,'') as c115,"+
	    " IFNULL(service_job.SBJ_CHECKER_8_VALUE ,'') as c116,"+
	    " IFNULL(service_job.SBJ_CHECKER_9_IS_PASS ,'') as c117,"+
	    " IFNULL(service_job.SBJ_CHECKER_10_IS_PASS ,'') as c118,"+
	    " IFNULL(service_job.SBJ_CHECKER_11_IS_PASS ,'') as c119,"+
	    " IFNULL(service_job.SBJ_CHECKER_12_IS_PASS ,'') as c120,"+
	    " IFNULL(service_job.SBJ_CHECKER_13_IS_PASS ,'') as c121,"+
	    " IFNULL(service_job.SBJ_CHECKER_14_IS_PASS ,'') as c122,"+
	    " IFNULL(service_job.SBJ_CHECKER_15_IS_PASS ,'') as c123,"+
	    " IFNULL(service_job.SBJ_CHECKER_16_IS_PASS ,'') as c124,"+
	    " IFNULL(service_job.SBJ_CHECKER_17_IS_PASS ,'') as c125,"+
	    " IFNULL(service_job.SBJ_CHECKER_18_IS_PASS ,'') as c126,"+
	    " IFNULL(service_job.SBJ_CHECKER_19_VALUE ,'') as c127,"+
	    " IFNULL(service_job.SBJ_CHECKER_20_VALUE ,'') as c128,"+
	    " IFNULL(service_job.SBJ_CHECKER_21_VALUE ,'') as c129,"+
	    " IFNULL(service_job.SBJ_CHECKER_22_VALUE ,'') as c130,"+
	    " IFNULL(service_job.SBJ_CHECKER_EXT_VALUE ,'') as c131 "+
	    /*
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_1 ,'') as c132, "+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_2 ,'') as c133,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_3 ,'') as c134,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_4 ,'') as c135,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_5 ,'') as c136,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_6 ,'') as c137,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_NAME_7 ,'') as c138,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_1 ,'') as c139,"+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_2 ,'') as c140, "+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_3 ,'') as c141, "+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_4 ,'') as c142,"+ 
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_5 ,'') as c143,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_6 ,'') as c144,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_PATH_7 ,'') as c145,"+
	  
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_1 ,'') as c146,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_2 ,'') as c147,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_3 ,'') as c148,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_4 ,'') as c149,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_5 ,'') as c150,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_6 ,'') as c151,"+
	    " IFNULL(service_job.SBJ_DOC_ATTACH_HOTLINK_7 ,'') as c152,"+
	    " IFNULL(service_job.SBJ_STATUS_JOB ,'') as c153,"+
	    " IFNULL(service_job.SBJ_DEPT_ID ,'') as c154,"+
	   
	    " IFNULL(service_job.SBJ_JOB_STATUS ,'') as c155 "+
	   */
	   " "+
	   " FROM "+SCHEMA_G+".BPM_CALL_CENTER call_center left join  "+
	   "  "+SCHEMA_G+".BPM_ARMAS arms   "+
	   " on call_center.BCC_CUSCODE=arms.CUSCOD "+
	   " left join  "+
	   "  "+SCHEMA_G+".BPM_SERVICE_JOB service_job   "+
	   " on call_center.BCC_NO=service_job.BCC_NO "+
	  // " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	  // " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where call_center.BCC_NO='${bccNo}'";
	  //  alert(query)
	 //  SynDomeBPMAjax.searchObject(query,{
		 SynDomeBPMAjax.searchServices('${bccNo}',{
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
					$("#BCC_NO").val(data[0][0]);
					 var BCC_SERIAL=data[0][1]; $("#BCC_SERIAL").val(BCC_SERIAL);
					 
					 var BCC_MODEL=data[0][2]; $("#BCC_MODEL").val(BCC_MODEL);
					 //alert(BCC_MODEL)
					 var BCC_CAUSE=data[0][3]; $("#BCC_CAUSE").val(BCC_CAUSE);
					 var BCC_CREATED_TIME=data[0][5]; $("#BCC_CREATED_TIME").val(BCC_CREATED_TIME);
					 var BCC_SLA=data[0][6]; $("#BCC_SLA").val(BCC_SLA);
					 var BCC_IS_MA=data[0][7]; $("#BCC_IS_MA").val(BCC_IS_MA);
					 // alert(BCC_IS_MA)
					 $("input[name=radio1][value=" + BCC_IS_MA + "]").prop('checked', true); 
					 var BCC_MA_NO=data[0][8]; $("#BCC_MA_NO").val(BCC_MA_NO);
					 var BCC_MA_START=data[0][9]; $("#BCC_MA_START").val(BCC_MA_START);
					 var BCC_MA_END=data[0][10]; $("#BCC_MA_END").val(BCC_MA_END);
					 var BCC_STATUS=data[0][11]; $("#BCC_STATUS").val(BCC_STATUS);
					 $("input[name=BCC_STATUS][value=" + BCC_STATUS + "]").prop('checked', true);
					 var BCC_REMARK=data[0][12]; $("#BCC_REMARK").val(BCC_REMARK);
					 var BCC_USER_CREATED=data[0][13]; $("#BCC_USER_CREATED").val(BCC_USER_CREATED);
					 var BCC_DUE_DATE=data[0][14]; $("#BCC_DUE_DATE").val(BCC_DUE_DATE);
					 var BCC_CONTACT=data[0][15]; $("#BCC_CONTACT").val(BCC_CONTACT);
					 var BCC_TEL=data[0][16]; $("#BCC_TEL").val(BCC_TEL); 
					 var BCC_CUSTOMER_NAME=data[0][17]; $("#BCC_CUSTOMER_NAME").val(BCC_CUSTOMER_NAME);
					// alert(BCC_CUSTOMER_NAME)
					 var BCC_ADDR1=data[0][18]; $("#BCC_ADDR1").val(BCC_ADDR1);
					 var BCC_ADDR2=data[0][19]; $("#BCC_ADDR2").val(BCC_ADDR2);
					 var BCC_ADDR3=data[0][20]; $("#BCC_ADDR3").val(BCC_ADDR3);
					 var BCC_LOCATION=data[0][21]; $("#BCC_LOCATION").val(BCC_LOCATION);
					 var BCC_PROVINCE=data[0][22]; $("#BCC_PROVINCE").val(BCC_PROVINCE);
					 var BCC_ZIPCODE=data[0][23]; $("#BCC_ZIPCODE").val(BCC_ZIPCODE);
					 var BCC_DUE_DATE=data[0][24]; $("#BCC_DUE_DATE").val(BCC_DUE_DATE);
					 var BCC_CUSCODE=data[0][25]; $("#BCC_CUSCODE").val(BCC_CUSCODE);
					 var BCC_SALE_ID=data[0][26]; $("#BCC_SALE_ID").val(BCC_SALE_ID);
					 var BCC_DUE_DATE_START=data[0][27]; $("#BCC_DUE_DATE_START").val(BCC_DUE_DATE_START);
					 var BCC_DUE_DATE_END=data[0][28]; $("#BCC_DUE_DATE_END").val(BCC_DUE_DATE_END);
					 
					 var BSJ_REMARK=data[0][33]; $("#BSJ_REMARK").val(BSJ_REMARK);
					// On Site
					 var SBJ_ONSITE_DETECTED=data[0][75]; $("#SBJ_ONSITE_DETECTED").val(SBJ_ONSITE_DETECTED);
					 var SBJ_ONSITE_CAUSE=data[0][76]; $("#SBJ_ONSITE_CAUSE").val(SBJ_ONSITE_CAUSE);
					 var SBJ_ONSITE_SOLUTION=data[0][77]; $("#SBJ_ONSITE_SOLUTION").val(SBJ_ONSITE_SOLUTION);
					 var SBJ_ONSITE_IS_GET_BACK=data[0][78]; 
					 $('input[id="SBJ_ONSITE_IS_GET_BACK"][value="'+SBJ_ONSITE_IS_GET_BACK+'"]').prop('checked', true);
					// $("#SBJ_ONSITE_IS_GET_BACK").val(SBJ_ONSITE_IS_GET_BACK); 
					 var SBJ_ONSITE_IS_REPLACE=data[0][79];// $("#SBJ_ONSITE_IS_REPLACE").val(SBJ_ONSITE_IS_REPLACE); 
					 $('input[id="SBJ_ONSITE_IS_REPLACE"][value="'+SBJ_ONSITE_IS_REPLACE+'"]').prop('checked', true);
					 var SBJ_ONSITE_IS_SPARE=data[0][80];// $("#SBJ_ONSITE_IS_SPARE").val(SBJ_ONSITE_IS_SPARE);
					 $('input[id="SBJ_ONSITE_IS_SPARE"][value="'+SBJ_ONSITE_IS_SPARE+'"]').prop('checked', true);
					 var SBJ_ONSITE_BATTERY_AMOUNT=data[0][81]; $("#SBJ_ONSITE_BATTERY_AMOUNT").val(SBJ_ONSITE_BATTERY_AMOUNT);
					 var SBJ_ONSITE_BATTERY_YEAR=data[0][82]; $("#SBJ_ONSITE_BATTERY_YEAR").val(SBJ_ONSITE_BATTERY_YEAR);
					 var SBJ_ONSITE_IS_BATTERRY=data[0][83]; //$("#SBJ_ONSITE_IS_BATTERRY").val(SBJ_ONSITE_IS_BATTERRY);
					 $('input[id="SBJ_ONSITE_IS_BATTERRY"][value="'+SBJ_ONSITE_IS_BATTERRY+'"]').prop('checked', true);
					 
					// SC
					   var SBJ_SC_DETECTED=data[0][84]; $("#SBJ_SC_DETECTED").val(SBJ_SC_DETECTED);  
					   var SBJ_SC_CAUSE=data[0][85]; $("#SBJ_SC_CAUSE").val(SBJ_SC_CAUSE);  
					   var SBJ_SC_SOLUTION=data[0][86];  $("#SBJ_SC_SOLUTION").val(SBJ_SC_SOLUTION);  
					   var SBJ_SC_IS_CHANGE_ITEM=data[0][87];// $("#SBJ_SC_IS_CHANGE_ITEM").val(SBJ_SC_IS_CHANGE_ITEM); 
					   $('input[id="SBJ_SC_IS_CHANGE_ITEM"][value="'+SBJ_SC_IS_CHANGE_ITEM+'"]').prop('checked', true);
					   var SBJ_SC_IS_CHARGE=data[0][88]; //$("#SBJ_SC_IS_CHARGE").val(SBJ_SC_IS_CHARGE); 
					   $('input[id="SBJ_SC_IS_CHARGE"][value="'+SBJ_SC_IS_CHARGE+'"]').prop('checked', true);
					   var SBJ_SC_IS_RECOMMEND=data[0][89]; //$("#SBJ_SC_IS_RECOMMEND").val(SBJ_SC_IS_RECOMMEND);  
					   $('input[id="SBJ_SC_IS_RECOMMEND"][value="'+SBJ_SC_IS_RECOMMEND+'"]').prop('checked', true);
					   
					// ยืม
					   var SBJ_BORROW_ACTOR=data[0][90]; $("#SBJ_BORROW_ACTOR").val(SBJ_BORROW_ACTOR);  
					   var SBJ_BORROW_APPROVER=data[0][91]; $("#SBJ_BORROW_APPROVER").val(SBJ_BORROW_APPROVER);   
					   var SBJ_BORROW_SENDER=data[0][92]; $("#SBJ_BORROW_SENDER").val(SBJ_BORROW_SENDER);   
					   var SBJ_BORROW_RECEIVER=data[0][93]; $("#SBJ_BORROW_RECEIVER").val(SBJ_BORROW_RECEIVER);   
					   var SBJ_BORROW_ACTOR_DATE=data[0][94]; $("#SBJ_BORROW_ACTOR_DATE").val(SBJ_BORROW_ACTOR_DATE);   
					   var SBJ_BORROW_APPROVER_DATE=data[0][95]; $("#SBJ_BORROW_APPROVER_DATE").val(SBJ_BORROW_APPROVER_DATE);   
					   var SBJ_BORROW_SENDER_DATE=data[0][96]; $("#SBJ_BORROW_SENDER_DATE").val(SBJ_BORROW_SENDER_DATE);    
					   var SBJ_BORROW_RECEIVER_DATE=data[0][97]; $("#SBJ_BORROW_RECEIVER_DATE").val(SBJ_BORROW_RECEIVER_DATE);    
					   var SBJ_BORROW_IS_REPAIR_SITE=data[0][98]; //$("#SBJ_BORROW_IS_REPAIR_SITE").val(SBJ_BORROW_IS_REPAIR_SITE);   c98,"+
					   $('input[id="SBJ_BORROW_IS_REPAIR_SITE"][value="'+SBJ_BORROW_IS_REPAIR_SITE+'"]').prop('checked', true);
					   var SBJ_BORROW_IS_SPARE=data[0][99]; // $("#SBJ_BORROW_IS_SPARE").val(SBJ_BORROW_IS_SPARE);   c99,"+
					   $('input[id="SBJ_BORROW_IS_SPARE"][value="'+SBJ_BORROW_IS_SPARE+'"]').prop('checked', true);
					   var SBJ_BORROW_IS_CHANGE=data[0][100]; // $("#SBJ_BORROW_IS_CHANGE").val(SBJ_BORROW_IS_CHANGE);   c100,"+
					   $('input[id="SBJ_BORROW_IS_CHANGE"][value="'+SBJ_BORROW_IS_CHANGE+'"]').prop('checked', true);
					   
					   // ตรวจเช็ค
					   var SBJ_CHECKER_1_IS_PASS=data[0][101]; 
					   $('input[id="SBJ_CHECKER_1_IS_PASS"][value="'+SBJ_CHECKER_1_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_1_VALUE=data[0][102]; $("#SBJ_CHECKER_1_VALUE").val(SBJ_CHECKER_1_VALUE);  
					  
					   var SBJ_CHECKER_2_IS_PASS=data[0][103];  
					   $('input[id="SBJ_CHECKER_2_IS_PASS"][value="'+SBJ_CHECKER_2_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_2_VALUE=data[0][104]; $("#SBJ_CHECKER_2_VALUE").val(SBJ_CHECKER_2_VALUE);  
					   var SBJ_CHECKER_3_IS_PASS=data[0][105];  
					   $('input[id="SBJ_CHECKER_3_IS_PASS"][value="'+SBJ_CHECKER_3_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_3_VALUE=data[0][106]; $("#SBJ_CHECKER_3_VALUE").val(SBJ_CHECKER_3_VALUE); 
					   var SBJ_CHECKER_4_IS_PASS=data[0][107];  
					   $('input[id="SBJ_CHECKER_4_IS_PASS"][value="'+SBJ_CHECKER_4_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_4_VALUE=data[0][108]; $("#SBJ_CHECKER_4_VALUE").val(SBJ_CHECKER_4_VALUE);  
					   var SBJ_CHECKER_5_IS_PASS=data[0][109];  
					   $('input[id="SBJ_CHECKER_5_IS_PASS"][value="'+SBJ_CHECKER_5_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_5_VALUE=data[0][110]; $("#SBJ_CHECKER_5_VALUE").val(SBJ_CHECKER_5_VALUE);  
					   var SBJ_CHECKER_6_IS_PASS=data[0][111]; 
					   $('input[id="SBJ_CHECKER_6_IS_PASS"][value="'+SBJ_CHECKER_6_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_6_VALUE=data[0][112]; $("#SBJ_CHECKER_6_VALUE").val(SBJ_CHECKER_6_VALUE);  
					   var SBJ_CHECKER_7_IS_PASS=data[0][113];  
					   $('input[id="SBJ_CHECKER_7_IS_PASS"][value="'+SBJ_CHECKER_7_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_7_VALUE=data[0][114]; $("#SBJ_CHECKER_7_VALUE").val(SBJ_CHECKER_7_VALUE);  
					   var SBJ_CHECKER_8_IS_PASS=data[0][115];  
					   $('input[id="SBJ_CHECKER_8_IS_PASS"][value="'+SBJ_CHECKER_8_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_8_VALUE=data[0][116]; $("#SBJ_CHECKER_8_VALUE").val(SBJ_CHECKER_8_VALUE);  
					   var SBJ_CHECKER_9_IS_PASS=data[0][117];  
					   $('input[id="SBJ_CHECKER_9_IS_PASS"][value="'+SBJ_CHECKER_9_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_10_IS_PASS=data[0][118];  
					   $('input[id="SBJ_CHECKER_10_IS_PASS"][value="'+SBJ_CHECKER_10_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_11_IS_PASS=data[0][119];  
					   $('input[id="SBJ_CHECKER_11_IS_PASS"][value="'+SBJ_CHECKER_11_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_12_IS_PASS=data[0][120];  
					   $('input[id="SBJ_CHECKER_12_IS_PASS"][value="'+SBJ_CHECKER_12_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_13_IS_PASS=data[0][121];  
					   $('input[id="SBJ_CHECKER_13_IS_PASS"][value="'+SBJ_CHECKER_13_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_14_IS_PASS=data[0][122];  
					   $('input[id="SBJ_CHECKER_14_IS_PASS"][value="'+SBJ_CHECKER_14_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_15_IS_PASS=data[0][123];  
					   $('input[id="SBJ_CHECKER_15_IS_PASS"][value="'+SBJ_CHECKER_15_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_16_IS_PASS=data[0][124];  
					   $('input[id="SBJ_CHECKER_16_IS_PASS"][value="'+SBJ_CHECKER_16_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_17_IS_PASS=data[0][125]; 
					   $('input[id="SBJ_CHECKER_17_IS_PASS"][value="'+SBJ_CHECKER_17_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_18_IS_PASS=data[0][125]; 
					   $('input[id="SBJ_CHECKER_18_IS_PASS"][value="'+SBJ_CHECKER_18_IS_PASS+'"]').prop('checked', true);
					   var SBJ_CHECKER_19_VALUE=data[0][127]; $("#SBJ_CHECKER_19_VALUE").val(SBJ_CHECKER_19_VALUE);  
					   var SBJ_CHECKER_20_VALUE=data[0][128]; $("#SBJ_CHECKER_20_VALUE").val(SBJ_CHECKER_20_VALUE);  
					   var SBJ_CHECKER_21_VALUE=data[0][129]; $("#SBJ_CHECKER_21_VALUE").val(SBJ_CHECKER_21_VALUE);  
					   var SBJ_CHECKER_22_VALUE=data[0][130]; $("#SBJ_CHECKER_22_VALUE").val(SBJ_CHECKER_22_VALUE);  
					   var SBJ_CHECKER_EXT_VALUE=data[0][131]; $("#SBJ_CHECKER_EXT_VALUE").val(SBJ_CHECKER_EXT_VALUE);  
					   var SBJ_BORROW_SERAIL=data[0][160]; $("#SBJ_BORROW_SERAIL").val(SBJ_BORROW_SERAIL);  
					   
	    // นำเครื่องกลับ
	    var SBJ_GET_BACK_1=data[0][70];//$("#SBJ_GET_BACK_1").val(SBJ_GET_BACK_1);  
	    $('input[name="SBJ_GET_BACK_1"][value="'+SBJ_GET_BACK_1+'"]').prop('checked', true);
	    var SBJ_GET_BACK_2=data[0][71]; //$("#SBJ_GET_BACK_2").val(SBJ_GET_BACK_2);  
	    $('input[name="SBJ_GET_BACK_2"][value="'+SBJ_GET_BACK_2+'"]').prop('checked', true);
	    var SBJ_GET_BACK_3=data[0][72]; //$("#SBJ_GET_BACK_3").val(SBJ_GET_BACK_3);  
	    $('input[name="SBJ_GET_BACK_3"][value="'+SBJ_GET_BACK_3+'"]').prop('checked', true);
	    var SBJ_GET_BACK_4=data[0][73];// $("#SBJ_GET_BACK_4").val(SBJ_GET_BACK_4);  
	    $('input[name="SBJ_GET_BACK_4"][value="'+SBJ_GET_BACK_4+'"]').prop('checked', true);
	    var SBJ_GET_BACK_EXT=data[0][74]; $("#SBJ_GET_BACK_EXT").val(SBJ_GET_BACK_EXT); 
	    
	    var SBJ_JOB_STATUS=data[0][155]; $("#SBJ_JOB_STATUS").val(SBJ_JOB_STATUS);
	    //alert(SBJ_JOB_STATUS+",xx")
	    <%-- 
		<option value="1">รับเครื่อง/เช็คไซต์</option>
		<option value="2">เสนอราคา</option>
		<option value="3">รออนุมัติซ่อม</option>
		<option value="4">ซ่อม</option>
		<option value="5">ส่งเครื่อง</option>
		<option value="6">ตรวจสอบเอกสาร</option>
		<option value="7">ปิดงานเรียบร้อย</option>
		--%>
		 $("#service_box7").css("opacity","0.3");
		 $("#service_box8").css("opacity","0.3");
		 $("#service_box10_2").hide(); 
		if(SBJ_JOB_STATUS=='1'){
			 $("#service_box4").css("opacity","0.3"); 
			 $("#service_box10").css("opacity","0.3"); 
			 //$("#service_box11").css("opacity","0.3"); 
		}else if(SBJ_JOB_STATUS=='2' || SBJ_JOB_STATUS=='3'){
			 for(var k=1;k<=11;k++){
				 $("#service_box"+k).css("opacity","0.3");
			 } 
			 $("#service_box7").css("opacity","1");
			 
		}else if(SBJ_JOB_STATUS=='4'){
			 $("#service_box9").css("opacity","0.3"); 
			 $("#service_box11").css("opacity","0.3"); 
		}else if(SBJ_JOB_STATUS=='5'){
			 $("#service_box9").css("opacity","0.3"); 
			 $("#service_box10").css("opacity","0.3"); 
		}else if(SBJ_JOB_STATUS=='6'){
			 $("#service_box8").css("opacity","1");  
		}
		
	    //Sale
	     var SBJ_CONFIRM_REPAIR_DATE=data[0][66]; $("#SBJ_CONFIRM_REPAIR_DATE").val(SBJ_CONFIRM_REPAIR_DATE);  
	     var SBJ_CUSTOMER_CONFIRM_REPAIR=data[0][67]; $("#SBJ_CUSTOMER_CONFIRM_REPAIR").val(SBJ_CUSTOMER_CONFIRM_REPAIR); 
	     var SBJ_IS_REPAIR=data[0][68]; $("#SBJ_IS_REPAIR").val(SBJ_IS_REPAIR);  
	     $('input[name="SBJ_IS_REPAIR"][value="'+SBJ_IS_REPAIR+'"]').prop('checked', true);
	     if(SBJ_IS_REPAIR=='1'){
			 $("#service_box10_2").show(); 
		 }
	     var SBJ_CLOSE_DATE=data[0][65]; $("#SBJ_CLOSE_DATE").val(SBJ_CLOSE_DATE);    
	    var SBJ_CLOSE_ACTOR=data[0][69]; $("#SBJ_CLOSE_ACTOR").val(SBJ_CLOSE_ACTOR); 
	    
	    var SBJ_SYNDOME_RECIPIENT=data[0][44]; $("#SBJ_SYNDOME_RECIPIENT").val(SBJ_SYNDOME_RECIPIENT); 
	    if(SBJ_SYNDOME_RECIPIENT.length==0 && SBJ_JOB_STATUS=='1'){
	    	  <c:if test="${isOperationAccount}">
	    	    $("#SBJ_SYNDOME_RECIPIENT").val('${username}'); 
	    	  </c:if>
	    }
	    	
	     
	    var SBJ_SYNDOME_RECIPIENT_DATE=data[0][45]; $("#SBJ_SYNDOME_RECIPIENT_DATE").val(SBJ_SYNDOME_RECIPIENT_DATE);  
	    var SBJ_SYNDOME_RECIPIENT_TIME_IN=data[0][46]; $("#SBJ_SYNDOME_RECIPIENT_TIME_IN").val(SBJ_SYNDOME_RECIPIENT_TIME_IN); 
	    var SBJ_SYNDOME_RECIPIENT_TIME_OUT=data[0][47]; $("#SBJ_SYNDOME_RECIPIENT_TIME_OUT").val(SBJ_SYNDOME_RECIPIENT_TIME_OUT);  
	    //alert(SBJ_SYNDOME_RECIPIENT_TIME_OUT)
	    var SBJ_CUSTOMER_SEND=data[0][48]; $("#SBJ_CUSTOMER_SEND").val(SBJ_CUSTOMER_SEND);  
	    var SBJ_CUSTOMER_SEND_DATE=data[0][49]; $("#SBJ_CUSTOMER_SEND_DATE").val(SBJ_CUSTOMER_SEND_DATE);  
	    var SBJ_CUSTOMER_SEND_TIME_IN=data[0][50]; $("#SBJ_CUSTOMER_SEND_TIME_IN").val(SBJ_CUSTOMER_SEND_TIME_IN);  
	    var SBJ_CUSTOMER_SEND_TIME_OUT=data[0][51]; $("#SBJ_CUSTOMER_SEND_TIME_OUT").val(SBJ_CUSTOMER_SEND_TIME_OUT);  
	    var SBJ_SYNDOME_ENGINEER=data[0][52]; $("#SBJ_SYNDOME_ENGINEER").val(SBJ_SYNDOME_ENGINEER); 
	    if(SBJ_SYNDOME_ENGINEER.length==0  && SBJ_JOB_STATUS=='4'){
	    	  <c:if test="${isOperationAccount}">
	    	    $("#SBJ_SYNDOME_ENGINEER").val('${username}'); 
	    	  </c:if>
	    }
	    var SBJ_SYNDOME_ENGINEER_DATE=data[0][53]; $("#SBJ_SYNDOME_ENGINEER_DATE").val(SBJ_SYNDOME_ENGINEER_DATE); 
	    var SBJ_SYNDOME_ENGINEER_TIME_IN=data[0][54]; $("#SBJ_SYNDOME_ENGINEER_TIME_IN").val(SBJ_SYNDOME_ENGINEER_TIME_IN);  
	    var SBJ_SYNDOME_ENGINEER_TIME_OUT=data[0][55]; $("#SBJ_SYNDOME_ENGINEER_TIME_OUT").val(SBJ_SYNDOME_ENGINEER_TIME_OUT);  
	    var SBJ_SYNDOME_SEND=data[0][56]; $("#SBJ_SYNDOME_SEND").val(SBJ_SYNDOME_SEND);  
	    if(SBJ_SYNDOME_SEND.length==0  && SBJ_JOB_STATUS=='5'){
	    	  <c:if test="${isOperationAccount}">
	    	    $("#SBJ_SYNDOME_SEND").val('${username}'); 
	    	  </c:if>
	    }
	     
	    var SBJ_SYNDOME_ENGINEER2=data[0][156]; $("#SBJ_SYNDOME_ENGINEER2").val(SBJ_SYNDOME_ENGINEER); 
	    if(SBJ_SYNDOME_ENGINEER2.length==0  && SBJ_JOB_STATUS=='4'){
	    	  <c:if test="${isOperationAccount}">
	    	    $("#SBJ_SYNDOME_ENGINEER2").val('${username}'); 
	    	  </c:if>
	    }
	    var SBJ_SYNDOME_ENGINEER2_DATE=data[0][157]; $("#SBJ_SYNDOME_ENGINEER2_DATE").val(SBJ_SYNDOME_ENGINEER2_DATE); 
	    var SBJ_SYNDOME_ENGINEER2_TIME_IN=data[0][158];  $("#SBJ_SYNDOME_ENGINEER2_TIME_IN").val(SBJ_SYNDOME_ENGINEER2_TIME_IN);  
	    var SBJ_SYNDOME_ENGINEER2_TIME_OUT=data[0][159]; $("#SBJ_SYNDOME_ENGINEER2_TIME_OUT").val(SBJ_SYNDOME_ENGINEER2_TIME_OUT); 
 
	    
	    var SBJ_SYNDOME_SEND_RFE_NO=data[0][57]; $("#SBJ_SYNDOME_SEND_RFE_NO").val(SBJ_SYNDOME_SEND_RFE_NO);   
	    var SBJ_SYNDOME_SEND_DATE=data[0][58]; $("#SBJ_SYNDOME_SEND_DATE").val(SBJ_SYNDOME_SEND_DATE);  
	    var SBJ_SYNDOME_SEND_TIME_IN=data[0][59]; $("#SBJ_SYNDOME_SEND_TIME_IN").val(SBJ_SYNDOME_SEND_TIME_IN);  
	    var SBJ_SYNDOME_SEND_TIME_OUT=data[0][60]; $("#SBJ_SYNDOME_SEND_TIME_OUT").val(SBJ_SYNDOME_SEND_TIME_OUT);  
	    var SBJ_CUSTOMER_RECIPIENT=data[0][61]; $("#SBJ_CUSTOMER_RECIPIENT").val(SBJ_CUSTOMER_RECIPIENT);   
	    var SBJ_CUSTOMER_RECIPIENT_DATE=data[0][62]; $("#SBJ_CUSTOMER_RECIPIENT_DATE").val(SBJ_CUSTOMER_RECIPIENT_DATE);  
	    var SBJ_CUSTOMER_RECIPIENT_TIME_IN=data[0][63]; $("#SBJ_CUSTOMER_RECIPIENT_TIME_IN").val(SBJ_CUSTOMER_RECIPIENT_TIME_IN);  
	    var SBJ_CUSTOMER_RECIPIENT_TIME_OUT=data[0][64]; $("#SBJ_CUSTOMER_RECIPIENT_TIME_OUT").val(SBJ_CUSTOMER_RECIPIENT_TIME_OUT);  
	    
	    var SBJ_DEPT_ID=data[0][154]; 
	    $('input[name="SBJ_DEPT_ID"][value="'+SBJ_DEPT_ID+'"]').prop('checked', true);
	  //  $("#SBJ_DEPT_ID").val(SBJ_DEPT_ID);  
	    
	    
	  
	    var index=1;
	     for(var i=132 ;i<=138;i++){
	    	    var _NAME=data[0][i]!=null?data[0][i]:"";// $("#BDT_DOC_ATTACH_NAME").val(BDT_DOC_ATTACH_NAME);
				var _HOTLINK=data[0][i+14]!=null?data[0][i+14]:"";// $("#BDT_DOC_ATTACH_HOTLINK").val(BDT_DOC_ATTACH_HOTLINK);
				//alert(_NAME) 
				$("#SBJ_DOC_ATTACH_"+index+"_SRC").attr("style","text-decoration: underline;cursor:pointer"); 
				$("#SBJ_DOC_ATTACH_"+index+"_SRC").html(_NAME);
			     $("#SBJ_DOC_ATTACH_"+index+"_SRC").attr("onclick","loadFile('getfile/Services/${bccNo}_"+index+"/"+_HOTLINK+"')");
			     index++;
	     }
	   //  alert(SBJ_JOB_STATUS)
	    //if(SBJ_JOB_STATUS=='6')
	    	// $("#close_job_element").show();
	     	 
					var to_do_count=data[0][29]!=null?data[0][29]:0; 
					var BCC_STATE=data[0][30];
					var BSO_MA_TYPE=data[0][161];
					 var SBJ_JOB_PROBLEM_ID=data[0][162]; $("#SBJ_JOB_PROBLEM_ID").val(SBJ_JOB_PROBLEM_ID);  
					 var SBJ_JOB_PROBLEM_SOLUTION=data[0][163]; $("#SBJ_JOB_PROBLEM_SOLUTION").val(SBJ_JOB_PROBLEM_SOLUTION);
					//  $('input[name="radio1"][value="2"]').prop('checked', true);
					//alert(BCC_STATE)
				if(BCC_STATE!='cancel')
					if(BCC_STATE.length>0){
						$("#button_update").show();
					}else
						$("#button_send").show();
				if(isEdit && BCC_STATE!=''){
					 $("#BCC_SERIAL").attr("readonly","readonly" );
					 $("input[name=radio1]").attr("disabled",true);
					 $("#BCC_MA_NO").attr("readonly","readonly" );
					 $("input[name=BCC_STATUS]").attr("disabled",true);
					 
				 }
				var BCC_IS_MA_0="&nbsp;";
				var BCC_IS_MA_1="&nbsp;";
				var BCC_IS_MA_2="&nbsp;";
				if(BCC_IS_MA=='0') 
					BCC_IS_MA_0="x";
				else if(BCC_IS_MA=='1')
					BCC_IS_MA_1="x";
				else if(BCC_IS_MA=='2')
					BCC_IS_MA_2="x";
				$("#BCC_IS_MA_0").html(BCC_IS_MA_0);
				$("#BCC_IS_MA_1").html(BCC_IS_MA_1);
				$("#BCC_IS_MA_2").html(BCC_IS_MA_2);
				
				//1=Gold,2=Silver,3=Bronze 
				var BSO_MA_TYPE_1="&nbsp;";
				var BSO_MA_TYPE_2="&nbsp;";
				var BSO_MA_TYPE_3="&nbsp;";
				if(BSO_MA_TYPE=='1') 
					BSO_MA_TYPE_1="x";
				else if(BSO_MA_TYPE=='2')
					BSO_MA_TYPE_2="x";
				else if(BSO_MA_TYPE=='3')
					BSO_MA_TYPE_3="x";
				$("#BSO_MA_TYPE_1").html(BSO_MA_TYPE_1);
				$("#BSO_MA_TYPE_2").html(BSO_MA_TYPE_2);
				$("#BSO_MA_TYPE_3").html(BSO_MA_TYPE_3);
				
				 
				var flow="";
				if(BCC_STATUS=='0')
					flow="เสนอราคาซ่อม";
				else if(BCC_STATUS=='1')
					flow="ให้ดำเนินการซ่อม Onsite (กทม ปริฯ)";
				else if(BCC_STATUS=='2')
					flow="ให้ดำเนินการซ่อม Onsite (ภูมิภาค)";
				else if(BCC_STATUS=='3')
					flow="ให้ซ่อมภายใน SC";
				else if(BCC_STATUS=='4')
					flow="ให้ดำเนินการรับเครื่อง (กทม ปริฯ)";
				else if(BCC_STATUS=='5')
					flow="ให้ดำเนินการรับเครื่อง (ภูมิภาค)";
				$("#flow").html(flow);
					/*
					if(to_do_count>0){
						$("#button_send").hide();
					}else
						$("#button_update").show();
					 */
					 
				} 
				//searchItemList("1");
				renderBorrowItemList('${bccNo}','1');
				renderBorrowItemList('${bccNo}','2');
				
				
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("CALL_CENTER","ym","4","en",{
			callback:function(data){  
				if(data.resultMessage.msgCode=='ok'){
					data=data.resultMessage.msgDesc;
				}else{// Error Code
					//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
					  bootbox.dialog(data.resultMessage.msgDesc,[{
						    "label" : "Close",
						     "class" : "btn-danger"
					 }]);
					 return false;
				}
				if(data!=null && data.length>0){
					$("#BCC_NO").val(data);
					var querys=[];  
					//return false;
					var query="insert into "+SCHEMA_G+".BPM_CALL_CENTER set BCC_NO='"+data+"' ,BCC_USER_CREATED='${username}' ,"+
					  " BCC_CREATED_TIME=now() ";
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
								query=" SELECT "+
								   " BCC_NO, BCC_USER_CREATED  FROM "+SCHEMA_G+".BPM_CALL_CENTER where BCC_NO='"+$("#BCC_NO").val()+"'";
								  SynDomeBPMAjax.searchObject(query,{
										callback:function(data2){ 
											if(data2.resultMessage.msgCode=='ok'){
												data2=data2.resultListObj;
											}else{// Error Code
												//alert(dwr.util.toDescriptiveString(data.resultMessage.exception, 2));
												  bootbox.dialog(data2.resultMessage.msgDesc,[{
													    "label" : "Close",
													     "class" : "btn-danger"
												 }]);
												 return false;
											}
											loadDynamicPage('dispatcher/page/callcenter_job?bccNo='+data2[0][0]+'&mode=edit');
										},errorHandler:function(errorString, exception) { 
											alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
										}
								  }); 
								//searchDeliveryInstallation("1"); 
							}
						}
					});
					//alert(data)	
				}else{
					
				} 
			},errorHandler:function(errorString, exception) { 
				alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
			}
	 	  }); 
	  $("#hodElement").html("Not set");
	  $("#hodElement").css("color","red");
	  $("#hodElement").css("cursor","pointer"); 
	 var str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		"<thead>"+
		"<tr> "+
		"<th colspan=\"7\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
		"</tr>"+
		"</thead>"+
		"<tbody></table> ";    
	//$("#item_section").html(str);
   }
}
function doUpdateServiceJob(mode){ 
	
	// On Site
	 var SBJ_ONSITE_DETECTED = jQuery.trim($("#SBJ_ONSITE_DETECTED").val());
	 var SBJ_ONSITE_CAUSE = jQuery.trim($("#SBJ_ONSITE_CAUSE").val());
	 var SBJ_ONSITE_SOLUTION = jQuery.trim($("#SBJ_ONSITE_SOLUTION").val());
	 var SBJ_ONSITE_IS_GET_BACK = jQuery.trim($("input[id=SBJ_ONSITE_IS_GET_BACK]:checked" ).val());
	 SBJ_ONSITE_IS_GET_BACK=(SBJ_ONSITE_IS_GET_BACK.length>0)?SBJ_ONSITE_IS_GET_BACK:"0";
	 
	 var SBJ_ONSITE_IS_REPLACE = jQuery.trim($("input[id=SBJ_ONSITE_IS_REPLACE]:checked" ).val());
	 SBJ_ONSITE_IS_REPLACE=(SBJ_ONSITE_IS_REPLACE.length>0)?SBJ_ONSITE_IS_REPLACE:"0";
	 
	 var SBJ_ONSITE_IS_SPARE = jQuery.trim($("input[id=SBJ_ONSITE_IS_SPARE]:checked" ).val());
	 SBJ_ONSITE_IS_SPARE=(SBJ_ONSITE_IS_SPARE.length>0)?SBJ_ONSITE_IS_SPARE:"0";
	  
	 var SBJ_ONSITE_BATTERY_AMOUNT = jQuery.trim($("#SBJ_ONSITE_BATTERY_AMOUNT").val());
	 var SBJ_ONSITE_BATTERY_YEAR = jQuery.trim($("#SBJ_ONSITE_BATTERY_YEAR").val());
	 var SBJ_ONSITE_IS_BATTERRY = jQuery.trim($("input[id=SBJ_ONSITE_IS_BATTERRY]:checked" ).val());
	 SBJ_ONSITE_IS_BATTERRY=(SBJ_ONSITE_IS_BATTERRY.length>0)?SBJ_ONSITE_IS_BATTERRY:"0";
	  
	 // SC
	  var SBJ_SC_DETECTED = jQuery.trim($("#SBJ_SC_DETECTED").val());
	 var SBJ_SC_CAUSE = jQuery.trim($("#SBJ_SC_CAUSE").val());
	 var SBJ_SC_SOLUTION = jQuery.trim($("#SBJ_SC_SOLUTION").val());
	 var SBJ_SC_IS_CHANGE_ITEM   = jQuery.trim($("input[id=SBJ_SC_IS_CHANGE_ITEM]:checked" ).val());
	 SBJ_SC_IS_CHANGE_ITEM=(SBJ_SC_IS_CHANGE_ITEM.length>0)?SBJ_SC_IS_CHANGE_ITEM:"0";
	 
	 var SBJ_SC_IS_CHARGE   = jQuery.trim($("input[id=SBJ_SC_IS_CHARGE]:checked" ).val());
	 SBJ_SC_IS_CHARGE=(SBJ_SC_IS_CHARGE.length>0)?SBJ_SC_IS_CHARGE:"0";
	 
	 var SBJ_SC_IS_RECOMMEND= jQuery.trim($("input[id=SBJ_SC_IS_RECOMMEND]:checked" ).val());
	 SBJ_SC_IS_RECOMMEND=(SBJ_SC_IS_RECOMMEND.length>0)?SBJ_SC_IS_RECOMMEND:"0";
	 
	 // รับเครื่องกลับ
	 var SBJ_GET_BACK_1 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_1"]:checked').val());  
	 var SBJ_GET_BACK_2 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_2"]:checked').val());  
	 var SBJ_GET_BACK_3 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_3"]:checked').val());  
	 var SBJ_GET_BACK_4 = jQuery.trim($('input:radio[name="SBJ_GET_BACK_4"]:checked').val());  
	 var SBJ_GET_BACK_EXT = jQuery.trim($("#SBJ_GET_BACK_EXT").val());
	
	 // ยืม 
	 var SBJ_BORROW_ACTOR = jQuery.trim($("#SBJ_BORROW_ACTOR").val());
	 var SBJ_BORROW_APPROVER = jQuery.trim($("#SBJ_BORROW_APPROVER").val());
	 var SBJ_BORROW_SENDER = jQuery.trim($("#SBJ_BORROW_SENDER").val());
	 var SBJ_BORROW_RECEIVER = jQuery.trim($("#SBJ_BORROW_RECEIVER").val());
	 var SBJ_BORROW_ACTOR_DATE = jQuery.trim($("#SBJ_BORROW_ACTOR_DATE").val());
	 var SBJ_BORROW_SERAIL = jQuery.trim($("#SBJ_BORROW_SERAIL").val());
	 SBJ_BORROW_ACTOR_DATE=changeDateToStr(SBJ_BORROW_ACTOR_DATE);
	  
	 var SBJ_BORROW_APPROVER_DATE = jQuery.trim($("#SBJ_BORROW_APPROVER_DATE").val());
	 SBJ_BORROW_APPROVER_DATE=changeDateToStr(SBJ_BORROW_APPROVER_DATE);
	 
	 var SBJ_BORROW_SENDER_DATE = jQuery.trim($("#SBJ_BORROW_SENDER_DATE").val());
	 SBJ_BORROW_SENDER_DATE=changeDateToStr(SBJ_BORROW_SENDER_DATE);
	 
	 var SBJ_BORROW_RECEIVER_DATE = jQuery.trim($("#SBJ_BORROW_RECEIVER_DATE").val());
	 SBJ_BORROW_RECEIVER_DATE=changeDateToStr(SBJ_BORROW_RECEIVER_DATE);
	 
	 var SBJ_BORROW_IS_REPAIR_SITE = jQuery.trim($("input[id=SBJ_BORROW_IS_REPAIR_SITE]:checked" ).val());
	 SBJ_BORROW_IS_REPAIR_SITE=(SBJ_BORROW_IS_REPAIR_SITE.length>0)?SBJ_BORROW_IS_REPAIR_SITE:"0";
	 
	 var SBJ_BORROW_IS_SPARE = jQuery.trim($("input[id=SBJ_BORROW_IS_SPARE]:checked" ).val());
	 SBJ_BORROW_IS_SPARE=(SBJ_BORROW_IS_SPARE.length>0)?SBJ_BORROW_IS_SPARE:"0";
	 
	 var SBJ_BORROW_IS_CHANGE = jQuery.trim($("input[id=SBJ_BORROW_IS_CHANGE]:checked" ).val());
	 SBJ_BORROW_IS_CHANGE=(SBJ_BORROW_IS_CHANGE.length>0)?SBJ_BORROW_IS_CHANGE:"0";
	 
	 
	 // ตรวจเช็ค
	  var SBJ_CHECKER_1_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_1_IS_PASS]:checked" ).val());
	  SBJ_CHECKER_1_IS_PASS=(SBJ_CHECKER_1_IS_PASS.length>0)?SBJ_CHECKER_1_IS_PASS:"0";
		 
	 var SBJ_CHECKER_1_VALUE = jQuery.trim($("#SBJ_CHECKER_1_VALUE").val());
	 var SBJ_CHECKER_2_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_2_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_2_IS_PASS=(SBJ_CHECKER_2_IS_PASS.length>0)?SBJ_CHECKER_2_IS_PASS:"0";
	 
	 var SBJ_CHECKER_2_VALUE = jQuery.trim($("#SBJ_CHECKER_2_VALUE").val());
	 var SBJ_CHECKER_3_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_3_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_3_IS_PASS=(SBJ_CHECKER_3_IS_PASS.length>0)?SBJ_CHECKER_3_IS_PASS:"0";
	 
	 var SBJ_CHECKER_3_VALUE = jQuery.trim($("#SBJ_CHECKER_3_VALUE").val());
	 var SBJ_CHECKER_4_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_4_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_4_IS_PASS=(SBJ_CHECKER_4_IS_PASS.length>0)?SBJ_CHECKER_4_IS_PASS:"0";
	 
	 var SBJ_CHECKER_4_VALUE = jQuery.trim($("#SBJ_CHECKER_4_VALUE").val());
	 var SBJ_CHECKER_5_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_5_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_5_IS_PASS=(SBJ_CHECKER_5_IS_PASS.length>0)?SBJ_CHECKER_5_IS_PASS:"0";
	 
	 var SBJ_CHECKER_5_VALUE = jQuery.trim($("#SBJ_CHECKER_5_VALUE").val());
	 var SBJ_CHECKER_6_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_6_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_6_IS_PASS=(SBJ_CHECKER_6_IS_PASS.length>0)?SBJ_CHECKER_6_IS_PASS:"0";
	 
	 var SBJ_CHECKER_6_VALUE = jQuery.trim($("#SBJ_CHECKER_6_VALUE").val());
	 var SBJ_CHECKER_7_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_7_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_7_IS_PASS=(SBJ_CHECKER_7_IS_PASS.length>0)?SBJ_CHECKER_7_IS_PASS:"0";
	 
	 var SBJ_CHECKER_7_VALUE = jQuery.trim($("#SBJ_CHECKER_7_VALUE").val());
	 var SBJ_CHECKER_8_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_8_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_8_IS_PASS=(SBJ_CHECKER_8_IS_PASS.length>0)?SBJ_CHECKER_8_IS_PASS:"0";
	 
	 var SBJ_CHECKER_8_VALUE = jQuery.trim($("#SBJ_CHECKER_8_VALUE").val());
	 var SBJ_CHECKER_9_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_9_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_9_IS_PASS=(SBJ_CHECKER_9_IS_PASS.length>0)?SBJ_CHECKER_9_IS_PASS:"0";
	 
	 var SBJ_CHECKER_10_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_10_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_10_IS_PASS=(SBJ_CHECKER_10_IS_PASS.length>0)?SBJ_CHECKER_10_IS_PASS:"0";
	 
	 var SBJ_CHECKER_11_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_11_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_11_IS_PASS=(SBJ_CHECKER_11_IS_PASS.length>0)?SBJ_CHECKER_11_IS_PASS:"0";
	 
	 var SBJ_CHECKER_12_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_12_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_12_IS_PASS=(SBJ_CHECKER_12_IS_PASS.length>0)?SBJ_CHECKER_12_IS_PASS:"0";
	 
	 var SBJ_CHECKER_13_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_13_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_13_IS_PASS=(SBJ_CHECKER_13_IS_PASS.length>0)?SBJ_CHECKER_13_IS_PASS:"0";
	 
	 var SBJ_CHECKER_14_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_14_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_14_IS_PASS=(SBJ_CHECKER_14_IS_PASS.length>0)?SBJ_CHECKER_14_IS_PASS:"0";
	 
	 var SBJ_CHECKER_15_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_15_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_15_IS_PASS=(SBJ_CHECKER_15_IS_PASS.length>0)?SBJ_CHECKER_15_IS_PASS:"0";
	 
	 var SBJ_CHECKER_16_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_16_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_16_IS_PASS=(SBJ_CHECKER_16_IS_PASS.length>0)?SBJ_CHECKER_16_IS_PASS:"0";
	 
	 var SBJ_CHECKER_17_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_17_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_17_IS_PASS=(SBJ_CHECKER_17_IS_PASS.length>0)?SBJ_CHECKER_17_IS_PASS:"0";
	 
	 var SBJ_CHECKER_18_IS_PASS = jQuery.trim($("input[id=SBJ_CHECKER_18_IS_PASS]:checked" ).val());
	 SBJ_CHECKER_18_IS_PASS=(SBJ_CHECKER_18_IS_PASS.length>0)?SBJ_CHECKER_18_IS_PASS:"0";
	 
	 var SBJ_CHECKER_19_VALUE = jQuery.trim($("#SBJ_CHECKER_19_VALUE").val());
	 var SBJ_CHECKER_20_VALUE = jQuery.trim($("#SBJ_CHECKER_20_VALUE").val());
	 var SBJ_CHECKER_21_VALUE = jQuery.trim($("#SBJ_CHECKER_21_VALUE").val());
	 var SBJ_CHECKER_22_VALUE = jQuery.trim($("#SBJ_CHECKER_22_VALUE").val());
	 var SBJ_CHECKER_EXT_VALUE = jQuery.trim($("#SBJ_CHECKER_EXT_VALUE").val());
	 
	 // Sale
	  var SBJ_IS_REPAIR = jQuery.trim($('input:radio[name="SBJ_IS_REPAIR"]:checked').val()); 
	  var SBJ_CONFIRM_REPAIR_DATE = jQuery.trim($("#SBJ_CONFIRM_REPAIR_DATE").val());
	  SBJ_CONFIRM_REPAIR_DATE=changeDateToStr(SBJ_CONFIRM_REPAIR_DATE);
		
	  var SBJ_CUSTOMER_CONFIRM_REPAIR = jQuery.trim($("#SBJ_CUSTOMER_CONFIRM_REPAIR").val());
		
	 // Close Job
	  var SBJ_CLOSE_DATE = jQuery.trim($("#SBJ_CLOSE_DATE").val()); 
	  SBJ_CLOSE_DATE=changeDateToStr(SBJ_CLOSE_DATE);
	 var SBJ_CLOSE_ACTOR = jQuery.trim($("#SBJ_CLOSE_ACTOR").val());
	 
	 // Update Actor
	 var SBJ_SYNDOME_RECIPIENT = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT").val());
	 var SBJ_SYNDOME_RECIPIENT_DATE = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_DATE").val());
	 SBJ_SYNDOME_RECIPIENT_DATE=changeDateToStr(SBJ_SYNDOME_RECIPIENT_DATE);
		 
	 var SBJ_SYNDOME_RECIPIENT_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_TIME_IN").val());
	 var SBJ_SYNDOME_RECIPIENT_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_RECIPIENT_TIME_OUT").val());
	 var SBJ_CUSTOMER_SEND = jQuery.trim($("#SBJ_CUSTOMER_SEND").val());
	 var SBJ_CUSTOMER_SEND_DATE = jQuery.trim($("#SBJ_CUSTOMER_SEND_DATE").val());
	 SBJ_CUSTOMER_SEND_DATE=changeDateToStr(SBJ_CUSTOMER_SEND_DATE);
		
	 var SBJ_CUSTOMER_SEND_TIME_IN = jQuery.trim($("#SBJ_CUSTOMER_SEND_TIME_IN").val());
	 var SBJ_CUSTOMER_SEND_TIME_OUT = jQuery.trim($("#SBJ_CUSTOMER_SEND_TIME_OUT").val());
	 var SBJ_SYNDOME_ENGINEER = jQuery.trim($("#SBJ_SYNDOME_ENGINEER").val());
	 var SBJ_SYNDOME_ENGINEER_DATE = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_DATE").val());
	 SBJ_SYNDOME_ENGINEER_DATE=changeDateToStr(SBJ_SYNDOME_ENGINEER_DATE);
	 
	 var SBJ_SYNDOME_ENGINEER_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_TIME_IN").val());
	 var SBJ_SYNDOME_ENGINEER_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_ENGINEER_TIME_OUT").val());
	 
	 var SBJ_SYNDOME_ENGINEER2 = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2").val());
	 var SBJ_SYNDOME_ENGINEER2_DATE = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_DATE").val());
	 SBJ_SYNDOME_ENGINEER2_DATE=changeDateToStr(SBJ_SYNDOME_ENGINEER2_DATE);
	 
	 var SBJ_SYNDOME_ENGINEER2_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_TIME_IN").val());
	 var SBJ_SYNDOME_ENGINEER2_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_ENGINEER2_TIME_OUT").val());
	 
	 var SBJ_SYNDOME_SEND = jQuery.trim($("#SBJ_SYNDOME_SEND").val());
	 var SBJ_SYNDOME_SEND_RFE_NO = jQuery.trim($("#SBJ_SYNDOME_SEND_RFE_NO").val());
	 var SBJ_SYNDOME_SEND_DATE = jQuery.trim($("#SBJ_SYNDOME_SEND_DATE").val());
	 SBJ_SYNDOME_SEND_DATE=changeDateToStr(SBJ_SYNDOME_SEND_DATE);
	 
	 var SBJ_SYNDOME_SEND_TIME_IN = jQuery.trim($("#SBJ_SYNDOME_SEND_TIME_IN").val());
	 var SBJ_SYNDOME_SEND_TIME_OUT = jQuery.trim($("#SBJ_SYNDOME_SEND_TIME_OUT").val());
	 var SBJ_CUSTOMER_RECIPIENT = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT").val());
	 var SBJ_CUSTOMER_RECIPIENT_DATE = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_DATE").val());
	 SBJ_CUSTOMER_RECIPIENT_DATE=changeDateToStr(SBJ_CUSTOMER_RECIPIENT_DATE);
	 
	 var SBJ_CUSTOMER_RECIPIENT_TIME_IN = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_TIME_IN").val());
	 var SBJ_CUSTOMER_RECIPIENT_TIME_OUT = jQuery.trim($("#SBJ_CUSTOMER_RECIPIENT_TIME_OUT").val());
	
	  //Status
	 // var SBJ_DEPT_ID = jQuery.trim($("#SBJ_DEPT_ID").val()); 
	  
	 var SBJ_DEPT_ID = jQuery.trim($("input[name=SBJ_DEPT_ID]:checked" ).val());
	 var SBJ_JOB_STATUS = jQuery.trim($("#SBJ_JOB_STATUS").val());
	 var BSJ_REMARK = jQuery.trim($("#BSJ_REMARK").val());
	/*	 
	
	 var BSJ_FEEDBACK = jQuery.trim($("#BSJ_FEEDBACK").val());
	 var BSJ_RECOMMEND = jQuery.trim($("#BSJ_RECOMMEND").val());
	 var BSJ_CAUSE = jQuery.trim($("#BSJ_CAUSE").val());
	 var BSJ_SOLUTION = jQuery.trim($("#BSJ_SOLUTION").val());
	 var BSJ_IS_SOLUTION1 = jQuery.trim($("#BSJ_IS_SOLUTION1").val());
	 var BSJ_IS_SOLUTION2 = jQuery.trim($("#BSJ_IS_SOLUTION2").val());
	 var BSJ_IS_SOLUTION3 = jQuery.trim($("#BSJ_IS_SOLUTION3").val());
	 var BSJ_CREATED_TIME = jQuery.trim($("#BSJ_CREATED_TIME").val());
	 var BSJ_STATE = jQuery.trim($("#BSJ_STATE").val());
	 var BSJ_STATUS = jQuery.trim($("#BSJ_STATUS: 0 ,
	  
	
	 var SBJ_DOC_ATTACH_NAME_1 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_1").val());
	 var SBJ_DOC_ATTACH_NAME_2 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_2").val());
	 var SBJ_DOC_ATTACH_NAME_3 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_3").val());
	 var SBJ_DOC_ATTACH_NAME_4 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_4").val());
	 var SBJ_DOC_ATTACH_NAME_5 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_5").val());
	 var SBJ_DOC_ATTACH_NAME_6 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_6").val());
	 var SBJ_DOC_ATTACH_NAME_7 = jQuery.trim($("#SBJ_DOC_ATTACH_NAME_7").val());
	 var SBJ_DOC_ATTACH_PATH_1 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_1").val());
	 var SBJ_DOC_ATTACH_PATH_2 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_2").val());
	 var SBJ_DOC_ATTACH_PATH_3 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_3").val());
	 var SBJ_DOC_ATTACH_PATH_4 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_4").val());
	 var SBJ_DOC_ATTACH_PATH_5 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_5").val());
	 var SBJ_DOC_ATTACH_PATH_6 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_6").val());
	 var SBJ_DOC_ATTACH_PATH_7 = jQuery.trim($("#SBJ_DOC_ATTACH_PATH_7").val());
	 var SBJ_DOC_ATTACH_HOTLINK_1 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_1").val());
	 var SBJ_DOC_ATTACH_HOTLINK_2 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_2").val());
	 var SBJ_DOC_ATTACH_HOTLINK_3 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_3").val());
	 var SBJ_DOC_ATTACH_HOTLINK_4 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_4").val());
	 var SBJ_DOC_ATTACH_HOTLINK_5 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_5").val());
	 var SBJ_DOC_ATTACH_HOTLINK_6 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_6").val());
	 var SBJ_DOC_ATTACH_HOTLINK_7 = jQuery.trim($("#SBJ_DOC_ATTACH_HOTLINK_7").val());
	 var SBJ_STATUS_JOB = jQuery.trim($("#SBJ_STATUS_JOB").val());
	 
	 WHERE `BCC_NO` =  ;
*/
	 var BCC_NO="${bccNo}";  
		 
	var query=" UPDATE "+SCHEMA_G+".BPM_SERVICE_JOB SET "+ 
	 " BSJ_REMARK   = '"+BSJ_REMARK+"' , "+  
	// On Site
	 " SBJ_ONSITE_DETECTED   = '"+SBJ_ONSITE_DETECTED+"' , "+ 
	 " SBJ_ONSITE_CAUSE    = '"+SBJ_ONSITE_CAUSE+"' , "+ 
	 " SBJ_ONSITE_SOLUTION  = '"+SBJ_ONSITE_SOLUTION+"' , "+ 
	 " SBJ_ONSITE_IS_GET_BACK    = '"+SBJ_ONSITE_IS_GET_BACK+"' , "+  
	 " SBJ_ONSITE_IS_REPLACE   = '"+SBJ_ONSITE_IS_REPLACE+"' , "+ 
	  " SBJ_ONSITE_IS_SPARE    = '"+SBJ_ONSITE_IS_SPARE+"' , "+  
	 " SBJ_ONSITE_BATTERY_AMOUNT  = '"+SBJ_ONSITE_BATTERY_AMOUNT+"' , "+ 
	 " SBJ_ONSITE_BATTERY_YEAR    = '"+SBJ_ONSITE_BATTERY_YEAR+"' , "+ 
	 " SBJ_ONSITE_IS_BATTERRY    = '"+SBJ_ONSITE_IS_BATTERRY+"' , "+ 
	  
	 // SC
	  " SBJ_SC_DETECTED  = '"+SBJ_SC_DETECTED+"' , "+ 
	  " SBJ_SC_CAUSE =    '"+SBJ_SC_CAUSE+"' , "+ 
	  " SBJ_SC_SOLUTION =   '"+SBJ_SC_SOLUTION+"' , "+ 
	  " SBJ_SC_IS_CHANGE_ITEM    = '"+SBJ_SC_IS_CHANGE_ITEM+"' , "+   
	 " SBJ_SC_IS_CHARGE    = '"+SBJ_SC_IS_CHARGE+"' , "+   
	 " SBJ_SC_IS_RECOMMEND = '"+SBJ_SC_IS_RECOMMEND+"' , "+  
	 
	 // รับเครื่องกลับ
	 " SBJ_GET_BACK_1 = '"+SBJ_GET_BACK_1+"' , "+ 
	 " SBJ_GET_BACK_2 = '"+SBJ_GET_BACK_2+"' , "+ 
	 " SBJ_GET_BACK_3 = '"+SBJ_GET_BACK_3+"' , "+ 
	 " SBJ_GET_BACK_4 = '"+SBJ_GET_BACK_4+"' , "+ 
	 " SBJ_GET_BACK_EXT = '"+SBJ_GET_BACK_EXT+"' , "+ 
	
	 // ยืม
     " SBJ_BORROW_ACTOR = '"+SBJ_BORROW_ACTOR+"' , "+ 
     " SBJ_BORROW_APPROVER = '"+SBJ_BORROW_APPROVER+"' , "+ 
     " SBJ_BORROW_SENDER = '"+SBJ_BORROW_SENDER+"' , "+ 
     " SBJ_BORROW_RECEIVER = '"+SBJ_BORROW_RECEIVER+"' , ";
     if(SBJ_BORROW_ACTOR_DATE.length>0){
			query=query+" SBJ_BORROW_ACTOR_DATE='"+SBJ_BORROW_ACTOR_DATE+"' , ";
	}else
			query=query+" SBJ_BORROW_ACTOR_DATE=null  , ";
    
     if(SBJ_BORROW_APPROVER_DATE.length>0){
			query=query+" SBJ_BORROW_APPROVER_DATE='"+SBJ_BORROW_APPROVER_DATE+"' , ";
		}else
			query=query+" SBJ_BORROW_APPROVER_DATE=null  , ";
	   
     if(SBJ_BORROW_SENDER_DATE.length>0){
			query=query+" SBJ_BORROW_SENDER_DATE='"+SBJ_BORROW_SENDER_DATE+"' , ";
		}else
			query=query+" SBJ_BORROW_SENDER_DATE=null  , ";
      
	 if(SBJ_BORROW_RECEIVER_DATE.length>0){
			query=query+" SBJ_BORROW_RECEIVER_DATE='"+SBJ_BORROW_RECEIVER_DATE+"' , ";
		}else
			query=query+" SBJ_BORROW_RECEIVER_DATE=null  , ";
	  
	 query=query+" SBJ_BORROW_IS_REPAIR_SITE = '"+SBJ_BORROW_IS_REPAIR_SITE+"' , "+ 
	  
	 " SBJ_BORROW_IS_SPARE = '"+SBJ_BORROW_IS_SPARE+"' , "+ 
	  
	 " SBJ_BORROW_IS_CHANGE = '"+SBJ_BORROW_IS_CHANGE+"' , "+ 
	 " SBJ_BORROW_SERAIL = '"+SBJ_BORROW_SERAIL+"' , "+ 
	 
	  
	 // ตรวจเช็ค
	  " SBJ_CHECKER_1_IS_PASS = '"+SBJ_CHECKER_1_IS_PASS+"' , "+  
	  " SBJ_CHECKER_1_VALUE = '"+SBJ_CHECKER_1_VALUE+"' , "+ 
	  " SBJ_CHECKER_2_IS_PASS = '"+SBJ_CHECKER_2_IS_PASS+"' , "+  
	 " SBJ_CHECKER_2_VALUE = '"+SBJ_CHECKER_2_VALUE+"' , "+ 
	 " SBJ_CHECKER_3_IS_PASS = '"+SBJ_CHECKER_3_IS_PASS+"' , "+   
	 " SBJ_CHECKER_3_VALUE = '"+SBJ_CHECKER_3_VALUE+"' , "+ 
	 " SBJ_CHECKER_4_IS_PASS = '"+SBJ_CHECKER_4_IS_PASS+"' , "+   
	 " SBJ_CHECKER_4_VALUE = '"+SBJ_CHECKER_4_VALUE+"' , "+ 
	 " SBJ_CHECKER_5_IS_PASS = '"+SBJ_CHECKER_5_IS_PASS+"' , "+   
	 " SBJ_CHECKER_5_VALUE = '"+SBJ_CHECKER_5_VALUE+"' , "+ 
	 " SBJ_CHECKER_6_IS_PASS = '"+SBJ_CHECKER_6_IS_PASS+"' , "+   
	 " SBJ_CHECKER_6_VALUE = '"+SBJ_CHECKER_6_VALUE+"' , "+ 
	 " SBJ_CHECKER_7_IS_PASS = '"+SBJ_CHECKER_7_IS_PASS+"' , "+   
	 " SBJ_CHECKER_7_VALUE = '"+SBJ_CHECKER_7_VALUE+"' , "+ 
	 " SBJ_CHECKER_8_IS_PASS = '"+SBJ_CHECKER_8_IS_PASS+"' , "+   
	 " SBJ_CHECKER_8_VALUE = '"+SBJ_CHECKER_8_VALUE+"' , "+ 
	 " SBJ_CHECKER_9_IS_PASS = '"+SBJ_CHECKER_9_IS_PASS+"' , "+   
	 " SBJ_CHECKER_10_IS_PASS = '"+SBJ_CHECKER_10_IS_PASS+"' , "+   
	 " SBJ_CHECKER_11_IS_PASS = '"+SBJ_CHECKER_11_IS_PASS+"' , "+   
	 " SBJ_CHECKER_12_IS_PASS = '"+SBJ_CHECKER_12_IS_PASS+"' , "+   
	 " SBJ_CHECKER_13_IS_PASS = '"+SBJ_CHECKER_13_IS_PASS+"' , "+    
	 " SBJ_CHECKER_14_IS_PASS = '"+SBJ_CHECKER_14_IS_PASS+"' , "+   
	 " SBJ_CHECKER_15_IS_PASS = '"+SBJ_CHECKER_15_IS_PASS+"' , "+   
	 " SBJ_CHECKER_16_IS_PASS = '"+SBJ_CHECKER_16_IS_PASS+"' , "+   
	 " SBJ_CHECKER_17_IS_PASS = '"+SBJ_CHECKER_17_IS_PASS+"' , "+   
	 " SBJ_CHECKER_18_IS_PASS = '"+SBJ_CHECKER_18_IS_PASS+"' , "+   
	 " SBJ_CHECKER_19_VALUE = '"+SBJ_CHECKER_19_VALUE+"' , "+ 
	 " SBJ_CHECKER_20_VALUE = '"+SBJ_CHECKER_20_VALUE+"' , "+ 
	 " SBJ_CHECKER_21_VALUE = '"+SBJ_CHECKER_21_VALUE+"' , "+ 
	 " SBJ_CHECKER_22_VALUE = '"+SBJ_CHECKER_22_VALUE+"' , "+ 

	
	 // Sale
	  " SBJ_IS_REPAIR = '"+SBJ_IS_REPAIR+"' , ";
	 if(SBJ_CONFIRM_REPAIR_DATE.length>0){
			query=query+" SBJ_CONFIRM_REPAIR_DATE='"+SBJ_CONFIRM_REPAIR_DATE+"' , ";
		}else
			query=query+" SBJ_CONFIRM_REPAIR_DATE=null  , "; 
	 
	  query=query+" SBJ_CUSTOMER_CONFIRM_REPAIR = '"+SBJ_CUSTOMER_CONFIRM_REPAIR+"' , ";
		
	 // Close Job
	  if(SBJ_CLOSE_DATE.length>0){
			query=query+" SBJ_CLOSE_DATE='"+SBJ_CLOSE_DATE+"' , ";
		}else
			query=query+" SBJ_CLOSE_DATE=null  , ";  
	  query=query+" SBJ_CLOSE_ACTOR = '"+SBJ_CLOSE_ACTOR+"' , "+  
	 
	 // Update Actor
	 " SBJ_SYNDOME_RECIPIENT = '"+SBJ_SYNDOME_RECIPIENT+"' , "; 
	 if(SBJ_SYNDOME_RECIPIENT_DATE.length>0){
			query=query+" SBJ_SYNDOME_RECIPIENT_DATE='"+SBJ_SYNDOME_RECIPIENT_DATE+"' , ";
		}else
			query=query+" SBJ_SYNDOME_RECIPIENT_DATE=null  , ";
	 	 
	 if(SBJ_SYNDOME_RECIPIENT_TIME_IN.length>0){
			query=query+" SBJ_SYNDOME_RECIPIENT_TIME_IN='"+SBJ_SYNDOME_RECIPIENT_TIME_IN+"' , ";
		}else
			query=query+" SBJ_SYNDOME_RECIPIENT_TIME_IN=null  , ";
	 if(SBJ_SYNDOME_RECIPIENT_TIME_OUT.length>0){
			query=query+" SBJ_SYNDOME_RECIPIENT_TIME_OUT='"+SBJ_SYNDOME_RECIPIENT_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_SYNDOME_RECIPIENT_TIME_OUT=null  , ";
	  
	 query=query+" SBJ_CUSTOMER_SEND = '"+SBJ_CUSTOMER_SEND+"' , "; 
	 if(SBJ_CUSTOMER_SEND_DATE.length>0){
			query=query+" SBJ_CUSTOMER_SEND_DATE='"+SBJ_CUSTOMER_SEND_DATE+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_SEND_DATE=null  , ";
	 	 
	 if(SBJ_CUSTOMER_SEND_TIME_IN.length>0){
			query=query+" SBJ_CUSTOMER_SEND_TIME_IN='"+SBJ_CUSTOMER_SEND_TIME_IN+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_SEND_TIME_IN=null  , ";
	 if(SBJ_CUSTOMER_SEND_TIME_OUT.length>0){
			query=query+" SBJ_CUSTOMER_SEND_TIME_OUT='"+SBJ_CUSTOMER_SEND_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_SEND_TIME_OUT=null  , ";
	 query=query+" SBJ_SYNDOME_ENGINEER = '"+SBJ_SYNDOME_ENGINEER+"' , ";  
	 if(SBJ_SYNDOME_ENGINEER_DATE.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER_DATE='"+SBJ_SYNDOME_ENGINEER_DATE+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER_DATE=null  , ";
	   
	 if(SBJ_SYNDOME_ENGINEER_TIME_IN.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER_TIME_IN='"+SBJ_SYNDOME_ENGINEER_TIME_IN+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER_TIME_IN=null  , ";
	 if(SBJ_SYNDOME_ENGINEER_TIME_OUT.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER_TIME_OUT='"+SBJ_SYNDOME_ENGINEER_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER_TIME_OUT=null  , ";
	 
	 query=query+" SBJ_SYNDOME_ENGINEER2 = '"+SBJ_SYNDOME_ENGINEER2+"' , ";  
	 if(SBJ_SYNDOME_ENGINEER2_DATE.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER2_DATE='"+SBJ_SYNDOME_ENGINEER2_DATE+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER2_DATE=null  , ";
	   
	 if(SBJ_SYNDOME_ENGINEER2_TIME_IN.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER2_TIME_IN='"+SBJ_SYNDOME_ENGINEER2_TIME_IN+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER2_TIME_IN=null  , ";
	 if(SBJ_SYNDOME_ENGINEER2_TIME_OUT.length>0){
			query=query+" SBJ_SYNDOME_ENGINEER2_TIME_OUT='"+SBJ_SYNDOME_ENGINEER2_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_SYNDOME_ENGINEER2_TIME_OUT=null  , ";
	 
	  query=query+ " SBJ_SYNDOME_SEND = '"+SBJ_SYNDOME_SEND+"' , "+  
	 " SBJ_SYNDOME_SEND_RFE_NO = '"+SBJ_SYNDOME_SEND_RFE_NO+"' , ";
	 if(SBJ_SYNDOME_SEND_DATE.length>0){
			query=query+" SBJ_SYNDOME_SEND_DATE='"+SBJ_SYNDOME_SEND_DATE+"' , ";
		}else
			query=query+" SBJ_SYNDOME_SEND_DATE=null  , "; 
	 if(SBJ_SYNDOME_SEND_TIME_IN.length>0){
			query=query+" SBJ_SYNDOME_SEND_TIME_IN='"+SBJ_SYNDOME_SEND_TIME_IN+"' , ";
		}else
			query=query+" SBJ_SYNDOME_SEND_TIME_IN=null  , ";
	 if(SBJ_SYNDOME_SEND_TIME_OUT.length>0){
			query=query+" SBJ_SYNDOME_SEND_TIME_OUT='"+SBJ_SYNDOME_SEND_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_SYNDOME_SEND_TIME_OUT=null  , ";
	 query=query+" SBJ_CUSTOMER_RECIPIENT = '"+SBJ_CUSTOMER_RECIPIENT+"' , ";
	 if(SBJ_CUSTOMER_RECIPIENT_DATE.length>0){
			query=query+" SBJ_CUSTOMER_RECIPIENT_DATE='"+SBJ_CUSTOMER_RECIPIENT_DATE+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_RECIPIENT_DATE=null  , "; 
	 if(SBJ_CUSTOMER_RECIPIENT_TIME_IN.length>0){
			query=query+" SBJ_CUSTOMER_RECIPIENT_TIME_IN='"+SBJ_CUSTOMER_RECIPIENT_TIME_IN+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_RECIPIENT_TIME_IN=null  , ";
	 if(SBJ_CUSTOMER_RECIPIENT_TIME_OUT.length>0){
			query=query+" SBJ_CUSTOMER_RECIPIENT_TIME_OUT='"+SBJ_CUSTOMER_RECIPIENT_TIME_OUT+"' , ";
		}else
			query=query+" SBJ_CUSTOMER_RECIPIENT_TIME_OUT=null  , ";
	
	
	  //Status
	  if(mode!='update'){
		  query=query+" SBJ_DEPT_ID = '"+SBJ_DEPT_ID+"' , "+  
	 	 " SBJ_JOB_STATUS = '"+SBJ_JOB_STATUS+"' ,  ";
	  }
	  query=query+ " SBJ_CHECKER_EXT_VALUE = '"+SBJ_CHECKER_EXT_VALUE+"'  ";
		query=query+" WHERE BCC_NO = '"+BCC_NO+"' ";
 	  
	 
	  return query;
}
function doSubmitCallCenter(){ 
	var querys=[];  
	var query_update =doUpdateServiceJob('submit');
	 if(query_update!=false){ 
	   }else
	   	   return false;
	
		var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
        " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=5) as hod_reg ,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=3) as hod_sc,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=9) as hod_reg_logistic	FROM dual ";
		
SynDomeBPMAjax.searchObject(query_search,{
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
		//var BSO_DELIVERY_TYPE=$("input[name=BSO_DELIVERY_TYPE]:checked" ).val();
	  // * ไม่อยู่ในประกัน => ไปหา sale
  	  // * ให้ดำเนินการซ่อม Onsite =>ไปหา sub IT
      // * ให้ซ่อมภายใน SC => ไปหา role SC คุณฝน
      // * ให้ดำเนินการรับเครื่อง => ไปหา sup logistice
      /*
       ให้ดำเนินการซ่อม Onsite  1
	   ให้ซ่อมภายใน SC  2
       ให้ดำเนินการรับเครื่อง  3
      */
      querys.push(query_update); 
       var BCC_STATUS=$("input[name=BCC_STATUS]:checked" ).val();
      var state="";
		if(BCC_STATUS=='2'){ // IT REG
			 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
				"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
				"('${bccNo}','2','wait_for_assign_to_team','"+data[0][1]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		} 
		else if(BCC_STATUS=='1'){ // IT
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][0]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='3'){ // SC
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][2]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='4'){ // REF
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][3]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(BCC_STATUS=='5'){ // REF REG
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_assign_to_team','"+data[0][4]+"','1','Job wait for assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(SBJ_DEPT_ID=='0'){ // SALE
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_quotation','ROLE_QUOTATION_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_quotation";
		}else  { // Key Account
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
	 		querys.push(query); 
	 		 state="wait_for_send_to_supervisor";
  		}
		
		 //query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='wait_for_assign_to_team' where BSO_ID=${bccNo}";
		// querys.push(query); 
	 
		/*
		var message_todolist="Job wait for assign to Team";
		var owner_type="2";
		var owner="ROLE_SUPERVISOR_ACCOUNT";
		var hide_status='1';
		var	 query3="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_assign_to_team','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	null,'"+hide_status+"','${username}','${bccNo}',(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00'))) ) ";
		
		querys.push(query3); 
		*/
		query=" INSERT INTO "+SCHEMA_G+".BPM_SERVICE_JOB (BCC_NO,BSJ_CREATED_TIME,BSJ_STATE) VALUES ('${bccNo}',now(),'"+state+"')";
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
											bootbox.dialog("Submit Job.",[{
											    "label" : "Ok",
											    "class" : "btn-primary",
											    "callback": function() {
											    	loadDynamicPage('dispatcher/page/callcenter')
											    }
											 }]);
										}
									}
								});
	}
}});
		
	 return false;
    // return false; 
}
function doSaveDraftAction(){  	  
	   query =doUpdateServiceJob('savedraft');
	   if(query!=false){ 
	   }else
	   	   return false;
	var querys=[];
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
			//alert(data); 
			if(data!=0){
				
				loadDynamicPage('dispatcher/page/callcenter');
			}
		},errorHandler:function(errorString, exception) { 
			alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
		}
	 });
	}
function showOnSite(){  
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
     var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
     "<tbody>"+
     "<tr style=\"cursor: pointer;\">"+
      " <td style=\"text-align: left;\">สาเหตุ (Cause)<br>"+
      "     <textarea name=\"textarea3\" id=\"textarea3\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
      "     <br>"+
      "   การแก้ไข (Solution)<br>"+
      "   <textarea name=\"textarea4\" id=\"textarea4\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
      "   <br>"+
      "   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
      "   <span style=\"padding-right:10px\">  รับเครื่อง</span>"+
      "     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
      "   <span style=\"padding-right:10px\">  เปลี่ยนเครื่องใหม่</span>"+
      "    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
      "   <span style=\"padding-right:10px\">  วางสแปร์</span>"+
      "     <input type=\"checkbox\" name=\"checkbox4\" id=\"checkbox4\">"+
      "   <span style=\"padding-right:10px\">  เปลี่ยน Battery</span>"+
      "     <input name=\"textfield3\" style=\"height: 30px;\" type=\"text\" id=\"textfield3\" class=\"span1\">"+
      "   <span style=\"padding-right:10px\">  ลูก ปี Battery</span>"+
      "     <input name=\"textfield4\" style=\"height: 30px;\" type=\"text\" id=\"textfield4\" class=\"span1\">"+
      "   <span style=\"padding-right:10px\">  (ตัวปั้ม)</span></td>"+
     "  </tr>"+
   "  </tbody>"+
 "  </table>";
						bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
		 
}
function showSC( ){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
  var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
  "<tbody>"+
  "<tr style=\"cursor: pointer;\">"+
   " <td style=\"text-align: left;\">สาเหตุ (Cause)<br>"+
   "     <textarea name=\"textarea3\" id=\"textarea3\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
   "     <br>"+
   "   การแก้ไข (Solution)<br>"+
   "   <textarea name=\"textarea4\" id=\"textarea4\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea>"+
   "   <br>"+
   "   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
   "   <span style=\"padding-right:10px\">  เปลี่ยนอุปกรณ์ ตามรายการ</span>"+
   "     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
   "   <span style=\"padding-right:10px\">  ชาร์ตแบตเตอรี่</span>"+
   "    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
   "   <span style=\"padding-right:10px\">  แนะนำการใช้งาน</span>"+ 
   " </td>"+
  "  </tr>"+
"  </tbody>"+
"  </table>"+
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"5%\"><div class=\"th_class\">ลำดับ</div></th> "+
"  		<th width=\"10%\"><div class=\"th_class\">รหัส</div></th> "+
"  		<th width=\"80%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
 "  	<tr style=\"cursor: pointer;\">"+  
"  		<td>1</td>"+  
"  		<td style=\"text-align: left;\">90001</td>"+    
"  		<td style=\"text-align: left;\">Test</td>"+    
"  		<td style=\"text-align: left;\">2</td>"+   
 "  	</tr>  "+
"  </tbody>"+
"  </table>";
						bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showBorrow(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"<tbody>"+
"<tr style=\"cursor: pointer;\">"+
" <td style=\"text-align: left;\"> "+
"   <input type=\"checkbox\" name=\"checkbox\" id=\"checkbox\">"+
"   <span style=\"padding-right:10px\">  ซ่อม Site</span>"+
"     <input type=\"checkbox\" name=\"checkbox2\" id=\"checkbox2\">"+
"   <span style=\"padding-right:10px\">  สแปร์</span>"+
"    <input type=\"checkbox\" name=\"checkbox3\" id=\"checkbox3\">"+
"   <span style=\"padding-right:10px\">  เปลี่ยนเครื่อง</span>"+ 
" </td>"+
"  </tr>"+

"  </tbody>"+
"  </table>"+
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"5%\"><div class=\"th_class\">ลำดับ</div></th> "+
"  		<th width=\"10%\"><div class=\"th_class\">รหัส</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">คลัง</div></th> "+
"  		<th width=\"75%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+  
"  		<td>1</td>"+  
"  		<td style=\"text-align: left;\">90001</td>"+   
"  		<td style=\"text-align: left;\">2</td>"+   
"  		<td style=\"text-align: left;\">Test</td>"+    
"  		<td style=\"text-align: left;\">2</td>"+   
"  	</tr>  "+
"  </tbody>"+
"  </table>";
						bootbox.dialog("<div>ยืม</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showCheck(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
var str="<table width=\"100%\" style=\"font-size: 12px\" border=\"0\">"+
"<tbody>"+ 
"<tr valign=\"top\" style=\"cursor: pointer;\">"+
" <td style=\"text-align: left;\" valign=\"top\" width=\"60%\"> "+ 
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"80%\"><div class=\"th_class\">รายการ</div></th> "+
"  		<th width=\"15%\"><div class=\"th_class\">วัดได้</div></th> "+
"  		<th width=\"5%\"><div class=\"th_class\">ผ่าน</div></th> "+ 
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 198-242Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 165-198Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Input 243-275Vac)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Output (Battery Mode)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ความถี่ Output (Battery Mode)</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดันชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">กระแสชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">แรงดัน Low Battery Cut Off</td>"+   
"  		<td style=\"text-align: left;\"><input style=\"height:25px;width:80px\" type=\"text\"/></td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ชาร์จแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ทดสอบสำรองไฟ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การทำงานของพัดลม</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การแสดงผลของ LED/LCD</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">สัญญาณเสียง Alarm ต่างๆ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ปุ่มทดสอบแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การทำงานของพัดลม</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">การแสดงผลของ LED/LCD</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">สัญญาณเสียง Alarm ต่างๆ</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\">ปุ่มทดสอบแบตเตอรี่</td>"+   
"  		<td style=\"text-align: left;\">X</td>"+    
"  		<td style=\"text-align: left;\"><input type=\"checkbox\"/></td>"+ 
"  	</tr>  "+
"  </tbody>"+
"  </table>"+
" </td>"+
" <td style=\"text-align: left;padding-left:5px\" valign=\"top\" width=\"40%\"> "+ 
"<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
"	<thead> 	"+
"  		<tr> "+
"  		<th width=\"100%\" colspan=\"2\"><div class=\"th_class\">รายการ</div></th> "+ 
" 		</tr>"+
"	</thead>"+
"	<tbody>   "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td width=\"30%\"  style=\"text-align: left;\"><span>กระแสโหลด</span></td>"+   
"  		<td width=\"70%\" style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"> A</span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+ 
"  		<td style=\"text-align: left;\"><span>ขนาดสายไฟ</span></td>"+  
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"> SQ.mm</span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+   
"  		<td style=\"text-align: left;\"><span>ปีแบตเตอรี่ (ตัวปั้ม)</span></td>"+   
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"></span></td>"+   
"  	</tr>  "+
"  	<tr style=\"cursor: pointer;\">"+  
"  		<td style=\"text-align: left;\"><span>ปีแบตเตอรี่ (สติ๊กเกอร์)</span></td>"+   
"  		<td style=\"text-align: left;\"><span><input style=\"height: 30px;\" type=\"text\"></span></td>"+   
"  	</tr>  "+
"  	<tr  valign=\"top\" style=\"cursor: pointer;\">"+   
"  		<td colspan=\"2\" style=\"text-align: left;\"><span>อื่นๆ <textarea name=\"textarea\" id=\"textarea\" cols=\"100\" rows=\"3\"></textarea></span></td>"+   
"  	</tr>  "+ 
"  </tbody>"+
"  </table>"+
" </td>"+
"  </tr>"+ 
"  </tbody>"+
"  </table>"; 
						bootbox.dialog("<div>ตรวจเช็ค</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );

}
function showReceive(){
	 var button_cancel="<a class=\"btn btn-primary\" style=\"margin-top: 10px;\" onclick=\"\">"+
		"<span style=\"color: white;font-weight: bold;\">Submit</span></a>&nbsp;&nbsp;&nbsp;"+
		"<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\">"+
		"<span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
	var str="<table class=\"table table-striped table-bordered table-condensed\" style=\"font-size: 12px\" border=\"1\">"+
    "<tbody>"+
    "<tr style=\"cursor: pointer;\">"+
    "  <td style=\"text-align: left;\"><table width=\"100%\" border=\"0\" cellpadding=\"0\">"+
    "    <tbody><tr>"+
    "      <td width=\"20%\">กล่องกระดาษกระเป๋า</td>"+
    "      <td width=\"80%\"><input type=\"radio\" name=\"radio\"   value=\"radio\">"+
    "        มี&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" name=\"radio\"  value=\"radio2\">"+
    "ไม่มี</td>"+
    "      </tr>"+
    "    <tr>"+
    "      <td>สายไฟ</td>"+
    "      <td><input type=\"radio\" name=\"radio0\"   value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio0\"  value=\"radio2\">"+
"ไม่มี</td>"+
 "         </tr>"+
 "       <tr>"+
 "         <td>รอยขีดข่วน</td>"+
 "         <td><input type=\"radio\" name=\"radio1\"  value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio1\"   value=\"radio2\">"+
"ไม่มี</td>"+
"          </tr>"+
"        <tr>"+
"          <td>แบตเตอรี่</td>"+
"          <td><input type=\"radio\" name=\"radio2\"  value=\"radio\">"+
"มี&nbsp;&nbsp;&nbsp;&nbsp;"+
"<input type=\"radio\" name=\"radio2\"   value=\"radio2\">"+
"ไม่มี</td>"+
"          </tr>"+
"        <tr>"+
"          <td colspan=\"2\">อื่นๆ : "+
"           <textarea name=\"textarea\" id=\"textarea\" cols=\"100\" rows=\"3\" class=\"span10\"></textarea></td>"+
"          </tr>"+
"      </tbody></table>"+
"       </td>"+
"    </tr>"+
"  </tbody>"+
"</table>";
bootbox.dialog("<div>อาการเสียที่ตรวจพบ</div>"+str+"<div style=\"align: right;margin-left:370px\">"+button_cancel+"</div>" );
}
function addBorrowItem(bccNo,type){ 
	// type 1=ยืม,2=ใช้
	//BPM_SERVICE_ITEM_MAPPING
	bootbox.hideAll();
	 
					   var button_cancel=""+
		                  "<a class=\"btn btn-danger\" style=\"margin-top: 10px;\" onclick=\"hideAllDialog()\"><span style=\"color: white;font-weight: bold;\">Cancel</span></a>";
						// bootbox.dialog();
		                var remark_str="<div align=\"right\" style=\"\">"+button_cancel+"</div>" ;
						var function_str="addBorrowItemToList('"+bccNo+"','"+type+"')";
						var label_str="Add Item";
						var input_id="ima_item_id";
						var input_hidden_id="IMA_ItemID"; 
						var query="SELECT IMA_ItemID,IMA_ItemName,LocQty,ROUND(AcctValAmt,2),CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name  FROM "+SCHEMA_G+".BPM_PRODUCT "+	
						  " where  CONCAT(IMA_ItemID, ' ', IMA_ItemName) like ";
						
						var bt= "<span style=\"padding-left:10px\"><a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
						var input_str= "<span>รหัส&nbsp;&nbsp;&nbsp;<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+ 
							            "<input type=\"hidden\" id=\"IMA_ItemID\" /><input type=\"hidden\" id=\"BSIM_PRICE\" name=\"BSIM_PRICE\" style=\"height: 30;\" /></span>"+  
						 				"<span style=\"padding-left:10px\">คลัง&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_STORE\" name=\"BSIM_STORE\" style=\"height: 30;width:50px\" /></span>"+
						 				"<span style=\"padding-left:10px\">จำนวน&nbsp;&nbsp;<input type=\"text\" id=\"BSIM_AMOUNT\" name=\"BSIM_AMOUNT\" style=\"height: 30;width:50px\" /></span>";
						 var  item_section_str="";
						 bootbox.classes("aoe_small");
						 bootbox.dialog(input_str+bt+"</span><br/><span id=\"item_name\"></span>"+item_section_str+remark_str);
						//  alert(input_id)
						 $("#"+input_id+"" ).autocomplete({
							  source: function( request, response ) {    
								  //$("#pjCustomerNo").val(ui.item.label);
								  $("#IMA_ItemID").val("");
								  var queryiner=query+" '%"+request.term+"%' limit 15 ";
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
										        	  label: item[0]+" "+item[1]+" ["+item[2]+"]",
										        	  value: item[0] ,
										        	//  IMA_ItemID,IMA_ItemName,LocQty,LastCostAmt,CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name 
										        	  id: item[0],
										        	  IMA_ItemID:item[0] ,
										        	  IMA_ItemName:item[1] ,
										        	  LocQty:item[2] ,
										        	  Price:item[3] ,
										        	  name:item[4] 
										          }
										        }));
											}else{
												var xx=[]; 
												response( $.map(xx));
											}
										}
										,errorHandler:function(errorString, exception) { 
											alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
										}
								 });		  
							  },
							  minLength: 1,
							  select: function( event, ui ) { 
								  this.value = ui.item.value;
								  $("#"+input_hidden_id+"").val(ui.item.id);   
									
					 
								  document.getElementById("BSIM_PRICE").value=ui.item.Price; 
								  $("#item_name").html(ui.item.IMA_ItemName+" ["+ui.item.LocQty+"]"); 
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
function renderBorrowItemList(bccNo,type){
	// alert(BSJ_REMARK)  
	var query_common=" SELECT  mapping.BCC_NO,mapping.IMA_ItemID,product.IMA_ItemName, mapping.BSIM_AMOUNT "+
		 					",mapping.BSIM_STORE,mapping.BSIM_TYPE "+  
"FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING  mapping left join "+SCHEMA_G+".BPM_PRODUCT product "+
" on mapping.IMA_ItemID=product.IMA_ItemID  where mapping.BSIM_TYPE='"+type+"' AND mapping.BCC_NO='"+bccNo+"'"; 
var query= query_common;



//var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
var queryObject="  "+query;//+"   limit "+limitRow+", "+_perpageG;
var queryCount=" select count(*) from (  "+query+" ) as x";
//alert(queryObject)
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
	bootbox.hideAll();
	var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
	        "	<thead> 	"+
	        "  		<tr> "+
	        "  		<th width=\"5%\"><div class=\"th_class\">#</div></th> "+
	        "  		<th width=\"20%\"><div class=\"th_class\">รหัส</div></th> "+
	        "  		<th width=\"10%\"><div class=\"th_class\">คลัง</div></th> "+
	        "  		<th width=\"55%\"><div class=\"th_class\">รายการ</div></th> "+
	        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+   
	        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+  
	        " 		</tr>"+
	        "	</thead>"+
	        "	<tbody>   ";  
	   if(data!=null && data.length>0){ 
		   
		   for(var i=0;i<data.length;i++){  
			 
			   str=str+ "  	<tr style=\"cursor: pointer;\">"+
			   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
			   "  		<td style=\"text-align: left;\"> "+data[i][1]+"</td>"+    
		        "    	<td style=\"text-align: left;\">"+data[i][4]+"</td>  "+  
		        "    	<td style=\"text-align: left;\">"+data[i][2]+"</td>  "+  
		        "    	<td style=\"text-align: center;\">"+data[i][3]+"</td>  "+
		        "    	<td style=\"text-align: center;\">";
		        if(type=='1'){
		        	<c:if test="${!isOperationAccount}">
		        	 str=str+ " <i title=\"Delete\" onclick=\"doDeleteMappingItem('"+data[i][0]+"','"+data[i][1]+"','"+type+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>  "
		        	</c:if>
		        }else{ 
		        	 str=str+ " <i title=\"Delete\" onclick=\"doDeleteMappingItem('"+data[i][0]+"','"+data[i][1]+"','"+type+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>  "
		         }
		        str=str+ "</td> "+
		        "  	</tr>  ";
		   } 
	   }else{
		   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
	    /* str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
    		"<thead>"+
    		"<tr> "+
  			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
  		"</tr>"+
	"</thead>"+
	"<tbody>"; 
	*/
	   }
	  
	   str=str+  " </tbody>"+
	   "</table> "; 
	   
	 $("#item_section_"+type).html(str);
}
});
}
function addBorrowItemToList(bccNo,type){
	 
	//var IMA_ItemID=jQuery.trim($("#ima_item_id").val()); 
	var IMA_ItemID=jQuery.trim($("#IMA_ItemID").val());
	
	var BSIM_PRICE=jQuery.trim($("#BSIM_PRICE").val());
	var BSIM_AMOUNT=jQuery.trim($("#BSIM_AMOUNT").val());
	var BSIM_STORE=jQuery.trim($("#BSIM_STORE").val()); 
	if(!IMA_ItemID.length>0){
		 alert('กรุณากรอก รหัสให้ถูกต้อง.');  
		 $("#IMA_ItemID").val("");
		 $("#ima_item_id").val("");
		 $("#ima_item_id").focus(); 
		 $("#IMA_ItemID").focus(); 
		 return false; 	
	}
	if(!BSIM_STORE.length>0){
		 alert('กรุณากรอก ข้อมูล.');  
		 $("#BSIM_STORE").focus(); 
		 return false;	
	}
	 var  isNumber=checkNumber(jQuery.trim($("#BSIM_AMOUNT").val())); 
	 if(isNumber){  
		 alert('กรุณากรอก  จำนวน เป็นตัวเลข.');  
		 $("#BSIM_AMOUNT").val(""); 
		 $("#BSIM_AMOUNT").focus(); 
		 return false;	  
	 } 
	  
	var getAutoK="SELECT count(*) FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING where "+
		" BCC_NO='"+bccNo+"'  and IMA_ITEMID='"+IMA_ItemID+"' and BSIM_TYPE='"+type+"'";
	 SynDomeBPMAjax.searchObject(getAutoK,{
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
			    var max_auto=1;
				if(data>0){ 
					bootbox.dialog("ข้อมูลถูกเพิ่มไปก่อนหน้านี้แล้ว",[{
					    "label" : "Close",
					     "class" : "btn-danger"
				   }]);
				 return false;
				}else{
					
				}
				var querys=[]; 
				var query="INSERT INTO "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING (BCC_NO,IMA_ItemID,BSIM_STORE,BSIM_AMOUNT,BSIM_TYPE,BSIM_PRICE) "+
				          " VALUES('"+bccNo+"','"+IMA_ItemID+"','"+BSIM_STORE+"','"+BSIM_AMOUNT+"','"+type+"','"+BSIM_PRICE+"'); ";
				 
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
							renderBorrowItemList(bccNo,type);
							//bootbox.hideAll();
						}
					},errorHandler:function(errorString, exception) { 
						alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
					}
				});
		 }
	 });
	
}
function doDeleteMappingItem(bccNo,itemId,type){
	var querys=[]; 
	var query=" DELETE FROM "+SCHEMA_G+".BPM_SERVICE_ITEM_MAPPING WHERE BCC_NO='"+bccNo+"' and IMA_ItemID='"+itemId+"' and BSIM_TYPE='"+type+"'"; 
	 
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
				renderBorrowItemList(bccNo,type);
				//bootbox.hideAll();
			}
		},errorHandler:function(errorString, exception) { 
			alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
		}
	});
}
function doUpdateJob(){ 
	var querys=[];  
	var query_update =doUpdateServiceJob('submit');
	//alert(query_update);
	 if(query_update!=false){
		// return false;
	   }else
	   	   return false;
	 querys.push(query_update);
	  var SBJ_JOB_STATUS=$("#SBJ_JOB_STATUS" ).val();
	 // var SBJ_DEPT_ID=$("#SBJ_DEPT_ID").val();

		 var SBJ_DEPT_ID = jQuery.trim($("input[name=SBJ_DEPT_ID]:checked" ).val());
		<%-- 
	  <select id="SBJ_JOB_STATUS">
		<option value="1">รับเครื่อง/เช็คไซต์</option>
		<option value="2">เสนอราคา</option>
		<option value="3">รออนุมัติซ่อม</option>
		<option value="4">ซ่อม</option>
		<option value="5">ส่งเครื่อง</option>
		<option value="6">ตรวจสอบเอกสาร</option>
		<option value="7">ปิดงานเรียบร้อย</option>
	</select>
</span>
<span style="padding-left:40px">หน่วยงาน</span> 
<span style="padding-left:10px">
	<select id="SBJ_DEPT_ID">
		<option value="1">SC</option>
		<option value="2">IT</option>
		<option value="3">Reg</option>
		<option value="4">Logistic</option>
		<option value="5">Logistic Reg</option>
		<option value="6">Sale</option> 
	</select>
	--%>
      var state="";
      var query2=";"
      var query="";
      if(SBJ_JOB_STATUS!='3'){
		if(SBJ_DEPT_ID=='3'){ // IT REG ต่างจังหวัด
			 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
				"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
				"('${bccNo}','2','wait_for_it_reg_assign_to_team','siwaporn','1','Job wait for IT Reg assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
			
		} 
		else if(SBJ_DEPT_ID=='2'){ // IT
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_it_assign_to_team','sommai','1','Job wait for IT assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(SBJ_DEPT_ID=='1'){ // SC
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_sc_assign_to_team','numfon','1','Job wait for SC assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(SBJ_DEPT_ID=='4'){ // REF
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_ref_assign_to_team','maytazzawan','1','Job wait for REF assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(SBJ_DEPT_ID=='5'){ // REF REG
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_ref_reg_assign_to_team','regent_admin','1','Job wait for REF Reg assign to Team','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_assign_to_team";
		}
		else if(SBJ_DEPT_ID=='6'){ // SALE
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
					"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
					"('${bccNo}','2','wait_for_sale_quotation','ROLE_QUOTATION_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
			 querys.push(query); 
			 state="wait_for_quotation";
		}else  { // Key Account
			query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bccNo}','2','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','Job wait for Create Quotation','',0,now(),	null,'1','${username}','${bccNo}',null) ";
	 		querys.push(query); 
	 		 state="wait_for_send_to_supervisor";
  		}  
		var owner='${username}'; 
			  <c:if test="${isKeyAccount}">
			 		 owner='ROLE_KEY_ACCOUNT';
		 	  </c:if>
		 	  <c:if test="${isQuotationAccount}">
		 		 owner='ROLE_QUOTATION_ACCOUNT';
	 	  </c:if>
		  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bccNo}' and "+
			"BTDL_TYPE='2' and BTDL_STATE='${state}' and BTDL_OWNER='"+owner+"'";
			//alert(query2)
		  querys.push(query2); 
      }
		//querys.push(query); 
		//alert(SBJ_JOB_STATUS)
    if(SBJ_JOB_STATUS=='7'){
    	doCloseJob('2','wait_for_supervisor_services_close','${username}','1','Job Closed');
    }else{
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
					bootbox.dialog("Submit Job.",[{
					    "label" : "Ok",
					    "class" : "btn-primary",
					    "callback": function() {
					    	loadDynamicPage('dispatcher/page/todolist')
					    }
					 }]);
				}
			}
		});
    }
}
function doCloseServicesJob(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bccNo}' and "+
	"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";
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
				//if(data!=null && data.length>0){
					//showDialog(message_duplicate);
				//}else{
					var querys=[];  
					var btdl_state_update='wait_for_supervisor_services_close';
					 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
							"('${bccNo}','"+btdl_type+"','"+btdl_state_update+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','${bccNo}') ";
					 if('${state}'!='' && is_hide_todolist){
					  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bccNo}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
					 } 
					 if(btdl_state=='wait_for_supervisor_services_close'){
						 query2="update "+SCHEMA_G+".BPM_SERVICE_JOB set BSJ_STATE='"+btdl_state+"' where BCC_NO=${bccNo}"; 
						  querys.push(query2); 
					 }
				  
						var query_update =doUpdateServiceJob('update');
						//alert(query_update);
						 if(query_update!=false){
							// return false;
						   }else
						   	   return false;
					 querys.push(query_update);
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
								bootbox.dialog(message_created,[{
								    "label" : "Ok",
								    "class" : "btn-primary",
								    "callback": function() {
								    	loadDynamicPage('dispatcher/page/todolist')
								    }
								 }]);
							}
						}
					});
				//} 
			}});
	
}

function doCloseJob(btdl_type,btdl_state,owner,owner_type,message){
	   /*  alert($("#BSO_IS_DELIVERY").val());
	    alert($("#BSO_IS_INSTALLATION").val()) */; 
	    
	    var querys=[];  
		var query_update =doUpdateServiceJob('submit');
		//alert(query_update);
		 if(query_update!=false){
			// return false;
		   }else
		   	   return false;
		 querys.push(query_update);
		  var SBJ_JOB_STATUS=$("#SBJ_JOB_STATUS" ).val();
		 // var SBJ_DEPT_ID=$("#SBJ_DEPT_ID").val();

			 var SBJ_DEPT_ID = jQuery.trim($("input[name=SBJ_DEPT_ID]:checked" ).val());
			 query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bccNo}' and "+
				"BTDL_TYPE='2' and BTDL_STATE='${state}' and BTDL_OWNER='ROLE_KEY_ACCOUNT' ";
			  querys.push(query2); 
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
						bootbox.dialog("Closed Job.",[{
						    "label" : "Ok",
						    "class" : "btn-primary",
						    "callback": function() {
						    	loadDynamicPage('dispatcher/page/todolist')
						    }
						 }]);
					}
				}
			});
	    }
	 
 function clearSelect(ele_name){
	 $('input[name=\"'+ele_name+'\"]').prop('checked', false);
 }
 function getSelectEle(ele_name,ele_value){
	 $('input[name=\"'+ele_name+'\"][value="' + ele_value + '"]').prop('checked', true);
 }
 function show_hide_element(ele_name_source,ele_name,ele_value){
	 
    if($('#'+ele_name_source).prop('checked')){
    	 $('#'+ele_name).slideDown(1000);
    }else
    	 $('#'+ele_name).slideUp(1000); 
 }
 function show_hide(ele_name,ele_value){
	 if(ele_value=='1'){
		 $('#'+ele_name).show();
	 }else
		 $('#'+ele_name).hide();
 }
 function clearElementValue(ele){
	 $("#"+ele).val("");
 }
 function clearElementTimeValue(){
	 $("#BCC_DUE_DATE").val("");
	 $("#BCC_DUE_DATE_START").val("");
	 $("#BCC_DUE_DATE_END").val(""); 
 }
</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px;padding-left:2px">
        <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px" bgcolor="#F9F9F9">
          <form id="breakdownForm" name="breakdownForm" class="well" action="" method="post">
            <fieldset style="font-family: sans-serif;">
              <div align="left">
                  <span><strong id="delivery_install_title">เลขที่แจ้งซ่อม </strong>
                  <input type="text" id="BCC_NO" style="height: 30px;width: 125px" value=" " readonly="readonly"/>
                  </span> 
                   <span  style="padding-left: 5px"><strong>วันที่เปิดเอกสาร</strong>
                    <input type="text" readonly="readonly" style="width:130px; height: 30px;" id="BCC_CREATED_TIME" /> 
                  </span> 
                   <span  style="padding-left: 5px"><strong>เวลานัดหมาย</strong>
                    <input type="text" id="BCC_DUE_DATE" style="width:100px; height: 30px;" value="" readonly="readonly">
                    ระบุเวลา
                    <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_START" type="text"> 
                                  - เวลา
                                  <input   readonly="readonly" style="cursor:pointer;width:50px; height: 30px;" id="BCC_DUE_DATE_END" type="text">
                                  <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementTimeValue()"></i>
                  </span>  
                  <span  style="padding-left: 5px">
                  <%--
                 		 <a class="btn btn-primary btnPrint"  href='dispatcher/page/service_supervisor_print?bccNo=${bccNo}&mode=edit&state=${state}&requestor=${requestor}'><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบเสนอราคา</span></a>
                 		  --%>
                 		   <c:if test="${isKeyAccount}">
                 		  <a class="btn btn-primary" onclick="printJobServices()"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบแจ้งซ่อม</span></a>
				
				 	      <a class="btn btn-primary" style="padding-left:10px" onclick="updateJobServicesConfirm()"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">แก้ใขข้อมูล</span></a>
				 </c:if>	 
				 	 </span>
                <br>
                <br>
              </div>
              <table border="0" width="100%" style="font-size: 12px"> 
                    <tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="6%">
    					   				<span>
    					   				บริษัทผู้ขาย(Dealer/User):
    					   				<%-- 	บริษัทผู้แจ้ง: --%>
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_CUSTOMER_NAME" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					บริษัทผู้แจ้ง(สถานที่ซ่อม):
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px;height: 30px;" id="BCC_LOCATION" /> 
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ: 
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px;height: 30px;" id="BCC_CONTACT" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	<tr>
    					   		<td width="6%">
    					   				<span>
    					   					เบอร์โทร:
    					   				</span> 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px"> 
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_TEL" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					ที่อยู่:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR1" />
    					   				</span> 
    					   		</td> 
    					   		<td width="6%">
    					   				<span>
    					   					แขวง/ตำบล:
    					   				</span>
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR2" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	<tr>
    					   		<td width="7%">
    					   				<span>
    					   					เขต/อำเภอ:
    					   				</span> 
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ADDR3" />
    					   				</span>
    					   		</td> 
    					   		<td width="6%"> 
    					   				<span>
    					   					จังหวัด:
    					   				</span>
    					   				 
    					   		</td>
    					   		<td width="27%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_PROVINCE" />
    					   				</span> 
    					   		</td> 
    					   		<td width="7%">
    					   				<span>
    					   					รหัสไปรษณีย์:
    					   				</span>
    					   		</td>
    					   		<td width="26%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:300px;height: 30px;" id="BCC_ZIPCODE" />
    					   				</span> 
    					   		</td> 
    					   	</tr>
    					   	</table> 
    					  </div>
    					</td>
    				</tr>
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top:1px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="66%" colspan="4">
    					   				<span style="padding-left: 100px">
    					   					[ <span id="BCC_IS_MA_1"></span> ] ในประกัน (Warranty)
    					   				</span> 
    					   				<span style="padding-left: 50px">
    					   					[ <span id="BCC_IS_MA_2"></span> ] สัญญา MA เลขที่ (Contact No.):
    					   				</span> 
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;"  id="BCC_MA_NO" />
    					   				</span> 
    					   		</td> 
    					   		<td width="10%">
    					   				<span>
    					   					วันเริ่มรับประกัน:
    					   				</span>
    					   		</td>
    					   		<td width="23%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;" readonly="readonly" id="BCC_MA_START" />
    					   				</span> 
    					   		</td> 
    					   	</tr> 
    					   	<tr>
    					   		<td width="66%" colspan="4">
    					   				<span style="padding-left: 100px">
    					   					[ <span id="BCC_IS_MA_0"></span> ] นอกประกัน (Out Warranty)
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_1"></span> ] Gold
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_2"></span> ] Silver
    					   				</span> 
    					   				<span style="padding-left: 15px">
    					   					[ <span id="BSO_MA_TYPE_3"></span> ] Bronze
    					   				</span>  
    					   		</td> 
    					   		<td width="10%">
    					   				<span>
    					   					วันหมดรับประกัน:
    					   				</span>
    					   		</td>
    					   		<td width="23%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px;height: 30px;" readonly="readonly" id="BCC_MA_END" />
    					   				</span> 
    					   		</td> 
    					   	</tr> 
    					   	</table> 
    					  </div>
    					</td>
    				</tr>
    		</table>
              <table style="font-size: 12px" border="0" width="100%">
                <tbody>
                  <tr>
                    <td width="100%"></td>
                  </tr>
                  <tr valign="top">
                    <td align="left" valign="top"><table class="table table-striped table-bordered table-condensed" style="font-size: 12px" border="1">
                      <thead>
                        <tr>
                          <th width="5%"><div class="th_class">หมายเลขเครื่อง</div></th>
                          <th width="12%"><div class="th_class">Model (รุ่น)</div></th>
                          <th width="22%"><div class="th_class">อาการเสีย</div></th>
                           <th width="15%"><div class="th_class">Flow</div></th>
                           <th width="16%"><div class="th_class">บันทึกเพิ่มเติม(เบื้องต้น)</div></th>
                            <th width="22%"><div class="th_class">บันทึกเพิ่มเติม</div></th>
                          <th width="8%"><div class="th_class">SLA</div></th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr style="cursor: pointer;">
                          <td style="text-align: left;"><input name="BCC_SERIAL" style="width:130px;height: 30;" type="text" id="BCC_SERIAL" value=""></td>
                          <td style="text-align: left;"><input name="BCC_MODEL"  readonly="readonly" style="width:150px;height: 30;" type="text" id="BCC_MODEL" value=""></td>
                          <td style="text-align: left;"><textarea name="BCC_CAUSE"  readonly="readonly" id="BCC_CAUSE" cols="100" rows="3" class="span10"></textarea></td>
                          <td style="text-align: left;">
                          <span id="flow"></span></td>
    					   	  <td style="text-align: left;">
    					   	   <textarea name="BCC_REMARK" id="BCC_REMARK" cols="100" rows="3" class="span10"></textarea>
                         </td>
    					   	  <td style="text-align: left;">
    					   	   <textarea name="BSJ_REMARK" id="BSJ_REMARK" cols="100" rows="3" class="span10"></textarea>
                         </td>
                         
    					   	  <td style="text-align: left;">
    					   	 <select name="BCC_SLA" id="BCC_SLA" style="width:70px">
                        <option value="24">24 ชม.</option>
                        <option value="48">48 ชม.</option>
                        <option value="72">72 ชม.</option> </select></td>
    
                        </tr>
                      </tbody>
                    </table>
                    </td>
                  </tr> 
                </tbody>
              </table>
              <table border="0" width="100%" style="font-size: 12px"> 
    				<tr valign="top">
    					<td width="45%" valign="top" align="left">
    						 <div id="service_box1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>อาการเสียที่ตรวจพบ</span>
    						    		</td>
    						    		<td width="65%">
    						    			<span> <input type="text" id="SBJ_ONSITE_DETECTED" style="width:300px;height: 30;"/></span>
    						    		</td>
    						    		<td width="15%">
    						    			 <a class="btn btn-info"><span style="font-weight:bold;">On Site</span></a>
    						    		</td>
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>สาเหตุ (Cause)</span>
    						    		</td>
    						    		<td width="80%" colspan="2">
    						    			<span><textarea name="SBJ_ONSITE_CAUSE"  style="width:420px;" id="SBJ_ONSITE_CAUSE" cols="100" rows="3"></textarea></span>
    						    		</td>
    						    		 
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>การแก้ใข (Solution)</span>
    						    		</td>
    						    		<td width="80%" colspan="2">
    						    			<span><textarea name="SBJ_ONSITE_SOLUTION"  style="width:420px;" id="SBJ_ONSITE_SOLUTION" cols="100" rows="3"></textarea></span>
    						    		</td>
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="100%" colspan="3">
    						    			<div style="padding-left:50px">
    						    			 <span ><input type="checkbox" value="1" id="SBJ_ONSITE_IS_GET_BACK"/> รับเครื่อง</span>
    						    			 <span style="padding-left:50px"><input type="checkbox" value="1" id="SBJ_ONSITE_IS_REPLACE"/> เปลี่ยนเครื่องใหม่</span>
    						    			 </div>   
    						    			 <div style="padding-left:50px">
    						    			 <span ><input type="checkbox" value="1" id="SBJ_ONSITE_IS_SPARE"/> วางสแปร์</span>
    						    			 <span style="padding-left:50px"><input type="checkbox" value="1" id="SBJ_ONSITE_IS_BATTERRY"/> เปลี่ยน Battery <input type="text"  id="SBJ_ONSITE_BATTERY_AMOUNT" style="width:50px;height: 30;"/> ลูก </span>
    						    			 <span>ปี Battery<input type="text"    id="SBJ_ONSITE_BATTERY_YEAR" style="width:50px;height: 30;"/> (ตัวปั้ม)</span>
    						    			 </div>
    						    		</td> 
    						    	</tr>
    						    </table> 
    						 </div>
    						 <div  id="service_box2" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    	<tr valign="top">
    						    		<td width="85%" colspan="2">
    						    			<div style="padding-left:50px">  
    						    			 <span ><input type="checkbox" value='1' id="SBJ_BORROW_IS_REPAIR_SITE"/> ซ่อม Site</span>
    						    			 <span style="padding-left:50px"><input type="checkbox"  value='1' id="SBJ_BORROW_IS_SPARE"/> สแปร์</span>
    						    			  <span style="padding-left:50px"><input type="checkbox"  value='1' id="SBJ_BORROW_IS_CHANGE"/> เปลี่ยนเครื่อง</span> 
    						    			 </div>
    						    		</td> 
    						    		<td width="15%" align="right"> 
    						    			 <a class="btn btn-info"><span style="font-weight:bold;">ยืม</span></a>
    						    		</td>
    						    	</tr>
    						    	<tr>
    						    		<td width="30%" colspan="1" align="left">
    						    		    <c:if test="${!isOperationAccount}">
    						    		 	   <i onclick="addBorrowItem('${bccNo}','1')" style="cursor: pointer;" class="icon-plus-sign"></i>
    						    		 	 </c:if> 
    					  				</td> 
    					  				<td width="70%" colspan="2" align="right">
    						    			 <span style="">Serial:<input type="text" style="height:30px;width:150px"  id="SBJ_BORROW_SERAIL"/></span>
    						    		  </td>
    					  			</tr>
    						    	<tr valign="top">
    						    		<td width="100%" colspan="3">
    						    			<span id="item_section_1"></span>
    						    			<%-- 
    						    			 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 	<thead>  
        											<tr>
        												<th width="5%"><div class="th_class">ลำดับ</div></th>
        												<th width="20%"><div class="th_class">รหัส</div></th>
        												<th width="10%"><div class="th_class">คลัง</div></th>
        												<th width="50%"><div class="th_class">รายการ</div></th>
        												<th width="10%"><div class="th_class">จำนวน</div></th>
        												<th width="5%"><div class="th_class"></div></th>
      												</tr>
         										</thead>
       											<tbody> 
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;">1</td>
       													<td style="text-align: left;">01103</td>
       													<td style="text-align: left;">1</td>
       													<td style="text-align: left;">กล่องโลหะ UPS 10 KVA (CAT 025)</td>
       													<td style="text-align: left;">1</td>
       													<td style="text-align: left;">1</td> 
       												</tr>
       											</tbody>
       											</table>
       											 --%>
    						    		</td> 
    						    	</tr>  
  									<c:if test="${isKeyAccount || isSupervisorAccount}">
    						    	<tr valign="top">
    						    		<td width="100%" colspan="3">
    						    			<table style="width:100%;font-size: 12px">
    						    				<tr>
    						    					<td width="20%">
    						    						ผู้ยืม 
    						    					</td>
    						    					<td width="30%">
    						    					    <input type="text" id="SBJ_BORROW_ACTOR"  style="height:30px"/>
    						    					</td>
    						    					<td align="center" width="20%">
    						    						วันที่
    						    					</td>
    						    					<td width="30%">
    						    						   <input id="SBJ_BORROW_ACTOR_DATE"  readonly="readonly" type="text" style="width:100px;height:30px"/>
    						    					    <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_BORROW_ACTOR_DATE')"></i> 
    						    					 </td>
    						    				</tr> 
    						    				<tr>
    						    					<td width="20%">
    						    						ผู้อนุมัติ
    						    					</td>
    						    					<td width="30%">
    						    					       <input id="SBJ_BORROW_APPROVER" type="text" style="height:30px"/>
    						    					 </td>
    						    					<td align="center" width="20%">
    						    						วันที่
    						    					</td>
    						    					<td width="30%"> 
    						    						<input id="SBJ_BORROW_APPROVER_DATE"  readonly="readonly" type="text" style="width:100px;height:30px"/>
    						    					    <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_BORROW_APPROVER_DATE')"></i> 
    						    					</td>
    						    				</tr>
    						    				<tr>
    						    					<td width="20%">
    						    						ผู้ส่งคืน
    						    					</td>
    						    					<td width="30%">
    						    					    <input type="text"  id="SBJ_BORROW_SENDER"  style="height:30px"/>
    						    					</td>
    						    					<td align="center" width="20%">
    						    						วันที่
    						    					</td>
    						    					<td width="30%"> 
    						    						<input id="SBJ_BORROW_SENDER_DATE"  readonly="readonly" type="text" style="width:100px;height:30px"/>
    						    					    <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_BORROW_SENDER_DATE')"></i> 
    						    					</td>
    						    				</tr>
    						    				<tr>
    						    					<td width="20%">
    						    						ผู้รับคืน
    						    					</td>
    						    					<td width="30%">
    						    					    <input type="text" id="SBJ_BORROW_RECEIVER" style="height:30px"/>
    						    					</td>
    						    					<td align="center" width="20%">
    						    						วันที่
    						    					</td>
    						    					<td width="30%"> 
    						    						<input id="SBJ_BORROW_RECEIVER_DATE"  readonly="readonly" type="text" style="width:100px;height:30px"/>
    						    					    <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_BORROW_RECEIVER_DATE')"></i> 
    						    					</td>
    						    				</tr>
    						    			</table>
    						    		</td> 
    						    	</tr> 
    						    	</c:if>
    						    </table> 
    						 </div>
    						  <div  id="service_box3" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    	<tr valign="top">
    						    		<td width="65%" colspan="2">
    						    			 
    						    		</td> 
    						    		<td width="25%" align="right"> 
    						    			 <a class="btn btn-info"><span style="font-weight:bold;">แนบเอกสาร</span></a>
    						    		</td> 
    					  			</tr>
    						    	<tr valign="top">
    						    		<td width="100%" colspan="3">
    						    			 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 	 
       											<tbody>
       												<tr style="cursor: pointer;"> 
       													
       													<td style="text-align: left;" width="30%">แนบเอกสาร</td>
       													<td style="text-align: left;" width="70%"> 
       													<span>
    					   									<input class="btn" id="SBJ_DOC_ATTACH_1" type="button" value="Upload">     
    					   								</span>
    					   								<span id="SBJ_DOC_ATTACH_1_SRC" style="padding-left: 3px">
    					   				
    					   								</span>
       													</td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปสถานที่</td>
       													<td style="text-align: left;" width="70%"> 
       														<span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_2" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_2_SRC" style="padding-left: 3px">
    					   				
    					   									</span>
       													</td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปพื้นที่ก่อนการซ่อม</td>
       													<td style="text-align: left;" width="70%">
       													   <span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_3" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_3_SRC" style="padding-left: 3px">
    					   				
    					   									</span>  
       													</td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปพื้นที่หลังการซ่อม</td>
       													<td style="text-align: left;" width="70%"> 
       														<span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_4" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_4_SRC" style="padding-left: 3px">
    					   				
    					   									</span>  
       													 </td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปพื้นที่หลังการทดสอบ</td>
       													<td style="text-align: left;" width="70%">
       														<span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_5" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_5_SRC" style="padding-left: 3px">
    					   				
    					   									</span>   
       													</td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปปัญหา 1</td>
       													<td style="text-align: left;" width="70%"> 
       														<span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_6" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_6_SRC" style="padding-left: 3px">
    					   				
    					   									</span>  
       													</td> 
       												</tr>
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;" width="30%">รูปปัญหา 2</td>
       													<td style="text-align: left;" width="70%"> 
       														<span>
    					   										<input class="btn" id="SBJ_DOC_ATTACH_7" type="button" value="Upload">     
    					   									</span>
    					   									<span id="SBJ_DOC_ATTACH_7_SRC" style="padding-left: 3px">
    					   				
    					   									</span>  
       													</td> 
       												</tr>
       											</tbody>
       											</table>
    						    		</td> 
    						    	</tr> 
    						    	 
    						    </table> 
    						 </div>
    					</td>
    					<td width="55%" valign="top" align="left">
    					<%--
    					<div  id="service_box4" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;opacity: 0.3; background: #fff;z-index: 1;background-color: none;">
    						 --%> 
    						 <div  id="service_box4" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;">
    						  <table border="0" width="100%" style="font-size: 12px"> 
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>อาการเสียที่ตรวจพบ</span>
    						    		</td>
    						    		<td width="65%">
    						    			<span> <input type="text" id="SBJ_SC_DETECTED" style="width:300px;height: 30;"/></span>
    						    		</td>
    						    		<td width="15%" align="right">
    						    			 <a class="btn btn-info"><span style="font-weight:bold;">SC</span></a>
    						    		</td>
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>สาเหตุ (Cause)</span>
    						    		</td>
    						    		<td width="80%" colspan="2">
    						    			<span><textarea name="SBJ_SC_CAUSE"  style="width:420px;" id="SBJ_SC_CAUSE" cols="100" rows="3"></textarea></span>
    						    		</td>
    						    		 
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="20%">
    						    			<span>การแก้ใข (Solution)</span>
    						    		</td>
    						    		<td width="80%" colspan="2">
    						    			<span><textarea name="SBJ_SC_SOLUTION"  style="width:420px;" id="SBJ_SC_SOLUTION" cols="100" rows="3"></textarea></span>
    						    		</td>
    						    	</tr>
    						    	<tr valign="top">
    						    		<td width="100%" colspan="3">
    						    			<div style="padding-left:50px">
    						    			 <span ><input type="checkbox" id="SBJ_SC_IS_CHANGE_ITEM" value="1"/> เปลี่ยนอุปกรณ์ ตามรายการ</span>
    						    			 <span style="padding-left:50px"><input type="checkbox" id="SBJ_SC_IS_CHARGE" value="1"/> ชาร์จแบตเตอรี่</span>
    						    			  <span style="padding-left:50px"><input type="checkbox" id="SBJ_SC_IS_RECOMMEND" value="1"/> แนะนำการใช้งาน</span>
    						    			 </div>
    						    			 
    						    		</td> 
    						    	</tr> 	
    						    	<tr>
    						    		<td width="100%" colspan="3" align="left">
    						    		 	 <i onclick="addBorrowItem('${bccNo}','2')" style="cursor: pointer;" class="icon-plus-sign"></i>
    					  				</td> 
    					  			</tr>
    						    	<tr>
    						    		<td width="100%" colspan="3">
    						    			<span id="item_section_2"></span>
    						    			<%--
    						    			 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 	<thead>  
        											<tr>
        												<th width="5%"><div class="th_class">ลำดับ</div></th>
        												<th width="20%"><div class="th_class">รหัส</div></th>
        												<th width="60%"><div class="th_class">รายการ</div></th>
        												<th width="10%"><div class="th_class">จำนวน</div></th>
        												<th width="5%"><div class="th_class"></div></th>
      												</tr>
         										</thead>
       											<tbody> 
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;">1</td>
       													<td style="text-align: left;">01103</td>
       													<td style="text-align: left;">กล่องโลหะ UPS 10 KVA (CAT 025)</td>
       													<td style="text-align: left;">1</td>
       													<td style="text-align: left;">1</td> 
       												</tr>
       											</tbody>
       											</table>
       											 --%>
    						    		</td>
    						    	</tr>
    						    </table> 
    						 </div>
    						 <div  id="service_box5" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						  <table border="0" width="100%" style="font-size: 12px"> 
    						    	<tr valign="top">
    						    		<td width="85%" align="center">
    						    			<span><b>เมื่อซ่อมเสร็จให้ตรวจเช็คดังนี้</b></span>
    						    		</td> 
    						    		<td width="15%" align="right">
    						    			 <a class="btn btn-info"><span style="font-weight:bold;">ตรวจเช็ค</span></a>
    						    		</td>
    						    	</tr> 
    						    	<tr valign="top">
    						    		<td  width="100%" colspan="2"> 
    						    		  <table  width="100%"  style="font-size: 12px">
    						    		 		 <tr valign="top">
        												<td width="50%">
        														<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 					<thead>  
        															<tr>
        																<th width="75%"><div class="th_class">รายการ</div></th>
        																<th width="20%"><div class="th_class">วัดได้</div></th>
        																<th width="5%"><div class="th_class">ผ่าน[*]</div></th> 
      																</tr>
         														</thead>  
       															<tbody> 
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดัน Output (Input 198-242Vac)</td>  
       																	<td style="text-align: left;"><input type="text" id="SBJ_CHECKER_1_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_1_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดัน Output (Input 165-198Vac)</td>  
       																	<td style="text-align: left;"><input type="text" id="SBJ_CHECKER_2_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_2_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดัน Output (Input 243-275Vac)</td>  
       																	<td style="text-align: left;"><input type="text" id="SBJ_CHECKER_3_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_3_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดัน Output (Battery Mode)</td>  
       																	<td style="text-align: left;"><input type="text"  id="SBJ_CHECKER_4_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_4_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ความถี่ Output (Battery Mode)</td>  
       																	<td style="text-align: left;"><input type="text"  id="SBJ_CHECKER_5_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_5_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดันชาร์จแบตเตอรี่</td>  
       																	<td style="text-align: left;"><input type="text"  id="SBJ_CHECKER_6_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_6_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">กระแสชาร์จแบตเตอรี่</td>  
       																	<td style="text-align: left;"><input type="text"  id="SBJ_CHECKER_7_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_7_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แรงดัน Low Battery Cut Off</td>  
       																	<td style="text-align: left;"><input type="text"  id="SBJ_CHECKER_8_VALUE" style="width:50px;height:20px"/></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_8_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ชาร์จแบตเตอรี่</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_9_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ทดสอบสำรองไฟ</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_10_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">การทำงานของพัดลม</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_11_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">การแสดงผลของ LED/LCD</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_12_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">สัญญาณเสียง Alarm ต่างๆ</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_13_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ปุ่มทดสอบแบตเตอรี่</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_14_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">การทำงานของพัดลม</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_15_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">การแสดงผลของ LED/LCD</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_16_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">สัญญาณเสียง Alarm ต่างๆ</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_17_IS_PASS" value="1"/></td> 
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ปุ่มทดสอบแบตเตอรี่</td>  
       																	<td style="text-align: left;"></td>
       																	<td style="text-align: left;"><input type="checkbox" id="SBJ_CHECKER_18_IS_PASS" value="1"/></td> 
       																</tr> 
       															</tbody> 
       															</table>
														</td>
        												<td width="50%">
        													<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 					<thead>  
        															<tr>
        																<th width="100%"><div class="th_class">รายการ</div></th> 
      																</tr>
         														</thead>
       															<tbody> 
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">กระแสโหลด <input type="text" id="SBJ_CHECKER_19_VALUE" style="width:50px;height:20px"/> A </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ขนาดสายไฟ <input type="text" id="SBJ_CHECKER_20_VALUE" style="width:50px;height:20px"/>  SQ.mm </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ปีแบตเตอรี่(ตัวปั้ม) <input type="text" id="SBJ_CHECKER_21_VALUE" style="width:50px;height:20px"/> A </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">ปีแบตเตอรี่(สติ๊กเกอร์) <input type="text"  id="SBJ_CHECKER_22_VALUE" style="width:50px;height:20px"/> A </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">อื่นๆ<textarea name="SBJ_CHECKER_EXT_VALUE"  style=""  id="SBJ_CHECKER_EXT_VALUE" cols="100" rows="3"></textarea></td>
       																</tr>
       															</tbody>
       														</table>
       														 <div  id="service_box6" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
       											 	 <table border="1" width="100%" style="font-size: 12px"> 
    						    						<tr valign="top">
    						    							<td width="75%" align="center">
    						    								<span><b>กรณีรับเครื่องกลับ</b></span>
    						    							</td> 
    						    							<td width="25%" align="right">
    						    								 <a class="btn btn-info"><span style="font-weight:bold;">รับเครื่อง</span></a>
    						    							</td>
    						    						</tr> 
    						    						<tr valign="top">
    						    							<td width="100%" align="left" colspan="2">
    						    							 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 					<%--
    						    			 					<thead>  
        															<tr>
        																<th width="100%"><div class="th_class">รายการ</div></th> 
      																</tr>
         														</thead>
         														 --%>
       															<tbody> 
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">กล่องกระดาษ/กระเป๋า</td>
       																	<td style="text-align: left;"><input type="radio" value="1" name="SBJ_GET_BACK_1"/>มี &nbsp;&nbsp;<input type="radio" value="0" name="SBJ_GET_BACK_1"/>ไม่มี </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">สายไฟ</td>
       																	<td style="text-align: left;"><input type="radio" value="1" name="SBJ_GET_BACK_2"/>มี &nbsp;&nbsp;<input type="radio" value="0" name="SBJ_GET_BACK_2"/>ไม่มี </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">รอยขีดข่วน</td>
       																	<td style="text-align: left;"><input type="radio" value="1" name="SBJ_GET_BACK_3"/>มี &nbsp;&nbsp;<input type="radio" value="0" name="SBJ_GET_BACK_3"/>ไม่มี </td>
       																</tr>
       																<tr style="cursor: pointer;"> 
       																	<td style="text-align: left;">แบตเตอรี่</td>
       																	<td style="text-align: left;"><input type="radio" value="1" name="SBJ_GET_BACK_4"/>มี &nbsp;&nbsp;<input type="radio" value="0" name="SBJ_GET_BACK_4"/>ไม่มี </td>
       																</tr>
       																<tr style="cursor: pointer;">
       																	<td style="text-align: left;" colspan="2">อื่นๆ<textarea    style="" id="SBJ_GET_BACK_EXT" cols="100" rows="3"></textarea></td>
       																</tr>
       															</tbody>
       														</table>
    						    							</td>
    						    						</tr> 
    						    					</table>
       											 </div>
        												</td> 
      											 </tr>
    						    		  </table> 
    						    		</td>
    						    		<%--  
    						    		 <td  width="50%">
    						    			 <table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
    						    			 	<thead>  
        											<tr>
        												<th width="100%"><div class="th_class">รายการ</div></th> 
      												</tr>
         										</thead>
       											<tbody> 
       												<tr style="cursor: pointer;"> 
       													<td style="text-align: left;">กระแสโหลด <input type="text" style="width:50px;height:20px"/> A </td> 
       												</tr>
       											</tbody>
       											</table>
       											 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
       											 	 <table border="1" width="100%" style="font-size: 12px"> 
    						    						<tr valign="top">
    						    							<td width="85%" align="center">
    						    								<span><b>กรณีรับเครื่องกลับ</b></span>
    						    							</td> 
    						    							<td width="15%" align="right">
    						    								 <a class="btn btn-info"><span style="font-weight:bold;">รับเครื่อง</span></a>
    						    							</td>
    						    						</tr> 
    						    						<tr valign="top">
    						    							<td width="85%" align="center">
    						    								กล่องกระดาษ/กระเป๋า
    						    							</td> 
    						    							<td width="15%" align="right">
    						    								 [x] มี [x] ไม่มี
    						    							</td>
    						    						</tr> 
    						    					</table>
       											 </div>
    						    		</td> 
    						    		--%>
    						    	</tr>
    						    </table> 
    						 </div>
    					</td>  
    				</tr>
    				</table>
              <%--
              <table border="0" width="100%" style="font-size: 12px"> 
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="100%" align="center">
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showOnSite()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">On Site</span>&nbsp;</a> 
    					   				</span> 
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showSC()">&nbsp;&nbsp;
    					   					<span style="color:white;font-weight:bold;">SC</span>&nbsp;&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showBorrow()">&nbsp;&nbsp;
    					   					<span style="color:white;font-weight:bold;">ยืม</span>&nbsp;&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showCheck()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">ตรวจเช็ค</span>&nbsp;</a> 
    					   				</span>
    					   				<span> 
    					   					<a class="btn btn-primary" onclick="showReceive()">&nbsp;
    					   					<span style="color:white;font-weight:bold;">รับเครื่อง</span>&nbsp;</a> 
    					   				</span>
    					   		</td>
    					   	 </tr>
    					   	</table> 
    					  </div>
    					</td>
    				</tr>
    				</table>
    				--%>
    				 <table border="0" width="100%" style="font-size: 12px"> 
    				<tr valign="top">
    					<td width="75%" valign="top"  colspan="3" align="left">
    						 <div  id="service_box7" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    <tr  valign="top">
    						    	<td width="33%" align="center" rowspan="2">
    						    		กรณีนอกประกัน
    						    	</td>
    						    	<td>  
    						    	  <input type="radio" value="1" name="SBJ_IS_REPAIR"> <span style="padding-left:3px">ตกลงซ่อม</span>
    						    	</td>
    						    	<td>
    						    	  วันที่ตกลงซ่อม/ไม่ตกลงซ่อม<input type="text" id="SBJ_CONFIRM_REPAIR_DATE" readonly="readonly" style="width:100px;height:30px"/>
    						    	   <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CONFIRM_REPAIR_DATE')"></i>
    						    	   <span style="padding-left:40px">
    						    	        <%-- 
    						    	   		<a class="btn btn-primary"  onclick="loadDynamicPage('dispatcher/page/service_quotation?bccNo=${bccNo}')"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบเสนอราคา</span></a>
    						    	   		 --%>
    				 					</span>
    						    	</td>
    						    </tr>
    						     <tr> 
    						    	<td> 
    						    	  <input type="radio"  value="0" name="SBJ_IS_REPAIR"> <span  style="padding-left:3px">ไม่ตกลงซ่อม</span> 
    						    	</td>
    						    	<td>
    						    	  ชื่อลูกค้าผู้อนุมัติ<input type="text" id="SBJ_CUSTOMER_CONFIRM_REPAIR" style="width:100px;height:30px"/>
    						    	</td>
    						    </tr>
    						    </table>
    						  </div>
    					</td>
    					<td width="25%" valign="top" align="left">
    						 <div    id="service_box8" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    <tr>
    						    	<td>
    						    	   Job ปิดวันที่ <input type="text" id="SBJ_CLOSE_DATE" readonly="readonly" style="width:100px;height:30px"/>
    						    	</td>
    						    </tr>
    						    <tr>
    						    	<td>
    						    	  ผู้ปิดจบ <input type="text" id="SBJ_CLOSE_ACTOR" style="width:100px;height:30px"/>
    						    	</td>
    						    </tr>
    						    </table>
    						  </div>
    					</td>
    				 </tr>            
    				 <tr valign="top">
    					<td width="100%" valign="top"  colspan="4" align="left">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    <tr  valign="top">
    						    	<td width="40%" align="center" colspan="2"> 
    						 				<div  id="service_box9" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						 				  <table border="1" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td width="20%">ผู้รับเครื่อง/ซ่อมหน้างาน</td>
    						 				  		<td  width="30%"><input id="SBJ_SYNDOME_RECIPIENT" type="text" style="width:100px;height:30px"/></td>
    						 				  		<td align="right" width="20%"><span style="padding-right:10px">ผู้ส่งซ่อม/ลูกค้า</span></td>
    						 				  		<td  width="30%"><input id="SBJ_CUSTOMER_SEND" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="center" colspan="4" ><span style="padding-right:10px">วันที่</span>
    						 				  		<input id="SBJ_SYNDOME_RECIPIENT_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_DATE')"></i>
    						 				  		</td>
    						 				  		<%--  
    						 				  		<td><input id="SBJ_SYNDOME_RECIPIENT_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_DATE')"></i>
    						 				  		 </td>
    						 				  		 --%>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="center" colspan="4"><span style="padding-right:10px">เวลาเข้า</span>
    						 				  		<input id="SBJ_SYNDOME_RECIPIENT_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_TIME_IN')"></i>
    						 				  		 </td>
    						 				  		 <%--  
    						 				  		<td  ><input id="SBJ_SYNDOME_RECIPIENT_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_TIME_IN')"></i>
    						 				  		 </td>
    						 				  		  --%>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="center" colspan="4" ><span style="padding-right:10px">เวลาออก</span>
    						 				  		<input id="SBJ_SYNDOME_RECIPIENT_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_TIME_OUT')"></i>
    						 				  		</td>
    						 				  		 <%-- 
    						 				  		<td  ><input id="SBJ_SYNDOME_RECIPIENT_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_RECIPIENT_TIME_OUT')"></i></td>
    						 				  		 --%>
    						 				  	</tr>
    						 				  </table> 
    						 				</div>
    						    	</td>   
    						    	<%-- 
    						    	<td width="20%" align="center"> 
    						 				<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						 				<table border="0" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td align="right" width="40%"><span style="padding-right:10px">ผู้ส่งซ่อม/ลูกค้า</span></td>
    						 				  		<td  width="60%"><input id="SBJ_CUSTOMER_SEND" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">วันที่</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_SEND_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_SEND_DATE')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาเข้า</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_SEND_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_SEND_TIME_IN')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาออก</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_SEND_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_SEND_TIME_OUT')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  </table> 
    				   
    						 				</div> 
    						    	</td>  
    						    	 --%>
    						    	<td width="20%" align="center"> 
    						 				<div   id="service_box10"style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						 				<table  id="service_box10_1" border="1" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td align="right" width="40%"><span style="padding-right:10px">ผู้ตรวจซ่อม/ช่าง</span></td>
    						 				  		<td  width="60%"><input id="SBJ_SYNDOME_ENGINEER" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">วันที่</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER_DATE')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาเข้า</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER_TIME_IN')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาออก</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER_TIME_OUT')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  </table>
    						 				  <table id="service_box10_2" border="1" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td align="right" width="40%"><span style="padding-right:10px">ผู้ตรวจซ่อม/ช่าง(หลังเสนอราคา)</span></td>
    						 				  		<td  width="60%"><input id="SBJ_SYNDOME_ENGINEER2" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">วันที่</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER2_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER2_DATE')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาเข้า</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER2_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER2_TIME_IN')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาออก</span></td>
    						 				  		<td  ><input id="SBJ_SYNDOME_ENGINEER2_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_ENGINEER2_TIME_OUT')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  </table>
    						 				  <%-- 
    						 				<div>ผู้ตรวจซ่อม/ช่าง</div>
    						 					<div><input type="text" style="width:100px;height:30px"/></div>
    						 					<div>วันที่ <input type="text" style="width:100px;height:30px"/></div>
    						 					<div>เวลาเข้า<input type="text" style="width:100px;height:30px"/></div>
    						 					<div>เวลาออก<input type="text" style="width:100px;height:30px"/></div>
    						 					 --%>
    						 				</div> 
    						    	</td>   
    						    	<td width="40%" align="center" colspan="2"> 
    						 				<div  id="service_box11" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						 				<table border="1" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td align="right" width="20%"><span style="padding-right:10px">ผู้ส่งคืน</span></td>
    						 				  		<td  width="30%"><input id="SBJ_SYNDOME_SEND" type="text" style="width:100px;height:30px"/></td>
    						 				  		<td align="right" width="20%"><span style="padding-right:10px">ผู้รับคืน/ลูกค้า</span></td>
    						 				  		<td  width="30%"><input id="SBJ_CUSTOMER_RECIPIENT" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  	<td align="right" width="20%" ><span style="padding-right:10px">RFE No.</span> 
    						 				  		</td> 
    						 				  		<td width="30%" ><input id="SBJ_SYNDOME_SEND_RFE_NO" type="text" style="width:100px;height:30px"/></td>
    						 				  		
    						 				  	   <td align="center" colspan="2"  width="50%"></td>
    						 				  	 
    						 				  		
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="center" colspan="4"><span style="padding-right:10px">วันที่</span>
    						 				  		<input id="SBJ_SYNDOME_SEND_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_DATE')"></i>
    						 				  		</td>
    						 				  		<%--
    						 				  		<td  ><input id="SBJ_SYNDOME_SEND_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_DATE')"></i>
    						 				  		 </td>
    						 				  		 --%>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td  align="center" colspan="4" ><span style="padding-right:10px">เวลาเข้า</span>
    						 				  		<input id="SBJ_SYNDOME_SEND_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_TIME_IN')"></i>
    						 				  		 </td>
    						 				  		<%--
    						 				  		<td  ><input id="SBJ_SYNDOME_SEND_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_TIME_IN')"></i>
    						 				  		 </td>
    						 				  		 --%>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td  align="center" colspan="4" ><span style="padding-right:10px">เวลาออก</span>
    						 				  		<input id="SBJ_SYNDOME_SEND_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_TIME_OUT')"></i></td>
    						 				  		<%--
    						 				  		<td  ><input id="SBJ_SYNDOME_SEND_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_SYNDOME_SEND_TIME_OUT')"></i>
    						 				  		 </td>
    						 				  		 --%>
    						 				  	</tr>
    						 				  </table>
    						 				</div>
    						    	</td> 
    						    	<%--  
    						    	<td width="20%" align="center"> 
    						 				<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						 				<table border="0" width="100%" style="font-size: 12px">
    						 				  	<tr>
    						 				  		<td align="right" width="40%"><span style="padding-right:10px">ผู้รับคืน/ลูกค้า</span></td>
    						 				  		<td  width="60%"><input id="SBJ_CUSTOMER_RECIPIENT" type="text" style="width:100px;height:30px"/></td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">วันที่</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_RECIPIENT_DATE" type="text"  readonly="readonly" style="width:100px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_RECIPIENT_DATE')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาเข้า</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_RECIPIENT_TIME_IN" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_RECIPIENT_TIME_IN')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  	<tr>
    						 				  		<td align="right" ><span style="padding-right:10px">เวลาออก</span></td>
    						 				  		<td  ><input id="SBJ_CUSTOMER_RECIPIENT_TIME_OUT" type="text"  readonly="readonly" style="width:50px;height:30px"/>
    						 				  		 <i class="icon-refresh" style="cursor: pointer;" onclick="clearElementValue('SBJ_CUSTOMER_RECIPIENT_TIME_OUT')"></i>
    						 				  		 </td>
    						 				  	</tr>
    						 				  </table>  
    						 				</div>
    						    	</td> 
    						    	--%>
    						    </tr>
    						    </table>
    						   
    					</td> 
    				 </tr>
    				 <c:if test="${isSupervisorAccount || isKeyAccount || isQuotationAccount}">
    				 <tr valign="top">
    					<td width="100%" valign="top"  colspan="4" align="left">
    						 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    <tr  valign="top">
    						    	<td width="100%" align="left">
    						    		<span style="padding-left:10px">Status</span> 
    						    		<span style="padding-left:10px">
    						    			<select id="SBJ_JOB_STATUS" style="width:135px">
    						    				<option value="1">รับเครื่อง/เช็คไซต์</option>
    						    				<option value="2">เสนอราคา</option>
    						    				<option value="3">รออนุมัติซ่อม</option>
    						    				<option value="4">ซ่อม</option>
    						    				<option value="5">ส่งเครื่อง</option>
    						    				<option value="6">ตรวจสอบเอกสาร</option>
    						    				<option value="7">ปิดงานเรียบร้อย</option>
    						    			</select>
    						    		</span>
    						    		<span style="padding-left:40px"><strong>หน่วยงาน</strong></span> 
    						    		<span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="1"/> SC
						    			 </span>
						    			  <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="2"/> IT(ช่าง กทม ปริฯ)
						    			 </span>
						    			 <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="3"/> Reg(ช่าง ภูมิภาค)
						    			 </span>
						    			 <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="4"/> Logistic(ขนส่ง กทม ปริฯ)
						    			 </span>
						    			 <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="5"/> Logistic Reg (ขนส่ง ภูมิภาค)
						    			 </span>
						    			 <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="6"/> Sale
						    			 </span>
						    			 <span style="padding-left:20px">
						    			    <input type="radio" name="SBJ_DEPT_ID" value="7"/> Admin Center
						    			 </span> 
    						    	</td> 
    						    </tr> 
    						     <tr valign="top">
    					<td width="100%" valign="top"  colspan="4" align="left">
    						 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    						    <table border="0" width="100%" style="font-size: 12px"> 
    						    <tr  valign="top">
    						    	<td width="100%" align="left">
    						    		<span style="padding-left:10px">งานไม่จบเนื่องจาก :</span> 
    						    		<span style="padding-left:10px">
    						    			<select id="SBJ_JOB_PROBLEM_ID" style="width:245px">
    						    				<option value="0">ไม่พบปัญหา</option>
    						    				<option value="1">เข้าปฏิบัตงานที่ไซค์งานไม่ทันเวลา</option>
    						    				<option value="2">ลูกค้าไม่สะดวกให้เข้าปฏิบัติงาน</option>
    						    				<option value="3">อะไหล่ / เครื่องมีปัญหา</option>
    						    				<option value="4">รายละเอียดข้อมูลของลูกค้าไม่ถูกต้อง</option>
    						    				<option value="5">นำอะไหล่ไปปซ่อมไม่ถูกต้อง</option>
    						    				<option value="6">ไซค์งานไม่พร้อม</option>
    						    				<option value="7">บุคลากรไม่พร้อม</option>
    						    			</select>
    						    		</span>
    						    		<span style="padding-left:40px"><strong>การแก้ใขปัญหา</strong></span> 
    						    		<span style="padding-left:20px">
    						    		<textarea name="SBJ_JOB_PROBLEM_SOLUTION" style="width:420px;" id="SBJ_JOB_PROBLEM_SOLUTION" cols="100" rows="3"></textarea>
						    			      
						    			 </span> 
    						    	</td> 
    						    </tr> 
    						    </table>
    						  </div>
    					</td> 
    				 </tr> 
    						    </table>
    						  </div>
    					</td> 
    				 </tr> 
    				 </c:if>
    				 </table>
            </fieldset>
            <div style="padding-top: 10px" align="center" class="hidden-print">
              <table style="width: 100%" border="0">
                <tbody>
                  <tr>
                    <td width="50%"> 
                    <a  class="btn btn-info" onClick="loadDynamicPage('dispatcher/page/callcenter_job?bccNo=${bccNo}&mode=edit')"> <span style="color:white; font-weight:bold; ">Back</span></a>&nbsp; 
                   
                     
                   <c:if test="${false}">
                     <a class="btn btn-primary"  onclick="doCloseServicesJob('2','wait_for_supervisor_services_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Job wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Job</span></a>
				 	</c:if>
                   <c:if test="${false}">
                   <a class="btn btn-primary"  onclick="doUpdateJob()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Job</span></a>
                   </c:if>
    				<a id="close_job_element" style="display:none" class="btn btn-primary"  onclick="doCloseJob('2','wait_for_supervisor_services_close','${username}','1','Job Closed')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a>
    					 
                    </td>
                    <td align="center" width="80%">
                    <%-- <span id="button_send" style="display: none;"> 
                    <a class="btn btn-primary" onclick="doSubmitCallCenter()">&nbsp;<span style="color:white; font-weight:bold;">Submit</span></a>
                     </span> <span id="button_update" style="display: none;"> <a class="btn btn-primary" onclick="doSaveDraftAction()">&nbsp;
                     <span style="color:white; font-weight:bold;">Update</span></a> </span>
                      --%>
                     </td>
                  </tr>
                </tbody>
              </table>
            </div>
            </form>
            </div>
  </fieldset>