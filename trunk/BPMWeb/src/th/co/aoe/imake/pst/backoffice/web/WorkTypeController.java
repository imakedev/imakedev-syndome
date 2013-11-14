package th.co.aoe.imake.pst.backoffice.web;

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

import th.co.aoe.imake.pst.backoffice.form.WorkTypeForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstWorkType;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/workType"})
@SessionAttributes(value={"workTypeForm"})
public class WorkTypeController {


	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 WorkTypeForm workTypeForm =  new WorkTypeForm();
	        
		 workTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 workTypeForm.getPstWorkType().setPagging(workTypeForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstWorkType(workTypeForm.getPstWorkType());
	      
	        model.addAttribute("pstWorkTypes", vresultMessage.getResultListObj());
	        workTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        workTypeForm.setPageCount(IMakeDevUtils.calculatePage(workTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("workTypeForm", workTypeForm);
	        model.addAttribute("message", "");  
	        model.addAttribute("pstDepartments",  pstService.listPstDepartments());
	        return "backoffice/template/workType_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="workTypeForm") WorkTypeForm workTypeForm, BindingResult result, Model model)
	    {
	        String mode = workTypeForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	workTypeForm.getPstWorkType().setIds(workTypeForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(workTypeForm.getPstWorkType(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	workTypeForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstWorkType(workTypeForm.getPstWorkType(),  ServiceConstant.PST_WORK_TYPE_DELETE);
	        	workTypeForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("workTypeForm"))
	            	workTypeForm = (WorkTypeForm)model.asMap().get("workTypeForm");
	            else
	            	workTypeForm = new WorkTypeForm();
	        }
	        workTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        workTypeForm.getPstWorkType().setPagging(workTypeForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstWorkType(workTypeForm.getPstWorkType());
	       
	        workTypeForm.setPageCount(IMakeDevUtils.calculatePage(workTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstWorkTypes", vresultMessage.getResultListObj());
	        model.addAttribute("workTypeForm", workTypeForm);
	        model.addAttribute("message", ""); 
	        model.addAttribute("pstDepartments",  pstService.listPstDepartments());
	        return "backoffice/template/workType_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  WorkTypeForm workTypeForm = null;
	        if(model.containsAttribute("workTypeForm"))
	        	workTypeForm = (WorkTypeForm)model.asMap().get("workTypeForm");
	        else
	        	workTypeForm = new WorkTypeForm();
	        workTypeForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstWorkType pstWorkType = pstService.findPstWorkTypeById(Long.parseLong(maId));
	        workTypeForm.setPstWorkType(pstWorkType);
	        model.addAttribute("workTypeForm", workTypeForm);
	        model.addAttribute("display", "display: none");
	        model.addAttribute("pstDepartments",  pstService.listPstDepartments());
	        return "backoffice/template/workType_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="workTypeForm") WorkTypeForm workTypeForm, BindingResult result, Model model)
	    {
	        String mode = workTypeForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstWorkType(workTypeForm.getPstWorkType());
	                workTypeForm.getPstWorkType().setPwtId(id);
	                workTypeForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstWorkType(workTypeForm.getPstWorkType());
	                id = workTypeForm.getPstWorkType().getPwtId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        workTypeForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("workTypeForm", workTypeForm);*/
	       // workTypeForm workTypeForm = null; 
	       workTypeForm = new WorkTypeForm(); 
	       workTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       workTypeForm.getPstWorkType().setPagging(workTypeForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstWorkType(workTypeForm.getPstWorkType());
		        model.addAttribute("pstWorkTypes", vresultMessage.getResultListObj());
		        workTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        workTypeForm.setPageCount(IMakeDevUtils.calculatePage(workTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("workTypeForm", workTypeForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        model.addAttribute("pstDepartments",  pstService.listPstDepartments());
		        return "backoffice/template/workType_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  WorkTypeForm workTypeForm = new WorkTypeForm(); 
		  workTypeForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("workTypeForm", workTypeForm);
	        model.addAttribute("display", "display: none");
	        model.addAttribute("pstDepartments",  pstService.listPstDepartments());
	        return "backoffice/template/workType_management";
	    }


}
