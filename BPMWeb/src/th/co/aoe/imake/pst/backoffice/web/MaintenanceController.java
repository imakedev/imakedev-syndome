package th.co.aoe.imake.pst.backoffice.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import th.co.aoe.imake.pst.backoffice.service.PSTService;

@Controller
@RequestMapping(value={"/maintenance"})
public class MaintenanceController {
	@Autowired
	private PSTService pstService;
	@RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	public String init(Model model)
	    {
	       // return "backoffice/template/maintenance_check_search";
		  return "backoffice/template/empty";
	    }
	@RequestMapping(value={"/page/{pagename}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String page(Model model,@PathVariable String pagename)
	    {
	       return "backoffice/template/"+pagename;
		 // return "backoffice/template/empty";
	    }
	@RequestMapping(value={"/history/{prpId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String page(Model model,@PathVariable Long prpId)
	    {
		   model.addAttribute("pstRoadPump", pstService.findPstRoadPumpById(prpId));
	       return "backoffice/template/maintenance_roadpump_history";
		 
	    }
	  @RequestMapping(value={"/item/{prpId}/{checkTime}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET}) 
	 public String getItem(Model model,@PathVariable Long prpId,@PathVariable String checkTime)
	    { 
			model.addAttribute("prpId", prpId);
			model.addAttribute("pstRoadPump", pstService.findPstRoadPumpById(prpId));
			model.addAttribute("checkTime", checkTime);
			model.addAttribute("mode","edit");
	       return "backoffice/template/maintenance_roadpump_management";
		 
	    } 
	@RequestMapping(value={"/new/{prpId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String getNewForm(Model model,@PathVariable Long prpId)
	    {  
			model.addAttribute("prpId",prpId);
			model.addAttribute("mode","add");
			model.addAttribute("pstRoadPump", pstService.findPstRoadPumpById(prpId));
			model.addAttribute("checkTime","");
	       return "backoffice/template/maintenance_roadpump_management";
		 
	    }
}
