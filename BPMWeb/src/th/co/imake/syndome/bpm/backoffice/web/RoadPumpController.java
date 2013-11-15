package th.co.imake.syndome.bpm.backoffice.web;

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

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstRoadPump;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.RoadPumpForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/roadpump"})
@SessionAttributes(value={"roadPumpForm"}) 
public class RoadPumpController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 RoadPumpForm roadPumpForm =  new RoadPumpForm();
		 roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 roadPumpForm.getPstRoadPump().setPagging(roadPumpForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPump(roadPumpForm.getPstRoadPump());
	      //  logger.debug("vresultMessage="+vresultMessage);
	       // logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstRoadPumps", vresultMessage.getResultListObj());
	        roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        @SuppressWarnings("rawtypes")
	        List list=pstService.listPstRoadPumpStatuses();
	        model.addAttribute("pstRoadPumpStatuses",list);
	        //logger.info("list==>"+list);
	        model.addAttribute("roadPumpForm", roadPumpForm);
	        return "backoffice/template/road_pump_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="roadPumpForm") RoadPumpForm roadPumpForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	roadPumpForm.getPstRoadPump().setIds(roadPumpForm.getPrpIdArray());
	        	pstService.deletePstRoadPump(roadPumpForm.getPstRoadPump(), ServiceConstant.PST_ROAD_PUMP_ITEMS_DELETE);
	        	roadPumpForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstRoadPump(roadPumpForm.getPstRoadPump(),  ServiceConstant.PST_ROAD_PUMP_DELETE);
	        	roadPumpForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("roadPumpForm"))
	            	roadPumpForm = (RoadPumpForm)model.asMap().get("roadPumpForm");
	            else
	            	roadPumpForm = new RoadPumpForm();
	        }
	        roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        roadPumpForm.getPstRoadPump().setPagging(roadPumpForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstRoadPump(roadPumpForm.getPstRoadPump());
	       
	        roadPumpForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstRoadPumps", vresultMessage.getResultListObj());
	        model.addAttribute("roadPumpForm", roadPumpForm);
	        model.addAttribute("pstRoadPumpStatuses", pstService.listPstRoadPumpStatuses());
	        model.addAttribute("message", "");
	        model.addAttribute("message_class", "");
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/road_pump_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  RoadPumpForm roadPumpForm = null;
	        if(model.containsAttribute("roadPumpForm"))
	        	roadPumpForm = (RoadPumpForm)model.asMap().get("roadPumpForm");
	        else
	        	roadPumpForm = new RoadPumpForm();
	        roadPumpForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstRoadPump pstRoadPump = pstService.findPstRoadPumpById(Long.parseLong(maId));
	        roadPumpForm.setPstRoadPump(pstRoadPump);
	        PstRoadPump pstRoadPumpMaster= pstService.listPstRoadPumpMaster();
	        logger.info("xxx"+pstRoadPumpMaster);
	        model.addAttribute("pstRoadPumpStatusList", pstRoadPumpMaster.getPstRoadPumpStatusList());
	        model.addAttribute("pstRoadPumpTypeList", pstRoadPumpMaster.getPstRoadPumpTypeList());
	        model.addAttribute("pstBrandRoadList", pstRoadPumpMaster.getPstBrandRoadList());
	        model.addAttribute("pstBrandPumpList", pstRoadPumpMaster.getPstBrandPumpList());
	        model.addAttribute("pstModelRoadList", pstRoadPumpMaster.getPstModelRoadList());
	        model.addAttribute("pstModelPumpList", pstRoadPumpMaster.getPstModelPumpList());
	        model.addAttribute("roadPumpForm", roadPumpForm);
	        model.addAttribute("display", "display: none");
	        /*  roadPumpForm =  new RoadPumpForm();
			 roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
			 roadPumpForm.getPstRoadPump().setPagging(roadPumpForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstRoadPump(roadPumpForm.getPstRoadPump()); 
		        model.addAttribute("pstRoadPumps", vresultMessage.getResultListObj());
		        roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        roadPumpForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		      
		        model.addAttribute("pstRoadPumpStatuses",pstService.listPstRoadPumpStatuses());
		     
		        model.addAttribute("roadPumpForm", roadPumpForm);
		        return "backoffice/template/road_pump_search";*/
	        return "backoffice/template/road_pump_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="roadPumpForm") RoadPumpForm roadPumpForm, BindingResult result, Model model)
	    {
	        String mode = roadPumpForm.getMode();
	        String message = "";
	        String message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstRoadPump(roadPumpForm.getPstRoadPump());
	                roadPumpForm.getPstRoadPump().setPrpId(id);
	                roadPumpForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstRoadPump(roadPumpForm.getPstRoadPump());
	                id = roadPumpForm.getPstRoadPump().getPrpId();
	                message = "Update success !";
	                message_class="success";
	            }
	       roadPumpForm =  new RoadPumpForm();
			 roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
			 roadPumpForm.getPstRoadPump().setPagging(roadPumpForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstRoadPump(roadPumpForm.getPstRoadPump()); 
		        model.addAttribute("pstRoadPumps", vresultMessage.getResultListObj());
		        roadPumpForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        roadPumpForm.setPageCount(IMakeDevUtils.calculatePage(roadPumpForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		      
		        model.addAttribute("pstRoadPumpStatuses",pstService.listPstRoadPumpStatuses());
		        model.addAttribute("message", message);
		        model.addAttribute("message_class", message_class);
		        model.addAttribute("display", "display: none");
		        model.addAttribute("roadPumpForm", roadPumpForm);
		        return "backoffice/template/road_pump_search";
	     /*  PstRoadPump pstRoadPump = pstService.findPstRoadPumpById(id);
	       roadPumpForm.setPstRoadPump(pstRoadPump);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        PstRoadPump pstRoadPumpMaster= pstService.listPstRoadPumpMaster();
	        
	        model.addAttribute("pstRoadPumpStatusList", pstRoadPumpMaster.getPstRoadPumpStatusList());
	        model.addAttribute("pstRoadPumpTypeList", pstRoadPumpMaster.getPstRoadPumpTypeList());
	        model.addAttribute("pstBrandRoadList", pstRoadPumpMaster.getPstBrandRoadList());
	        model.addAttribute("pstBrandPumpList", pstRoadPumpMaster.getPstBrandPumpList());
	        model.addAttribute("pstModelRoadList", pstRoadPumpMaster.getPstModelRoadList());
	        model.addAttribute("pstModelPumpList", pstRoadPumpMaster.getPstModelPumpList());
	        model.addAttribute("roadPumpForm", roadPumpForm);
	        return "backoffice/template/road_pump_management";*/
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  RoadPumpForm roadPumpForm = new RoadPumpForm(); 
		  roadPumpForm.setMode(IMakeDevUtils.MODE_NEW);
		   PstRoadPump pstRoadPumpMaster= pstService.listPstRoadPumpMaster();
	        logger.info("xxx"+pstRoadPumpMaster);
	        model.addAttribute("pstRoadPumpStatusList", pstRoadPumpMaster.getPstRoadPumpStatusList());
	        model.addAttribute("pstRoadPumpTypeList", pstRoadPumpMaster.getPstRoadPumpTypeList());
	        model.addAttribute("pstBrandRoadList", pstRoadPumpMaster.getPstBrandRoadList());
	        model.addAttribute("pstBrandPumpList", pstRoadPumpMaster.getPstBrandPumpList());
	        model.addAttribute("pstModelRoadList", pstRoadPumpMaster.getPstModelRoadList());
	        model.addAttribute("pstModelPumpList", pstRoadPumpMaster.getPstModelPumpList());
		  model.addAttribute("roadPumpForm", roadPumpForm);
	        model.addAttribute("display", "display: none");   
	        return "backoffice/template/road_pump_management";
	    }
}
