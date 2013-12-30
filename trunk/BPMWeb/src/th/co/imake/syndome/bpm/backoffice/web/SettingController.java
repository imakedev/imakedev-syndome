package th.co.imake.syndome.bpm.backoffice.web;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping(value={"/setting"})
@SessionAttributes(value={"settingForm"})
public class SettingController {
	/*@Autowired
	private SynDomeBPMService pstService;*/
	/*private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
*/
	@RequestMapping(value = { "/page/{pagename}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String page(Model model, @PathVariable String pagename,HttpServletRequest request){
		Enumeration<?> e_num=request.getParameterNames();
		while (e_num.hasMoreElements()) {
			String param_name = (String) e_num.nextElement();
			//System.out.println("param_name=>"+param_name+",param_value=>"+request.getParameter(param_name));
			model.addAttribute(param_name,request.getParameter(param_name));
		}
		return "backoffice/bpm/" + pagename;
		//return "backoffice/template/empty";
	}


}
