package th.co.aoe.imake.pst.backoffice.ajax;

import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.xstream.PstMaintenance;
import th.co.aoe.imake.pst.xstream.PstMaintenanceTran;

public class PSTAjax {
	private final PSTService pstService; 
	public PSTAjax(){
		WebContext ctx = WebContextFactory.get(); 
		ServletContext servletContext = ctx.getServletContext();
    	WebApplicationContext wac = WebApplicationContextUtils.
    	getRequiredWebApplicationContext(servletContext);
    	pstService = (PSTService)wac.getBean("pstService"); 
	}   
	@SuppressWarnings("rawtypes")
	public List searchObject(String query){
		return pstService.searchObject(query);
	}
	public int executeQuery(String[] query){
		return pstService.executeQuery(query);
	} 
	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate){
		return pstService.executeQueryUpdate(queryDelete,queryUpdate);
	} 
	public int executeMaintenance(PstMaintenance[] pstMaintenance,PstMaintenanceTran pstMaintenanceTran,String mode){
		return pstService.executeMaintenance(pstMaintenance,pstMaintenanceTran,mode);
	} 
	/*public int executeQueryDelete(String[] queryUpdate){
		return pstService.executeQueryDelete(queryUpdate);
	}*/
}
