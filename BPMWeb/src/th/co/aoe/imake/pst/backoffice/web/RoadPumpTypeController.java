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

import th.co.aoe.imake.pst.backoffice.form.RoadPumpTypeForm;
import th.co.aoe.imake.pst.backoffice.service.PSTService;
import th.co.aoe.imake.pst.backoffice.utils.IMakeDevUtils;
import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstRoadPumpType;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/roadPumpType"})
@SessionAttributes(value={"roadPumpTypeForm"})
public class RoadPumpTypeController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 RoadPumpTypeForm roadPumpTypeForm =  new RoadPumpTypeForm();
	        
		 roadPumpTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 roadPumpTypeForm.getPstRoadPumpType().setPagging(roadPumpTypeForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType());
	      
	        model.addAttribute("pstRoadPumpTypes", vresultMessage.getResultListObj());
	        roadPumpTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpTypeForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/roadPumpType_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="roadPumpTypeForm") RoadPumpTypeForm roadPumpTypeForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpTypeForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	roadPumpTypeForm.getPstRoadPumpType().setIds(roadPumpTypeForm.getPesIdArray());
	        	pstService.deletePstEmployeeType(roadPumpTypeForm.getPstRoadPumpType(), ServiceConstant.PST_EMPLOYEE_TYPE_ITEMS_DELETE);
	        	roadPumpTypeForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType(),  ServiceConstant.PST_ROAD_PUMP_TYPE_DELETE);
	        	roadPumpTypeForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("roadPumpTypeForm"))
	            	roadPumpTypeForm = (RoadPumpTypeForm)model.asMap().get("roadPumpTypeForm");
	            else
	            	roadPumpTypeForm = new RoadPumpTypeForm();
	        }
	        roadPumpTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpTypeForm.getPstRoadPumpType().setPagging(roadPumpTypeForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType());
	       
	        roadPumpTypeForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstRoadPumpTypes", vresultMessage.getResultListObj());
	        model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/roadPumpType_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  RoadPumpTypeForm roadPumpTypeForm = null;
	        if(model.containsAttribute("roadPumpTypeForm"))
	        	roadPumpTypeForm = (RoadPumpTypeForm)model.asMap().get("roadPumpTypeForm");
	        else
	        	roadPumpTypeForm = new RoadPumpTypeForm();
	        roadPumpTypeForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstRoadPumpType pstRoadPumpType = pstService.findPstRoadPumpTypeById(Long.parseLong(maId));
	        roadPumpTypeForm.setPstRoadPumpType(pstRoadPumpType);
	        model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/roadPumpType_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="roadPumpTypeForm") RoadPumpTypeForm roadPumpTypeForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpTypeForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType());
	                roadPumpTypeForm.getPstRoadPumpType().setPrptId(id);
	                roadPumpTypeForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType());
	                id = roadPumpTypeForm.getPstRoadPumpType().getPrptId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeType pstBreakDown = pstService.findPstEmployeeTypeById(id);
	        roadPumpTypeForm.setPstEmployeeType(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);*/
	       // roadPumpTypeForm roadPumpTypeForm = null; 
	       roadPumpTypeForm = new RoadPumpTypeForm(); 
	       roadPumpTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       roadPumpTypeForm.getPstRoadPumpType().setPagging(roadPumpTypeForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstRoadPumpType(roadPumpTypeForm.getPstRoadPumpType());
		        model.addAttribute("pstRoadPumpTypes", vresultMessage.getResultListObj());
		        roadPumpTypeForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        roadPumpTypeForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpTypeForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/roadPumpType_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  RoadPumpTypeForm roadPumpTypeForm = new RoadPumpTypeForm(); 
		  roadPumpTypeForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("roadPumpTypeForm", roadPumpTypeForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/roadPumpType_management";
	    }
}
