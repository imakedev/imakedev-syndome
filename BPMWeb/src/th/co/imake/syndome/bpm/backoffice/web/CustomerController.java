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
import th.co.aoe.imake.pst.xstream.PstCustomer;
import th.co.aoe.imake.pst.xstream.PstCustomerContact;
import th.co.aoe.imake.pst.xstream.PstCustomerDivision;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.CustomerForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/customer"})
@SessionAttributes(value={"customerForm"})
public class CustomerController {
	 @Autowired
	 private PSTService pstService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 CustomerForm customerForm =  new CustomerForm();
	        
		 customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 customerForm.getPstCustomer().setPagging(customerForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCustomer(customerForm.getPstCustomer());
	      
	        model.addAttribute("pstCustomers", vresultMessage.getResultListObj());
	        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/customer_search";
	    }
	 // Customer
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstCustomer(customerForm.getPstCustomer(),  ServiceConstant.PST_CUSTOMER_DELETE);
	        	customerForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("customerForm"))
	            	customerForm = (CustomerForm)model.asMap().get("customerForm");
	            else
	            	customerForm = new CustomerForm();
	        }
	        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        customerForm.getPstCustomer().setPagging(customerForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCustomer(customerForm.getPstCustomer());
	       
	        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstCustomers", vresultMessage.getResultListObj());
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/customer_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  CustomerForm customerForm = null;
	        if(model.containsAttribute("customerForm"))
	        	customerForm = (CustomerForm)model.asMap().get("customerForm");
	        else
	        	customerForm = new CustomerForm();
	        customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstCustomer pstCustomer = pstService.findPstCustomerById(Long.parseLong(maId));
	        customerForm.setPstCustomer(pstCustomer);
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/customer_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	        int pageNo=1;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstCustomer(customerForm.getPstCustomer());
	                customerForm.getPstCustomer().setPcId(id);
	                customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstCustomer(customerForm.getPstCustomer());
	                id = customerForm.getPstCustomer().getPcId();
	                message = "Update success !";
	                message_class="success";
	                pageNo=customerForm.getPaging().getPageNo();
	            }
	       customerForm = new CustomerForm(); 
	       customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       customerForm.getPaging().setPageNo(pageNo);
	       customerForm.getPstCustomer().setPagging(customerForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCustomer(customerForm.getPstCustomer());
		        model.addAttribute("pstCustomers", vresultMessage.getResultListObj());
		        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("customerForm", customerForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/customer_search";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  CustomerForm customerForm = new CustomerForm(); 
		  customerForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("customerForm", customerForm);
	      model.addAttribute("display", "display: none"); return "backoffice/template/customer_management";
	    }
	 
	  // Division
	   @RequestMapping(value={"/division/init/{pcId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
		public String divisionInit(Model model,@PathVariable Long pcId)
		    {
			 CustomerForm customerForm =  new CustomerForm();
			 PstCustomer pstCustomer =new PstCustomer();
			 pstCustomer.setPcId(pcId);
			 customerForm.getPstCustomerDivision().setPstCustomer(pstCustomer);
			 customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
			 customerForm.getPstCustomerDivision().setPagging(customerForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCustomerDivision(customerForm.getPstCustomerDivision());
		      
		        model.addAttribute("pstCustomerDivisions", vresultMessage.getResultListObj());
		        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("customerForm", customerForm);
		        model.addAttribute("message", ""); 
		        return "backoffice/template/customer_division_search";
		    }
	  @RequestMapping(value={"/division/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doDivisionSearch(HttpServletRequest request, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstCustomerDivision(customerForm.getPstCustomerDivision(),  ServiceConstant.PST_CUSTOMER_DIVISION_DELETE);
	        	customerForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("customerForm"))
	            	customerForm = (CustomerForm)model.asMap().get("customerForm");
	            else
	            	customerForm = new CustomerForm();
	        }
	        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        customerForm.getPstCustomerDivision().setPagging(customerForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCustomerDivision(customerForm.getPstCustomerDivision());
	       
	        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstCustomerDivisions", vresultMessage.getResultListObj());
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/customer_division_search";
	    }
	  @RequestMapping(value={"/division/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getDivisionItem(@PathVariable String maId, Model model)
	    {
		  CustomerForm customerForm = null;
	        if(model.containsAttribute("customerForm"))
	        	customerForm = (CustomerForm)model.asMap().get("customerForm");
	        else
	        	customerForm = new CustomerForm();
	        customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstCustomerDivision pstCustomerDivision = pstService.findPstCustomerDivisionById(Long.parseLong(maId));
	        customerForm.setPstCustomerDivision(pstCustomerDivision);
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/customer_division_management";
	    }
	   @RequestMapping(value={"/division/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doDivisionAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	        int pageNo=1;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstCustomerDivision(customerForm.getPstCustomerDivision());
	                customerForm.getPstCustomerDivision().setPcdId(id);
	                customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstCustomerDivision(customerForm.getPstCustomerDivision());
	                id = customerForm.getPstCustomerDivision().getPcdId();
	                message = "Update success !";
	                message_class="success";
	                pageNo=customerForm.getPaging().getPageNo();
	            }
	       PstCustomerDivision pstCustomerDivision =pstService.findPstCustomerDivisionById(id);
	       customerForm = new CustomerForm(); 
	       customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       customerForm.getPaging().setPageNo(pageNo);
	       customerForm.getPstCustomerDivision().setPstCustomer(pstCustomerDivision.getPstCustomer());
	       customerForm.getPstCustomerDivision().setPagging(customerForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCustomerDivision(customerForm.getPstCustomerDivision());
		        model.addAttribute("pstCustomerDivisions", vresultMessage.getResultListObj());
		        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("customerForm", customerForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/customer_division_search";
	    }
	  @RequestMapping(value={"/division/new/{pcId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getDivisionNewForm(Model model,@PathVariable Long pcId)
	    {
		  CustomerForm customerForm = new CustomerForm(); 
		  PstCustomer pstCustomer =pstService.findPstCustomerById(pcId);
		  customerForm.getPstCustomerDivision().setPstCustomer(pstCustomer);
		  customerForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("customerForm", customerForm);
	      model.addAttribute("display", "display: none"); return "backoffice/template/customer_division_management";
	    }
	  
	  // Contact
	  @RequestMapping(value={"/contact/init/{pcId}/{pcdId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
		public String contactInit(Model model,@PathVariable Long pcId,@PathVariable Long pcdId)
		    {
			 CustomerForm customerForm =  new CustomerForm();
			 PstCustomerDivision division =new PstCustomerDivision();
			 division.setPcdId(pcdId);
			 PstCustomer  customer =new PstCustomer();
			 customer.setPcId(pcId);
			 division.setPstCustomer(customer);
			 
			 customerForm.getPstCustomerContact().setPstCustomerDivision(division);
			 customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
			 customerForm.getPstCustomerContact().setPagging(customerForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCustomerContact(customerForm.getPstCustomerContact());
		      
		        model.addAttribute("pstCustomerContacts", vresultMessage.getResultListObj());
		        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("customerForm", customerForm);
		        model.addAttribute("message", ""); 
		        return "backoffice/template/customer_contact_search";
		    }
	  @RequestMapping(value={"/contact/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doContactSearch(HttpServletRequest request, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();

	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	pstService.deletePstCustomerContact(customerForm.getPstCustomerContact(),  ServiceConstant.PST_CUSTOMER_CONTACT_DELETE);
	        	customerForm.getPaging().setPageNo(1);
 
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("customerForm"))
	            	customerForm = (CustomerForm)model.asMap().get("customerForm");
	            else
	            	customerForm = new CustomerForm();
	        } 
	       /* PstCustomerDivision division =new PstCustomerDivision();
			 division.setPcdId(pcdId);
			 PstCustomer  customer =new PstCustomer();
			 customer.setPcId(pcId);
			 division.setPstCustomer(customer);*/
			 
	        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        customerForm.getPstCustomerContact().setPagging(customerForm.getPaging());
	        VResultMessage vresultMessage = pstService.searchPstCustomerContact(customerForm.getPstCustomerContact());
	       
	        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("pstCustomerContacts", vresultMessage.getResultListObj());
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/customer_contact_search";
	    }
	  @RequestMapping(value={"/contact/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getContactItem(@PathVariable String maId, Model model)
	    {
		  CustomerForm customerForm = null;
	        if(model.containsAttribute("customerForm"))
	        	customerForm = (CustomerForm)model.asMap().get("customerForm");
	        else
	        	customerForm = new CustomerForm();
	        customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	        PstCustomerContact pstCustomerContact = pstService.findPstCustomerContactById(Long.parseLong(maId));
	        customerForm.setPstCustomerContact(pstCustomerContact);
	        model.addAttribute("customerForm", customerForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/customer_contact_management";
	    }
	  @RequestMapping(value={"/contact/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doContactAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="customerForm") CustomerForm customerForm, BindingResult result, Model model)
	    {
	        String mode = customerForm.getMode();
	        String message = "";
	        String  message_class="";
	        Long id = null;
	        int pageNo=1;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = pstService.savePstCustomerContact(customerForm.getPstCustomerContact());
	                customerForm.getPstCustomerContact().setPccId(id);
	                customerForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	pstService.updatePstCustomerContact(customerForm.getPstCustomerContact());
	                id = customerForm.getPstCustomerContact().getPccId();
	                message = "Update success !";
	                message_class="success";
	                pageNo=customerForm.getPaging().getPageNo();
	            }
	       PstCustomerContact pstCustomerContact=pstService.findPstCustomerContactById(id);
	       customerForm = new CustomerForm(); 
	       customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       customerForm.getPaging().setPageNo(pageNo);
	       customerForm.getPstCustomerContact().setPstCustomerDivision(pstCustomerContact.getPstCustomerDivision());
	       customerForm.getPstCustomerContact().setPagging(customerForm.getPaging());
		        VResultMessage vresultMessage = pstService.searchPstCustomerContact(customerForm.getPstCustomerContact());
		        model.addAttribute("pstCustomerContacts", vresultMessage.getResultListObj());
		        customerForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        customerForm.setPageCount(IMakeDevUtils.calculatePage(customerForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("customerForm", customerForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/customer_contact_search";
	    }
	  @RequestMapping(value={"/contact/new/{pcdId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getContactNewForm(Model model, @PathVariable Long pcdId )
	    {
		  CustomerForm customerForm = new CustomerForm(); 
		  PstCustomerDivision pstCustomerDivision =pstService.findPstCustomerDivisionById(pcdId);
		  customerForm.getPstCustomerContact().setPstCustomerDivision(pstCustomerDivision);
		  customerForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("customerForm", customerForm);
	      model.addAttribute("display", "display: none"); return "backoffice/template/customer_contact_management";
	    }
	  
	  
}
