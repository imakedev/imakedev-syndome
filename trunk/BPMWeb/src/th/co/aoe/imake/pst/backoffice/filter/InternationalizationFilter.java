package th.co.aoe.imake.pst.backoffice.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class InternationalizationFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		final String newLocale = request.getParameter("language"); 
	    if (newLocale != null) {
	       /* final Locale locale = StringUtils.parseLocaleString(newLocale
	                .toLowerCase());
	    	 
	        LocaleContextHolder.setLocale(locale,true);
	        
	        */
	        
	        // work --> if in controller
	       /* LocaleEditor localeEditor = new LocaleEditor();
            localeEditor.setAsText(newLocale);

            // set the new locale
            LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
            localeResolver.setLocale(request, response,
                (Locale) localeEditor.getValue()); */

	    }
	    try {
	        filterChain.doFilter(request, response);
	    }catch (Exception e) {
			// TODO: handle exception
	    	e.printStackTrace();
		}finally {
	     //   LocaleContextHolder.resetLocaleContext();
	    }

	}


}
