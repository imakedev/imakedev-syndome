<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<script type="text/javascript" src="<c:url value='/resources/FusionCharts/FusionCharts.js'/>"></script> 
<script>
$(document).ready(function() {
	//renderPageSelect();
});
function startExport(){
	//Get reference to chart.
	var chart = getChartFromId("myChartId");
	//Now, we proceed with exporting only if chart has finished rendering.
	if (chart.hasRendered()==true){
		chart.exportChart();
	}else{
		alert("Please wait for the chart to finish rendering, before you can invoke exporting");
	}
}
</script> 
<fieldset style="font-family: sans-serif;">  
		 
    <div id="chartdiv" align="center">The chart will appear within this DIV. This text will be replaced by the chart.</div>
   <script type="text/javascript">
   	//Create the chart.
    
	 // FusionCharts.setCurrentRenderer('javascript'); // for new version
    // var myChart = new FusionCharts("../../newVersion/Charts/Column2D.swf", "myChartId", "400", "300", "0", "1"); //for new version
    var xml="<chart yAxisName='Sales Figure' caption='Top 5 Sales Person' numberPrefix='$' useRoundEdges='1' bgColor='FFFFFF,FFFFFF' showBorder='0' exportEnabled='1' exportAtClient='0' exportAction='download' exportHandler='http://localhost:8080/TestFusion/FCExporter.jsp?aoe=1' exportFileName='MyFileName'>"+
	"<set label='Alex' value='25000'  />"+
	"<set label='Mark' value='35000' /> "+
	"<set label='David' value='42300' /> "+
	"<set label='Graham' value='35300' /> "+
	"<set label='John' value='31300' /> "+
"</chart>";
     var myChart = new FusionCharts("<c:url value='/resources/FusionCharts/Column2D.swf'/>", "myChartId", "600", "300", "0", "1"); // for old version
	myChart.setDataXML(xml);
	myChart.render("chartdiv");
   </script>

<BR/>
<center><input type='button' value='Begin Chart Export' onClick="javascript:startExport();">

</fieldset>