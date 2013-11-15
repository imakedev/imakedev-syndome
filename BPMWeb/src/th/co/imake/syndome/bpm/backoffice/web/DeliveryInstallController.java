package th.co.imake.syndome.bpm.backoffice.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.form.EmployeeWorkMappingForm;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;
import th.co.imake.syndome.bpm.backoffice.utils.IMakeDevUtils;

@Controller
@RequestMapping(value={"/deliveryInstall"})
@SessionAttributes(value={"deliveryInstallForm"})
public class DeliveryInstallController {
	@Autowired
	private PSTService pstService;
	private static final Logger logger = LoggerFactory.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");

	@RequestMapping(value = { "/init" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String init(Model model) {
		EmployeeWorkMappingForm employeeWorkMappingForm = null;
		employeeWorkMappingForm = new EmployeeWorkMappingForm();
		employeeWorkMappingForm.getPaging().setPageSize(IMakeDevUtils.PAGE_SIZE);
		employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(
				employeeWorkMappingForm.getPaging());
		employeeWorkMappingForm.getPstEmployeeWorkMapping().setPewmDateTime(
				new Date());
		VResultMessage vresultMessage = pstService
				.searchPstEmployeeWorkMapping(employeeWorkMappingForm
						.getPstEmployeeWorkMapping());
		model.addAttribute("pstEmployeeWorkMappings",
				vresultMessage.getResultListObj());
		employeeWorkMappingForm.getPaging()
				.setPageSize(IMakeDevUtils.PAGE_SIZE);
		employeeWorkMappingForm.setPageCount(IMakeDevUtils.calculatePage(
				employeeWorkMappingForm.getPaging().getPageSize(),
				Integer.parseInt(vresultMessage.getMaxRow())));
		employeeWorkMappingForm.setPewmDateTime(format1.format(new Date()));
		model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
		model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
		model.addAttribute("pstEmployeeStatuses",
				pstService.listPstEmployeeStatuses());
		model.addAttribute("message", "");
		return "backoffice/template/empty";
	}

}
