package th.co.imake.syndome.bpm.backoffice.web;

import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;
import th.co.imake.syndome.bpm.constant.ServiceConstant;

@Controller
@RequestMapping(value={"/service"})
@SessionAttributes(value={"serviceForm"})
public class ServiceController {
	@Autowired
	private SynDomeBPMService pstService;
	private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");

	@RequestMapping(value = { "/init" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String init(Model model) {
		
		return "backoffice/template/empty";
	}

}
