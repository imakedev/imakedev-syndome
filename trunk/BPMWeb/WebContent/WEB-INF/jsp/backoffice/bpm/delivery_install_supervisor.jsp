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
</style>
<script type="text/javascript">
$(document).ready(function() {  
	 
   getSaleOrder();   
		
    
   var query="SELECT CUSCOD,CUSTYP,PRENAM,CUSNAM,ADDR01,ADDR02,ADDR03,ZIPCOD,TELNUM,CONTACT,CUSNAM2  FROM "+SCHEMA_G+".BPM_ARMAS where CUSCOD like "; 
   $("#CUSCOD" ).autocomplete({
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
					        	  id: item[2],
					        	  CUSCOD: item[0],
					        	  CUSTYP: item[1],
					        	  PRENAM: item[2],
					        	  CUSNAM: item[3],
					        	  ADDR01: item[4],
					        	  ADDR02: item[5],
					        	  ADDR03: item[6],
					        	  ZIPCOD: item[7],
					        	  TELNUM: item[8],
					        	  CONTACT: item[9],
					        	  CUSNAM2: item[10] 
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
			  $("#CUSCOD").val(ui.item.CUSCOD);
			  $("#CONTACT").val(ui.item.CONTACT); 
			  $("#CUSNAM").val(ui.item.CUSNAM); 
			  $("#ADDR01").val(ui.item.ADDR01+" "+ui.item.ADDR02);
			  $("#TELNUM").val(ui.item.TELNUM);  
		      return false;
		  },
		  open: function() {
		    $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
		  },
		  close: function() {
		    $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
		  }
		}); 
}); 
/* function getSupervisorSelect(){ 
	var query="SELECT user.username,dept.bdept_name FROM "+SCHEMA_G+".BPM_DEPARTMENT  dept left join "+SCHEMA_G+".user "+
			 " on dept.bdept_hdo_user_id=user.id ";
	var str="<select id=\"supervisor_select\"	style=\"margin-top: 10px;width: 75px\">";
	SynDomeBPMAjax.searchObject(query,{
		callback:function(data){ 
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++)
					str=str+"<option value=\""+data[i][0]+"\">"+data[i][1]+"</option>";
			}else{
				 
			}
			str=str+"</select>";
			$("#supervisor_select_element").html(str);
		}
 });
} */
function bsoTypeCheck(type){  
	//alert(type)
	   if(type=='1' || type=='2' ){ 
		   $("#bsoTypeCheck_3").prop("checked",false);
		   $("#bsoTypeCheck_4").prop("checked",false); 
	   }else if(type=='3' ){ 
		   $("#bsoTypeCheck_1").prop("checked",false);
			 $("#bsoTypeCheck_2").prop("checked",false);
			 $("#bsoTypeCheck_4").prop("checked",false);
	   }else if(type=='4' ){ 
		   $("#bsoTypeCheck_1").prop("checked",false);
			 $("#bsoTypeCheck_2").prop("checked",false);
			 $("#bsoTypeCheck_3").prop("checked",false);
	   } 
	   $("#bsoType_1").slideUp(1000);
	   $("#bsoType_2").slideUp(1000);  
	   for(var i=1;i<=2;i++){ 
		 //if( $('input[name="BSO_DELIVERY_TYPE"][value="' + i + '"]').prop('checked') ){
		  if($("#bsoTypeCheck_"+i).prop("checked")){ 
			  $("#bsoType_"+i).slideDown(1000);
		  } 
	  }  
	   
	   if(type=='3'){ 
			 if($("#bsoTypeCheck_"+type).prop("checked")){
				  $("#bsoType_1").slideDown(1000);
				  $("#bsoType_2").slideDown(1000); 
			 }
		 	/*  else{ 
				  $("#bsoType_1").slideUp(1000);
				  $("#bsoType_2").slideUp(1000);
		 	 } */
		  }
}
function addItem(){
	//var str="";
	 
	var function_str="addItemToList()";
	var label_str="Add Item";
	var input_id="ima_item_id";
	var input_hidden_id="IMA_ItemID"; 
	var query="SELECT IMA_ItemID,IMA_ItemName,LocQty,ROUND(LastCostAmt,2),CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name  FROM "+SCHEMA_G+".BPM_PRODUCT "+	
	  " where  CONCAT(IMA_ItemID, ' ', IMA_ItemName) like ";
	 
	var bt= "<span>&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
	var input_str= "<br/><span id=\"item_name\"></span>"+
		            "<input type=\"hidden\" id=\"Price\" name=\"Price\" style=\"height: 30;\" />"+
		            "<br/>ราคาขาย <input type=\"text\" id=\"LastCostAmt\" name=\"LastCostAmt\" style=\"height: 30;\" />"+
	 				"<br/>จำนวน <input type=\"text\" id=\"AMOUNT\" name=\"AMOUNT\" style=\"height: 30;\" />"+
	 				""+
	 				"<br/>Serial เริ่มต้น &nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" checked value=\"1\" name=\"isNoSerail\" onclick=\"show_hide('SERIAL','1')\"/>&nbsp;&nbsp;ระบุ"+
	 				"&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" value=\"0\" name=\"isNoSerail\" onclick=\"show_hide('SERIAL','0')\"/>&nbsp;&nbsp;ไม่ระบุ"+
	 				"&nbsp;&nbsp;&nbsp;&nbsp;<br/>"+
	 				"<input type=\"text\" id=\"SERIAL\" name=\"SERIAL\" style=\"height: 30;\" />"+
	 				"<br/>";
	 bootbox.dialog("<input type=\"text\" id=\""+input_id+"\" name=\""+input_id+"\" style=\"height: 30;\" />"+bt+"</span>"+input_str,[{
		    "label" : "Cancel",
		    "class" : "btn-danger"
	 }]);
	 /*
	 , [{
		    "label" : "Success!",
		    "class" : "btn-success",
		    "callback": function() {
		        Example.show("great success");
		    }
		}]);
		*/
	 $("#"+input_id+"" ).autocomplete({
		  source: function( request, response ) {    
			  //$("#pjCustomerNo").val(ui.item.label); 
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
			 });		  
		  },
		  minLength: 1,
		  select: function( event, ui ) { 
			  this.value = ui.item.value;
			  $("#"+input_hidden_id+"").val(ui.item.id);  
			  document.getElementById("Price").value=ui.item.Price; 
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
function addItemToList(){
	//alert('aui aui 1');
	//alert( $("#bdeptUserId").val());
	var IMA_ItemID=jQuery.trim($("#IMA_ItemID").val());
	var LastCostAmt=jQuery.trim($("#LastCostAmt").val());
	var Price=jQuery.trim($("#Price").val());
	var AMOUNT=jQuery.trim($("#AMOUNT").val());
	var SERIAL=jQuery.trim($("#SERIAL").val());
	var IS_SERIAL="0";
	var PRE_SERIAL="";
	//alert(IMA_ItemID);
	//alert(SERIAL.length);
	
	if($('input[name="isNoSerail"][value="1"]').prop('checked')){
		IS_SERIAL='1';
		if(SERIAL.length!=13){
			if(SERIAL.length!=15){
				alert(" กรอก Serial เริ่มต้น 13, 15 หลัก เท่านั้น"); 
				return false;
			}
		}else{
			PRE_SERIAL=SERIAL.substring(0,9);
			//alert(PRE_SERIAL);
			SERIAL=SERIAL.substring(9);
			//alert(SERIAL);
		}
	}else{
		SERIAL="1";
	}
	
	//return false;
	var querys=[];
	var query="INSERT INTO "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM (BSO_ID,CUSCOD,IMA_ItemID,AMOUNT,PRICE,PRICE_COST) "+
	          " VALUES(${bsoId},'"+$("#CUSCOD").val()+"','"+IMA_ItemID+"',"+AMOUNT+","+LastCostAmt+","+Price+"); ";
	
	var fullSerial = jQuery.trim($("#SERIAL").val());
	querys.push(query);
	if(!isNaN(jQuery.trim($("#SERIAL").val()))){
		for(var i=0;i<AMOUNT;i++){
			//alert(SERIAL+i);
			var val=parseInt(SERIAL, 10)+i;
			var val_str=(""+val);
			if(val>99 && val<=999) // 100-999
				val_str="0"+val;
			else if(val>9 && val<=99) // 10-99
				val_str="00"+val;
			else if(val<=9) // 1-9
				val_str="000"+val;
	
			 query="INSERT INTO "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING (BSO_ID,CUSCOD,IMA_ItemID,SERIAL,IS_SERIAL) "+
	         " VALUES(${bsoId},'"+$("#CUSCOD").val()+"','"+IMA_ItemID+"','"+PRE_SERIAL+val_str+"','"+IS_SERIAL+"'); "; 
	         //alert("query->"+query)
			querys.push(query);  
		} 
	}else{//contain String ex. 1501100305M0251(new serial 2015) Aui edit[20150221]
		var running_no ="";
		var len = SERIAL.length;
		var strSerial = "";
		for(var i = len-1 ;i>0 ;i--){
			var res = SERIAL.charAt(i);
			if(!isNaN(res)){//is numeric
				running_no = res+""+running_no;
			}else{					
				strSerial = fullSerial.substr(0, i+1);
				break;
			}
		}

		for(var i=0;i<AMOUNT;i++){ 
			var val=parseInt(running_no, 10)+i;
			var val_str=(""+val);
			if(val>99 && val<=999) // 100-999
				val_str="0"+val;
			else if(val>9 && val<=99) // 10-99
				val_str="00"+val;
			else if(val<=9) // 1-9
				val_str="000"+val;
			
			query="INSERT INTO "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM_MAPPING (BSO_ID,CUSCOD,IMA_ItemID,SERIAL,IS_SERIAL) "+
	         " VALUES(${bsoId},'"+$("#CUSCOD").val()+"','"+IMA_ItemID+"','"+strSerial+""+val_str+"','"+IS_SERIAL+"'); "; 
	         //alert("query->"+query)
			querys.push(query);  			
		} 
		
	}
	
	
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
				bootbox.hideAll();
			}
		}
	});
}
function getSaleOrder(){  
	var isEdit=false;
	var function_message="Create";
	if("${mode}"=="edit"){
		function_message="Edit";
		isEdit=true;
	}
	//$("#delivery_install_title").html("Sale Order ("+function_message+")");
	$("#delivery_install_title").html("Sale Order ");
  if(isEdit){  
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
	   " so.BSO_STORE_PRE_SEND , "+ 
	   " so.BSO_INT_NO "+
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
					var BSO_INT_NO=data[0][63]!=null?data[0][63]:""; 
					var check_store_element="ยังไม่ได้ เตรียมของ";
					if(BSO_STORE_PRE_SEND=='1'){
						check_store_element="เตรียมของเรียบร้อยแล้ว";
					}
					$("#check_store_element").html(check_store_element);
					$("#BSO_INSTALLATION_TIME_TIME_PICKER").val(BSO_INSTALLATION_TIME_TIME_PICKER);
					
					 
					// BSO_BORROW_EXT
					//BSO_BORROW_DURATION
					//BSO_WARRANTY_EXT
					//BSO_PM_MA_EXT
					//alert("BSO_IS_DELIVERY->"+BSO_IS_DELIVERY) 
					 if(BSO_IS_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_1"]').prop('checked', true);						 
						 bsoTypeCheck('1'); 
						 $("#bsoRfe_element").show(); 
						 
						// $("#delivery_form_element").show();  
					}
					if(BSO_IS_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_2"]').prop('checked', true);
						 bsoTypeCheck('2');
						 $("#install_form_element").show();
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						 getInstallationNo();
					}
					  if(BSO_IS_DELIVERY_INSTALLATION=='1' ){ 
						 $('input[id="bsoTypeCheck_3"]').prop('checked', true);
						 bsoTypeCheck('3');
						 $("#install_form_element").show();
						 $("#BSO_INT_NO").val(BSO_INT_NO);
						  getInstallationNo();
					} 
					if(BSO_IS_NO_DELIVERY=='1' ){ 
						 $('input[id="bsoTypeCheck_4"]').prop('checked', true);
						  bsoTypeCheck('4');
					}  
					
				 	$('input[name="BSO_LEVEL"][value="' + BSO_LEVEL + '"]').prop('checked', true);
					$('input[name="BSO_CUSTOMER_TYPE"][value="' + BSO_CUSTOMER_TYPE + '"]').prop('checked', true);
					$('input[name="BSO_PAYMENT_TERM"][value="' + BSO_PAYMENT_TERM + '"]').prop('checked', true);
					
					$('input[name="BSO_IS_WARRANTY"][value="' + BSO_IS_WARRANTY + '"]').prop('checked', true);
					var BSO_WARRANTY_EXT="";
					var BSO_WARRANTY_VALUE='0';
					/*
					if(BSO_WARRANTY.length>0){
						BSO_WARRANTY_VALUE=BSO_WARRANTY;
						if(BSO_WARRANTY!='2' && BSO_WARRANTY!='3'){
							BSO_WARRANTY_EXT=BSO_WARRANTY;
							BSO_WARRANTY_VALUE="0"; 
						} 
					}else{
						BSO_WARRANTY_VALUE=BSO_WARRANTY; 
					} 
					alert(BSO_WARRANTY_VALUE)
					*/
					BSO_WARRANTY_VALUE=BSO_WARRANTY; 
					$('input[name="BSO_WARRANTY"][value="' + BSO_WARRANTY_VALUE + '"]').prop('checked', true);
					$("#BSO_WARRANTY_EXT").val(BSO_WARRANTY_EXT);
					
					var BSO_PM_MA_EXT="";
					var BSO_PM_MA_VALUE='0';
					if(BSO_PM_MA.length>0){
						BSO_PM_MA_VALUE=BSO_PM_MA;
						if(BSO_PM_MA!='4' && BSO_PM_MA!='3'){
							BSO_PM_MA_EXT=BSO_PM_MA;
							BSO_PM_MA_VALUE="0"; 
						} 
					}else{
						BSO_PM_MA_VALUE=BSO_PM_MA; 
					} 
					$('input[name="BSO_PM_MA"][value="' + BSO_PM_MA_VALUE + '"]').prop('checked', true);
					$("#BSO_PM_MA_EXT").val(BSO_PM_MA_EXT);
					
					//var BSO_BORROW_TYPE="";
					var BSO_BORROW_EXT_VALUE="";
					var BSO_BORROW_DURATION_VALUE=""; 
					if(BSO_BORROW_TYPE.length>0){
						if(BSO_BORROW_TYPE=='7'){
							BSO_BORROW_DURATION_VALUE=BSO_BORROW_DURATION;
							BSO_BORROW_EXT_VALUE=BSO_BORROW_EXT; 
						} 
					}
					$('input[name="BSO_BORROW_TYPE"][value="' + BSO_BORROW_TYPE + '"]').prop('checked', true); 
					$("#BSO_BORROW_EXT").val(BSO_BORROW_EXT_VALUE);
					$("#BSO_BORROW_DURATION").val(BSO_BORROW_DURATION_VALUE);
					
					//var BSO_PAYMENT_TERM_EXT="";
					
					var BSO_PAYMENT_TERM_DESC_3="";
					var BSO_PAYMENT_TERM_DESC_4="";
					//var BSO_PAYMENT_TERM_VALUE='0';
					if(BSO_PAYMENT_TERM.length>0){ 
						if(BSO_PAYMENT_TERM=='3'){ 
							BSO_PAYMENT_TERM_DESC_3=BSO_PAYMENT_TERM_DESC;
						}else if( BSO_PAYMENT_TERM=='4'){
							BSO_PAYMENT_TERM_DESC_4=BSO_PAYMENT_TERM_DESC;
						}
					}else{
						BSO_PAYMENT_TERM_VALUE=BSO_PAYMENT_TERM; 
					} 
					
					$('input[name="BSO_PAYMENT_TERM"][value="' + BSO_PAYMENT_TERM + '"]').prop('checked', true);
					$("#BSO_PAYMENT_TERM_DESC_4").val(BSO_PAYMENT_TERM_DESC_4);
					$("#BSO_PAYMENT_TERM_DESC_3").val(BSO_PAYMENT_TERM_DESC_3);
					
					$('input[name="BSO_IS_PM_MA"][value="' + BSO_IS_PM_MA + '"]').prop('checked', true);
					$('input[name="BSO_IS_OPTION"][value="' + BSO_IS_OPTION + '"]').prop('checked', true); 
					
					
					
					
					$('input[name="BSO_OPTION"][value="' + BSO_OPTION + '"]').prop('checked', true);
					
					$('input[id="BSO_IS_HAVE_BORROW"][value="' + BSO_IS_HAVE_BORROW + '"]').prop('checked', true); 
				//	$('input[name="BSO_DELIVERY_TYPE"][value="' + BSO_DELIVERY_TYPE + '"]').prop('checked', true);
				//	 bsoTypeCheck("'"+BSO_DELIVERY_TYPE+"'");
					/* BSO_PAYMENT_TERM_DESC_3
					BSO_PAYMENT_TERM_DESC_4
					 */
					query=" SELECT BS_ID,BS_SLA_LIMIT "+
					   " FROM "+SCHEMA_G+".BPM_SLA  ORDER BY BS_SLA_LIMIT ";
					var sla_select="<select name=\"BSO_SLA\" id=\"BSO_SLA\"  style=\"width: 75px\">";   
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
								//alert(data2)
								for(var i=0;i<data2.length;i++){ 
									sla_select=sla_select+"<option value=\""+data2[i][1]+"\">"+data2[i][1]+"</option>";
								}
								sla_select=sla_select+"</select>"; 
								$("#sla_select_element").html(sla_select);
								$("#BSO_SLA").val(BSO_SLA);
							}
					  });
				 
				}else{
					
				} 
				searchItemList("1");
			}
	 	  }); 
  }else{
	  SynDomeBPMAjax.getRunningNo("SALE_ORDER_BY_YEAR","y","5","th",{
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
					$("#bsoTypeNo").val(data);
					var querys=[];  
					
					var query="insert into "+SCHEMA_G+".BPM_SALE_ORDER set BSO_TYPE='1',BSO_TYPE_NO='"+data+"' ,BSO_STATE='Sale Order Created' ,BSO_CREATED_BY='${username}' ,"+
					  " BSO_CREATED_DATE=now(),BSO_DOC_CREATED_DATE=now()";
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
								   " BSO_ID , CUSCOD FROM "+SCHEMA_G+".BPM_SALE_ORDER where BSO_TYPE_NO='"+$("#bsoTypeNo").val()+"'";
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
											loadDynamicPage('dispatcher/page/delivery_install_management?bsoId='+data2[0][0]+'&mode=edit');
										}
								  }); 
								//searchDeliveryInstallation("1"); 
							}
						}
					});
					//alert(data)	
				}else{
					
				} 
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
function getInstallationNo(){
	var BSO_INT_NO=jQuery.trim($("#BSO_INT_NO").val());
	if(!BSO_INT_NO.length>0){
		SynDomeBPMAjax.getRunningNo("INSTALL","ymd","4","",{ 
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
						$("#BSO_INT_NO").val(data);
						var querys=[];  
						var query=" UPDATE "+SCHEMA_G+".BPM_SALE_ORDER SET "+
						 " BSO_INT_NO = '"+data+"'  where BSO_ID=${bsoId}" ;
						 
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
							}
						});
					}else{
						
					} 
				}
		 	  });
	}
	 
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
	for(var i=1;i<=pageCount;i++){
		pageStr=pageStr+"<option value=\""+i+"\">"+i+"</option>";
	}
	pageStr=pageStr+"</select>"; 
	$("#pageElement").html(pageStr);
	checkWithSet("pageSelect",$("#pageNo").val());
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
	          " item.cuscod, "+
	          "  item.DETAIL , "+
	          "  item.AUTO_K,  "+
	          "  item.IS_REPLACE , "+
	          "  item.REPLACE_NAME  "+
		"FROM "+SCHEMA_G+".BPM_SALE_PRODUCT_ITEM  item left join "+SCHEMA_G+".BPM_PRODUCT product  "+
		" on item.IMA_ItemID=product.IMA_ItemID where item.BSO_ID=${bsoId}  and item.IMA_ItemID not in('900002','900004','90100002' )";
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
			       /*  "  		<th width=\"11%\"><div class=\"th_class\">ต้นทุนต่อหน่วย</div></th> "+			        
			        "  		<th width=\"12%\"><div class=\"th_class\">ต้นทุนรวม</div></th> "+  */
			       // "  		<th width=\"11%\"><div class=\"th_class\">ราคาขายต่อหน่วย</div></th> "+			        
			       // "  		<th width=\"12%\"><div class=\"th_class\">ราคาขายรวม</div></th> "+ 
			       /*  "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+ */
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
					   "  		<td style=\"text-align: left;\"> "+name+" "+(data[i][11]!=null?("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i][11]):"")+"</td>"+
				        "    	<td style=\"text-align: center;\"><span style=\"text-decoration: underline;\" onclick=\"showItem('"+data[i][10]+"','"+data[i][0]+"','"+data[i][12]+"')\">"+data[i][2]+"</span></td>  "+  
				     //   "    	<td style=\"text-align: right;\">"+((data[i][8]!=null)? $.formatNumber(data[i][8]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				      //   "    	<td style=\"text-align: right;\">"+((data[i][9]!=null)? $.formatNumber(data[i][9]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				      //   "    	<td style=\"text-align: right;\">"+((data[i][3]!=null)? $.formatNumber(data[i][3]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				      //   "    	<td style=\"text-align: right;\">"+((data[i][4]!=null)? $.formatNumber(data[i][4]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				        //"    	<td style=\"text-align: right;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				     /*    "    	<td style=\"text-align: center;\">"+    
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][10]+"','"+data[i][0]+"')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				        "    	</td> "+ */
				        "  	</tr>  ";
				   }
				   
				  /*  str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคารวม</td>"+    
			       "    	<td style=\"text-align: right;\">"+total+"</td>  "+ 
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">Vat 7%</td>"+    
			       "    	<td style=\"text-align: right;\">"+vat+"</td>  "+
			      
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\"4\" style=\"text-align: right;\">ราคาสุทธิ</td>"+    
			       "    	<td style=\"text-align: right;\">"+grand_total+"</td>  "+
			      
			        "  	</tr>  "; */
			   }else{
				   //var str="<div align=\"left\" style=\"padding-bottom: 4px\"> <a class=\"btn\" onclick=\"showForm('add','0')\"><i class=\"icon-plus-sign\"></i>&nbsp;<span style=\"font-weight: normal;\">Add</span></a></div>"+
			    str="<table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
		    		"<thead>"+
		    		"<tr> "+
	      			"<th colspan=\"6\" width=\"100%\"><div class=\"th_class\">Not Found</div></th>"+ 
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
function showTeam(){
	//alert("ss")
	var query="SELECT  "+
		" user.id,user.username ,user.firstName,user.lastName,user_hod.username as username_hod ,dept.bdept_id , "+
		" (SELECT count(*) FROM "+SCHEMA_G+".BPM_TO_DO_LIST  where btdl_owner=user.username and btdl_hide='1' ) "+
		" FROM "+SCHEMA_G+".BPM_DEPARTMENT_USER dept_user left join "+ 
		" "+SCHEMA_G+".user user on dept_user.user_id=user.id "+
		" left join  "+
		" "+SCHEMA_G+".BPM_DEPARTMENT dept  on dept_user.bdept_id=dept.bdept_id "+
		" left join  "+
		" "+SCHEMA_G+".user user_hod   on user_hod.id=dept.bdept_hdo_user_id "+  
		" where user_hod.username='${username}' "; 
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
				
				var str="	  <table class=\"table table-striped table-bordered table-condensed\" border=\"1\" style=\"font-size: 12px\"> "+
			    "	<thead> 	"+
			    "  		<tr> "+
			    "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			    "  		<th width=\"30%\"><div class=\"th_class\">Username</div></th> "+
			    "  		<th width=\"65%\"><div class=\"th_class\">Name </div></th> "+  
			    " 		</tr>"+
			    "	</thead>"+
			    "	<tbody>   ";   
			    var bdept_id="";
				   for(var i=0;i<data.length;i++){
					  /*  role_ids.push(data[i][0]);
					   var check_selected="";
					   var unCheck_selected=" checked=\"checked\" ";
					   if(data[i][4]>0){
						   check_selected=" checked=\"checked\" ";
						   unCheck_selected="";
					   } */
					   var pending_job="";
					   if(data[i][6]>0)
						   pending_job=" [ "+data[i][6]+"]";
					   bdept_id=data[i][5];
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"><input type=\"radio\" value=\""+data[i][1]+"\"  name=\"usernameIdCheckbox_radio\"></td>"+     
					   "  		<td style=\"text-align: left;\"> "+data[i][1]+" </td>"+    
				        "    	<td style=\"text-align: left;\">"+((data[i][2]!=null)?data[i][2]:"")+"  "+((data[i][3]!=null)?data[i][3]:"")+pending_job+"</td>  "+  
				        "  	</tr>  "; 
				   }
				   str=str+  " </tbody>"+
				   "</table> "; 
				   var send_to_str='ส่งต่อให้ Logistic';
					if(bdept_id=='8')
						send_to_str='ส่งต่อให้ IT';
				 
				   str=str+"<div align=\"center\"> <a class=\"btn btn-primary\"  onclick=\"doAssignTeam('"+bdept_id+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">Assign</span></a>"+
				   "&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\"  onclick=\"doSendTo('"+bdept_id+"')\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+send_to_str+"</span></a>"+
				   "</div>";
				// alert(str)
				   bootbox.dialog(str,[{
					    "label" : "Cancel",
					     "class" : "btn-danger"
					    //	"class" : "class-with-width"
				 }]);
			   }
		}
	});
}
  
	function doSendTo(bdept_id){
		 
		bootbox.hideAll();
		var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
        " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
        " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
        " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic	FROM dual ";
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
				var querys=[];   
				if(data!=null && data.length>0){
					var message_created='ข้อมูลถูกส่งไป Logistic เรียบร้อยแล้ว'; 
					if(bdept_id!='8'){// RFE
					 	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					}else {	 // IT
						message_created="ข้อมูลถูกส่งไป IT เรียบร้อยแล้ว";
					 	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
								"('${bsoId}','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					}
					var btdl_type='1'; 
					
					var is_hide_todolist=true;
					 
					 if('${state}'!='' && is_hide_todolist && bdept_id=='8'){
					  var query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
					 }   
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
				}
			}});
		//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
		//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
	    var btdl_state='wait_for_operation_install';
		if(bdept_id=='8'){
			btdl_state='wait_for_operation_delivery';
		}else{
			
		}
		

	}
