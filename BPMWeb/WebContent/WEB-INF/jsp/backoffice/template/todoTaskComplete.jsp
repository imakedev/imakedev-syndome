<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script>
$(document).ready(function() {
	
});
function goBackToSearchReport(){
	
	//alert(action)
	loadDynamicPage("template/todolist");
  }
  </script>
	    <!--Body content-->
	    <fieldset style="font-family: sans-serif;">  
           <form class="well"> 
     
              <table border="0" width="100%" style="font-size: 13px">
              				<tr>
	    					 <td align="center" ><strong>Send mail Success</strong></td>
	    					</tr> 
	    					</table> 
	    					</form>
	    					<!-- <div align="center"><input type="button" value="Send"></div> -->
	    					
	    					<div align="center"><a class="btn btn-primary" onclick="goBackToSearchReport();"><i class="icon-chevron-left icon-white"></i>&nbsp;<span style="color: white;font-weight: bold;">Back To Home</span></a></div>
      </fieldset> 
   