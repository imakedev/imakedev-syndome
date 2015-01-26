package th.co.imake.syndome.bpm.backoffice.ajax;

import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;
dd
public class SynDomeBPMAjax {
	private final SynDomeBPMService synDomeBPMService; 
	public SynDomeBPMAjax(){
		WebContext ctx = WebContextFactory.get(); 
		ServletContext servletContext = ctx.getServletContext();
    	WebApplicationContext wac = WebApplicationContextUtils.
    	getRequiredWebApplicationContext(servletContext);
    	synDomeBPMService = (SynDomeBPMService)wac.getBean("synDomeBPMService"); 
	}   
	@SuppressWarnings("rawtypes")
	//public List searchObject(String query) {
	public VResultMessage searchObject(String query) {
		try {
			return synDomeBPMService.searchObject(query);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	}
	
	
//	public int executeQuery(String[] query){
	public VResultMessage executeQuery(String[] query){
		try{
			return synDomeBPMService.executeQuery(query);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	}
	//public int executeQueryWithValues(String[] query,List<String[]> values){
	public VResultMessage executeQueryWithValues(String[] query,List<String[]> values){
		return synDomeBPMService.executeQuery(query, values);
	}
	//public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate){
	public VResultMessage executeQueryUpdate(String[] queryDelete,String[] queryUpdate){
		return synDomeBPMService.executeQueryUpdate(queryDelete,queryUpdate);
	} 
	 
	public VResultMessage getRunningNo(String module,String format_year_month_day,String digit,String local){
		return synDomeBPMService.getRunningNo(module,format_year_month_day,digit,local);
	}
	public VResultMessage searchServices(String bccNo){
		try {
			return synDomeBPMService.searchServices(bccNo);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		}  
	}
	public VResultMessage searchTodoList(String serviceType,String serviceStatus,String username,String role,String page,String pageG,String isStore,String type,
			String key_job,String BTDL_CREATED_TIME){
		try {
			return synDomeBPMService.searchTodoList(serviceType,serviceStatus,username,role,page,pageG,isStore,type,key_job,BTDL_CREATED_TIME);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	}
	 
	public VResultMessage genPMMA(String duedate,String username,String BPMJ_NO,int pm_amount,int pm_year){
		try {
			return synDomeBPMService.genPMMA(duedate,username,BPMJ_NO,pm_amount,pm_year);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	}
	@SuppressWarnings("rawtypes")
	//public List searchObject(String query) {
	public VResultMessage getReportSO(String start_date,String end_date) {
		try {
			return synDomeBPMService.getReportSO(start_date,end_date);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	} 
	@SuppressWarnings("rawtypes")
	//public List searchObject(String query) {
	public VResultMessage getReportDeptStatus(String start_date,String end_date) {
		try {
			return synDomeBPMService.getReportDeptStatus(start_date,end_date);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	} 
	@SuppressWarnings("rawtypes")
	//public List searchObject(String query) {
	public VResultMessage getReportPMMA(String start_date,String end_date,String viewBy) {
		try {
			return synDomeBPMService.getReportPMMA(start_date,end_date,viewBy);
		} catch (Exception e) {
			// TODO: handle exception 
	        throw new RuntimeException(e);
		} 
	} 
	/*public int executeQueryDelete(String[] queryUpdate){
		return synDomeBPMService.executeQueryDelete(queryUpdate);
	}*/
}