function doAssignTeam(bdept_id){
	var username_team=""; 
	var usernameIdCheckbox_radio=document.getElementsByName("usernameIdCheckbox_radio"); 
	for(var j=0;j<usernameIdCheckbox_radio.length;j++){
		if(usernameIdCheckbox_radio[j].checked){
			username_team=usernameIdCheckbox_radio[j].value;
			break;	
		}
	} 
	bootbox.hideAll();
	//doUpdateState('1','wait_for_operation',username_team,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว','Sale Order wait for Operation','1',true);
	//doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){
    var btdl_state='wait_for_operation_install';
    var BTDL_SLA_LIMIT_TIME="(SELECT (DATE_FORMAT((now() +  INTERVAL 1 DAY),'%Y-%m-%d 20:00:00')))";
    var BTDL_DUE_DATE="null";
    var spec_time="";
	if(bdept_id=='8'){
		btdl_state='wait_for_operation_delivery';
		var BSO_DELIVERY_DUE_DATE_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_PICKER").val());
		var BSO_DELIVERY_DUE_DATE_TIME_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val());
		var BSO_DELIVERY_DUE_DATE="";
		if(BSO_DELIVERY_DUE_DATE_PICKER.length>0){
			var BSO_DELIVERY_DUE_DATE_ARRAY=BSO_DELIVERY_DUE_DATE_PICKER.split("/");
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE_ARRAY[2]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[1]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[0];
			if(BSO_DELIVERY_DUE_DATE_TIME_PICKER.length>0){
				if(BSO_DELIVERY_DUE_DATE_TIME_PICKER=='00:00')					
					spec_time=BSO_DELIVERY_DUE_DATE+" 20:00:00"; 
				else
					spec_time=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
				BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
				
			}else{
				spec_time=BSO_DELIVERY_DUE_DATE+" 20:00:00"; 
				BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" 00:00:00";
				
			}
			 
		}

		if(BSO_DELIVERY_DUE_DATE.length>0){
			BTDL_SLA_LIMIT_TIME="'"+spec_time+"'";
			BTDL_DUE_DATE="'"+BSO_DELIVERY_DUE_DATE+"'";
		} 
	}else{
		var BSO_INSTALLATION_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_PICKER").val());
		var BSO_INSTALLATION_TIME_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_TIME_PICKER").val());
		var BSO_INSTALLATION_DUE_DATE="";
		if(BSO_INSTALLATION_TIME_PICKER.length>0){
			var BSO_INSTALLATION_DUE_DATE_ARRAY=BSO_INSTALLATION_TIME_PICKER.split("/");
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE_ARRAY[2]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[1]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[0];
			if(BSO_INSTALLATION_TIME_TIME_PICKER.length>0){
				if(BSO_INSTALLATION_TIME_TIME_PICKER=='00:00')		
					spec_time=BSO_INSTALLATION_DUE_DATE+" 20:00:00";
				else
					spec_time=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
				BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
				
			}else{
				spec_time=BSO_INSTALLATION_DUE_DATE+" 20:00:00"; 
				BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" 00:00:00";
				
			}
			 
		}
		if(BSO_INSTALLATION_DUE_DATE.length>0){
			BTDL_SLA_LIMIT_TIME="'"+spec_time+"'"; 
			BTDL_DUE_DATE="'"+BSO_INSTALLATION_DUE_DATE+"'";
		}
	}

	var btdl_type='1';
	var owner=username_team;var owner_type="1";var message_duplicate='ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว';
	var message_created='ข้อมูลถูกส่งไป Team เรียบร้อยแล้ว';var message_todolist='Sale Order wait for Operation';var hide_status='1';
	var is_hide_todolist=true;
	var querys=[];  
	 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bsoId}','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','24',3600,now(),	"+BTDL_DUE_DATE+",'"+hide_status+"','${username}','"+$("#bsoTypeNo").val()+"',"+BTDL_SLA_LIMIT_TIME+" ) ";
	 
	 if('${state}'!='' && is_hide_todolist){
	  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0',BTDL_ACTION_TIME=now()  where BTDL_REF='${bsoId}' and "+
		"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' and BTDL_OWNER='${username}' ";
		//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
		 querys.push(query2); 
	 } 
	 if(btdl_state=='wait_for_operation_delivery' || btdl_state=='wait_for_operation_install'   || btdl_state=='wait_for_supervisor_close'){
		 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
		  querys.push(query2); 
	 }
	 
	 if(username_team=='RFE'){
		 var BSO_RFE_NO =jQuery.trim($("#BSO_RFE_NO").val());
		 if(!BSO_RFE_NO.length>0){
			  alert("กรุณาใส่ RFE No.");
			  $("#BSO_RFE_NO").focus();
			  return false;
		  }
		  query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_RFE_NO='"+BSO_RFE_NO+"' where BSO_ID=${bsoId}"; 
		  querys.push(query2); 
	 }
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

}
//1(type จัดส่ง),wait_for_create_to_express,ROLE_INVOICE_ACCOUNT,2(role),ข้อมูล ถูก update เรียบร้อยแล้ว
function doUpdateJob(btdl_type,btdl_state,owner,owner_type,message){
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
				 if(btdl_state!='wait_for_create_to_express' && btdl_state!='wait_for_stock'){
					 if(btdl_state=='wait_for_supervisor_close')
						 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='Sale Order Closed', BSO_STATUS='1' where BSO_ID=${bsoId}";
					 else
						 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
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
								showDialog(message);
							}
						}
					});
				 }else
						showDialog(message);
				}else{
					showDialog(message);
				} 
			}});
}
function doSendToSupervisor(){
	var selectValue=$("select[id=supervisor_select] option:selected").val();
	 doUpdateState('1','wait_for_assign_to_team',selectValue,'1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor เรียบร้อยแล้ว','Sale Order wait for assign to Team','1',true);
	
	 //doUpdateState();
}
function showDialog(messaage){
	bootbox.dialog(messaage,[{
	    "label" : "Ok",
	    "class" : "btn-primary"
	 }]);
}
function doSubmitSaleOrder(){ 
	
	var querys=[];  
	// send to Express
	var  query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
			"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
			"('${bsoId}','1','wait_for_create_to_express','ROLE_INVOICE_ACCOUNT','2','Sale Order Created','5',60,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(5*60))) ";
	//alert(query)
	// send to Store
	 
	var  query2="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
	"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
	"('${bsoId}','1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order Created','1',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(1*3600))) ";
	
	// if(ส่งของ send to RFE, ติดตั้ง send to IT ,ส่งของพร้อมติดตั้ง send to IT)
	var	 query3="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
						"BTDL_TYPE='1' and BTDL_STATE='wait_for_assign_to_team' ";  

	 querys.push(query);
	 querys.push(query2);    
	 querys.push(query3); 
	var query_search="SELECT (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user  "+
			         " on dept.bdept_hdo_user_id=user.id where bdept_id=4) as hod_it,   "+
			         " (select user.username from  "+SCHEMA_G+".BPM_DEPARTMENT dept left join user   "+ 
			         " on dept.bdept_hdo_user_id=user.id where bdept_id=8) as hod_logistic	FROM dual ";
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
					var BSO_DELIVERY_TYPE=$("input[name=BSO_DELIVERY_TYPE]:checked" ).val();
					//if(document.getElementById("bsoTypeCheck_1").checked){ // RFE
					if(BSO_DELIVERY_TYPE=='1'){
						//24 3600
						 /* query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','24',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(24*3600))) "; */
						 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][1]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					} 
					if(BSO_DELIVERY_TYPE=='3' || BSO_DELIVERY_TYPE=='2'){
					//if(document.getElementById("bsoTypeCheck_3").checked || document.getElementById("bsoTypeCheck_2").checked){ // IT
						/*  query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
							"('${bsoId}','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','24',3600,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',addtime(now(),SEC_TO_TIME(24*3600))) "; */
							 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
								"BTDL_SLA,BTDL_SLA_UNIT,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO,BTDL_SLA_LIMIT_TIME) VALUES "+
								"('${bsoId}','1','wait_for_assign_to_team','"+data[0][0]+"','1','Sale Order wait for assign to Team','',0,now(),	null,'1','${username}','"+$("#bsoTypeNo").val()+"',null) ";
						 querys.push(query); 
					}
					 query="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='wait_for_assign_to_team' where BSO_ID=${bsoId}";
					 querys.push(query); 
				}
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
							showDialog("Submit Sale Order.");
						}
					}
				});
			}});
	
    // return false; 
	 
}
// 1(type จัดส่ง),wait_for_create_to_express,ROLE_INVOICE_ACCOUNT,2(role),ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว,ข้อมูลถูกส่งไปฝ่าย บัญชี เรียบร้อยแล้ว,Sale Order Created,1(show,0=hide)
function doUpdateState(btdl_type,btdl_state,owner,owner_type,message_duplicate,message_created,message_todolist,hide_status,is_hide_todolist){   
	var query="SELECT *  FROM "+SCHEMA_G+".BPM_TO_DO_LIST where BTDL_REF='${bsoId}' and "+
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
				if(data!=null && data.length>0){
					showDialog(message_duplicate);
				}else{
					var querys=[];  
					 query="insert into "+SCHEMA_G+".BPM_TO_DO_LIST(BTDL_REF,BTDL_TYPE,BTDL_STATE,BTDL_OWNER,BTDL_OWNER_TYPE,BTDL_MESSAGE,"+
							"BTDL_SLA,BTDL_CREATED_TIME,BTDL_DUE_DATE,BTDL_HIDE,BTDL_REQUESTOR,REF_NO) VALUES "+
							"('${bsoId}','"+btdl_type+"','"+btdl_state+"','"+owner+"','"+owner_type+"','"+message_todolist+"','',now(),	null,'"+hide_status+"','${username}','"+$("#bsoTypeNo").val()+"') ";
					 if('${state}'!='' && is_hide_todolist){
					  query2="update "+SCHEMA_G+".BPM_TO_DO_LIST set BTDL_HIDE='0'  where BTDL_REF='${bsoId}' and "+
						"BTDL_TYPE='"+btdl_type+"' and BTDL_STATE='${state}' ";
						//and BTDL_OWNER='"+owner+"' and BTDL_OWNER_TYPE='"+owner_type+"'  " 
						 querys.push(query2); 
					 } 
					 if(btdl_state=='wait_for_operation' || btdl_state=='wait_for_supervisor_close'){
						 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATE='"+btdl_state+"' where BSO_ID=${bsoId}"; 
						  querys.push(query2); 
					 }
					 if(btdl_state=='wait_for_supervisor_close'){
						 query2="update "+SCHEMA_G+".BPM_SALE_ORDER set BSO_STATUS='3' where BSO_ID=${bsoId}"; 
						  querys.push(query2); 
					 }
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
								showDialog(message_created);
							}
						}
					});
				} 
			}});
	
}
function doSaveDraftAction(){  	 
	var BSO_ID="${bsoId}";
	var CUSCOD=jQuery.trim($("#CUSCOD").val());
	var BSO_SALE_ID=jQuery.trim($("#BSO_SALE_ID").val()); 
	var BSO_IS_INSTALLATION=jQuery.trim($("#BSO_IS_INSTALLATION").val());
	var BSO_DELIVERY_DUE_DATE=jQuery.trim($("#BSO_DELIVERY_DUE_DATE").val());
	var BSO_DELIVERY_LOCATION=jQuery.trim($("#BSO_DELIVERY_LOCATION").val());
	var BSO_DELIVERY_CONTACT=jQuery.trim($("#BSO_DELIVERY_CONTACT").val());
	var BSO_INSTALLATION_SITE_LOCATION=jQuery.trim($("#BSO_INSTALLATION_SITE_LOCATION").val());
	var BSO_INSTALLATION_CONTACT=jQuery.trim($("#BSO_INSTALLATION_CONTACT").val());
	var BSO_INSTALLATION_TEL_FAX=jQuery.trim($("#BSO_INSTALLATION_TEL_FAX").val());
	var BSO_INSTALLATION_DUE_DATE=jQuery.trim($("#BSO_INSTALLATION_DUE_DATE").val());
	var BSO_LEVEL=jQuery.trim($("input[name=BSO_LEVEL]:checked" ).val());
	var BSO_DOC_CREATED_DATE=jQuery.trim($("#BSO_DOC_CREATED_DATE").val());
	var BSO_CUSTOMER_TYPE=jQuery.trim($("input[name=BSO_CUSTOMER_TYPE]:checked" ).val());
	var BSO_PO_NO=jQuery.trim($("#BSO_PO_NO").val());
	var BSO_PAYMENT_TERM=jQuery.trim($("input[name=BSO_PAYMENT_TERM]:checked" ).val());
	var BSO_PAYMENT_TERM_DESC=jQuery.trim($("#BSO_PAYMENT_TERM_DESC").val());
	var BSO_BORROW_TYPE=jQuery.trim($("input[name=BSO_BORROW_TYPE]:checked" ).val());  
	var BSO_BORROW_EXT='';//jQuery.trim($("#BSO_BORROW_EXT").val());
	var BSO_BORROW_DURATION='';//jQuery.trim($("#BSO_BORROW_DURATION").val());
	var BSO_IS_WARRANTY=jQuery.trim($("input[name=BSO_IS_WARRANTY]:checked" ).val());
	var BSO_WARRANTY=jQuery.trim($("input[name=BSO_WARRANTY]:checked" ).val()); 
	var BSO_IS_PM_MA=jQuery.trim($("input[name=BSO_IS_PM_MA]:checked" ).val()); 
	var BSO_OPTION=jQuery.trim($("input[name=BSO_OPTION]:checked" ).val());
	var BSO_TYPE=jQuery.trim($("#BSO_TYPE").val());
	var BSO_TYPE_NO=jQuery.trim($("#BSO_TYPE_NO").val());
	var BSO_STATE=jQuery.trim($("#BSO_STATE").val());
	var BSO_SLA=jQuery.trim($("#BSO_SLA").val());
	var BSO_PM_MA=jQuery.trim($("input[name=BSO_PM_MA]:checked" ).val()); 
	var BSO_DELIVERY_TYPE=jQuery.trim($("input[name=BSO_DELIVERY_TYPE]:checked" ).val());
	var BSO_CREATED_DATE=jQuery.trim($("#BSO_CREATED_DATE").val());
	var BSO_UPDATED_DATE=jQuery.trim($("#BSO_UPDATED_DATE").val());
	var BSO_STATUS=jQuery.trim($("#BSO_STATUS").val());
	var BSO_SUPERVISOR=jQuery.trim($("#BSO_SUPERVISOR").val());
	var BSO_SLA_LIMIT_TIME=jQuery.trim($("#BSO_SLA_LIMIT_TIME").val());
	var BSO_IS_OPTION=jQuery.trim($("input[name=BSO_IS_OPTION]:checked" ).val());
	var BSO_IS_HAVE_BORROW=jQuery.trim($("input[id=BSO_IS_HAVE_BORROW]:checked" ).val());
	var BSO_BORROW_NO=jQuery.trim($("#BSO_BORROW_NO").val()); 
	
	var BSO_DELIVERY_ADDR1=jQuery.trim($("#BSO_DELIVERY_ADDR1").val()); 
	var BSO_DELIVERY_ADDR2=jQuery.trim($("#BSO_DELIVERY_ADDR2").val());
	var BSO_DELIVERY_ADDR3=jQuery.trim($("#BSO_DELIVERY_ADDR3").val());
	var BSO_DELIVERY_PROVINCE=jQuery.trim($("#BSO_DELIVERY_PROVINCE").val());
	var BSO_DELIVERY_ZIPCODE=jQuery.trim($("#BSO_DELIVERY_ZIPCODE").val());
	var BSO_DELIVERY_TEL_FAX=jQuery.trim($("#BSO_DELIVERY_TEL_FAX").val());
	var BSO_INSTALLATION_ADDR1=jQuery.trim($("#BSO_INSTALLATION_ADDR1").val());
	var BSO_INSTALLATION_ADDR2=jQuery.trim($("#BSO_INSTALLATION_ADDR2").val());
	var BSO_INSTALLATION_ADDR3=jQuery.trim($("#BSO_INSTALLATION_ADDR3").val());
	var BSO_INSTALLATION_PROVINCE=jQuery.trim($("#BSO_INSTALLATION_PROVINCE").val());
	var BSO_INSTALLATION_ZIPCODE=jQuery.trim($("#BSO_INSTALLATION_ZIPCODE").val());
	 
	var BSO_IS_DELIVERY="0";
	var BSO_IS_INSTALLATION="0";
	var BSO_IS_DELIVERY_INSTALLATION="0";
	var BSO_IS_NO_DELIVERY="0";
	if($('#bsoTypeCheck_1').prop('checked')){
		BSO_IS_DELIVERY="1";
	}
	if($('#bsoTypeCheck_2').prop('checked')){
		BSO_IS_INSTALLATION="1";
	}
	if($('#bsoTypeCheck_3').prop('checked')){
		BSO_IS_DELIVERY_INSTALLATION="1";
	} 
	if($('#bsoTypeCheck_4').prop('checked')){
		BSO_IS_NO_DELIVERY="1";
	} 
	if(BSO_WARRANTY=='0'){
		BSO_WARRANTY=$("#BSO_WARRANTY_EXT").val();
	}
	if(BSO_PM_MA=='0')
		BSO_PM_MA=$("#BSO_PM_MA_EXT").val();

	if(BSO_PAYMENT_TERM=='3')
		BSO_PAYMENT_TERM_DESC=$("#BSO_PAYMENT_TERM_DESC_3").val();
	if(BSO_PAYMENT_TERM=='4')
		BSO_PAYMENT_TERM_DESC=$("#BSO_PAYMENT_TERM_DESC_4").val();
	
	if(BSO_BORROW_TYPE=='7'){
		BSO_BORROW_EXT=$("#BSO_BORROW_EXT").val();
		BSO_BORROW_DURATION=$("#BSO_BORROW_DURATION").val();
	}
	
	var query=" UPDATE "+SCHEMA_G+".BPM_SALE_ORDER SET "+
	   // "  BSO_ID = "+BSO_ID+" "+
 " CUSCOD = '"+CUSCOD+"' , "+ 
" BSO_SALE_ID = '"+BSO_SALE_ID+"', "+
" BSO_LEVEL = '"+BSO_LEVEL+"' ,  "+
" BSO_SLA = "+BSO_SLA+", "+
" BSO_CUSTOMER_TYPE = '"+BSO_CUSTOMER_TYPE+"' , "+
" BSO_PO_NO = '"+BSO_PO_NO+"' , "+
" BSO_PAYMENT_TERM = '"+BSO_PAYMENT_TERM+"', "+
" BSO_BORROW_TYPE = '"+BSO_BORROW_TYPE+"' , "+ 
" BSO_IS_WARRANTY = '"+BSO_IS_WARRANTY+"' ,"+
" BSO_IS_PM_MA = '"+BSO_IS_PM_MA+"' ,"+
" BSO_WARRANTY = '"+BSO_WARRANTY+"' ,"+
" BSO_PM_MA = '"+BSO_PM_MA+"' ,"+
" BSO_OPTION = '"+BSO_OPTION+"', "+ 
" BSO_BORROW_EXT = '"+BSO_BORROW_EXT+"' ,"+
" BSO_BORROW_DURATION = '"+BSO_BORROW_DURATION+"', "+
" BSO_IS_OPTION = '"+BSO_IS_OPTION+"', "+
" BSO_IS_HAVE_BORROW = '"+BSO_IS_HAVE_BORROW+"', "+
" BSO_BORROW_NO = '"+BSO_BORROW_NO+"' ,  "+
// " BSO_IS_DELIVERY = '"+BSO_IS_DELIVERY+"', "+
//" BSO_IS_INSTALLATION = '"+BSO_IS_INSTALLATION+"', "+
//" BSO_IS_DELIVERY_INSTALLATION = '"+BSO_IS_DELIVERY_INSTALLATION+"', "+
//" BSO_IS_NO_DELIVERY = '"+BSO_IS_NO_DELIVERY+"' , "+
" BSO_DELIVERY_TYPE = '"+BSO_DELIVERY_TYPE+"' ,"+
	
	" BSO_DELIVERY_ADDR1 = '"+BSO_DELIVERY_ADDR1+"' ,  "+
	" BSO_DELIVERY_ADDR2 = '"+BSO_DELIVERY_ADDR2+"' ,  "+
	" BSO_DELIVERY_ADDR3 = '"+BSO_DELIVERY_ADDR3+"' ,  "+
	" BSO_DELIVERY_PROVINCE = '"+BSO_DELIVERY_PROVINCE+"' ,  "+
	" BSO_DELIVERY_ZIPCODE = '"+BSO_DELIVERY_ZIPCODE+"' ,  "+
	" BSO_DELIVERY_TEL_FAX = '"+BSO_DELIVERY_TEL_FAX+"' ,  "+
	" BSO_INSTALLATION_ADDR1 = '"+BSO_INSTALLATION_ADDR1+"' ,  "+
	" BSO_INSTALLATION_ADDR2 = '"+BSO_INSTALLATION_ADDR2+"' ,  "+
	" BSO_INSTALLATION_ADDR3 = '"+BSO_INSTALLATION_ADDR3+"' ,  "+
	" BSO_INSTALLATION_PROVINCE = '"+BSO_INSTALLATION_PROVINCE+"' ,  "+
	" BSO_INSTALLATION_ZIPCODE = '"+BSO_INSTALLATION_ZIPCODE+"' , "+
	" BSO_DELIVERY_LOCATION = '"+BSO_DELIVERY_LOCATION+"', "+
	" BSO_DELIVERY_CONTACT = '"+BSO_DELIVERY_CONTACT+"', "+
	" BSO_INSTALLATION_TEL_FAX = '"+BSO_INSTALLATION_TEL_FAX+"' ,  "+
	" BSO_INSTALLATION_SITE_LOCATION = '"+BSO_INSTALLATION_SITE_LOCATION+"' ,"+
	" BSO_PAYMENT_TERM_DESC = '"+BSO_PAYMENT_TERM_DESC+"' ,";
//alert("BSO_SLA="+BSO_SLA);
//return false;
/*

" BSO_IS_INSTALLATION = "+BSO_IS_INSTALLATION+" ,"+
" BSO_DELIVERY_DUE_DATE = "+BSO_DELIVERY_DUE_DATE+" ,"+




" BSO_INSTALLATION_ = "+BSO_INSTALLATION_DUE_DATE+" ,"+
" BSO_DOC_CREATED_DATE = "+BSO_DOC_CREATED_DATE+" ,"+




 

" BSO_TYPE = "+BSO_TYPE+" ,"+
" BSO_TYPE_NO = "+BSO_TYPE_NO+" ,"+
" BSO_STATE = "+BSO_STATE+" ,"+ 


" BSO_CREATED_DATE = "+BSO_CREATED_DATE+" ,"+
" BSO_UPDATED_DATE = "+BSO_UPDATED_DATE+" ,"+
" BSO_STATUS = "+BSO_STATUS+" ,"+ 
" BSO_SUPERVISOR = "+BSO_SUPERVISOR+" ,"+
" BSO_SLA_LIMIT_TIME = "+BSO_SLA_LIMIT_TIME+" ,"+
*/

	var BSO_DELIVERY_DUE_DATE_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_PICKER").val());
	var BSO_DELIVERY_DUE_DATE_TIME_PICKER=jQuery.trim($("#BSO_DELIVERY_DUE_DATE_TIME_PICKER").val());
	var BSO_DELIVERY_DUE_DATE="";
	if(BSO_DELIVERY_DUE_DATE_PICKER.length>0){
		var BSO_DELIVERY_DUE_DATE_ARRAY=BSO_DELIVERY_DUE_DATE_PICKER.split("/");
		BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE_ARRAY[2]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[1]+"-"+BSO_DELIVERY_DUE_DATE_ARRAY[0];
		if(BSO_DELIVERY_DUE_DATE_TIME_PICKER.length>0){
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" "+BSO_DELIVERY_DUE_DATE_TIME_PICKER+":00";
		}else
			BSO_DELIVERY_DUE_DATE=BSO_DELIVERY_DUE_DATE+" 00:00:00";
		 
	}

	if(BSO_DELIVERY_DUE_DATE.length>0){
		query=query+" BSO_DELIVERY_DUE_DATE='"+BSO_DELIVERY_DUE_DATE+"' , ";
	}else
		query=query+" BSO_DELIVERY_DUE_DATE=null  , ";
	
	var BSO_INSTALLATION_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_PICKER").val());
	var BSO_INSTALLATION_TIME_TIME_PICKER=jQuery.trim($("#BSO_INSTALLATION_TIME_TIME_PICKER").val());
	var BSO_INSTALLATION_DUE_DATE="";
	if(BSO_INSTALLATION_TIME_PICKER.length>0){
		var BSO_INSTALLATION_DUE_DATE_ARRAY=BSO_INSTALLATION_TIME_PICKER.split("/");
		BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE_ARRAY[2]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[1]+"-"+BSO_INSTALLATION_DUE_DATE_ARRAY[0];
		if(BSO_INSTALLATION_TIME_TIME_PICKER.length>0){
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" "+BSO_INSTALLATION_TIME_TIME_PICKER+":00";
		}else
			BSO_INSTALLATION_DUE_DATE=BSO_INSTALLATION_DUE_DATE+" 00:00:00";
		 
	}

	if(BSO_DELIVERY_DUE_DATE.length>0){
		query=query+" BSO_DELIVERY_DUE_DATE='"+BSO_DELIVERY_DUE_DATE+"' , ";
	}else
		query=query+" BSO_DELIVERY_DUE_DATE=null  , ";
	if(BSO_INSTALLATION_DUE_DATE.length>0){
		query=query+" BSO_INSTALLATION_DUE_DATE='"+BSO_INSTALLATION_DUE_DATE+"' , ";
	}else
		query=query+" BSO_INSTALLATION_DUE_DATE=null  , ";
	
	
	query=query+" BSO_INSTALLATION_CONTACT = '"+BSO_INSTALLATION_CONTACT+"' ";
	" WHERE BSO_ID = "+BSO_ID+" ";
//	alert(BSO_DELIVERY_DUE_DATE);
//	alert(BSO_DELIVERY_DUE_DATE_TIME_PICKER)
	//alert(query)
  if(!CUSCOD.length>0){
	  alert("กรุณาใส่ Code ลูกค้า");
	  return false;
  }
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
		if(data!=0){
			//alert(data);
			loadDynamicPage('dispatcher/page/delivery_install_search');
		}
	}
});
	
   <%-- 
	 var bdeptName=jQuery.trim($("#bdeptName").val());
	 var bdeptDetail=jQuery.trim($("#bdeptDetail").val());
	 var bdeptHOD=jQuery.trim($("#bdeptHOD").val());  
	 var bdeptHOD_str="null";
	// var position=jQuery.trim($("#position").val());
	 
	 if(bdeptName.length==0){
		 alert("กรุณากรอก Name.");
		 $("#bdeptName").focus();
		 return false;
	 } 
	 <c:if test="${mode=='edit'}">
	  if(bdeptHOD.length==0){
		 alert("กรุณากำหนด HOD.");
		// $("#bdeptHOD").focus();
		 return false;
	 }
	  bdeptHOD_str=bdeptHOD;   
	  </c:if>
	
	var querys=[]; 
	var query="insert into "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str;
	if($("#mode").val()=='edit'){
		 query="update "+SCHEMA_G+".BPM_DEPARTMENT set BDEPT_NAME=?, BDEPT_DETAIL=?,BDEPT_HDO_USER_ID="+bdeptHOD_str+" where BDEPT_ID=${bsoId}";
	}
	querys.push(query); 
	var list_values=[];
		var values=[];
		values.push(bdeptName);
		values.push(bdeptDetail); 
		//values.push(position);
		
		list_values.push(values);
	SynDomeBPMAjax.executeQueryWithValues(querys,list_values,{
			callback:function(data){ 
				if(data!=0){
					loadDynamicPage("dispatcher/page/delivery_install_search");
				}
			}
		});
	--%> 
  }

 
 function clearSelect(ele_name){
	 $('input[name=\"'+ele_name+'\"]').prop('checked', false);
 }
 function getSelectEle(ele_name,ele_value){
	 $('input[name=\"'+ele_name+'\"][value="' + ele_value + '"]').prop('checked', true);
 }
 function show_hide(ele_name,ele_value){
	 if(ele_value=='1'){
		 $('#'+ele_name).show();
	 }else
		 $('#'+ele_name).hide();
 }
 function downloadForm(type){ 
		var src = "report/export_form";
		src=src+"?type="+type;
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
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="bsoId" id="bsoId"  value="${bsoId}"/> 
			 <input type="hidden" name="BSO_IS_DELIVERY" id="BSO_IS_DELIVERY" />
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/>
            <input type="hidden" id="bdeptUserId" name="bdeptUserId"/>
            <input type="hidden" id="IMA_ItemID" name="IMA_ItemID"/>
          <!--   <input type="hidden" id="LastCostAmt" name="LastCostAmt"/> -->
            
			  <fieldset style="font-family: sans-serif;">   
			 <!--  <pre  class="prettyprint" style="font-family: sans-serif;font-size:12px:;margin-top: 0px"> -->
			  <div align="left">
           	 <strong id="delivery_install_title"></strong><input type="text" id="bsoTypeNo" style="height: 30px;width: 125px" readonly="readonly"/> 
           	 
           	 &nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" id="BSO_IS_HAVE_BORROW" onclick=""/>มีใบยืม&nbsp;&nbsp;&nbsp;
           	เลขที่<input type="text" id="BSO_BORROW_NO" style="height: 30px;width: 125px" />
           	 <c:if test="${isExpressAccount}">
           	 IV No. <input type="text" id="BSO_INV_NO" style="height: 30px;width: 125px" /> 
           	 </c:if>
           	  <c:if test="${isStoreAccount}">
           	<!--  RTE No. <input type="text" id="BSO_RFE_NO" style="height: 30px;width: 125px" /> -->
           	 คนรับของ <input type="text" id="BSO_RFE_NAME" style="height: 30px;width: 125px" />  
           	 </c:if>
           	 <span id="bsoRfe_element" style="display: none">
           	  RFE No. <input type="text" id="BSO_RFE_NO" style="height: 30px;width: 125px" /> 
           	 </span>
           	 <span id="check_store_element"></span>
           	  <span id="delivery_form_element" style="padding-left: 10px;display: none">
            	<a class="btn" style="margin-top:-12px;" onclick="downloadForm('1')">&nbsp;Download Form&nbsp;</a>
            	</span>
            	<span id="install_form_element" style="padding-left: 10px;display: none">
            	<!-- <a class="btn" style="margin-top:-12px;" onclick="downloadForm('2')">&nbsp;Download Form&nbsp;</a> -->
            	INT No. <input type="text" id="BSO_INT_NO" readonly="readonly" style="height: 30px;width: 125px" />
            	</span>
           	 <br></br>
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">
			    	<tr>
    					<td width="100%" colspan="2"></td>
    				</tr>
    				<tr valign="top">
    					<td width="50%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อผู้ขาย
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;" id="BSO_SALE_ID" />
    					   			</span>
    					   			<span style="padding-left: 5px">
    					   				Code ลูกค้า
    					   			</span>
    					   			<span style="padding-left: 0px">
    					   				<input type="text" style="width:137px; height: 30px;" id="CUSCOD" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="CONTACT" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อบริษัท
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="CUSNAM" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					ที่อยู่
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<!-- <input type="text"  style="height: 30px;width: 320px" id="ADDR01" /> -->
    					   			  <textarea style="width: 320px;height: 58px" id="ADDR01" rows="2" cols="4"></textarea>
    					   					
    					<script>
    						/* CKEDITOR.replace( 'ADDR01',
    						    {
    							 toolbar:[ { name: 'basicstyles', items: [ 'Bold', 'Italic' ] } 
    							              ]
    						      //  uiColor : '#9AB8F3'
    						    }); */
    					</script>
    					   			
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์โทร/แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   			<input type="text"  style="height: 30px;width: 320px" id="TELNUM" /> <!-- 
    					   			 <textarea style="width: 320px;height: 47px" id="TELNUM" rows="2" cols="4"></textarea> -->
    					   				<!-- <input type="text"  style="height: 30px;" id="TELNUM" /> -->
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<%-- 
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;"/>
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	 --%>
    					   	<tr>
    					   		<td width="20%">
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="checkbox" value="1" id="bsoTypeCheck_1" onclick="bsoTypeCheck('1')"/>ส่งของ&nbsp;&nbsp;&nbsp;
    					   				<input type="checkbox" value="2" id="bsoTypeCheck_2" onclick="bsoTypeCheck('2')"/>ติดตั้ง&nbsp;&nbsp;&nbsp;
    					   				<input type="checkbox" value="3" id="bsoTypeCheck_3" onclick="bsoTypeCheck('3')"/>ส่งของพร้อมติดตั้ง&nbsp;&nbsp;&nbsp;
    					   				<input type="checkbox" value="4" id="bsoTypeCheck_4" onclick="bsoTypeCheck('4')"/>ไม่ส่งของ
    					   			
    					   			</span>
    					   		</td>
    					   	</tr>
    					   </table>
    					  </div>
    					  <div id="bsoType_1" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;display: none" >
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BSO_DELIVERY_DUE_DATE_PICKER" />
    					   			</span>
    					   			<span style="padding-left: 3px">ระบุเวลา
    					   				<input type="text" readonly="readonly" style="width:50px; height: 30px;" id="BSO_DELIVERY_DUE_DATE_TIME_PICKER" />
    					   			</span>
    					   			
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_CONTACT" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					สถานที่ส่งสินค้า
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_LOCATION" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					ที่อยู่
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR1" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					แขวง/ตำบล
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR2" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					เขต/อำเภอ
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ADDR3" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					จังหวัด
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_PROVINCE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   		<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					รหัสไปรษณีย์
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_ZIPCODE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์โทร/แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   			<input type="text"  style="height: 30px;width: 320px" id="BSO_DELIVERY_TEL_FAX" /> 
    					   			 <!-- <textarea style="width: 320px;height: 47px" id="TELNUM_2" rows="2" cols="4"></textarea>  -->
    					   			</span>
    					   		</td>
    					   	</tr>
    					   
    					   	<!-- <tr>
    					   		<td width="25%">
    					   				<span>
    					   					ส่งของระบุเวลา	
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  readonly="readonly" style="width:130px; height: 30px;" id="BSO_DELIVERY_TIME" />
    					   			</span>
    					   		</td>
    					   	</tr> -->
    					   	</table>
    					   </div>
    					   <div id="bsoType_2" style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px;display: none">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					กำหนดติดตั้ง
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" readonly="readonly" style="width:100px; height: 30px;" id="BSO_INSTALLATION_TIME_PICKER" />
    					   			</span>
    					   			<span style="padding-left: 3px">ระบุเวลา
    					   				<input type="text" readonly="readonly" style="width:50px; height: 30px;" id="BSO_INSTALLATION_TIME_TIME_PICKER" />
    					   			</span>
    					   				
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					ชื่อผู้ติดต่อ
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:300px; height: 30px;" id="BSO_INSTALLATION_CONTACT" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   		<tr>
    					   		<td width="20%">
    					   				<span>
    					   					ระบุชื่อ Site งาน
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_SITE_LOCATION" />
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					ที่อยู่
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR1" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					แขวง/ตำบล
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR2" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					เขต/อำเภอ
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ADDR3" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					จังหวัด
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_PROVINCE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   		<tr valign="top">
    					   		<td width="20%">
    					   				<span>
    					   					รหัสไปรษณีย์
    					   				</span>
    					   		</td> 
    					   		<td width="80%">
    					   			<span style="padding-left: 3px"> 
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_ZIPCODE" /> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   	<tr>
    					   		<td width="20%">
    					   				<span>
    					   					เบอร์โทร/แฟกซ์
    					   				</span>
    					   		</td>
    					   		<td width="80%">
    					   			<span style="padding-left: 3px">
    					   			 <input type="text"  style="height: 30px;width: 320px" id="BSO_INSTALLATION_TEL_FAX" /> 
    					   			 <!-- <textarea style="width: 320px;height: 47px" id="TELNUM_2" rows="2" cols="4"></textarea> --> 
    					   			</span>
    					   		</td>
    					   	</tr>
    					   
    					  <!--  	<tr>
    					   		<td width="25%">
    					   				<span>
    					   					เบอร์โทร
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   			<span style="padding-left: 3px">
    					   				<input type="text" style="width:100px; height: 30px;" id="BSO_INSTALLATION_TEL" />
    					   			</span>
    					   		</td>
    					   	</tr> -->
    					   
    					   	</table>
    					   </div>
    					  <div style="display:none;border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="1" name="BSO_LEVEL">ระดับ 1(ทั่วไป)
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="2" name="BSO_LEVEL">ระดับ 2(แน่นอนแต่ไม่รู้วัน)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="3" name="BSO_LEVEL">ระดับ 3
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="4" name="BSO_LEVEL">ระดับ 4(Project)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   	</div>
    					   <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-top: 1px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   SLA
    					   				 </span>&nbsp;&nbsp;
    					   				 <span id="sla_select_element"></span>ช.ม. 
    					   		</td>
    					   		 
    					   	</tr>
    					   	</table>
    					   	</div>
    					</td>
    					<td width="50%" valign="top">
    					<%-- 
    					  <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px">
    					   <table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 1(ทั่วไป)
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 2(แน่นอนแต่ไม่รู้วัน)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 3
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" name="level">ระดับ 4(Project)
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   	</div>
    					   	--%>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;padding-left: 10px;padding-top: 10px">
    					   	<table style="width: 100%;font-size:13px" border="0">
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					วันที่เปิดเอกสาร
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<fmt:formatDate var="time" value="${date}" pattern="dd/MM/yyyy"/>
    					   					<input type="text" readonly="readonly" value="${time}" style="width:100px; height: 30px;" id="BSO_DOC_CREATED_DATE" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					ประเภทลูกค้า
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="radio" value="1" name="BSO_CUSTOMER_TYPE"/>Dealer&nbsp;&nbsp;&nbsp;<input type="radio" value="2" name="BSO_CUSTOMER_TYPE"/>User
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					PO เลขที่
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="text" style="width:100px; height: 30px;" id="BSO_PO_NO" />
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	<%-- 
    					   	<tr style="height: 30px;">
    					   		<td width="25%">
    					   				<span>
    					   					โปรดระบุ
    					   				</span>
    					   		</td>
    					   		<td width="75%">
    					   				<span style="padding-left: 3px">
    					   					<input type="radio" name="havePO"/>มี&nbsp;&nbsp;&nbsp;<input type="radio" name="havePO"/>ไม่มี
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	 --%>
    					   	</table>
    					   	</div>
							<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="2" align="left">
    					   				<span style="text-decoration: underline;">
    					   					เงื่อนไขการชำระ
    					   				</span>
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="1" name="BSO_PAYMENT_TERM">เงินสด/เช็คเงินสด
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="2" name="BSO_PAYMENT_TERM">โอนเงิน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="3" name="BSO_PAYMENT_TERM">เช็คล่วงหน้า<input type="text" id="BSO_PAYMENT_TERM_DESC_3" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   		<td width="50%">
    					   				<span>
    					   					<input type="radio" value="4" name="BSO_PAYMENT_TERM">เครดิต<input type="text" id="BSO_PAYMENT_TERM_DESC_4" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>
    					   	</div> 
    					   	<div style="display:none;border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   					ใบยืม
    					   				</span>
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="1"  name="BSO_BORROW_TYPE">DEMO
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="2" name="BSO_BORROW_TYPE">เพื่อขาย
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="3" name="BSO_BORROW_TYPE">ฝากขาย
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="4" name="BSO_BORROW_TYPE">เปลี่ยน
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="5" name="BSO_BORROW_TYPE">สำรองใช้
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="6" name="BSO_BORROW_TYPE">ลดหนี้
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%" colspan="3">
    					   				<span>
    					   					<input type="radio" value="7" name="BSO_BORROW_TYPE">อื่นๆ<input type="text" id="BSO_BORROW_EXT" style="width: 40px;height: 30px;"> ระยะประกัน<input type="text" id="BSO_BORROW_DURATION" style="width: 40px;height: 30px;"> วัน
    					   				</span>
    					   		</td>
    					   	</tr>
    					   	</table>    					   	
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   การรับประกัน	
    					   				</span>&nbsp;&nbsp;<input type="radio" value="1" name="BSO_IS_WARRANTY"> มี  <input type="radio" value="0" name="BSO_IS_WARRANTY"  onclick="clearSelect('BSO_WARRANTY')"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="100%"  colspan="3" >
    					   				<span>
    					   					<input type="radio" value="1" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">1 ปี
    					   				</span> 
    					   				<span style="padding-left:40px">
    					   					<input type="radio" value="2" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">2 ปี(มาตรฐาน)
    					   				</span> 
    					   				<span  style="padding-left:40px">
    					   					<input type="radio" value="3" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">3 ปี
    					   				</span>
    					   				<span  style="padding-left:40px">
    					   					<input type="radio" value="4" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">4 ปี
    					   				</span> 
    					   		        <span  style="padding-left:40px">
    					   					<input type="radio" value="5" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">5 ปี
    					   				</span>
    					   				 <span  style="padding-left:40px">
    					   					<input type="radio" value="0" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">ตลอดชีพ
    					   				</span>
    					   				<%--  
    					   				<span>
    					   					<input type="radio" value="0" onclick="getSelectEle('BSO_IS_WARRANTY','1')" name="BSO_WARRANTY">อื่นๆ<input type="text" id="BSO_WARRANTY_EXT" style="width: 40px;height: 30px;"> ปี 
    					   				</span>
    					   				--%>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   PM(เดือน / ครั้ง)	
    					   				</span>&nbsp;&nbsp;<input type="radio" value="1" name="BSO_IS_PM_MA"> มี  <input type="radio" value="0" name="BSO_IS_PM_MA" onclick="clearSelect('BSO_PM_MA')"> ไม่มี 
    					   		</td>
    					   		 
    					   	</tr>
    					   	<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="4" onclick="getSelectEle('BSO_IS_PM_MA','1')" name="BSO_PM_MA">4 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="3" onclick="getSelectEle('BSO_IS_PM_MA','1')" name="BSO_PM_MA">3 เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="0" onclick="getSelectEle('BSO_IS_PM_MA','1')" name="BSO_PM_MA">อื่นๆ<input type="text" id="BSO_PM_MA_EXT" style="width: 30px;height: 30px;"> เดือน/ครั้ง
    					   				</span>
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	<div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;margin-left: 1px;margin-top: 1px;padding-left: 10px;padding-top: 10px;height: 73px">
    					  		 <table style="width: 100%;font-size:13px" border="0">
    					  		 	<tr style="height: 30px;">
    					   		<td width="100%" colspan="3" align="left">
    					   				<span style="text-decoration: underline;">
    					   				   อุปกรณ์เสริม
    					   				</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" value="1" name="BSO_IS_OPTION"> มี  <input type="radio" value="0" name="BSO_IS_OPTION"  onclick="clearSelect('BSO_OPTION')"> ไม่มี
    					   				
    					   		</td>
    					   		 
    					   	</tr>
    					   		<tr style="height: 30px;">
    					   		<td width="33%">
    					   				<span>
    					   					<input type="radio" value="1" onclick="getSelectEle('BSO_IS_OPTION','1')" name="BSO_OPTION"> สายไฟ
    					   				</span>
    					   		</td>
    					   		<td width="33%">
    					   			
    					   		</td>
    					   		<td width="33%">
    					   				 
    					   		</td>
    					   	</tr> 
    					   	</table>
    					   	</div>
    					   	</td>
    				</tr>
    				<%--
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">Detail :</span></td>
    					<td width="75%" colspan="2"> 
    					<input type="text" name="bdeptDetail" id="bdeptDetail" style="height: 30;"/>
    					</td>
    				</tr> 
    				<c:if test="${mode=='edit'}">
    				<tr valign="middle">
    					<td width="25%" align="right"><span style="font-size: 13px;padding: 15px">HOD :</span></td>
    					<td width="75%" colspan="2"> 
    					 <input type="hidden" id="bdeptHOD" name="bdeptHOD"/>
    					 <span id="hodElement" onclick="assignUser('hod')"></span>
    					</td>
    				</tr> 
    				</c:if>
    				--%>
    			</table> 
    			</fieldset> 
    			<%-- <sec:authorize access="hasAnyRole('ROLE_SALE_ORDER')" var="isSaleOrder"/>
<sec:authorize access="hasAnyRole('ROLE_KEY_ACCOUNT')" var="isKeyAccount"/>
<sec:authorize access="hasAnyRole('ROLE_INVOICE_ACCOUNT')" var="isExpressAccount"/>
<sec:authorize access="hasAnyRole('ROLE_STORE_ACCOUNT')" var="isStoreAccount"/>
<sec:authorize access="hasAnyRole('ROLE_SUPERVISOR_ACCOUNT')" var="isSupervisorAccount"/>  --%>
             <c:if test="${isSaleOrder}">
    			<div align="center" style="padding-top: 10px">
    			<table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/delivery_install_search')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%" align="center">
				 		 <a class="btn btn-primary"  onclick="doSubmitSaleOrder()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Submit</span></a>
				 		 <%-- 
				 		 <a class="btn btn-primary"  onclick="doUpdateState('1','wait_for_create_to_express','ROLE_INVOICE_ACCOUNT','2','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไปฝ่าย บัญชี เรียบร้อยแล้ว','Sale Order Created','1',false)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">ส่งไปฝ่าย บัญชี</span></a>
    					 <a class="btn btn-primary"  onclick="doUpdateState('1','wait_for_send_to_supervisor','ROLE_KEY_ACCOUNT','2','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Key Account เรียบร้อยแล้ว','Sale Order Created','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">ส่งไป Key Account</span></a>
    					  --%>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
    					 <%-- 
    					  <a class="btn btn-primary"  onclick=""><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update</span></a>
    					 <a class="btn btn-danger"  onclick=""><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">ยกเลิก SO</span></a>
    					  --%>
				 		</td>
				 	</tr>
				 </table> 
				</div>
				</c:if>
			<c:if test="${isKeyAccount && state=='wait_for_send_to_supervisor'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">
				 			Assign to Supervisor
				 			<span id="supervisor_select_element"></span>
				 			<%-- 
				 			<select id="supervisor_select"	style="margin-top: 10px;width: 75px"> 
				 			<option value="sc_admin">SC</option>
				 			<option value="it_admin">IT</option>
				 			<option value="reg_admin">Reg</option>
				 			<option value="rfe_admin">RFE</option>
				 			<option value="local_admin">Local</option>
				 			</select>
				 			 --%>
    					  <a class="btn btn-primary"  onclick="doSendToSupervisor()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Send</span></a>
    					 <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a>
				 		</td>
				 	</tr>
				 </table>
				  <%-- 
				  SELECT dept.*,user.* FROM SYNDOME_BPM_DB.BPM_DEPARTMENT dept left join 
				  SYNDOME_BPM_DB.user user on dept.BDEPT_HDO_USER_ID=user.id where dept.bdept_hdo_user_id is not null 
				   --%> 
				</div>
				</c:if>
			<c:if test="${isExpressAccount && state=='wait_for_create_to_express'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">
    					  <div align="center"><a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_create_to_express','ROLE_INVOICE_ACCOUNT','2','Sale Order updated ')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Update Status</span></a>
    					  </div>
				 		</td>
				 	</tr>
				 </table> 
				</div>
			</c:if>
			<c:if test="${isSupervisorAccount && state=='wait_for_assign_to_team'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%" align="center"> 
    					  <a class="btn btn-primary"  onclick="showTeam()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Assign to Team</span></a>
    					<!--  <a class="btn btn-primary"  onclick="doSaveDraftAction()"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Save Draft</span></a> -->
				 		</td>
				 	</tr>
				 </table>
				</div>
			 </c:if>
			 <c:if test="${isStoreAccount && state=='wait_for_stock'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%">  
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_stock','ROLE_STORE_ACCOUNT','2','Sale Order updated ')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">จัดรายการแล้ว</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			<c:if test="${isOperationAccount && state=='wait_for_operation'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
    					 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateState('1','wait_for_supervisor_close','${requestor}','1','ข้อมูลถูกส่งไปก่อนหน้านี้ เรียบร้อยแล้ว','ข้อมูลถูกส่งไป Supervisor  เรียบร้อยแล้ว','Sale Order wait for Supervisor Close','1',true)"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
				 		</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
			<c:if test="${isSupervisorAccount && state=='wait_for_supervisor_close'}">
				<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%">
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 		</td>
				 		<td width="80%"> 
				 		 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_supervisor_close','${username}','1','Sale Order Closed')"><i class="icon-ok icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Close Job</span></a></div>
    					 
    					</td>
				 	</tr>
				 </table>
				</div>
			</c:if>
		 
			  </form>   
			  <c:if test="${mode=='edit'}">
			   <div  class="well">
			  <table border="0" width="100%" style="font-size: 13px">
	    					<tbody> 
	    					<tr>
	    					<td align="left" width="70%">   
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
	    					<%--
	    					<table class="table table-striped table-bordered table-condensed" border="1" style="font-size: 12px">
        	<thead>
          		<tr> 
            	 	<th width="5%"><div class="th_class">No.</div></th>
            		<th width="15%"><div class="th_class">Name</div></th> 
            		<th width="15%"><div class="th_class">SLA Limit/Day</div></th>  
            		<th width="57%"><div class="th_class">Detail</div></th> 
            		<th width="8%"><div class="th_class"></div></th> 
            		 
          		</tr>
        	</thead>
        	<tbody> 
        	
          	<tr>  
            	<td>1. 	 
            	</td>
            	<td>1 วัน
            	</td> 
            	<td>1
            	</td>
            	<td>
            	 ภายใน กทม.</td>
            	 <td style="text-align: center;">
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=1&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				           	<i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				           	</td>
          	</tr> 
          	<tr>  
            	<td>2.
            	</td>
            	<td>2 วัน
            	</td> 
            	<td>2
            	</td>
            	<td>
            	ต่างจังหวัด</td>
            	<td style="text-align: center;"> 
				       	<i title="Edit" onclick="loadDynamicPage('setting/page/sla_management?bsId=2&mode=edit')" style="cursor: pointer;" class="icon-edit"></i>&nbsp;&nbsp;
				        <i title="Delete" onclick="confirmDelete('')" style="cursor: pointer;" class="icon-trash"></i>
				</td>
          	</tr> 
          	 
        	</tbody>
      </table> 
      </div>
      --%>
			 <div  id="item_section"> 
    		 </div> 
			</div>
			</c:if>
</fieldset>