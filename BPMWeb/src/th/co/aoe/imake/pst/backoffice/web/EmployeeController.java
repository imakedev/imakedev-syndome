package th.co.aoe.imake.pst.backoffice.web;

import java.util.List;

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

import th.co.aoe.imake.pst.backoffice.form.EmployeeForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstEmployee;
import th.co.aoe.imake.pst.xstream.PstPosition;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/employee"})
@SessionAttributes(value={"employeeForm"})
public class EmployeeController {


	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 EmployeeForm employeeForm = null;
	      /*  if(model.containsAttribute("employeeForm"))
	        	employeeForm = (EmployeeForm)model.asMap().get("employeeForm");
	        else*/
		 employeeForm = new EmployeeForm();
	        
		 employeeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 employeeForm.getPstEmployee().setPagging(employeeForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstEmployee(employeeForm.getPstEmployee());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstEmployees", vresultMessage.getResultListObj());
	        employeeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        employeeForm.setPageCount(IMakeDevUtils.calculatePage(employeeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("employeeForm", employeeForm);
	        @SuppressWarnings("rawtypes")
	        List listPositions=pstService.listPstPositions();
	     //   List listTitles=pstService.listPstTitles();
	        model.addAttribute("positions",listPositions);
	     //   model.addAttribute("titles",listTitles);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/employee_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="employeeForm") EmployeeForm employeeForm, BindingResult result, Model model)
	    {
	        String mode = employeeForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	employeeForm.getPstEmployee().setIds(employeeForm.getPeIdArray());
	        	pstService.deletePstEmployee(employeeForm.getPstEmployee(), ServiceConstant.PST_EMPLOYEE_ITEMS_DELETE);
	        	employeeForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstEmployee(employeeForm.getPstEmployee(),  ServiceConstant.PST_EMPLOYEE_DELETE);
	        	employeeForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("employeeForm"))
	            	employeeForm = (EmployeeForm)model.asMap().get("employeeForm");
	            else
	            	employeeForm = new EmployeeForm();
	        }
	        employeeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        employeeForm.getPstEmployee().setPagging(employeeForm.getPaging());
	        if(employeeForm.getPpId().intValue()!=-1){
	        	PstPosition position= new PstPosition(employeeForm.getPpId(),null);
	        	 employeeForm.getPstEmployee().setPstPosition(position);
	        }else
	        	employeeForm.getPstEmployee().setPstPosition(null);
	        	
	        VResultMessage vresultMessage = pstService.searchPstEmployee(employeeForm.getPstEmployee());
	       
	        employeeForm.setPageCount(IMakeDevUtils.calculatePage(employeeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstEmployees", vresultMessage.getResultListObj());
	        model.addAttribute("employeeForm", employeeForm);
	        @SuppressWarnings("rawtypes")
	        List listPositions=pstService.listPstPositions();
	       // List listTitles=pstService.listPstTitles();
	        model.addAttribute("positions",listPositions);
	        //model.addAttribute("titles",listTitles);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/employee_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  EmployeeForm employeeForm = null;
	        if(model.containsAttribute("employeeForm"))
	        	employeeForm = (EmployeeForm)model.asMap().get("employeeForm");
	        else
	        	employeeForm = new EmployeeForm();
	        employeeForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstEmployee pstBreakDown = pstService.findPstEmployeeById(Long.parseLong(maId));
	        employeeForm.setPstEmployee(pstBreakDown);
	        model.addAttribute("employeeForm", employeeForm);
	        @SuppressWarnings("rawtypes")
	        List listPositions=pstService.listPstPositions();
	        @SuppressWarnings("rawtypes")
	        List listTitles=pstService.listPstTitles();
	        model.addAttribute("positions",listPositions);
	        model.addAttribute("titles",listTitles);
	        model.addAttribute("display", "display: none");
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        return "backoffice/template/employee_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="employeeForm") EmployeeForm employeeForm, BindingResult result, Model model)
	    {
	        String mode = employeeForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstEmployee(employeeForm.getPstEmployee());
	                employeeForm.getPstEmployee().setPeId(id);
	                employeeForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstEmployee(employeeForm.getPstEmployee());
	                id = employeeForm.getPstEmployee().getPeId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployee pstBreakDown = pstService.findPstEmployeeById(id);
	        employeeForm.setPstEmployee(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("employeeForm", employeeForm);*/
	       // EmployeeForm employeeForm = null; 
	       employeeForm = new EmployeeForm(); 
	       employeeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       employeeForm.getPstEmployee().setPagging(employeeForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstEmployee(employeeForm.getPstEmployee());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstEmployees", vresultMessage.getResultListObj());
		        employeeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        employeeForm.setPageCount(IMakeDevUtils.calculatePage(employeeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("employeeForm", employeeForm);
		        model.addAttribute("message", message); 
		        @SuppressWarnings("rawtypes")
		        List listPositions=pstService.listPstPositions();
		       // List listTitles=pstService.listPstTitles();
		        model.addAttribute("positions",listPositions);
		     //   model.addAttribute("titles",listTitles);
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/employee_search";
	        // return "backoffice/template/employee_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  EmployeeForm employeeForm = new EmployeeForm(); 
		  employeeForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("employeeForm", employeeForm);
		  @SuppressWarnings("rawtypes")
		  List listPositions=pstService.listPstPositions();
		  @SuppressWarnings("rawtypes")
	        List listTitles=pstService.listPstTitles();
	        model.addAttribute("positions",listPositions);
	        model.addAttribute("titles",listTitles);
	        model.addAttribute("display", "display: none");
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        return "backoffice/template/employee_management";
	    }


}
