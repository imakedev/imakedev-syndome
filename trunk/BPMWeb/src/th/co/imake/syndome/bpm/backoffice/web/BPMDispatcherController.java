package th.co.imake.syndome.bpm.backoffice.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller 
@RequestMapping(value={"/dispatcher"})
public class BPMDispatcherController { 
	@RequestMapping(value = { "/page/{pagename}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String page(Model model, @PathVariable String pagename,HttpServletRequest request){
		Enumeration<?> e_num=request.getParameterNames();
		while (e_num.hasMoreElements()) {
			String param_name = (String) e_num.nextElement(); 
			model.addAttribute(param_name,request.getParameter(param_name));
		}
		return "backoffice/bpm/" + pagename; 
	}
	 @RequestMapping(value={"/roles"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	 public @ResponseBody List<String> getRoles()
	    { 
		List<String> roles=null;
		 Collection<SimpleGrantedAuthority> authorities =(Collection<SimpleGrantedAuthority>)  SecurityContextHolder.getContext().getAuthentication().getAuthorities();		
		if(authorities!=null && authorities.size()>0){
			roles=new ArrayList<String>(authorities.size());
			for (SimpleGrantedAuthority simpleGrantedAuthority : authorities) {
				roles.add(simpleGrantedAuthority.getAuthority());
			}
		}
		return roles;
	  }
}
