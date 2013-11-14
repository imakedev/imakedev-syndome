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

import th.co.aoe.imake.pst.backoffice.form.DepartmentForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstDepartment;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
@Controller
@RequestMapping(value={"/department"})
@SessionAttributes(value={"departmentForm"})
public class DepartmentController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 DepartmentForm departmentForm =  new DepartmentForm();
	        
		 departmentForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 departmentForm.getPstDepartment().setPagging(departmentForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstDepartment(departmentForm.getPstDepartment());
	      
	        model.addAttribute("pstDepartments", vresultMessage.getResultListObj());
	        departmentForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        departmentForm.setPageCount(IMakeDevUtils.calculatePage(departmentForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("departmentForm", departmentForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/department_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="departmentForm") DepartmentForm departmentForm, BindingResult result, Model model)
	    {
	        String mode = departmentForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	departmentForm.getPstDepartment().setIds(departmentForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(departmentForm.getPstDepartment(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	departmentForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstDepartment(departmentForm.getPstDepartment(),  ServiceConstant.PST_DEPARTMENT_DELETE);
	        	departmentForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("departmentForm"))
	            	departmentForm = (DepartmentForm)model.asMap().get("departmentForm");
	            else
	            	departmentForm = new DepartmentForm();
	        }
	        departmentForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        departmentForm.getPstDepartment().setPagging(departmentForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstDepartment(departmentForm.getPstDepartment());
	       
	        departmentForm.setPageCount(IMakeDevUtils.calculatePage(departmentForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstDepartments", vresultMessage.getResultListObj());
	        model.addAttribute("departmentForm", departmentForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/department_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  DepartmentForm departmentForm = null;
	        if(model.containsAttribute("departmentForm"))
	        	departmentForm = (DepartmentForm)model.asMap().get("departmentForm");
	        else
	        	departmentForm = new DepartmentForm();
	        departmentForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstDepartment pstDepartment = pstService.findPstDepartmentById(Long.parseLong(maId));
	        departmentForm.setPstDepartment(pstDepartment);
	        model.addAttribute("departmentForm", departmentForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/department_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="departmentForm") DepartmentForm departmentForm, BindingResult result, Model model)
	    {
	        String mode = departmentForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstDepartment(departmentForm.getPstDepartment());
	                departmentForm.getPstDepartment().setPdId(id);
	                departmentForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstDepartment(departmentForm.getPstDepartment());
	                id = departmentForm.getPstDepartment().getPdId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        departmentForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("departmentForm", departmentForm);*/
	       // departmentForm departmentForm = null; 
	       departmentForm = new DepartmentForm(); 
	       departmentForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       departmentForm.getPstDepartment().setPagging(departmentForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstDepartment(departmentForm.getPstDepartment());
		        model.addAttribute("pstDepartments", vresultMessage.getResultListObj());
		        departmentForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        departmentForm.setPageCount(IMakeDevUtils.calculatePage(departmentForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("departmentForm", departmentForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/department_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  DepartmentForm departmentForm = new DepartmentForm(); 
		  departmentForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("departmentForm", departmentForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/department_management";
	    }

}
