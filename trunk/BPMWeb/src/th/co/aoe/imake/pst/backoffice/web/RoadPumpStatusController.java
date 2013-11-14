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

import th.co.aoe.imake.pst.backoffice.form.RoadPumpStatusForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstRoadPumpStatus;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/roadPumpStatus"})
@SessionAttributes(value={"roadPumpStatusForm"})
public class RoadPumpStatusController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 RoadPumpStatusForm roadPumpStatusForm =  new RoadPumpStatusForm();
	        
		 roadPumpStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 roadPumpStatusForm.getPstRoadPumpStatus().setPagging(roadPumpStatusForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus());
	      
	        model.addAttribute("pstRoadPumpStatuss", vresultMessage.getResultListObj());
	        roadPumpStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpStatusForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/roadPumpStatus_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="roadPumpStatusForm") RoadPumpStatusForm roadPumpStatusForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpStatusForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	roadPumpStatusForm.getPstRoadPumpStatus().setIds(roadPumpStatusForm.getPesIdArray());
	        	pstService.deletePstEmployeeStatus(roadPumpStatusForm.getPstRoadPumpStatus(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	roadPumpStatusForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus(),  ServiceConstant.PST_ROAD_PUMP_STATUS_DELETE);
	        	roadPumpStatusForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("roadPumpStatusForm"))
	            	roadPumpStatusForm = (RoadPumpStatusForm)model.asMap().get("roadPumpStatusForm");
	            else
	            	roadPumpStatusForm = new RoadPumpStatusForm();
	        }
	        roadPumpStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpStatusForm.getPstRoadPumpStatus().setPagging(roadPumpStatusForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus());
	       
	        roadPumpStatusForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstRoadPumpStatuss", vresultMessage.getResultListObj());
	        model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/roadPumpStatus_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  RoadPumpStatusForm roadPumpStatusForm = null;
	        if(model.containsAttribute("roadPumpStatusForm"))
	        	roadPumpStatusForm = (RoadPumpStatusForm)model.asMap().get("roadPumpStatusForm");
	        else
	        	roadPumpStatusForm = new RoadPumpStatusForm();
	        roadPumpStatusForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstRoadPumpStatus pstRoadPumpStatus = pstService.findPstRoadPumpStatusById(Long.parseLong(maId));
	        roadPumpStatusForm.setPstRoadPumpStatus(pstRoadPumpStatus);
	        model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/roadPumpStatus_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="roadPumpStatusForm") RoadPumpStatusForm roadPumpStatusForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpStatusForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus());
	                roadPumpStatusForm.getPstRoadPumpStatus().setPrpsId(id);
	                roadPumpStatusForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus());
	                id = roadPumpStatusForm.getPstRoadPumpStatus().getPrpsId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        roadPumpStatusForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);*/
	       // roadPumpStatusForm roadPumpStatusForm = null; 
	       roadPumpStatusForm = new RoadPumpStatusForm(); 
	       roadPumpStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       roadPumpStatusForm.getPstRoadPumpStatus().setPagging(roadPumpStatusForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstRoadPumpStatus(roadPumpStatusForm.getPstRoadPumpStatus());
		        model.addAttribute("pstRoadPumpStatuss", vresultMessage.getResultListObj());
		        roadPumpStatusForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        roadPumpStatusForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpStatusForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/roadPumpStatus_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  RoadPumpStatusForm roadPumpStatusForm = new RoadPumpStatusForm(); 
		  roadPumpStatusForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("roadPumpStatusForm", roadPumpStatusForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/roadPumpStatus_management";
	    }

}
