package th.co.imake.syndome.bpm.backoffice.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.web.context.request.RequestContextHolder;

public class CustomLogoutSuccessHandler extends
SimpleUrlLogoutSuccessHandler implements LogoutSuccessHandler {

 /* @Autowired
  private AuditService auditService; 
*/
  @Override
  public void onLogoutSuccess
    (HttpServletRequest request, HttpServletResponse response, Authentication authentication) 
    throws IOException, ServletException {
      String refererUrl = request.getHeader("Referer");
      System.out.println("Logout from: " + refererUrl);
      //auditService.track("Logout from: " + refererUrl);
  	HttpServletRequest req = 
			  (( org.springframework.web.context.request.ServletRequestAttributes) RequestContextHolder.
			    currentRequestAttributes()).
			    getRequest();
	System.out.println("logout req 2->"+req.getRemoteAddr());
	System.out.println("logout req.getSession().getId() 2->"+req.getSession().getId());
      super.onLogoutSuccess(request, response, authentication);
  }
}