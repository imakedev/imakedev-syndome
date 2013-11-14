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

import th.co.aoe.imake.pst.backoffice.form.ModelForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstModel;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
@Controller
@RequestMapping(value={"/model"})
@SessionAttributes(value={"modelForm"})
public class ModelController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 ModelForm modelForm = null;
		 if(model.containsAttribute("modelForm")){ 
			 modelForm= (ModelForm)model.asMap().get("modelForm"); 
			 if(modelForm.getPstModel().getPmType()==null)
				 	modelForm.getPstModel().setPmType("1");
	        }else{
	         modelForm= new ModelForm();
	         modelForm.getPstModel().setPmType("1");
	        }
		 
	        
		 modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 modelForm.getPstModel().setPagging(modelForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstModel(modelForm.getPstModel());
	      
	        model.addAttribute("pstModels", vresultMessage.getResultListObj());
	        modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        modelForm.setPageCount(IMakeDevUtils.calculatePage(modelForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("modelForm", modelForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/model_head";
	    }
	 @RequestMapping(value={"/search/{pmType}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="modelForm") ModelForm modelForm, BindingResult result, Model model,
	    		@PathVariable String pmType)
	    { 
	        String page="model_search_section";  
	        modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        modelForm.getPaging().setPageNo(1);
	        modelForm.getPstModel().setPagging(modelForm.getPaging());
	        modelForm.getPstModel().setPmType(pmType);
	        VResultMessage vresultMessage = pstService.searchPstModel(modelForm.getPstModel());
	       
	        modelForm.setPageCount(IMakeDevUtils.calculatePage(modelForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstModels", vresultMessage.getResultListObj());
	        model.addAttribute("modelForm", modelForm); 
	        model.addAttribute("message", ""); 
	        return "backoffice/template/"+page;
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="modelForm") ModelForm modelForm, BindingResult result, Model model)
	    {
	        String mode = modelForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	modelForm.getPstModel().setIds(modelForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(modelForm.getPstModel(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	modelForm.getPaging().setPageNo(1);
	        } else*/
	        String page="model_search_section";
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstModel(modelForm.getPstModel(),  ServiceConstant.PST_MODEL_DELETE);
	        	modelForm.getPaging().setPageNo(1);
	        	page="model_head";
	        	modelForm.setMode(null);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("modelForm"))
	            	modelForm = (ModelForm)model.asMap().get("modelForm");
	            else
	            	modelForm = new ModelForm();
	        }
	        modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        modelForm.getPstModel().setPagging(modelForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstModel(modelForm.getPstModel());
	       
	        modelForm.setPageCount(IMakeDevUtils.calculatePage(modelForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstModels", vresultMessage.getResultListObj());
	        model.addAttribute("modelForm", modelForm);
	        
	        model.addAttribute("message", ""); 
	        return "backoffice/template/"+page;
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  ModelForm modelForm = null;
	        if(model.containsAttribute("modelForm"))
	        	modelForm = (ModelForm)model.asMap().get("modelForm");
	        else
	        	modelForm = new ModelForm();
	        modelForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstModel pstModel = pstService.findPstModelById(Long.parseLong(maId));
	        modelForm.setPstModel(pstModel);
	        model.addAttribute("modelForm", modelForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/model_management_section";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="modelForm") ModelForm modelForm, BindingResult result, Model model)
	    {
	        String mode = modelForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstModel(modelForm.getPstModel());
	                modelForm.getPstModel().setPmId(id);
	                modelForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstModel(modelForm.getPstModel());
	                id = modelForm.getPstModel().getPmId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        modelForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("modelForm", modelForm);*/
	       // modelForm modelForm = null; 
	     /*  modelForm = new ModelForm(); 
	       modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       modelForm.getPstModel().setPagging(modelForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstModel(modelForm.getPstModel());
		        model.addAttribute("pstModels", vresultMessage.getResultListObj());
		        modelForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        modelForm.setPageCount(IMakeDevUtils.calculatePage(modelForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));*/
		        model.addAttribute("modelForm", modelForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/model_search_section";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  ModelForm modelForm = new ModelForm(); 
		  modelForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("modelForm", modelForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/model_management_section";
	    }

}
