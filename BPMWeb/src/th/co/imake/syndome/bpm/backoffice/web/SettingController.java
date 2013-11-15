package th.co.imake.syndome.bpm.backoffice.web;

import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;

@Controller
@RequestMapping(value={"/setting"})
@SessionAttributes(value={"settingForm"})
public class SettingController {
	@Autowired
	private PSTService pstService;
	private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");

	@RequestMapping(value = { "/page/{pagename}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String page(Model model, @PathVariable String pagename) {
		//return "backoffice/template/" + pagename;
		return "backoffice/template/empty";
	}


}
