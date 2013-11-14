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

import th.co.aoe.imake.pst.backoffice.form.PositionForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstPosition;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/position"})
@SessionAttributes(value={"positionForm"})
public class PositionController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 PositionForm positionForm =  new PositionForm();
	        
		 positionForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 positionForm.getPstPosition().setPagging(positionForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstPosition(positionForm.getPstPosition());
	      
	        model.addAttribute("pstPositions", vresultMessage.getResultListObj());
	        positionForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        positionForm.setPageCount(IMakeDevUtils.calculatePage(positionForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("positionForm", positionForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/position_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="positionForm") PositionForm positionForm, BindingResult result, Model model)
	    {
	        String mode = positionForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	positionForm.getPstPosition().setIds(positionForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(positionForm.getPstPosition(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	positionForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstPosition(positionForm.getPstPosition(),  ServiceConstant.PST_POSITION_DELETE);
	        	positionForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("positionForm"))
	            	positionForm = (PositionForm)model.asMap().get("positionForm");
	            else
	            	positionForm = new PositionForm();
	        }
	        positionForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        positionForm.getPstPosition().setPagging(positionForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstPosition(positionForm.getPstPosition());
	       
	        positionForm.setPageCount(IMakeDevUtils.calculatePage(positionForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstPositions", vresultMessage.getResultListObj());
	        model.addAttribute("positionForm", positionForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/position_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  PositionForm positionForm = null;
	        if(model.containsAttribute("positionForm"))
	        	positionForm = (PositionForm)model.asMap().get("positionForm");
	        else
	        	positionForm = new PositionForm();
	        positionForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstPosition pstPosition = pstService.findPstPositionById(Long.parseLong(maId));
	        positionForm.setPstPosition(pstPosition);
	        model.addAttribute("positionForm", positionForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/position_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="positionForm") PositionForm positionForm, BindingResult result, Model model)
	    {
	        String mode = positionForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstPosition(positionForm.getPstPosition());
	                positionForm.getPstPosition().setPpId(id);
	                positionForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstPosition(positionForm.getPstPosition());
	                id = positionForm.getPstPosition().getPpId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        positionForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("positionForm", positionForm);*/
	       // positionForm positionForm = null; 
	       positionForm = new PositionForm(); 
	       positionForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       positionForm.getPstPosition().setPagging(positionForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstPosition(positionForm.getPstPosition());
		        model.addAttribute("pstPositions", vresultMessage.getResultListObj());
		        positionForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        positionForm.setPageCount(IMakeDevUtils.calculatePage(positionForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("positionForm", positionForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/position_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  PositionForm positionForm = new PositionForm(); 
		  positionForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("positionForm", positionForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/position_management";
	    }
}
