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

<script type="text/javascript" src="<c:url value='/resources/js/jquery.printPage.js'/>"></script>
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
function printQuotationServices(type){
	var insert_query="UPDATE "+SCHEMA_G+".BPM_CALL_CENTER set BCC_QUOTAION_REMARK='"+jQuery.trim($("#BCC_QUOTAION_REMARK").val())+"' "+
	" WHERE BCC_NO = '${bccNo}' ";
	 var querys=[];
	 querys.push(insert_query); 
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
								//showDialog("sss");
							}
							 var src = "getQuotationServices/${bccNo}/"+type;
							if(type=='pdf'){ 
								//src=src+"?type="+type;
								window.open(src,"_bank");
							}else{
								var div = document.createElement("div");
								document.body.appendChild(div);
								div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
							}
						}
					});
	
		/*
		var div = document.createElement("div");
		document.body.appendChild(div);
		div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
		*/
}

$(document).ready(function() {   
	 //$(".btnPrint").printPage();
  getQuotation();  
   //alert('${bccNo}')
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
function getQuotation(){
	
	 var queryCheck=" SELECT count(*) FROM "+SCHEMA_G+".BPM_QUOTATION where BQ_REF='${bccNo}' and bq_type='2'";
	// alert(queryCheck)
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
					if(data>0){ // have data
						searchItemList('1')
					}else{ // insert  
						 var insert_query="INSERT INTO "+SCHEMA_G+".BPM_QUOTATION ( BQ_REF,BQ_TYPE,BQ_CREATED_TIME,BQ_CREATED_BY) "+
						 " VALUES ('${bccNo}','2',now(),'${username}')"; 
						 var querys=[];
						 querys.push(insert_query); 
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
													//showDialog("sss");
												}
												searchItemList('1')
											}
										});
								
					}
				}
		 });
}
function searchItemList(_page){  
	var query_common=" SELECT  mapping.BQ_REF,mapping.IMA_ItemID,product.IMA_ItemName, mapping.BQ_AMOUNT,mapping.PRICE "+
		"  "+  
"FROM "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING  mapping left join "+SCHEMA_G+".BPM_PRODUCT product "+
" on mapping.IMA_ItemID=product.IMA_ItemID  where mapping.BQ_TYPE='2' AND mapping.BQ_REF='${bccNo}'"; 
var query= query_common;



//var limitRow=(_page>1)?((_page-1)*_perpageG):0; 
var queryObject="  "+query;//+"   limit "+limitRow+", "+_perpageG;
var queryCount=" select count(*) from (  "+query+" ) as x";
//alert(queryObject) 

	$("#pageNo").val(_page);   
	var query_common=" SELECT  item.IMA_ItemID AS C0 ,product.IMA_ItemName  AS C1,item.BQ_AMOUNT AS C2,item.PRICE AS C3, "+
    " ROUND(item.BQ_AMOUNT*item.PRICE,2) AS  C4 ,"+
    "(select sum(ROUND(BQ_AMOUNT*PRICE,2)) "+
    " from BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF=item.BQ_REF  and BQ_TYPE='2' )  AS C5,"+
    " (select ROUND((sum(ROUND(BQ_AMOUNT*PRICE,2))*7)/100,2)"+
    "  from BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF=item.BQ_REF  and BQ_TYPE='2' ) AS C6 ,"+
    " (select ROUND(ROUND((sum(ROUND(BQ_AMOUNT*PRICE,2))*7)/100,2) + sum(ROUND(BQ_AMOUNT*PRICE,2)),2)"+ 
    "  from BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF=item.BQ_REF  and BQ_TYPE='2') AS C7 ,"+
    "  item.PRICE_COST AS C8 , "+
    " ROUND(item.BQ_AMOUNT*item.PRICE_COST,2) AS C9, "+
    " IFNULL(item.BQ_DETAIL,'') AS C10 "+
  /*   "(select sum(ROUND(BQ_AMOUNT*PRICE_COST,2)) "+
    " from BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF=item.BQ_REF  and BQ_TYPE='2' ) as SUM_TOTAL_COST ,"+ 
    " item.cuscod ,"+
    "  item.DETAIL , "+
    "  item.AUTO_K , "+
    "  item.IS_REPLACE , "+
    "  item.REPLACE_NAME  "+*/
"FROM "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING  item left join "+SCHEMA_G+".BPM_PRODUCT product "+
" on item.IMA_ItemID=product.IMA_ItemID where item.BQ_REF='${bccNo}' and item.BQ_TYPE='2' ";
var query="	select * from ("+query_common +" and item.IMA_ItemID not in('900002','900004','90100002') order by item.PRICE  desc "+
          ")  as  item  "; 
	query=query+"union all";    
	query=query+query_common+" and item.IMA_ItemID  in('900002','900004') ";
	
	query=query+"union all";
	
	query=query+query_common+" and item.IMA_ItemID  in('90100002') ";
  
	
	 
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
			        "  		<th width=\"56%\"><div class=\"th_class\">สินค้า</div></th> "+
			        "  		<th width=\"5%\"><div class=\"th_class\">จำนวน</div></th> "+  
			        <c:if test="${username=='admin'}">
			         "  		<th width=\"11%\"><div class=\"th_class\">ต้นทุนต่อหน่วย</div></th> "+			        
			         "  		<th width=\"12%\"><div class=\"th_class\">ต้นทุนรวม</div></th> "+ 
			       </c:if>
			        "  		<th width=\"11%\"><div class=\"th_class\">ราคาขายต่อหน่วย</div></th> "+			        
			        "  		<th width=\"12%\"><div class=\"th_class\">ราคาขายรวม</div></th> "+ 
			        "  		<th width=\"5%\"><div class=\"th_class\"></div></th> "+
			        " 		</tr>"+
			        "	</thead>"+
			        "	<tbody>   ";  
			   if(data!=null && data.length>0){
				   var total=0;
				   var vat=0;
				   var grand_total=0;
				   var colspan_str="4";
				   //alert(usernameG=="admin")
				   if(usernameG=="admin")
					   colspan_str='6';
				   
				   for(var i=0;i<data.length;i++){ 
					     total=$.formatNumber(data[i][5]+"", {format:"#,###.00", locale:"us"});
					     vat=$.formatNumber(data[i][6]+"", {format:"#,###.00", locale:"us"});
					     grand_total=$.formatNumber(data[i][7]+"", {format:"#,###.00", locale:"us"});
					     var IS_REPLACE=data[i][13]!=null?data[i][13]:"0";
					     var REPLACE_NAME=data[i][14]!=null?data[i][14]:"";
					     var name ="";
					     if(IS_REPLACE=='1'){
					    	 name=REPLACE_NAME;
					     }else
					    	 name=data[i][1];
					 
					   str=str+ "  	<tr style=\"cursor: pointer;\">"+
					   "  		<td style=\"text-align: left;\"> "+data[i][0]+" </td>"+     
					   "  		<td style=\"text-align: left;\"> "+name+" "+(data[i][10]!=null?("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i][10]):"")+"</td>"+    
				      //  "    	<td style=\"text-align: center;\"><span style=\"text-decoration: underline;\" onclick=\"showItem('"+data[i][10]+"','"+data[i][0]+"','"+data[i][12]+"')\">"+data[i][2]+"</span></td>  "+
				        "    	<td style=\"text-align: center;\"><span style=\"\">"+data[i][2]+"</span></td>  "+
				        <c:if test="${username=='admin'}">
				        "    	<td style=\"text-align: right;\">"+((data[i][8]!=null)? $.formatNumber(data[i][8]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				         "    	<td style=\"text-align: right;\">"+((data[i][9]!=null)? $.formatNumber(data[i][9]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				        </c:if>
				         "    	<td style=\"text-align: right;\">"+((data[i][3]!=null)? $.formatNumber(data[i][3]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				         "    	<td style=\"text-align: right;\">"+((data[i][4]!=null)? $.formatNumber(data[i][4]+"", {format:"#,###.00", locale:"us"}):"")+"</td>  "+
				        //"    	<td style=\"text-align: right;\">"+((data[i][4]!=null)?data[i][4]:"")+"</td>  "+
				        "    	<td style=\"text-align: center;\">"+    
				    
				        "    	<i title=\"Delete\" onclick=\"confirmDelete('"+data[i][0]+"','${bccNo}','2')\" style=\"cursor: pointer;\" class=\"icon-trash\"></i>"+
				       
				        "    	</td> "+
				        "  	</tr>  ";
				   }
				  // alert(colspan_str)
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\""+colspan_str+"\" style=\"text-align: right;\">ราคารวม</td>"+    
			       "    	<td style=\"text-align: right;\">"+total+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\""+colspan_str+"\" style=\"text-align: right;\">Vat 7%</td>"+    
			       "    	<td style=\"text-align: right;\">"+vat+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  ";
				   str=str+ "  	<tr style=\"cursor: pointer;\">"+
				   "  		<td  colspan=\""+colspan_str+"\" style=\"text-align: right;\">ราคาสุทธิ</td>"+    
			       "    	<td style=\"text-align: right;\">"+grand_total+"</td>  "+
			        "    	<td style=\"text-align: center;\">&nbsp;"+    
			        "    	</td> "+
			        "  	</tr>  ";
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
			//renderPageSelect();
		}
	});
	 */
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
 
 function confirmDelete(IMA_ItemID,BQ_REF,BQ_TYPE){
		$( "#dialog-confirmDelete" ).dialog({
			/* height: 140, */
			modal: true,
			buttons: {
				"Yes": function() { 
					$( this ).dialog( "close" );
					doAction(IMA_ItemID,BQ_REF,BQ_TYPE);
				},
				"No": function() {
					$( this ).dialog( "close" );
					return false;
				}
			}
		});
	} 
 function doAction(IMA_ItemID,BQ_REF,BQ_TYPE){ 
		var querys=[]; 
	 
		  query="DELETE FROM "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING where IMA_ItemID='"+IMA_ItemID+"' and BQ_REF='"+BQ_REF+"' and BQ_TYPE='"+BQ_TYPE+"' ";
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
 function addItem(){
		//var str="";	 
		var function_str="addItemToList()";
		var label_str="Add Item";
		var input_id="ima_item_id";
		var input_hidden_id="IMA_ItemID"; 
		var query="SELECT IMA_ItemID,IMA_ItemName,LocQty,ROUND(AcctValAmt,2),CONCAT(IMA_ItemID, ' ', IMA_ItemName) as name  FROM "+SCHEMA_G+".BPM_PRODUCT "+	
		  " where  CONCAT(IMA_ItemID, ' ', IMA_ItemName) like ";
		 
		var bt= "<span>&nbsp;&nbsp;&nbsp;<a class=\"btn btn-primary\" style=\"margin-top: -10px;\" onclick=\""+function_str+"\"><i class=\"icon-ok icon-white\"></i>&nbsp;<span style=\"color: white;font-weight: bold;\">"+label_str+"</span></a>";
		var input_str= "<br/><span id=\"item_name\"></span>"+
						//"<br/><input  onclick=\"show_hide_element('IS_REPLACE','REPLACE_NAME_ELEMENT','1')\" type=\"checkbox\" id=\"IS_REPLACE\" name=\"IS_REPLACE\"/>เปลี่ยนชื่อ"+
						"<span id=\"REPLACE_NAME_ELEMENT\" style=\"display:none\">&nbsp;&nbsp;&nbsp;<input type=\"text\" id=\"REPLACE_NAME\" name=\"REPLACE_NAME\" style=\"height: 30;\" /></span>"+
			            "<input type=\"hidden\" id=\"LastCostAmt\" name=\"LastCostAmt\" style=\"height: 30;\" />"+
			            "<br/>ราคาขาย <input type=\"text\" id=\"Price\" name=\"Price\" style=\"height: 30;\" />"+
			        
		 			 	"<br/>จำนวน <input type=\"text\" id=\"AMOUNT\" name=\"AMOUNT\" style=\"height: 30;\" />"+
		 			    "<br/>&nbsp;&nbsp;&nbsp;<input type=\"checkbox\" value=\"1\" id=\"CHECK_FEE\" onclick=\"checkFree()\"/>ของแถม"+
		 			//	"<br/>น้ำหนัก <input type=\"text\" id=\"WEIGHT\" name=\"WEIGHT\" style=\"height: 30;\" />"+
		 			//	"<br/>รายละเอียด <input type=\"text\" id=\"DETAIL\" name=\"DETAIL\" style=\"height: 30;\" />"+
		 				""+
		 			//	"<br/>Serial เริ่มต้น &nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" checked value=\"1\" name=\"isNoSerail\" onclick=\"show_hide('SERIAL','1')\"/>&nbsp;&nbsp;ระบุ"+
		 			//	"&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"radio\" value=\"0\" name=\"isNoSerail\" onclick=\"show_hide('SERIAL','0')\"/>&nbsp;&nbsp;ไม่ระบุ"+
		 			//	"&nbsp;&nbsp;&nbsp;&nbsp;<br/>"+
		 			//	"<input type=\"text\" id=\"SERIAL\" name=\"SERIAL\" style=\"height: 30;\" />"+
		 				"";
		 				
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
						,errorHandler:function(errorString, exception) { 
							alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
						}
				 });		  
			  },
			  minLength: 1,
			  select: function( event, ui ) { 
				  this.value = ui.item.value;
				  $("#"+input_hidden_id+"").val(ui.item.id);  
				  document.getElementById("LastCostAmt").value=ui.item.Price; 
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
	function addDiscountToList(){
		
		$("#addDiscount_btn").attr('disabled',true);
//		alert("s"+$("#addDiscount_btn").attr('disabled'))
		var IMA_ItemID='90100002';
		 var isNumber=checkNumber(jQuery.trim($("#discount").val())); 
		 if(isNumber){  
			 alert('กรุณากรอก % เป็นตัวเลข.');  
			 $("#discount").val("");
			 $("#discount").focus(); 
			 return false;	  
		 }
		var discount=jQuery.trim($("#discount").val());
		var LastCostAmt=discount;
		var Price=discount;
		var AMOUNT='1';
		var SERIAL='001';
		var WEIGHT='';
		var DETAIL=''+Price+" %";
		var IS_SERIAL="0";
		var PRE_SERIAL="";
		 var queryCheck=" SELECT count(*) FROM "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF='${bccNo}' and bq_type='2' and IMA_ItemID='"+IMA_ItemID+"'";
		 
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
				    var max_auto=1;
					if(data>0){ 
						 bootbox.dialog("ข้อมูลถูกเพิ่มไปก่อนหน้านี้แล้ว ",[{
							    "label" : "Close",
							     "class" : "btn-danger"
						 }]);
						 return false;
					}  
					var query ="select ROUND((sum(ROUND(BQ_AMOUNT*PRICE_COST,2))*"+discount+")/100,2) from "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING "+
					" where BQ_REF='${bccNo}' and bq_type='2'";
				
					//alert(max_auto)
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
							 //  alert(data-1)
							 query="INSERT INTO "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING"+ 
							"(BQ_REF,BQ_TYPE,IMA_ItemID,PRICE,BQ_AMOUNT,BQ_DETAIL)"+ 
							"VALUES ('${bccNo}','2','"+IMA_ItemID+"','-"+data+"',"+AMOUNT+",'"+DETAIL+"')"; 
					//alert(query)
					var querys=[];
					querys.push(query);
					 
					//query=" UPDATE  "+SCHEMA_G+".BPM_SALE_ORDER SET BSO_STORE_PRE_SEND ='0' WHERE   BSO_ID=${bsoId} ";
					//alert(query)
					//querys.push(query);  
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
							$("#addDiscount_btn").attr('disabled',false);
							//$("#addDiscount_btn").attr("onclick","addDiscountToList()");
						},errorHandler:function(errorString, exception) { 
							alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
						}
					});
						 }}); 
			 }
		 });
	}
	function addItemToList(){
		//alert( $("#bdeptUserId").val());
		var IMA_ItemID=jQuery.trim($("#IMA_ItemID").val());
		var LastCostAmt=jQuery.trim($("#LastCostAmt").val());
		var Price=jQuery.trim($("#Price").val());
		var AMOUNT=jQuery.trim($("#AMOUNT").val());
	//	var SERIAL=jQuery.trim($("#SERIAL").val());
	//	var WEIGHT=jQuery.trim($("#WEIGHT").val());
	//	var DETAIL=jQuery.trim($("#DETAIL").val());
	//	var IS_REPLACE= $('#IS_REPLACE').prop('checked')?"1":"0";
	//	var REPLACE_NAME="";
	//	if(IS_REPLACE=='1')
	//		REPLACE_NAME=jQuery.trim($("#REPLACE_NAME").val()); 
		if(!IMA_ItemID.length>0){
			 alert('กรุณากรอก ข้อมูล.');  
			 $("#IMA_ItemID").focus(); 
			 return false;	
		}
/*		
		 isNumber=checkNumber(jQuery.trim($("#LastCostAmt").val())); 
		 if(isNumber){  
			 alert('กรุณากรอก  ราคาขาย เป็นตัวเลข.');  
			 $("#LastCostAmt").val("");
			 $("#LastCostAmt").focus(); 
			 return false;	  
		 }
		 */
		 isNumber=checkNumber(jQuery.trim($("#Price").val())); 
		 if(isNumber){  
			 alert('กรุณากรอก  ราคาขาย เป็นตัวเลข.');  
			 $("#Price").val("");
			 $("#Price").focus(); 
			 return false;	  
		 }
		 var  isNumber=checkNumber(jQuery.trim($("#AMOUNT").val())); 
		 if(isNumber){  
			 alert('กรุณากรอก  จำนวน เป็นตัวเลข.');  
			 $("#AMOUNT").val(""); 
			 $("#AMOUNT").focus(); 
			 return false;	  
		 } 
		 /*
		 if(IS_REPLACE=='1' && !REPLACE_NAME.length>0){
			 alert('กรุณากรอก ชื่อที่ต้องการเปลี่ยน.');  
			 $("#REPLACE_NAME").focus(); 
			 return false;	
		}
		
		var IS_SERIAL="0";
		var PRE_SERIAL="";
		//alert(IMA_ItemID);
		//alert(SERIAL.length);
		
		if($('input[name="isNoSerail"][value="1"]').prop('checked')){
			IS_SERIAL='1';
			if(SERIAL.length!=13){
				alert(" กรอก Serial เริ่มต้น 13 หลัก"); 
				return false;
			}else{
				PRE_SERIAL=SERIAL.substring(0,9);
				//alert(PRE_SERIAL);
				SERIAL=SERIAL.substring(9);
				//alert(SERIAL);
			}
		}else{
			SERIAL="1";
		}
		 */
	 
	    /* alert(Price);
		alert(LastCostAmt);
		alert(LastCostAmt-Price);  */
		if($('#CHECK_FEE').prop('checked')){
			Price='0';
			/*
			var Price_digit = parseFloat(Price);
			var LastCostAmt_digit = parseFloat(LastCostAmt)
			if((LastCostAmt_digit-Price_digit)<0 && IMA_ItemID!='90100002'){
				var r = confirm("ราคาขายน้อยกว่าต้นทุน คุณต้องการ Add Item ?");
				if (r == true)
				  {
				 // x = "You pressed OK!";
				  }
				else
				  {
					return false; 
				  }
			}
			*/
		}
		 var queryCheck=" SELECT count(*) FROM "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING where BQ_REF='${bccNo}' and bq_type='2' and IMA_ItemID='"+IMA_ItemID+"'";
	 
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
					if(data>0){ 
						 bootbox.dialog("ข้อมูลถูกเพิ่มไปก่อนหน้านี้แล้ว ",[{
							    "label" : "Close",
							     "class" : "btn-danger"
						 }]);
						 return false;
					}else {
						var querys=[]; 
						 query="INSERT INTO "+SCHEMA_G+".BPM_QUOTATION_PRODUCT_ITEM_MAPPING"+ 
							"(BQ_REF,BQ_TYPE,IMA_ItemID,PRICE,PRICE_COST,BQ_AMOUNT)"+ 
							"VALUES ('${bccNo}','2','"+IMA_ItemID+"','"+Price+"','"+LastCostAmt+"',"+AMOUNT+")"; 
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
								bootbox.hideAll();
							}
						},errorHandler:function(errorString, exception) { 
							alert("have error "+errorString +" , - Error Details: " + dwr.util.toDescriptiveString(exception, 2));
						}
					});
					} 
			 }
		 });
		
	}

	function printView(){
		//http://localhost:8080/bpm/dispatcher/page/service_quotation_print
	//	printWindow = new Object();
		//window.location = "dispatcher/page/service_quotation_print";
		//window.print();
		//return false;a
		// alert("a")
		// window.open("http://localhost:8080/bpm/dispatcher/page/service_quotation_print","_blank"); 
		// window.print(); 
		window.open("http://localhost:8080/bpm/dispatcher/page/service_quotation_print");return false;
	}
