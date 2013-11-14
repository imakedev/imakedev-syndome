// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:06:21 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   WelcomeController.java

package th.co.aoe.imake.pst.backoffice.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import th.co.aoe.imake.pst.backoffice.service.PSTService;
//import org.apache.log4j.Logger;

@Controller
@SessionAttributes(value={"UserMissContact"})
public class WelcomeController
{
	//private static int PAGE_SIZE=20;
	/*private static ResourceBundle bundle;
	static{
			bundle =  ResourceBundle.getBundle( "config" );		
		
	}*/
    @RequestMapping(value={"/"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public String getNewForm(HttpServletRequest request,HttpServletResponse response,  Model model)
    {
    	String language=request.getParameter("language");
    	if(language!=null && language.length()>0){
    	 LocaleEditor localeEditor = new LocaleEditor();
         localeEditor.setAsText(language);

         // set the new locale
         LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
         localeResolver.setLocale(request, response,
             (Locale) localeEditor.getValue());
    	}
        return "backoffice/common";
    }
    @RequestMapping(value={"/checksession"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
    public @ResponseBody String checksession()
    { 
    	Authentication authen=SecurityContextHolder.getContext().getAuthentication();		
		String userid=null;
		if(authen!=null)
			userid=authen.getName();
       // Gson gson=new Gson();
		// return gson.toJson(missTheme);
		return userid;
    }
  /*private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
    private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    //private static Logger logger = Logger.getRootLogger();
    private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);*/
    @Autowired
    private PSTService missExamService;

}
