package th.co.imake.syndome.bpm.backoffice.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class AuthentificationListener  implements AuthenticationFailureHandler{
	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	
    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
             HttpServletResponse response, AuthenticationException ae )
             throws IOException, ServletException {
    	 	System.out.println(" onAuthenticationFailure");
    	 	System.out.println("classes "+ae.getClass());
    	 	 
    	 	 //org.springframework.security.web.authentication.session.SessionAuthenticationException
            @SuppressWarnings("deprecation")
			UsernamePasswordAuthenticationToken user =(UsernamePasswordAuthenticationToken)ae.getAuthentication();
            System.out.println("xxxxxxxxx1 "+ae.getMessage());
            System.out.println("xxxxxxxxx2 "+ae.hashCode());
            System.out.println("xxxxxxxxx3 "+ae.toString());
         // user contains required data
            //login/duplicate ==> Session exceeded
            //login/failure ==> invalid username or password
           if(user!=null)
        	   response.sendRedirect("login/failure");
           else
        	   response.sendRedirect("login/duplicate");
        	   
          
          
         // Session exceeded
        /*  onAuthenticationFailure
         xxxxxxxxx1 Maximum sessions of 1 for this principal  exceeded
         xxxxxxxxx2 109033592
         xxxxxxxxx3 org.springframework.security.web.authentication.session.SessionAuthenticationException: Maximum sessions of 1 for this principal exceeded
         user null*/
         
         // invalid username or password
          /*onAuthenticationFailure
          xxxxxxxxx1 java.lang.NullPointerException
          xxxxxxxxx2 1637300018
          xxxxxxxxx3 org.springframework.security.authentication.AuthenticationServiceException: java.lang.NullPointerException
          user org.springframework.security.authentication.UsernamePasswordAuthenticationToken@5b97ec2: Principal: sdsd; Credentials: [PROTECTED]; Authenticated: false; Details: org.springframework.security.web.authentication.WebAuthenticationDetails@0: RemoteIpAddress: 127.0.0.1; SessionId: C602C7B2DFF3458815F9640ACC750D7F; Not granted any authorities
           */
          
          // invalid password Only
          /*onAuthenticationFailure
          xxxxxxxxx1 Bad credentials
         xxxxxxxxx2 405682457
         xxxxxxxxx3 org.springframework.security.authentication.BadCredentialsException: Bad credentials
         user org.springframework.security.authentication.UsernamePasswordAuthenticationToken@8b9d3a1a: Principal: MCA000049; Credentials: [PROTECTED]; Authenticated: false; Details: org.springframework.security.web.authentication.WebAuthenticationDetails@0: RemoteIpAddress: 127.0.0.1; SessionId: C602C7B2DFF3458815F9640ACC750D7F; Not granted any authorities
           */
 
}

}
