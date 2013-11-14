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

import th.co.aoe.imake.pst.backoffice.form.BreakdownForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstBreakDown;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/breakdown"})
@SessionAttributes(value={"breakdownForm"})
public class BreakDownController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 BreakdownForm breakdownForm = null;
	      /*  if(model.containsAttribute("breakdownForm"))
	        	breakdownForm = (BreakdownForm)model.asMap().get("breakdownForm");
	        else*/
	        	breakdownForm = new BreakdownForm();
	        
	        breakdownForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        breakdownForm.getPstBreakDown().setPagging(breakdownForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstBreakDown(breakdownForm.getPstBreakDown());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstBreakDowns", vresultMessage.getResultListObj());
	        breakdownForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        breakdownForm.setPageCount(IMakeDevUtils.calculatePage(breakdownForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("breakdownForm", breakdownForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/break_down_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="breakdownForm") BreakdownForm breakdownForm, BindingResult result, Model model)
	    {
	        String mode = breakdownForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	breakdownForm.getPstBreakDown().setIds(breakdownForm.getPbdIdArray());
	        	pstService.deletePstBreakDown(breakdownForm.getPstBreakDown(), ServiceConstant.PST_BREAK_DOWN_ITEMS_DELETE);
	            breakdownForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstBreakDown(breakdownForm.getPstBreakDown(),  ServiceConstant.PST_BREAK_DOWN_DELETE);
	            breakdownForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("breakdownForm"))
	            	breakdownForm = (BreakdownForm)model.asMap().get("breakdownForm");
	            else
	            	breakdownForm = new BreakdownForm();
	        }
	        breakdownForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        breakdownForm.getPstBreakDown().setPagging(breakdownForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstBreakDown(breakdownForm.getPstBreakDown());
	       
	        breakdownForm.setPageCount(IMakeDevUtils.calculatePage(breakdownForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstBreakDowns", vresultMessage.getResultListObj());
	        model.addAttribute("breakdownForm", breakdownForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/break_down_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  BreakdownForm breakdownForm = null;
	        if(model.containsAttribute("breakdownForm"))
	        	breakdownForm = (BreakdownForm)model.asMap().get("breakdownForm");
	        else
	        	breakdownForm = new BreakdownForm();
	        breakdownForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstBreakDown pstBreakDown = pstService.findPstBreakDownById(Long.parseLong(maId));
	        breakdownForm.setPstBreakDown(pstBreakDown);
	        model.addAttribute("breakdownForm", breakdownForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/break_down_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="breakdownForm") BreakdownForm breakdownForm, BindingResult result, Model model)
	    {
	        String mode = breakdownForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstBreakDown(breakdownForm.getPstBreakDown());
	                breakdownForm.getPstBreakDown().setPbdId(id);
	                breakdownForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstBreakDown(breakdownForm.getPstBreakDown());
	                id = breakdownForm.getPstBreakDown().getPbdId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstBreakDown pstBreakDown = pstService.findPstBreakDownById(id);
	        breakdownForm.setPstBreakDown(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("breakdownForm", breakdownForm);*/
	       // BreakdownForm breakdownForm = null; 
		        	breakdownForm = new BreakdownForm(); 
		        breakdownForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        breakdownForm.getPstBreakDown().setPagging(breakdownForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstBreakDown(breakdownForm.getPstBreakDown());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstBreakDowns", vresultMessage.getResultListObj());
		        breakdownForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        breakdownForm.setPageCount(IMakeDevUtils.calculatePage(breakdownForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("breakdownForm", breakdownForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/break_down_search";
	        // return "backoffice/template/break_down_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  BreakdownForm breakdownForm = new BreakdownForm(); 
		  breakdownForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("breakdownForm", breakdownForm);
	        model.addAttribute("display", "display: none");   
	        return "backoffice/template/break_down_management";
	    }
}