</script>  
<div id="dialog-confirmDelete" title="Delete Item" style="display: none;background: ('images/ui-bg_highlight-soft_75_cccccc_1x100.png') repeat-x scroll 50% 50% rgb(204, 204, 204)">
	Are you sure you want to delete Item ?
</div>
<fieldset style="font-family: sans-serif;padding-top:5px"> 
	    <form id="breakdownForm" name="breakdownForm"  class="well" action="" method="post">
	  
			<!--  <form class="well"> -->
			 <%--  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactRef}" id="maId"/>
			  <input type="hidden" value="${breakdownForm.pstBreakDown.mcontactType}" id="mcontactType"/> --%> 
			  <input type="hidden" name="mode" id="mode"  value="${mode}"/> 
			 <input type="hidden" name="bccNo" id="bccNo"  value="${bccNo}"/> 
			 <input type="hidden" name="BSO_IS_DELIVERY" id="BSO_IS_DELIVERY" />
			  <input type="hidden" id="pageNo" value="1"/>
            <input type="hidden" id="pageSize"/>
            <input type="hidden" id="pageCount" value="1"/> 
             <input type="hidden" id="IMA_ItemID" name="IMA_ItemID"/>
             <%-- 
			  <fieldset style="font-family: sans-serif;">    
			  <div align="center">
           	 <strong>ใบเสนอราคา</strong> 
            	</div>
			    <table border="0" width="100%" style="font-size: 12px">  
    				<tr valign="top">
    					<td width="100%" valign="top" align="left">
    					 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 2px;height:150px">
    					  
    					  </div> 
    					</td> 
    				</tr> 
    			</table> 
    			</fieldset>   
    			 --%>
			  </form>     
			   <div  class="well">
			  <table border="0" width="100%" style="font-size: 13px">
	    					<tbody> 
	    					<tr>
	    					<td align="left" width="70%">
	    					<a class="btn btn-primary"  onclick="addItem()"><i class="icon-plus-sign icon-white"></i>&nbsp;<span style="font-weight:bold;color:  white;">Add</span></a>   
	    					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    						ส่วนลด&nbsp;&nbsp;<input type="text" id="discount" style="width: 30px;height: 30px;" /> (%) <a  onclick="addDiscountToList()" id="addDiscount_btn"  class="btn"  ><span style="">เพิ่มส่วนลด</span></a>
	    						
	    					</td><td align="right" width="30%">  
	    					</td>
	    					</tr>
	    					</tbody></table> 
			 <div  id="item_section"> 
    		 </div> 
    		 <div style="border: 1px solid #FFC299;background: #F9F9F9;padding: 10px" bgcolor="#F9F9F9">   
    		  <table border="0" width="30%" style="font-size: 13px">
			         <thead>  
			         		<tr valign="top">  
			         		<td valign="top" width="10%"><div >หมายเหตุ :</div></td>  
			         		<td valign="top" width="20%"><div ><textarea id="BCC_QUOTAION_REMARK" rows="4" cols="4"></textarea></div></td>   
			        		</tr> 
			        	</thead> 
			     </table>  
			        	  
    		   </div>
			</div> 
			<div align="center" style="padding-top: 10px">
				 <table border="0" style="width: 100%">
				 	<tr>
				 		<td width="20%"> 
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/service_supervisor?bccNo=${bccNo}&mode=edit&state=${state}&requestor=${requestor}')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 			<%-- 
				 			<a class="btn btn-info"  onclick="loadDynamicPage('dispatcher/page/todolist')"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back</span></a>
				 			
				 			 --%>
				 		</td>
				 		<td width="80%"> 
				 		<%-- 
				 		 <div align="center"> <a class="btn btn-primary"  onclick="doUpdateJob('1','wait_for_supervisor_close','${username}','1','Sale Order Closed')"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบเสนอราคา</span></a></div>
				 		   --%>
				 		   <div align="center">
				 		   <%-- 
				 		   <a class="btnPrint" href='dispatcher/page/service_quotation_print'>Print second page!</a>
				 		   <a class="btnPrint"  href='dispatcher/page/service_quotation_print' onClick='w = window.open("http://localhost:8080/bpm/dispatcher/page/service_quotation_print");w.print();w.close();return false;'><img src="print.gif"></a>
				 		   
				 		   <a  onClick="printView()"><img src="print.gif"></a>
				 		    --%>
				 		   <a class="btn btn-primary" onclick="printQuotationServices('pdf')"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">พิมพ์ใบเสนอราคา</span></a>
				 		   <a class="btn btn-primary" onclick="printQuotationServices('xls')"><i class="icon-print icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Download ใบเสนอราคา( xls )</span></a>
				 		   </div>
				 		    
    					
    					</td>
				 	</tr>
				 </table>
				</div>
</fieldset>