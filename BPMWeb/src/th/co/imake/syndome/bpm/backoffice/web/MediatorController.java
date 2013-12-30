package th.co.imake.syndome.bpm.backoffice.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.imake.syndome.bpm.backoffice.service.SynDomeBPMService;

@Controller
@RequestMapping("/")
@SessionAttributes(value={"missExamForm","systemDate","timelimit"})
public class MediatorController {
	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	//private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	// private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	 //private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy/HH/mm/ss");
	@Autowired
	private SynDomeBPMService missExamService;
	/*@RequestMapping( method={org.springframework.web.bind.annotation.RequestMethod.GET})
	public String getCandidateInfo(Model model) {
		String userid=SecurityContextHolder.getContext().getAuthentication().getName();
		//0=not yet test finish, 1=  test finish
			MissExamForm missExamForm = null;
			 if(model.containsAttribute("missExamForm"))
				 missExamForm = (MissExamForm)model.asMap().get("missExamForm");
	         else
	        	 missExamForm = new MissExamForm();
			 MissCandidate missCandidate= missExamService.findMissCandidateByName(userid);
			 if(missCandidate != null && missCandidate.getMcaBirthDate() != null)
				 missExamForm.setMcaBirthDate(format1.format(missCandidate.getMcaBirthDate()));
			 missExamForm.setMissCandidate(missCandidate);
			 //SecurityContextHolder.getContext().getAuthentication().ggetName().get;
			 model.addAttribute("missExamForm", missExamForm);
			 Date date=new Date();
			 model.addAttribute("systemDate", format1.format(date));
		//	 model.addAttribute("timelimit", format2.format(date));
			return "exam/candidateInfo";
	}*/
	
	@RequestMapping(value="/user")
	public String getUserPage() {
		return "user";
	}
	
	@RequestMapping(value="/admin")
	public String getAdminPage() {
		return "admin";
	}
	@RequestMapping(value="/miss")
	public String getMissPage() {
		return "exam/index";
	}
}
