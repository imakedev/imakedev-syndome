package th.co.imake.syndome.bpm.backoffice.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import th.co.imake.syndome.bpm.backoffice.service.PSTService;

@Controller
@RequestMapping
public class AccessController {
	@Autowired
	private PSTService pstService;
	@RequestMapping("/login")
	public String login(HttpServletRequest request,HttpServletResponse response,Model model, @RequestParam(required=false) String message) {
		String language=request.getParameter("language");
    	if(language!=null && language.length()>0){
    	 LocaleEditor localeEditor = new LocaleEditor();
         localeEditor.setAsText(language);

        /* Locale locale = StringUtils.parseLocaleString("th_TH"
                 .toLowerCase());*/
         // set the new locale
         LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
         localeResolver.setLocale(request, response,
             (Locale) localeEditor.getValue());
    	}
		//model.addAttribute("message", message);
	//	model.addAttribute("message", "เทสสส");
		//SecurityExpressionRoot.		
		/*SecurityContextHolder.getContext().getAuthentication().
		SecurityExpressionRoot x = SecurityExpressionRoot(SecurityContextHolder.getContext().getAuthentication());*/
		//x.hasAnyRole(arg0)
		return "access/login";
	}
	
	@RequestMapping(value = "/denied")
 	public String denied() {
		return "access/denied";
	}
	@RequestMapping(value = "/checking")
   public String checking(Model model,HttpServletRequest request) {
		//String userid=SecurityContextHolder.getContext().getAuthentication().getName();
		int result=0;//pstService.checkMissTestResult(missTest);
		//0=not yet test finish, 1=  test finish
		//String	useragent = request.getHeader("User-Agent");
	//	String user = useragent.toLowerCase();
		/*String band="";
		 if(user.indexOf("firefox") != -1) {
			band="Firefox"; 		
		} else if(user.indexOf("chrome") != -1) {
			band="Chrome";
		} else if(user.indexOf("opera") != -1) {
			band="Opera";
		} else if(user.indexOf("safari") != -1) {
			band="Safari";
		} else if(user.indexOf("msie") != -1) {
			band="IE";
		} */ 
		 
		 
		
		if(result==1){ 
			model.addAttribute("message", "You test finish"); 
			return "access/login";
		}else
			return "redirect:/";
	}
	
	@RequestMapping(value = "/login/failure")
 	public String loginFailure(Model model) {
		/*String message = "Login Failure!";
		return "redirect:/login?message="+message;*/
		String message = "Login Failure!";
	//	String message = "Login เออเร่อ!";
	/*	MissTestResult missTest=new MissTestResult();
		missTest.setMtrResultCode(message);
		model.addAttribute("missTest", missTest);*/
		model.addAttribute("message", message);
		return "access/login";
	}
	
	@RequestMapping(value = "/logout/success")
 	public String logoutSuccess() {
		String message = "Logout Success!";
		/*MissTestResult missTest=new MissTestResult();
		int result=pstServicepstService.checkMissTestResult(missTest);
		//0=not yet test finish, 1=  test finish
		if(result==1){
			message="You test finish";
		}else{
			
		}*/
	//	return "redirect:/login?message="+message;
		return "redirect:/login";
	}
	/*private String getVersionBrowser(String band,String fullAgent){
		// mozilla/5.0 (x11; ubuntu; linux x86_64; rv:15.0) gecko/20100101 firefox/15.0
		// mozilla/5.0 (x11; linux x86_64) applewebkit/537.1 (khtml, like gecko) chrome/21.0.1180.57 safari/537.1
		// opera/9.80 (x11; linux x86_64; u; en) presto/2.10.289 version/12.01
		String version=""; 
		if(band.length()>0){
			String[] versions=fullAgent.split(" "); 
			if("Chrome".equals(band)){				
				for (int i = 0; i < versions.length; i++) {
					if(versions[i].indexOf("chrome")!=-1){
						version=versions[i].split("/")[1];
						break;
					}
				}
			}else if("Firefox".equals(band)){
				for (int i = 0; i < versions.length; i++) {
					if(versions[i].indexOf("firefox")!=-1){
						version=versions[i].split("/")[1];
						break;
					}
				}
			}else if("Opera".equals(band)){
				for (int i = 0; i < versions.length; i++) {
					if(versions[i].indexOf("version")!=-1){
						version=versions[i].split("/")[1];
						break;
					}
				}
			}else if("Safari".equals(band)){
				for (int i = 0; i < versions.length; i++) {
					if(versions[i].indexOf("version")!=-1){
						version=versions[i].split("/")[1];
						break;
					}
				}
			}else if("IE".equals(band)){
				 versions=fullAgent.split(";");
				for (int i = 0; i < versions.length; i++) {
					if(versions[i].trim().indexOf("msie")!=-1){
						versions[i]=versions[i].trim();
						version=versions[i].split(" ")[1];
						break;
					}
				}
			}
			
			//Mozilla/5.0 (Windows NT 5.2) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2
			//Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729)

		}
		
		return version;
	}*/
}