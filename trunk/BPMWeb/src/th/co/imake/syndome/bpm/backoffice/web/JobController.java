package th.co.imake.syndome.bpm.backoffice.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.PstJob;
import th.co.aoe.imake.pst.xstream.PstJobEmployee;
import th.co.aoe.imake.pst.xstream.PstJobPay;
import th.co.aoe.imake.pst.xstream.PstJobPayExt;
import th.co.aoe.imake.pst.xstream.PstJobWork;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.JobForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/job"}) 
@SessionAttributes(value={"jobForm"})
public class JobController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
	      
		 JobForm jobForm = null;
	      /*  if(model.containsAttribute("jobForm"))
	        	jobForm = (JobForm)model.asMap().get("jobForm");
	        else*/
		 jobForm = new JobForm();
	        
		 jobForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 jobForm.getPstJob().setPagging(jobForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstJob(jobForm.getPstJob());
	        logger.debug("vresultMessage="+vresultMessage);
	        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
	        model.addAttribute("pstJobs", vresultMessage.getResultListObj());
	        jobForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        jobForm.setPageCount(IMakeDevUtils.calculatePage(jobForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("jobForm", jobForm);
	        model.addAttribute("message", ""); 
	        model.addAttribute("pstConcretes", pstService.listPstConcretes());
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        
			 return "backoffice/template/job_search";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, Model model)
	    {
	        String mode = jobForm.getMode();
	        jobForm.getPstJob().setPjCreatedTime(null);
	        if(jobForm != null && jobForm.getPjCreatedTime() != null
	        		&& jobForm.getPjCreatedTime().length()>0)
				try {
					jobForm.getPstJob().setPjCreatedTime(format1.parse(jobForm.getPjCreatedTime()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	jobForm.getPstJob().setIds(jobForm.getPjIdArray());
	        	pstService.deletePstJob(jobForm.getPstJob(), ServiceConstant.PST_JOB_ITEMS_DELETE);
	        	jobForm.getPaging().setPageNo(1);
	        } else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstJob(jobForm.getPstJob(),  ServiceConstant.PST_JOB_DELETE);
	        	jobForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("jobForm"))
	            	jobForm = (JobForm)model.asMap().get("jobForm");
	            else
	            	jobForm = new JobForm();
	        }
	        jobForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        jobForm.getPstJob().setPagging(jobForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstJob(jobForm.getPstJob());
	        
	     
	        jobForm.setPageCount(IMakeDevUtils.calculatePage(jobForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstJobs", vresultMessage.getResultListObj());
	        model.addAttribute("jobForm", jobForm);
	        model.addAttribute("message", ""); 
	        model.addAttribute("pstConcretes", pstService.listPstConcretes());
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        return "backoffice/template/job_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  JobForm jobForm = null;
	        if(model.containsAttribute("jobForm"))
	        	jobForm = (JobForm)model.asMap().get("jobForm");
	        else
	        	jobForm = new JobForm();
	        jobForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstJob pstJob = pstService.findPstJobById(Long.parseLong(maId));
	        if(pstJob != null && pstJob.getPjCreatedTime() != null)    
					jobForm.setPjCreatedTime(format1.format(pstJob.getPjCreatedTime()));
				
	        jobForm.setPstJob(pstJob);
	        model.addAttribute("jobForm", jobForm);
	        model.addAttribute("display", "display: none");
	        model.addAttribute("pstConcretes", pstService.listPstConcretes());
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        try{
	        PstJob pstJobMaster= pstService.listJobMaster();
	        //logger.info("xxx"+pstRoadPumpMaster);
	        model.addAttribute("pstBreakDownList", pstJobMaster.getPstBreakDownList());
	        model.addAttribute("pstCostList", pstJobMaster.getPstCostList());
	        model.addAttribute("pstEmployeeList", pstJobMaster.getPstEmployeeList()); 
	       
	        }catch(Exception ex){
	        	ex.printStackTrace();
	        }
	        return "backoffice/template/job_manaement";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, Model model)
	    {
	        String mode = jobForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	        if(jobForm != null && jobForm.getPjCreatedTime() != null
	        		&& jobForm.getPjCreatedTime().length()>0)
				try {
					jobForm.getPstJob().setPjCreatedTime(format1.parse(jobForm.getPjCreatedTime()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        /*if(jobForm != null && jobForm.getPstJob() != null
	        		&& jobForm.getPstJob().getPstConcrete()!=null && jobForm.getPstJob().getPstConcrete().getPconcreteId()!=null)
				try {
					jobForm.getPstJob().setPjCreatedTime(format1.parse(jobForm.getPjCreatedTime()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/ 
	      /* if(jobForm.getPccId()!=null){
	    	   jobForm.getPstJob().setPccId(jobForm.getPccId());
	       }
	       if(jobForm.getPcdId()!=null){
	    	   jobForm.getPstJob().setPcdId(jobForm.getPcdId());
	       }
	       if(jobForm.getPcId()!=null){
	    	   jobForm.getPstJob().setPcId(jobForm.getPcId());
	       }*/
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstJob(jobForm.getPstJob());
	                jobForm.getPstJob().setPjId(id);
	                jobForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstJob(jobForm.getPstJob());
	                id = jobForm.getPstJob().getPjId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstJob pstJob = pstService.findPstJobById(id);
	        jobForm.setPstJob(pstJob);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("jobForm", jobForm);*/
	       // JobForm jobForm = null; 
	       jobForm = new JobForm(); 
	       jobForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       jobForm.getPstJob().setPagging(jobForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstJob(jobForm.getPstJob());
		        logger.debug("vresultMessage="+vresultMessage);
		        logger.debug("getResultListObj="+vresultMessage.getResultListObj());
		        model.addAttribute("pstJobs", vresultMessage.getResultListObj());
		        jobForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        jobForm.setPageCount(IMakeDevUtils.calculatePage(jobForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("jobForm", jobForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/job_search";
		        
	        // return "backoffice/template/job_manaement";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  JobForm jobForm = new JobForm(); 
		  jobForm.setMode(IMakeDevUtils.MODE_NEW);
		    model.addAttribute("jobForm", jobForm);
	        model.addAttribute("display", "display: none");   
	        model.addAttribute("pstConcretes", pstService.listPstConcretes());
	        model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
	        
	        PstJob pstJob= pstService.listJobMaster();
	        //logger.info("xxx"+pstRoadPumpMaster);
	        model.addAttribute("pstBreakDownList", pstJob.getPstBreakDownList());
	        model.addAttribute("pstCostList", pstJob.getPstCostList());
	        model.addAttribute("pstEmployeeList", pstJob.getPstEmployeeList()); 
	       
	        return "backoffice/template/job_manaement";
	    }
	  //PST_JOB_PAY_EXT 
	  @RequestMapping(value={"/payext_save/{part}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	  public @ResponseBody String payext(HttpServletRequest request, @PathVariable String part, @ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, Model model)
	    {
	//	 List payext=null;
		  if(part.equals("1")){
			//  jobForm.getPstJobWork();
			  jobForm.getPstJobWork().setPjId(jobForm.getPstJob().getPjId());
			  pstService.savePstJobWork(jobForm.getPstJobWork());
			 // payext= pstService.listPstJobWorks(jobForm.getPstJob().getPjId(), jobForm.getPstJobWork().getPrpId());
		  }else if(part.equals("2")){
			  jobForm.getPstJobEmployee().setPjId(jobForm.getPstJob().getPjId());
			  pstService.savePstJobEmployee(jobForm.getPstJobEmployee());
			  //payext=pstService.listPstJobEmployees(jobForm.getPstJob().getPjId(), jobForm.getPstJobEmployee().getPeId());
			//  jobForm.getPstJobEmployee();
		  }else if(part.equals("3")){
			  //jobForm.getPstJobPay();
			  jobForm.getPstJobPay().setPjId(jobForm.getPstJob().getPjId());
			  pstService.savePstJobPay(jobForm.getPstJobPay());
			 // payext=pstService.listPstJobPays(jobForm.getPstJob().getPjId(), jobForm.getPstJobPay().getPcId());
		  }else if(part.equals("4")){
			//  jobForm.getPstJobPayExt();
			  jobForm.getPstJobPayExt().setPjId(jobForm.getPstJob().getPjId());
			   pstService.savePstJobPayExt(jobForm.getPstJobPayExt());
			 
		  }
		  return part; 
	    }
	  @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value={"/payext_get/{part}/{pjId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	  public @ResponseBody List getPayExt(HttpServletRequest request, @PathVariable String part,
			  @PathVariable Long pjId,Model model)
	  //,@ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, 
	    { 
		 List returnResult=new ArrayList(2); 
		  List payext=null;
		  if(part.equals("1")){
			//  jobForm.getPstJobWork();
			  
			  payext= pstService.listPstJobWorks(pjId, null);
		  }else if(part.equals("3")){
			  //jobForm.getPstJobPay();
			  payext=pstService.listPstJobPays(pjId, null);
		  }else if(part.equals("4")){
			//  jobForm.getPstJobPayExt();   
			  payext=pstService.listPstJobPayExts(pjId, null);
		  }
		  returnResult.add(part);
		  returnResult.add(payext);
		  return returnResult; 
	    }
	  @SuppressWarnings({ "rawtypes" })
		@RequestMapping(value={"/payext_get_employee/{pjId}/{prpId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
		  public @ResponseBody List getPayExtEmployee(HttpServletRequest request, @PathVariable Long pjId,
				  @PathVariable Long prpId,Model model)
		    {  
			  	return pstService.listPstJobEmployees(pjId, null,prpId);
		    }
	  @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value={"/payext_delete/{part}/{pjId}/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	  public @ResponseBody List deletePayExt(HttpServletRequest request, @PathVariable String part,
			  @PathVariable Long pjId,@PathVariable Long id,Model model)
	  //,@ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, 
	    {
		 List returnResult=new ArrayList(2);
		 List payext=null;
		  if(part.equals("1")){
			//  jobForm.getPstJobWork();
			  PstJobWork work=new PstJobWork(pjId, id, null,
					  null,null,null, null,null, null, null, null); 
			  pstService.deletePstJobWork(work, ServiceConstant.PST_JOB_WORK_DELETE);
			  payext= pstService.listPstJobWorks(pjId, null);
		  }else if(part.equals("3")){
			  //jobForm.getPstJobPay();
			  PstJobPay jobpay=new PstJobPay(pjId, id, null, null, null);
			  pstService.deletePstJobPay(jobpay, ServiceConstant.PST_JOB_PAY_DELETE);
			  payext=pstService.listPstJobPays(pjId, null);
		  }else if(part.equals("4")){
			//  jobForm.getPstJobPayExt();   
			  PstJobPayExt ext=new PstJobPayExt(pjId, id, null, null, null);
			  pstService.deletePstJobPayExt(ext, ServiceConstant.PST_JOB_PAY_EXT_DELETE);
			  payext=pstService.listPstJobPayExts(pjId, null);
		  }
		  returnResult.add(part);
		  returnResult.add(payext);
		  return returnResult; 
	    }
	
	  @SuppressWarnings({ "rawtypes", "unchecked" })
		@RequestMapping(value={"/payext_delete_employee/{pjId}/{id}/{prpId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
		  public @ResponseBody List deletePayExtEmployee(HttpServletRequest request, 
				  @PathVariable Long pjId,@PathVariable Long id,@PathVariable Long prpId,Model model)
		  //,@ModelAttribute(value="jobForm") JobForm jobForm, BindingResult result, 
		    {
			 
			  
				  PstJobEmployee employee=new PstJobEmployee(pjId, id,prpId,null,null,null,null,null);
				  pstService.deletePstJobEmployee(employee, ServiceConstant.PST_JOB_EMPLOYEE_DELETE);
				return pstService.listPstJobEmployees(pjId, null,prpId);
				//  jobForm.getPstJobEmployee();
		 
		    }
	  
}
