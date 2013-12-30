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

import th.co.imake.syndome.bpm.backoffice.form.UserForm;
import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;
import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.xstream.User;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

@Controller
@RequestMapping(value={"/user"})
@SessionAttributes(value={"userForm"})
public class UserController {

	 @Autowired
	 private SynDomeBPMService synDomeBPMService;
	 private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	 @RequestMapping(value={"/init"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public String init(Model model)
	    {
		 UserForm userForm =  new UserForm();
	        
		 userForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		 userForm.getUser().setPagging(userForm.getPaging());
	        VResultMessage vresultMessage = synDomeBPMService.searchUser(userForm.getUser());
	      
	        model.addAttribute("users", vresultMessage.getResultListObj());
	        userForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        userForm.setPageCount(IMakeDevUtils.calculatePage(userForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("userForm", userForm);
	        model.addAttribute("message", ""); 
	        //return "backoffice/template/user_search";
	        return "backoffice/template/empty";
	    }
	 @RequestMapping(value={"/search"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doSearch(HttpServletRequest request, @ModelAttribute(value="userForm") UserForm userForm, BindingResult result, Model model)
	    {
	        String mode = userForm.getMode();
	       /* if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE_ITEMS))
	        {
	        	userForm.getUser().setIds(userForm.getPesIdArray());
	        	synDomeBPMService.deletePstEmployeeStatus(userForm.getUser(), ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE);
	        	userForm.getPaging().setPageNo(1);
	        } else*/
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DELETE)){
	        	synDomeBPMService.deleteUser(userForm.getUser(),  ServiceConstant.USER_DELETE);
	        	userForm.getPaging().setPageNo(1);
	        }
	        else
	        if(mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK))
	        {
	            if(model.containsAttribute("userForm"))
	            	userForm = (UserForm)model.asMap().get("userForm");
	            else
	            	userForm = new UserForm();
	        }
	        userForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	        userForm.getUser().setPagging(userForm.getPaging());
	        VResultMessage vresultMessage = synDomeBPMService.searchUser(userForm.getUser());
	       
	        userForm.setPageCount(IMakeDevUtils.calculatePage(userForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
	        model.addAttribute("users", vresultMessage.getResultListObj());
	        model.addAttribute("userForm", userForm);
	        model.addAttribute("message", ""); 
	        return "backoffice/template/user_search";
	    }
	  @RequestMapping(value={"/item/{maId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getItem(@PathVariable String maId, Model model)
	    {
		  UserForm userForm = null;
	        if(model.containsAttribute("userForm"))
	        	userForm = (UserForm)model.asMap().get("userForm");
	        else
	        	userForm = new UserForm();
	        userForm.setMode(IMakeDevUtils.MODE_EDIT);
	        User user = synDomeBPMService.findUserById(maId);
	        userForm.setUser(user);
	        model.addAttribute("userForm", userForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/user_management";
	    }
	  @RequestMapping(value={"/action/{section}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	    public String doAction(HttpServletRequest request, @PathVariable String section, @ModelAttribute(value="userForm") UserForm userForm, BindingResult result, Model model)
	    {
	        String mode = userForm.getMode();
	        String message = "";
	        String  message_class="";
	        String id = null;
	       if(mode != null)
	            if(mode.equals(IMakeDevUtils.MODE_NEW))
	            {
	                id = synDomeBPMService.saveUser(userForm.getUser());
	                userForm.getUser().setId(id);
	                userForm.setMode(IMakeDevUtils.MODE_EDIT);
	                message = "Save success !";
	                message_class="success";
	            } else
	            if(mode.equals(IMakeDevUtils.MODE_EDIT))
	            {
	            	synDomeBPMService.updateUser(userForm.getUser());
	                id = userForm.getUser().getId();
	                message = "Update success !";
	                message_class="success";
	            }
	        /*PstEmployeeStatus pstBreakDown = synDomeBPMService.findPstEmployeeStatusById(id);
	        userForm.setPstEmployeeStatus(pstBreakDown);
	        model.addAttribute("message", message);
	        model.addAttribute("display", "display: block");
	        model.addAttribute("userForm", userForm);*/
	       // userForm userForm = null; 
	       userForm = new UserForm(); 
	       userForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
	       userForm.getUser().setPagging(userForm.getPaging());
		        VResultMessage vresultMessage = synDomeBPMService.searchUser(userForm.getUser());
		        model.addAttribute("users", vresultMessage.getResultListObj());
		        userForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		        userForm.setPageCount(IMakeDevUtils.calculatePage(userForm.getPaging().getPageSize(), Integer.parseInt(vresultMessage.getMaxRow())));
		        model.addAttribute("userForm", userForm);
		        model.addAttribute("message", message); 
		        model.addAttribute("message_class", message_class);
		        return "backoffice/template/user_search";
	        // return "backoffice/template/employee_status_management";
	    }
	  @RequestMapping(value={"/new"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public String getNewForm(Model model)
	    {
		  UserForm userForm = new UserForm(); 
		  userForm.setMode(IMakeDevUtils.MODE_NEW);
		  model.addAttribute("userForm", userForm);
	        model.addAttribute("display", "display: none");
	        return "backoffice/template/user_management";
	    }

}
