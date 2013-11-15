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
import th.co.aoe.imake.pst.xstream.PstCost;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.CostForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/costs"})
@SessionAttributes(value={"costForm"})
public class CostsController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 CostForm costForm =  new CostForm();
		 costForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 costForm.getPstCost().setPagging(costForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCost(costForm.getPstCost());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstCosts", vresultMessage.getResultListObj());
	        costForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        costForm.setPageCount(IMakeDevUtils.calculatePage(costForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("costForm", costForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/costs_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="costForm") CostForm costForm, BindingResult result, Model model)
	    {
	        String mode = costForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	costForm.getPstCost().setIds(costForm.getPcIdArray());
	        	pstService.deletePstCost(costForm.getPstCost(), ServiceConstant.PST_COST_ITEMS_DELETE);
	        	costForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstCost(costForm.getPstCost(),  ServiceConstant.PST_COST_DELETE);
	        	costForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("costForm"))
	            	costForm = (CostForm)model.asMap().get("costForm");
	            else
	            	costForm = new CostForm();
	        }
	        costForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        costForm.getPstCost().setPagging(costForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCost(costForm.getPstCost());
	       
	        costForm.setPageCount(IMakeDevUtils.calculatePage(costForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstCosts", vresultMessage.getResultListObj());
	        model.addAttribute("costForm", costForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/costs_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  CostForm costForm = null;
	        if(model.containsAttribute("costForm"))
	        	costForm = (CostForm)model.asMap().get("costForm");
	        else
	        	costForm = new CostForm();
	        costForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstCost pstCost = pstService.findPstCostById(Long.parseLong(maId));
	        costForm.setPstCost(pstCost);
	        model.addAttribute("costForm", costForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/costs_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="costForm") CostForm costForm, BindingResult result, Model model)
	    {
	        String mode = costForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstCost(costForm.getPstCost());
	                costForm.getPstCost().setPcId(id);
	                costForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstCost(costForm.getPstCost());
	                id = costForm.getPstCost().getPcId();
	                message = "Update success !";
	                message_class="success";
	            }
	      /* PstCost pstCost = pstService.findPstCostById(id);
	       costForm.setPstCost(pstCost);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("costForm", costForm);*/
	        costForm =  new CostForm();
			 costForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
			 costForm.getPstCost().setPagging(costForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCost(costForm.getPstCost());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstCosts", vresultMessage.getResultListObj());
		        costForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        costForm.setPageCount(IMakeDevUtils.calculatePage(costForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("costForm", costForm);
		        model.addAttribute("message", message);
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/costs_search";
	       // return "backoffice/template/costs_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  CostForm costForm = new CostForm(); 
		  costForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("costForm", costForm);
	        model.addAttribute("display", "display: none");   
	        return "backoffice/template/costs_management";
	    }
}
