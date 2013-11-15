package th.co.imake.syndome.bpm.backoffice.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.EmployeeWorkMappingForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/employeeWorkMapping"})
@SessionAttributes(value={"employeeWorkMappingForm"})
public class EmployeeWorkMappingController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 EmployeeWorkMappingForm employeeWorkMappingForm = null;
	      /*  if(model.containsAttribute("employeeWorkMappingForm"))
	        	employeeWorkMappingForm = (EmployeeWorkMappingForm)model.asMap().get("employeeWorkMappingForm");
	        else*/
		 employeeWorkMappingForm = new EmployeeWorkMappingForm();
	        
		 employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(employeeWorkMappingForm.getPaging());
		 employeeWorkMappingForm.getPstEmployeeWorkMapping().setPewmDateTime(new Date());
	        VResultMessage vresultMessage = pstService.searchPstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        
	        model.addAttribute("pstEmployeeWorkMappings", vresultMessage.getResultListObj());
	        employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        employeeWorkMappingForm.setPageCount(IMakeDevUtils.calculatePage(employeeWorkMappingForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        employeeWorkMappingForm.setPewmDateTime(format1.format(new Date()));
	        model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        model.addAttribute("pstEmployeeStatuses", pstService.listPstEmployeeStatuses()); 
	        model.addAttribute("message", ""); 
	       // if( != null && missCandidate.getMcaBirthDate() != null)
	        
	        return "backoffice/template/employee_check";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="employeeWorkMappingForm") EmployeeWorkMappingForm employeeWorkMappingForm, BindingResult result, Model model)
	    {
	        String mode = employeeWorkMappingForm.getMode();
	        String message = "";
	        String  message_class="";
	        /*if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	employeeWorkMappingForm.getPstEmployeeWorkMapping().setIds(employeeWorkMappingForm.getPbdIdArray());
	        	pstService.deletePstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping(), ServiceConstant.PST_BREAK_DOWN_ITEMS_DELETE);
	        	employeeWorkMappingForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping(),  ServiceConstant.PST_BREAK_DOWN_DELETE);
	        	employeeWorkMappingForm.getPaging().setPageNo(1);
	        }*/
	      
	          if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("employeeWorkMappingForm"))
	            	employeeWorkMappingForm = (EmployeeWorkMappingForm)model.asMap().get("employeeWorkMappingForm");
	            else
	            	employeeWorkMappingForm = new EmployeeWorkMappingForm();
	        }
	          employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(employeeWorkMappingForm.getPaging());
		        if(employeeWorkMappingForm != null && employeeWorkMappingForm.getPewmDateTime() != null
		        		&& employeeWorkMappingForm.getPewmDateTime().length()>0)
					try {
						employeeWorkMappingForm.getPstEmployeeWorkMapping().setPewmDateTime(format1.parse(employeeWorkMappingForm.getPewmDateTime()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		        
	         if(mode.equals(IMakeDevUtils.MODE_EDIT))
            { 
	  	  employeeWorkMappingForm.getPstEmployeeWorkMapping().setPeIds(employeeWorkMappingForm.getPeIds());
	  	  employeeWorkMappingForm.getPstEmployeeWorkMapping().setPrpNos(employeeWorkMappingForm.getPrpNos());
	  	  employeeWorkMappingForm.getPstEmployeeWorkMapping().setPesIds(employeeWorkMappingForm.getPesIds());
            	pstService.setPstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
               // id = employeeWorkMappingForm.getPstEmployeeWorkMapping().getUpdateRecord();
                message = "Update success !";
                message_class="success";
            }
	        employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        
	        
	        VResultMessage vresultMessage = pstService.searchPstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
	       
	        employeeWorkMappingForm.setPageCount(IMakeDevUtils.calculatePage(employeeWorkMappingForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstEmployeeWorkMappings", vresultMessage.getResultListObj());
	     // if( != null && missCandidate.getMcaBirthDate() != null) 
	        model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        model.addAttribute("pstEmployeeStatuses", pstService.listPstEmployeeStatuses()); 
	        model.addAttribute("message", message); 
	        model.addAttribute("message_class", message_class);
	        return "backoffice/template/employee_check";
	    }
	  /*@RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  EmployeeWorkMappingForm employeeWorkMappingForm = null;
	        if(model.containsAttribute("employeeWorkMappingForm"))
	        	employeeWorkMappingForm = (EmployeeWorkMappingForm)model.asMap().get("employeeWorkMappingForm");
	        else
	        	employeeWorkMappingForm = new EmployeeWorkMappingForm();
	        employeeWorkMappingForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstEmployeeWorkMapping pstEmployeeWorkMapping = pstService.findPstEmployeeWorkMappingById(Long.parseLong(maId));
	        employeeWorkMappingForm.setPstEmployeeWorkMapping(pstEmployeeWorkMapping);
	        model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/break_down_management";
	    }*/
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="employeeWorkMappingForm") EmployeeWorkMappingForm employeeWorkMappingForm, BindingResult result, Model model)
	    {
	        String mode = employeeWorkMappingForm.getMode();
	        String message = "";
	        String  message_class="";
	        mode="edit";
	       // Long id = null;
	       
	       if(mode != null)
	          /*  if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
	                employeeWorkMappingForm.getPstEmployeeWorkMapping().setPbdId(id);
	                employeeWorkMappingForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else*/
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	if(employeeWorkMappingForm != null && employeeWorkMappingForm.getPewmDateTime() != null
			        		&& employeeWorkMappingForm.getPewmDateTime().length()>0)
						try {
							employeeWorkMappingForm.getPstEmployeeWorkMapping().setPewmDateTime(format1.parse(employeeWorkMappingForm.getPewmDateTime()));
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
			        
	            	pstService.setPstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
	               // id = employeeWorkMappingForm.getPstEmployeeWorkMapping().getUpdateRecord();
	                message = "Update success !";
	                message_class="success";
	            } 
	        /*PstEmployeeWorkMapping pstEmployeeWorkMapping = pstService.findPstEmployeeWorkMappingById(id);
	        employeeWorkMappingForm.setPstEmployeeWorkMapping(pstEmployeeWorkMapping);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);*/
	       // EmployeeWorkMappingForm employeeWorkMappingForm = null; 
	       employeeWorkMappingForm = new EmployeeWorkMappingForm(); 
	       employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(employeeWorkMappingForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstEmployeeWorkMapping(employeeWorkMappingForm.getPstEmployeeWorkMapping());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstEmployeeWorkMappings", vresultMessage.getResultListObj());
		        employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        employeeWorkMappingForm.setPageCount(IMakeDevUtils.calculatePage(employeeWorkMappingForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
		        model.addAttribute("pstEmployeeStatuses", pstService.listPstEmployeeStatuses()); 
		        return "backoffice/template/employee_check";
	        // return "backoffice/template/break_down_management";
	    }
	 /* @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  EmployeeWorkMappingForm employeeWorkMappingForm = new EmployeeWorkMappingForm(); 
		  employeeWorkMappingForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
	        model.addAttribute("display", "display: none");   
	        return "backoffice/template/break_down_management";
	    }*/

}
