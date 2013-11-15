package th.co.imake.syndome.bpm.backoffice.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstEmployeeStatus;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.EmployeeStatusForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/employeeStatus"})
@SessionAttributes(value={"employeeStatusForm"})
public class EmployeeStatusController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 EmployeeStatusForm employeeStatusForm = null;
	      /*  if(model.containsAttribute("employeeStatusForm"))
	        	employeeStatusForm = (EmployeeStatusForm)model.asMap().get("employeeStatusForm");
	        else*/
		 employeeStatusForm = new EmployeeStatusForm();
	        
		 employeeStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 employeeStatusForm.getPstEmployeeStatus().setPagging(employeeStatusForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstEmployeeStatuses", vresultMessage.getResultListObj());
	        employeeStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        employeeStatusForm.setPageCount(IMakeDevUtils.calculatePage(employeeStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("employeeStatusForm", employeeStatusForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/employee_status_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="employeeStatusForm") EmployeeStatusForm employeeStatusForm, BindingResult result, Model model)
	    {
	        String mode = employeeStatusForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	employeeStatusForm.getPstEmployeeStatus().setIds(employeeStatusForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	employeeStatusForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus(),  ServiceConstant.PST_EMPLOYEE_STATUS_DELETE);
	        	employeeStatusForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("employeeStatusForm"))
	            	employeeStatusForm = (EmployeeStatusForm)model.asMap().get("employeeStatusForm");
	            else
	            	employeeStatusForm = new EmployeeStatusForm();
	        }
	        employeeStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        employeeStatusForm.getPstEmployeeStatus().setPagging(employeeStatusForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus());
	       
	        employeeStatusForm.setPageCount(IMakeDevUtils.calculatePage(employeeStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstEmployeeStatuses", vresultMessage.getResultListObj());
	        model.addAttribute("employeeStatusForm", employeeStatusForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/employee_status_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  EmployeeStatusForm employeeStatusForm = null;
	        if(model.containsAttribute("employeeStatusForm"))
	        	employeeStatusForm = (EmployeeStatusForm)model.asMap().get("employeeStatusForm");
	        else
	        	employeeStatusForm = new EmployeeStatusForm();
	        employeeStatusForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(Long.parseLong(maId));
	        employeeStatusForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("employeeStatusForm", employeeStatusForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="employeeStatusForm") EmployeeStatusForm employeeStatusForm, BindingResult result, Model model)
	    {
	        String mode = employeeStatusForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus());
	                employeeStatusForm.getPstEmployeeStatus().setPesId(id);
	                employeeStatusForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus());
	                id = employeeStatusForm.getPstEmployeeStatus().getPesId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        employeeStatusForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("employeeStatusForm", employeeStatusForm);*/
	       // EmployeeStatusForm employeeStatusForm = null; 
	       employeeStatusForm = new EmployeeStatusForm(); 
	       employeeStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       employeeStatusForm.getPstEmployeeStatus().setPagging(employeeStatusForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstEmployeeStatus(employeeStatusForm.getPstEmployeeStatus());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstEmployeeStatuses", vresultMessage.getResultListObj());
		        employeeStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        employeeStatusForm.setPageCount(IMakeDevUtils.calculatePage(employeeStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("employeeStatusForm", employeeStatusForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/employee_status_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  EmployeeStatusForm employeeStatusForm = new EmployeeStatusForm(); 
		  employeeStatusForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("employeeStatusForm", employeeStatusForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/employee_status_management";
	    }

}
