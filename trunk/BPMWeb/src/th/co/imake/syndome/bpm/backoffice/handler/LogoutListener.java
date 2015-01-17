package th.co.imake.syndome.bpm.backoffice.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.constant.ServiceConstant;

@Component
public class LogoutListener implements ApplicationListener<SessionDestroyedEvent> {
	@Autowired
	private SynDomeBPMService synDomeBPMService;
    @Override
    public void onApplicationEvent(SessionDestroyedEvent event)
    {
        List<SecurityContext> lstSecurityContext = event.getSecurityContexts();
        UserDetails ud;
        for (SecurityContext securityContext : lstSecurityContext)
        {
            ud = (UserDetails) securityContext.getAuthentication().getPrincipal();
            // ...
            	
           // System.out.println("ud.getUsername()->"+ud.getUsername());
            HttpServletRequest req = 
  				  (( org.springframework.web.context.request.ServletRequestAttributes) RequestContextHolder.
  				    currentRequestAttributes()).
  				    getRequest();
  		 
  	/*	System.out.println("logout ip->"+req.getRemoteAddr());
  		System.out.println("logout session id->"+req.getSession().getId());
  		System.out.println("logout time->"+new Date());
  		System.out.println("logout username->"+SecurityContextHolder.getContext().getAuthentication().getName());*/
  	    String logout_query="UPDATE  "+ServiceConstant.SCHEMA+".BPM_SYSTEM_USED SET " +
     	  		" BPMSYSTEM_DATE_TIME_LOGOUT=now() " +
     	  		//" where BPMSYSTEM_USER_ID='"+SecurityContextHolder.getContext().getAuthentication().getName()+"' and BPMSYSTEM_SESSION_ID='"+req.getSession().getId()+"'" ;
     	  		" where BPMSYSTEM_USER_ID='"+ud.getUsername()+"' and BPMSYSTEM_SESSION_ID='"+req.getSession().getId()+"'" ;
  	   //System.out.println(logout_query);
     	synDomeBPMService.executeQuery(new String[]{logout_query});
        }
       
    }

}