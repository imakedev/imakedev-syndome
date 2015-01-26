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
   getSaleOrder(); 
});  
function getSaleOrder(){  
	var function_message="Edit";
	
	$("#delivery_install_title").html("Sale Order ");
	  var query=" SELECT "+
	   " so.BSO_ID, "+
	   " so.CUSCOD, "+
	   " so.BSO_SALE_ID, "+
	   " so.BSO_IS_DELIVERY, "+
	   " so.BSO_IS_INSTALLATION, "+
	   " so.BSO_DELIVERY_DUE_DATE, "+
	   " so.BSO_DELIVERY_LOCATION, "+
	   " so.BSO_DELIVERY_CONTACT, "+
	   " so.BSO_INSTALLATION_SITE_LOCATION, "+
	   " so.BSO_INSTALLATION_CONTACT, "+
	   " so.BSO_INSTALLATION_TEL_FAX, "+
	   " so.BSO_INSTALLATION_DUE_DATE, "+
	   " so.BSO_LEVEL, "+
	  // " so.BSO_DOC_CREATED_DATE, "+
	   " IFNULL(DATE_FORMAT(so.BSO_DOC_CREATED_DATE,'%d/%m/%Y'),'') ,"+
	   " so.BSO_CUSTOMER_TYPE, "+
	   " so.BSO_PO_NO, "+
	   " so.BSO_PAYMENT_TERM, "+
	   " so.BSO_PAYMENT_TERM_DESC, "+
	   " so.BSO_BORROW_TYPE, "+
	   " so.BSO_BORROW_EXT, "+
	   " so.BSO_BORROW_DURATION, "+
	   " so.BSO_IS_WARRANTY, "+
	   " so.BSO_WARRANTY, "+
	   " so.BSO_IS_PM_MA, "+
	   " so.BSO_OPTION, "+
	   " so.BSO_TYPE, "+
	   " so.BSO_TYPE_NO, "+
	   " so.BSO_CREATED_BY, "+
	   " so.BSO_UPDATED_BY, "+  
	   " armas.CUSNAM , "+
	   
	   " armas.CUSTYP, "+
	   " armas.PRENAM, "+
	   " armas.ADDR01, "+
	   " armas.ADDR02, "+
	   " armas.ADDR03, "+
	   " armas.ZIPCOD, "+ 
	   " armas.TELNUM, "+
	   " armas.CONTACT, "+
	   " armas.CUSNAM2 ,"+  
	   " so.BSO_SLA ,"+
	   " so.BSO_PM_MA, "+ 
	   " so.BSO_IS_OPTION ,"+
	   " so.BSO_IS_HAVE_BORROW , "+
	   " so.BSO_BORROW_NO ,"+
	   " so.BSO_IS_DELIVERY_INSTALLATION ,"+ 
	   " so.BSO_IS_NO_DELIVERY, "+  
	   " so.BSO_DELIVERY_TYPE, "+ 
	   " so.BSO_DELIVERY_ADDR1, "+ 
	   " so.BSO_DELIVERY_ADDR2, "+ 
	   " so.BSO_DELIVERY_ADDR3, "+ 
	   " so.BSO_DELIVERY_PROVINCE, "+
	   " so.BSO_DELIVERY_ZIPCODE, "+
	   " so.BSO_DELIVERY_TEL_FAX, "+
	   " so.BSO_INSTALLATION_ADDR1, "+
	   " so.BSO_INSTALLATION_ADDR2, "+
	   " so.BSO_INSTALLATION_ADDR3, "+
	   " so.BSO_INSTALLATION_PROVINCE, "+
	   " so.BSO_INSTALLATION_ZIPCODE, "+
	   " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%d/%m/%Y'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_DELIVERY_DUE_DATE,'%H:%i'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%d/%m/%Y'),'') ,"+
	   " IFNULL(DATE_FORMAT(so.BSO_INSTALLATION_DUE_DATE,'%H:%i'),'') , "+ 
	   " so.BSO_STORE_PRE_SEND "+
	   " FROM "+SCHEMA_G+".BPM_SALE_ORDER  so left join "+
	   " "+SCHEMA_G+".BPM_ARMAS armas on so.CUSCOD=armas.CUSCOD "+
	   " where so.BSO_ID=${bsoId}";
	   
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
					$("#bsoTypeNo").val(data[0][26]);
					var BSO_ID=data[0][0]!=null?data[0][0]:""; 
					var CUSCOD=data[0][1]!=null?data[0][1]:""; $("#CUSCOD").val(CUSCOD);
					var BSO_SALE_ID=data[0][2]!=null?data[0][2]:""; $("#BSO_SALE_ID").val(BSO_SALE_ID);
					var BSO_IS_DELIVERY=data[0][3]!=null?data[0][3]:""; $("#BSO_IS_DELIVERY").val(BSO_IS_DELIVERY);
					var BSO_IS_INSTALLATION=data[0][4]!=null?data[0][4]:""; $("#BSO_IS_INSTALLATION").val(BSO_IS_INSTALLATION);
					var BSO_DELIVERY_DUE_DATE=data[0][5]!=null?data[0][5]:"";// $("#BSO_DELIVERY_DUE_DATE").val(BSO_DELIVERY_DUE_DATE);
					var BSO_DELIVERY_LOCATION=data[0][6]!=null?data[0][6]:""; $("#BSO_DELIVERY_LOCATION").val(BSO_DELIVERY_LOCATION);
					var BSO_DELIVERY_CONTACT=data[0][7]!=null?data[0][7]:""; $("#BSO_DELIVERY_CONTACT").val(BSO_DELIVERY_CONTACT);
					var BSO_INSTALLATION_SITE_LOCATION=data[0][8]!=null?data[0][8]:""; $("#BSO_INSTALLATION_SITE_LOCATION").val(BSO_INSTALLATION_SITE_LOCATION);
					var BSO_INSTALLATION_CONTACT=data[0][9]!=null?data[0][9]:""; $("#BSO_INSTALLATION_CONTACT").val(BSO_INSTALLATION_CONTACT);
					var BSO_INSTALLATION_TEL_FAX=data[0][10]!=null?data[0][10]:""; $("#BSO_INSTALLATION_TEL_FAX").val(BSO_INSTALLATION_TEL_FAX);
					var BSO_INSTALLATION_DUE_DATE=data[0][11]!=null?data[0][11]:"";// $("#BSO_INSTALLATION_DUE_DATE").val(BSO_INSTALLATION_DUE_DATE);
					var BSO_LEVEL=data[0][12]!=null?data[0][12]:"";// $("#BSO_LEVEL").val(BSO_LEVEL);
					var BSO_DOC_CREATED_DATE=data[0][13]!=null?data[0][13]:""; $("#BSO_DOC_CREATED_DATE").val(BSO_DOC_CREATED_DATE);
					var BSO_CUSTOMER_TYPE=data[0][14]!=null?data[0][14]:""; //$("#BSO_CUSTOMER_TYPE").val(BSO_CUSTOMER_TYPE);
					var BSO_PO_NO=data[0][15]!=null?data[0][15]:""; $("#BSO_PO_NO").val(BSO_PO_NO);
					var BSO_PAYMENT_TERM=data[0][16]!=null?data[0][16]:"";// $("#BSO_PAYMENT_TERM").val(BSO_PAYMENT_TERM);
					var BSO_PAYMENT_TERM_DESC=data[0][17]!=null?data[0][17]:""; $("#BSO_PAYMENT_TERM_DESC").val(BSO_PAYMENT_TERM_DESC);
					var BSO_BORROW_TYPE=data[0][18]!=null?data[0][18]:""; // $("#BSO_BORROW_TYPE").val(BSO_BORROW_TYPE);
					var BSO_BORROW_EXT=data[0][19]!=null?data[0][19]:"";// $("#BSO_BORROW_EXT").val(BSO_BORROW_EXT);
					var BSO_BORROW_DURATION=data[0][20]!=null?data[0][20]:"";// $("#BSO_BORROW_DURATION").val(BSO_BORROW_DURATION);
					var BSO_IS_WARRANTY=data[0][21]!=null?data[0][21]:"";// $("#BSO_IS_WARRANTY").val(BSO_IS_WARRANTY);
					var BSO_WARRANTY=data[0][22]!=null?data[0][22]:"";// $("#BSO_WARRANTY").val(BSO_WARRANTY);
					var BSO_IS_PM_MA=data[0][23]!=null?data[0][23]:""; //$("#BSO_IS_PM_MA").val(BSO_IS_PM_MA);
					var BSO_OPTION=data[0][24]!=null?data[0][24]:"";// $("#BSO_OPTION").val(BSO_OPTION);
					var BSO_TYPE=data[0][25]!=null?data[0][25]:""; $("#BSO_TYPE").val(BSO_TYPE);
					var BSO_TYPE_NO=data[0][26]!=null?data[0][26]:""; $("#BSO_TYPE_NO").val(BSO_TYPE_NO);
					var BSO_CREATED_BY=data[0][27]!=null?data[0][27]:""; $("#BSO_CREATED_BY").val(BSO_CREATED_BY);
					var BSO_UPDATED_BY=data[0][28]!=null?data[0][28]:"";   $("#BSO_UPDATED_BY").val(BSO_UPDATED_BY);
					var CUSNAM=data[0][29]!=null?data[0][29]:""; $("#CUSNAM").val(CUSNAM);
					
					var CUSTYP=data[0][30]!=null?data[0][30]:""; $("#CUSTYP").val(CUSTYP);
					var PRENAM=data[0][31]!=null?data[0][31]:""; $("#PRENAM").val(PRENAM); 
					var ADDR01=data[0][32]!=null?data[0][32]:""; $("#ADDR01").val(ADDR01);
					var ADDR02=data[0][33]!=null?data[0][33]:""; $("#ADDR02").val(ADDR02);
					var ADDR03=data[0][34]!=null?data[0][34]:""; $("#ADDR03").val(ADDR03);
					var ZIPCOD=data[0][35]!=null?data[0][35]:""; $("#ZIPCOD").val(ZIPCOD);
					var TELNUM=data[0][36]!=null?data[0][36]:""; $("#TELNUM").val(TELNUM);
					var CONTACT=data[0][37]!=null?data[0][37]:""; $("#CONTACT").val(CONTACT);
					var CUSNAM2=data[0][38]!=null?data[0][38]:""; $("#CUSNAM2").val(CUSNAM2); 
					var BSO_SLA=data[0][39]!=null?data[0][39]:""; $("#BSO_SLA").val(BSO_SLA);
					var BSO_PM_MA=data[0][40]!=null?data[0][40]:""; 
					var BSO_IS_OPTION=data[0][41]!=null?data[0][41]:"";
					var BSO_IS_HAVE_BORROW=data[0][42]!=null?data[0][42]:"";
					var BSO_BORROW_NO=data[0][43]!=null?data[0][43]:""; $("#BSO_BORROW_NO").val(BSO_BORROW_NO);  
					var BSO_IS_DELIVERY_INSTALLATION=data[0][44]!=null?data[0][44]:"";
					var BSO_IS_NO_DELIVERY=data[0][45]!=null?data[0][45]:""; 
					var BSO_DELIVERY_TYPE=data[0][46]!=null?data[0][46]:"";  

					var BSO_DELIVERY_ADDR1=data[0][47]!=null?data[0][47]:""; $("#BSO_DELIVERY_ADDR1").val(BSO_DELIVERY_ADDR1);  
					var BSO_DELIVERY_ADDR2=data[0][48]!=null?data[0][48]:""; $("#BSO_DELIVERY_ADDR2").val(BSO_DELIVERY_ADDR2);  
					var BSO_DELIVERY_ADDR3=data[0][49]!=null?data[0][49]:""; $("#BSO_DELIVERY_ADDR3").val(BSO_DELIVERY_ADDR3);
					var BSO_DELIVERY_PROVINCE=data[0][50]!=null?data[0][50]:""; $("#BSO_DELIVERY_PROVINCE").val(BSO_DELIVERY_PROVINCE);  
					var BSO_DELIVERY_ZIPCODE=data[0][51]!=null?data[0][51]:""; $("#BSO_DELIVERY_ZIPCODE").val(BSO_DELIVERY_ZIPCODE);  
					var BSO_DELIVERY_TEL_FAX=data[0][52]!=null?data[0][52]:""; $("#BSO_DELIVERY_TEL_FAX").val(BSO_DELIVERY_TEL_FAX);
					var BSO_INSTALLATION_ADDR1=data[0][53]!=null?data[0][53]:""; $("#BSO_INSTALLATION_ADDR1").val(BSO_INSTALLATION_ADDR1);  
					var BSO_INSTALLATION_ADDR2=data[0][54]!=null?data[0][54]:""; $("#BSO_INSTALLATION_ADDR2").val(BSO_INSTALLATION_ADDR2);  
					var BSO_INSTALLATION_ADDR3=data[0][55]!=null?data[0][55]:""; $("#BSO_INSTALLATION_ADDR3").val(BSO_INSTALLATION_ADDR3);
					var BSO_INSTALLATION_PROVINCE=data[0][56]!=null?data[0][56]:""; $("#BSO_INSTALLATION_PROVINCE").val(BSO_INSTALLATION_PROVINCE);  
					var BSO_INSTALLATION_ZIPCODE=data[0][57]!=null?data[0][57]:""; $("#BSO_INSTALLATION_ZIPCODE").val(BSO_INSTALLATION_ZIPCODE);  
					
					var BSO_DELIVERY_DUE_DATE_PICKER=data[0][58]!=null?data[0][58]:""; $("#BSO_DELIVERY_DUE_DATE_PICKER").val(BSO_DELIVERY_DUE_DATE_PICKER);
					var BSO_DELIVERY_DUE_DATE_TIME_PICKER=data[0][59]!=null?data[0][59]:""; $("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val(BSO_DELIVERY_DUE_DATE_TIME_PICKER);
					var BSO_INSTALLATION_TIME_PICKER=data[0][60]!=null?data[0][60]:""; $("#BSO_INSTALLATION_TIME_PICKER").val(BSO_INSTALLATION_TIME_PICKER);
					var BSO_INSTALLATION_TIME_TIME_PICKER=data[0][61]!=null?data[0][61]:""; $("#BSO_INSTALLATION_TIME_TIME_PICKER").val(BSO_INSTALLATION_TIME_TIME_PICKER);
					var BSO_STORE_PRE_SEND=data[0][62]!=null?data[0][62]:"";
					 
					if(BSO_STORE_PRE_SEND=='1'){
						$("#store_update_id").show();
						$("#received_by_elelement").show();
					}else{
						$("#store_prepare_id").show();
					}
				    
					
				}else{
					
				} 
				searchItemList("1");
			}
	 	  }); 
 
	  
}
function goPrev(){
	if($("#pageNo").val()!='1'){
		var prev=parseInt($("#pageNo").val())-1;
		$("#pageNo").val(prev);
		searchItemList(prev);
	}
}
function goNext(){
	var next=parseInt($("#pageNo").val());
	if(next<parseInt($("#pageCount").val())){
		next=next+1;
		$("#pageNo").val(next);
		searchItemList(next);
	}
} 
function goToPage(){ 
	//$("#pageNo").val(document.getElementById("pageSelect").value);
	checkWithSet("pageNo",$("#pageSelect").val());
//	doAction('search','0');
	searchItemList($("#pageNo").val());
}
function renderPageSelect(){
	 
	var pageStr="<select name=\"pageSelect\" id=\"pageSelect\" onchange=\"goToPage()\" style=\"width: 50px\">";
//	var pageCount=parseInt($("#pageCount").val());
	var pageCount=$("#pageCount").val(); 
	//alert(pageCount)
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	//alert(pageStr)
	$("#pageElement").html(pageStr);
	checkWithSet("pageSelect",$("#pageNo").val());
	//document.getElementById("pageSelect").value=$("#pageNo").val();
}
function confirmDelete(cuscod,itemid){
	$( "#dialog-confirmDelete" ).dialog({
		/* height: 140, */
		modal: true,
		buttons: {
			"Yes": function() { 
				$( this ).dialog( "close" );
				doAction(cuscod,itemid);
			},
			"No": function() {
				$( this ).dialog( "close" );
				return false;
			}
		}
	});
} 
function doAction(cuscod,itemid){ 
	var querys=[]; 
	var query="DELETE FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM where BSO_ID=${bsoId} and CUSCOD='"+cuscod+"' and IMA_ItemID='"+itemid+"'";
	querys.push(query); 
	  query="DELETE FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING where BSO_ID=${bsoId} and CUSCOD='"+cuscod+"' and IMA_ItemID='"+itemid+"'"; 
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
				searchItemList("1"); 
			}
		}
	});
} 
function searchItemList(_page){  
	$("#pageNo").val(_page);   
	
	var query="SELECT  item.IMA_ItemID ,product.IMA_ItemName ,item.AMOUNT,item.PRICE, "+
	          " ROUND(item.AMOUNT*item.PRICE,2) AS SUM_PRICE ,"+
	          "(select sum(ROUND(AMOUNT*PRICE,2)) "+
	          " from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as SUM_TOTAL ,"+
	          " (select ROUND((sum(ROUND(AMOUNT*PRICE,2))*7)/100,2)"+
	          "  from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as VAT ,"+
	          " (select ROUND(ROUND((sum(ROUND(AMOUNT*PRICE,2))*7)/100,2) + sum(ROUND(AMOUNT*PRICE,2)),2)"+ 
	          "  from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as GRAND_TOTAL ,"+
	          "  item.PRICE_COST , "+
	          " ROUND(item.AMOUNT*item.PRICE_COST,2) AS SUM_PRICE_COST ,"+
	        /*   "(select sum(ROUND(AMOUNT*PRICE_COST,2)) "+
	          " from BPM_SALE_PRODUCT_ITEM where BSO_ID=item.BSO_ID ) as SUM_TOTAL_COST ,"+ */
	          " item.cuscod , "+
	          "  item.DETAIL , "+
	          "  item.AUTO_K  ,"+
	          "  item.IS_REPLACE , "+
	          "  item.REPLACE_NAME  "+
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM  item left join "+SCHEMA_G+".BPM_PRODUCT product "+ 
		" on item.IMA_ItemID=product.IMA_ItemID where item.BSO_ID=${bsoId}  and item.IMA_ItemID not in('900002','900004','90100002' ) ";
	var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
	var queryObject="  "+query+"   limit "+limitRow+", "+_perpageG;
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
			var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			        "	<thead> 	"+
			        "  		<tr> "+
			        "  		<th width=\"11%\"><div class=\"th_class\">รหัสสินค้า</div></th> "+
			        "  		<th width=\"84%\"><div class=\"th_class\">สินค้า</div></th> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+  
			        <%-- 
			        "  		<th width=\"11%\"><div class=\"th_class\">ต้นทุนต่อหน่วย</div></th> "+			        
			        "  		<th width=\"12%\"><div class=\"th_class\">ต้นทุนรวม</div></th> "+ 
			        "  		<th width=\"11%\"><div class=\"th_class\">ราคาขายต่อหน่วย</div></th> "+			        
			        "  		<th width=\"12%\"><div class=\"th_class\">ราคาขายรวม</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        --%>
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   var total=0;
				   var vat=0;
				   var grand_total=0;
				   for(var i=0;i<data.length;i++){ 
					   var IS_REPLACE=data[i][13]!=null?data[i][13]:"0";
					     var REPLACE_NAME=data[i][14]!=null?data[i][14]:"";
					   var name ="";
					     if(IS_REPLACE=='1'){
					    	 name=REPLACE_NAME;
					     }else
					    	 name=data[i][1];
					     total=$.formatNumber(data[i][5]+"", {format:"#,###.00", locale:"us"});
					     vat=$.formatNumber(data[i][6]+"", {format:"#,###.00", locale:"us"});
					     grand_total=$.formatNumber(data[i][7]+"", {format:"#,###.00", locale:"us"});
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+     
					 //  "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
					   "  		<td style=\"text-align: left;\"> "+name+" "+(data[i][11]!=null?("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i][11]):"")+"</td>"+   
				        "    	<td style=\"text-align: center;\"><span style=\"text-decoration: underline;\" onclick=\"showItem('"+data[i][10]+"','"+data[i][0]+"','"+data[i][12]+"')\">"+data[i][2]+"</span></td>  "+  
				     <%-- 
				        "    	<td style=\"text-align: right;\">"+((data[i][8]!=null)? $.formatNumber(data[i][8]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				         "    	<td style=\"text-align: right;\">"+((data[i][9]!=null)? $.formatNumber(data[i][9]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				         "    	<td style=\"text-align: right;\">"+((data[i][3]!=null)? $.formatNumber(data[i][3]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				         "    	<td style=\"text-align: right;\">"+((data[i][4]!=null)? $.formatNumber(data[i][4]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				        //"    	<td style=\"text-align: right;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+    
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][10]+"','"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+
				        --%>
				        "  	</tr>  ";
				   }
				 /*   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"6\" style=\"text-align: right;\">ราคารวม</td>"+    
			       "    	<td style=\"text-align: right;\">"+total+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"6\" style=\"text-align: right;\">Vat 7%</td>"+    
			       "    	<td style=\"text-align: right;\">"+vat+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"6\" style=\"text-align: right;\">ราคาสุทธิ</td>"+    
			       "    	<td style=\"text-align: right;\">"+grand_total+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  "; */
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
			$("#item_section").html(str);
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
			 if(data==0) 
				 data=1;
			//alert(calculatePage(_perpageG,data))
			var pageCount=calculatePage(_perpageG,data);
			$("#pageCount").val(pageCount);
			renderPageSelect();
		}
	});
	*/
} 
function showItem(cuscod,itemId,auto){
	
	var query="  SELECT "+
	" mapping.BSO_ID,"+
	"  mapping.CUSCOD,"+
	"  mapping.IMA_ItemID,"+
	"  product.IMA_ItemName,"+
	"  mapping.SERIAL , "+
	"  mapping.IS_SERIAL "+
	"  FROM BPM_SALE_PRODUCT_ITEM_MAPPING mapping"+ 
	"  left join BPM_PRODUCT product"+
	"  on mapping.IMA_ItemID=product.IMA_ItemID"+
	"  where mapping.bso_id=${bsoId} and mapping.cuscod='"+cuscod+"' and mapping.IMA_ItemID='"+itemId+"' "+
	" and mapping.AUTO_K="+auto+
	"   order by  mapping.SERIAL asc "; 
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
			 role_ids=[];
			if(data!=null && data.length>0){
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\">No.</div></th> "+
			    "  		<th width=\"95%\"><div class=\"th_class\">Serial Number</div></th> "+ 
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
				   for(var i=0;i<data.length;i++){ 
					   str=str+ "  	<tr style=\"cursor: pointer;font-size: 16px; font-family: tahoma;\">"+
					   "  		<td style=\"text-align: left;\"> "+(i+1)+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+((data[i][5]=="1")?data[i][4]:"ไม่ระบุ")+" </td>"+ 
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> ";  
				   bootbox.dialog(str,[{
					    "label" : "Close",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
function showDialog(messaage){
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary"
	 }]);
} 
function doUpdateStockPre_send(btdl_type,btdl_state,owner,owner_type){
	 querys=[];   
	 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STORE_PRE_SEND='1' ,BSO_STORE_PREPARE_DATE=now(), BSO_STORE_PREPARE_COUNT=BSO_STORE_PREPARE_COUNT+1 "+
	 " where BSO_ID=${bsoId}"; 
querys.push(query); 
    query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_ACTION_TIME=now()  where BTDL_REF='${bsoId}' and "+
"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
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
			bootbox.dialog("จัดของเรียบร้อยแล้ว",[{
			    "label" : "Ok",
			    "class" : "btn-primary",
			    "callback": function() {
			    	togle_page('dispatcher/page/todolist','todolist_link')
			    }
			 }]);
		}
	}
});
}
// doUpdateStock('1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order updated ')"
function doUpdateStock(btdl_type,btdl_state,owner,owner_type,message){
	var BSO_STORE_RECEIVED_BY=jQuery.trim($("#BSO_STORE_RECEIVED_BY").val());
	if(BSO_STORE_RECEIVED_BY.length==0) {
		alert("กรุณากรอก ชื่อ คนรับของ");
		$("#BSO_STORE_RECEIVED_BY").focus();
		return false;
	}
	
	var querys=[]; 
	var query="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
	"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='"+btdl_state+"' and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  ";	 
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
						 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STORE_RECEIVED_BY='"+BSO_STORE_RECEIVED_BY+"' "+
						 ",BSO_STORE_RECEIVED_DATE=now(), BSO_STORE_BY='${username}'  where BSO_ID=${bsoId}"; 
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
								bootbox.dialog(message,[{
								    "label" : "Ok",
								    "class" : "btn-primary",
								    "callback": function() {
								    	togle_page('dispatcher/page/todolist','todolist_link')
								    }
								 }]);
							}
						}
					});
				}else{
					bootbox.dialog(message,[{
					    "label" : "Ok",
					    "class" : "btn-primary",
					    "callback": function() {
					    	togle_page('dispatcher/page/todolist','todolist_link')
					    }
					 }]);
				} 
			}});
}
function downloadForm(){  
	var src = "report/storeReport/${bsoId}";
	var div = document.createElement("div");
	document.body.appendChild(div);
	div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";  
}
</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px">
    <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px">
			  <c:if test="${mode=='edit'}">
			  <form>
			    <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
			  </form>
			   <div  class="well">
			  <table border="0" width="100%" style="font-size: 13px">
	    					<tbody>
	    					<tr>
	    					<td align="left" width="70%">   
	    					 <strong id="delivery_install_title"></strong>
	    					 <input type="text" id="bsoTypeNo" style="height: 30px;width: 125px" readonly="readonly"/>
	    					 <span style="display: none"  id="received_by_elelement">&nbsp;&nbsp;&nbsp;คนรับของ <input type="text" id="BSO_STORE_RECEIVED_BY" style="height: 30px;" /></span>
	    					 
	    					 <span  style="padding-left: 10px;">
            	<a class="btn" style="margin-top:-12px;" onclick="downloadForm()">&nbsp;Preview Form&nbsp;</a>
            	</span> 
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
	    					 
			 <div  id="item_section"> 
    		 </div> 
			</div>
			<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="togle_page('dispatcher/page/todolist','todolist_link')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">  
    					 <div align="center"> 
    					 <a id="store_prepare_id" style="display: none" class="btn btn-primary"  onclick="doUpdateStockPre_send('1','wait_for_stock','ROLE_STORE_ACCOUNT','2')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">จัดรายการแล้ว</span></a>
    					 <a id="store_update_id"  style="display: none" class="btn btn-primary"  onclick="doUpdateStock('1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order updated ')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update คนรับของ</span></a>
    					 </div>
				 		 
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
</fieldset>