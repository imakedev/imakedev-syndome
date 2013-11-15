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
import th.co.aoe.imake.pst.xstream.PstConcrete;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.ConcreteForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;
@Controller
@RequestMapping(value={"/concrete"})
@SessionAttributes(value={"concreteForm"})
public class ConcreteController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 ConcreteForm concreteForm =  new ConcreteForm();
	        
		 concreteForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 concreteForm.getPstConcrete().setPagging(concreteForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstConcrete(concreteForm.getPstConcrete());
	        //System.out.println("vresultMessage-->"+vresultMessage.getResultListObj());
	        model.addAttribute("pstConcretes", vresultMessage.getResultListObj());
	        concreteForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        concreteForm.setPageCount(IMakeDevUtils.calculatePage(concreteForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("concreteForm", concreteForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/concrete_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="concreteForm") ConcreteForm concreteForm, BindingResult result, Model model)
	    {
	        String mode = concreteForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	concreteForm.getPstConcrete().setIds(concreteForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(concreteForm.getPstConcrete(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	concreteForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstConcrete(concreteForm.getPstConcrete(),  ServiceConstant.PST_CONCRETE_DELETE);
	        	concreteForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("concreteForm"))
	            	concreteForm = (ConcreteForm)model.asMap().get("concreteForm");
	            else
	            	concreteForm = new ConcreteForm();
	        }
	        concreteForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        concreteForm.getPstConcrete().setPagging(concreteForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstConcrete(concreteForm.getPstConcrete());
	       
	        concreteForm.setPageCount(IMakeDevUtils.calculatePage(concreteForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstConcretes", vresultMessage.getResultListObj());
	        model.addAttribute("concreteForm", concreteForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/concrete_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  ConcreteForm concreteForm = null;
	        if(model.containsAttribute("concreteForm"))
	        	concreteForm = (ConcreteForm)model.asMap().get("concreteForm");
	        else
	        	concreteForm = new ConcreteForm();
	        concreteForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstConcrete pstConcrete = pstService.findPstConcreteById(Long.parseLong(maId));
	        concreteForm.setPstConcrete(pstConcrete);
	        model.addAttribute("concreteForm", concreteForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/concrete_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="concreteForm") ConcreteForm concreteForm, BindingResult result, Model model)
	    {
	        String mode = concreteForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstConcrete(concreteForm.getPstConcrete());
	                concreteForm.getPstConcrete().setPconcreteId(id);
	                concreteForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstConcrete(concreteForm.getPstConcrete());
	                id = concreteForm.getPstConcrete().getPconcreteId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        concreteForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("concreteForm", concreteForm);*/
	       // concreteForm concreteForm = null; 
	       concreteForm = new ConcreteForm(); 
	       concreteForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       concreteForm.getPstConcrete().setPagging(concreteForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstConcrete(concreteForm.getPstConcrete());
		        model.addAttribute("pstConcretes", vresultMessage.getResultListObj());
		        concreteForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        concreteForm.setPageCount(IMakeDevUtils.calculatePage(concreteForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("concreteForm", concreteForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/concrete_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  ConcreteForm concreteForm = new ConcreteForm(); 
		  concreteForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("concreteForm", concreteForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/concrete_management";
	    }

}
