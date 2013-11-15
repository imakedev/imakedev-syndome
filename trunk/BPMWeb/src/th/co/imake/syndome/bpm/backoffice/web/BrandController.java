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
import th.co.aoe.imake.pst.xstream.PstBrand;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.BrandForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;
@Controller
@RequestMapping(value={"/brand"})
@SessionAttributes(value={"brandForm"})
public class BrandController {

	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 BrandForm brandForm = null;
		 if(model.containsAttribute("brandForm")){
			 brandForm= (BrandForm)model.asMap().get("brandForm");
			 if(brandForm.getPstBrand().getPbType()==null)
				 brandForm.getPstBrand().setPbType("1");
	        }else{
	        	brandForm= new BrandForm();
	        	brandForm.getPstBrand().setPbType("1");
	        }
		   
	        
		 brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 brandForm.getPstBrand().setPagging(brandForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstBrand(brandForm.getPstBrand());
	      
	        model.addAttribute("pstBrands", vresultMessage.getResultListObj());
	        brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        brandForm.setPageCount(IMakeDevUtils.calculatePage(brandForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("brandForm", brandForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/brand_head";
	    }
	 @RequestMapping(value={"/search/{pbType}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="brandForm") BrandForm brandForm, BindingResult result, Model model,
	    		@PathVariable String pbType)
	    {
	         
	        String page="brand_search_section";
	         
	        brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        brandForm.getPaging().setPageNo(1);
	        brandForm.getPstBrand().setPagging(brandForm.getPaging());
	        brandForm.getPstBrand().setPbType(pbType);
	        VResultMessage vresultMessage = pstService.searchPstBrand(brandForm.getPstBrand());
	       
	        brandForm.setPageCount(IMakeDevUtils.calculatePage(brandForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstBrands", vresultMessage.getResultListObj());
	        model.addAttribute("brandForm", brandForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/"+page;
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="brandForm") BrandForm brandForm, BindingResult result, Model model)
	    {
	        String mode = brandForm.getMode();
	        String page="brand_search_section";
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstBrand(brandForm.getPstBrand(),  ServiceConstant.PST_BRAND_DELETE);
	        	brandForm.getPaging().setPageNo(1);
	        	page="brand_head";
	        	brandForm.setMode(null);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("brandForm"))
	            	brandForm = (BrandForm)model.asMap().get("brandForm");
	            else
	            	brandForm = new BrandForm();
	        }
	        brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        brandForm.getPstBrand().setPagging(brandForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstBrand(brandForm.getPstBrand());
	       
	        brandForm.setPageCount(IMakeDevUtils.calculatePage(brandForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstBrands", vresultMessage.getResultListObj());
	        model.addAttribute("brandForm", brandForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/"+page;
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  BrandForm brandForm = null;
	        if(model.containsAttribute("brandForm"))
	        	brandForm = (BrandForm)model.asMap().get("brandForm");
	        else
	        	brandForm = new BrandForm();
	        brandForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstBrand pstBrand = pstService.findPstBrandById(Long.parseLong(maId));
	        brandForm.setPstBrand(pstBrand);
	        model.addAttribute("brandForm", brandForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/brand_management_section";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="brandForm") BrandForm brandForm, BindingResult result, Model model)
	    {
	        String mode = brandForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstBrand(brandForm.getPstBrand());
	                brandForm.getPstBrand().setPbId(id);
	                brandForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstBrand(brandForm.getPstBrand());
	                id = brandForm.getPstBrand().getPbId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = pstService.findPstEmployeeStatusById(id);
	        brandForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("brandForm", brandForm);*/
	       // brandForm brandForm = null; 
	      /* brandForm = new BrandForm(); 
	       brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       brandForm.getPstBrand().setPagging(brandForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstBrand(brandForm.getPstBrand());
		        model.addAttribute("pstBrands", vresultMessage.getResultListObj());
		        brandForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        brandForm.setPageCount(IMakeDevUtils.calculatePage(brandForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));*/
		        model.addAttribute("brandForm", brandForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/brand_head";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  BrandForm brandForm = new BrandForm(); 
		  brandForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("brandForm", brandForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/brand_management_section";
	    }

}
