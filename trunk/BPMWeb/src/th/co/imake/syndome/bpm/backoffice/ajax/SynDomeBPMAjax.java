package th.co.imake.syndome.bpm.backoffice.ajax;

import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;

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
	public List searchObject(String query){
		return synDomeBPMService.searchObject(query);
	}
	public int executeQuery(String[] query){
		return synDomeBPMService.executeQuery(query);
	}
	public int executeQueryWithValues(String[] query,List<String[]> values){
		return synDomeBPMService.executeQuery(query, values);
	}
	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate){
		return synDomeBPMService.executeQueryUpdate(queryDelete,queryUpdate);
	} 
	 
	public String getRunningNo(String module,String format_year_month_day,String digit,String local){
		return synDomeBPMService.getRunningNo(module,format_year_month_day,digit,local);
	}
	/*public int executeQueryDelete(String[] queryUpdate){
		return synDomeBPMService.executeQueryDelete(queryUpdate);
	}*/
}
