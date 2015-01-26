<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %> 	
<jsp:useBean id="date" class="java.util.Date"/>
<sec:authorize access="hasAnyRole('ROLE_SALE_ORDER_ACCOUNT')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>
<sec:authorize access="hasAnyRole('ROLE_TECHNICIAL_ACCOUNT')" var="isOperationAccount"/>  
<sec:authentication var="username" property="principal.username"/> 

<style> 
.ui-autocomplete-loading {
    background: white url('<%=request.getContextPath() %>/resources/css/smoothness/images/ui-anim_basic_16x16.gif') right center no-repeat;
  } 
table > thead > tr > th
{
background	:#e5e5e5;
}
.ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
.ui-timepicker-div dl { text-align: left; }
.ui-timepicker-div dl dt { float: left; clear:left; padding: 0 0 0 5px; }
.ui-timepicker-div dl dd { margin: 0 10px 10px 40%; }
.ui-timepicker-div td { font-size: 90%; }
.ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }

.ui-timepicker-rtl{ direction: rtl; }
.ui-timepicker-rtl dl { text-align: right; padding: 0 5px 0 0; }
.ui-timepicker-rtl dl dt{ float: right; clear: right; }
.ui-timepicker-rtl dl dd { margin: 0 40% 10px 10px; }
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 
new AjaxUpload('stock_element', {
	  action: 'upload/stock/1',
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
		  bootbox.dialog("Upload Stock เรียบร้อยแล้ว",[{
			    "label" : "Close",
			     "class" : "btn-danger"
		 }]);
		 return false;
	}		
}); 
});

</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	   
			 <input type="hidden" name="BSO_IS_DELIVERY" id="BSO_IS_DELIVERY" />
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/> 
          <!--   <input type="hidden" id="LastCostAmt" name="LastCostAmt"/> -->
            
			  <fieldset style="font-family: sans-serif;">   
			 
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top"> 
    					<td width="100%" valign="top">
    					<div  id="cust_input_1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px;">
    					   	<table style="width: 100%;font-size:13px" border="0">
    					   
    					   	<tr id="attach_file1" style="height: 30px;">
    					   		<td width="100%">
    					   				<span>
    					   					แนบเอกสาร(Stock)
    					   				</span>
    					   				<span style="padding-left: 3px">
    					   					<input class="btn" id="stock_element" type="button" value="Upload">     
    					   				</span>
    					   				<span id="stock_element_SRC" style="padding-left: 3px">
    					   				
    					   				</span>
    					   		</td>
    					   		 
    					   	</tr> 
    					   	</table>
    					   	</div> 
    					   	 
    			</table> 
    			</fieldset>  
			  </form>   
			 </div>
</fieldset>