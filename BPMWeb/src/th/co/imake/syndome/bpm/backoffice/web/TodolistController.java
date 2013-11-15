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
@RequestMapping(value = { "/todolist" })
@SessionAttributes(value = { "todolistForm" })
public class TodolistController {

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

	@RequestMapping(value = { "/search" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public String doSearch(
			HttpServletRequest request,
			@ModelAttribute(value = "employeeWorkMappingForm") EmployeeWorkMappingForm employeeWorkMappingForm,
			BindingResult result, Model model) {
		String mode = employeeWorkMappingForm.getMode();
		String message = "";
		String message_class = "";
		if (mode != null && mode.equals(IMakeDevUtils.MODE_DO_BACK)) {
			if (model.containsAttribute("employeeWorkMappingForm"))
				employeeWorkMappingForm = (EmployeeWorkMappingForm) model
						.asMap().get("employeeWorkMappingForm");
			else
				employeeWorkMappingForm = new EmployeeWorkMappingForm();
		}
		employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(
				employeeWorkMappingForm.getPaging());
		if (employeeWorkMappingForm != null
				&& employeeWorkMappingForm.getPewmDateTime() != null
				&& employeeWorkMappingForm.getPewmDateTime().length() > 0)
			try {
				employeeWorkMappingForm.getPstEmployeeWorkMapping()
						.setPewmDateTime(
								format1.parse(employeeWorkMappingForm
										.getPewmDateTime()));
			} catch (ParseException e) {
				e.printStackTrace();
			}

		if (mode.equals(IMakeDevUtils.MODE_EDIT)) {
			employeeWorkMappingForm.getPstEmployeeWorkMapping().setPeIds(
					employeeWorkMappingForm.getPeIds());
			employeeWorkMappingForm.getPstEmployeeWorkMapping().setPrpNos(
					employeeWorkMappingForm.getPrpNos());
			employeeWorkMappingForm.getPstEmployeeWorkMapping().setPesIds(
					employeeWorkMappingForm.getPesIds());
			pstService.setPstEmployeeWorkMapping(employeeWorkMappingForm
					.getPstEmployeeWorkMapping());
			message = "Update success !";
			message_class = "success";
		}
		employeeWorkMappingForm.getPaging()
				.setPageSize(IMakeDevUtils.PAGE_SIZE);

		VResultMessage vresultMessage = pstService
				.searchPstEmployeeWorkMapping(employeeWorkMappingForm
						.getPstEmployeeWorkMapping());

		employeeWorkMappingForm.setPageCount(IMakeDevUtils.calculatePage(
				employeeWorkMappingForm.getPaging().getPageSize(),
				Integer.parseInt(vresultMessage.getMaxRow())));
		model.addAttribute("pstEmployeeWorkMappings",
				vresultMessage.getResultListObj());
		// if( != null && missCandidate.getMcaBirthDate() != null)
		model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
		model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
		model.addAttribute("pstEmployeeStatuses",
				pstService.listPstEmployeeStatuses());
		model.addAttribute("message", message);
		model.addAttribute("message_class", message_class);
		return "backoffice/template/employee_check";
	}
	@RequestMapping(value = { "/action/{section}" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	public String doAction(
			HttpServletRequest request,
			@PathVariable String section,
			@ModelAttribute(value = "employeeWorkMappingForm") EmployeeWorkMappingForm employeeWorkMappingForm,
			BindingResult result, Model model) {
		String mode = employeeWorkMappingForm.getMode();
		String message = "";
		String message_class = "";
		mode = "edit";
		if (mode != null)
			if (mode.equals(IMakeDevUtils.MODE_EDIT)) {
				if (employeeWorkMappingForm != null
						&& employeeWorkMappingForm.getPewmDateTime() != null
						&& employeeWorkMappingForm.getPewmDateTime().length() > 0)
					try {
						employeeWorkMappingForm.getPstEmployeeWorkMapping()
								.setPewmDateTime(
										format1.parse(employeeWorkMappingForm
												.getPewmDateTime()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				pstService.setPstEmployeeWorkMapping(employeeWorkMappingForm
						.getPstEmployeeWorkMapping());
				message = "Update success !";
				message_class = "success";
			}
		employeeWorkMappingForm = new EmployeeWorkMappingForm();
		employeeWorkMappingForm.getPaging()
				.setPageSize(IMakeDevUtils.PAGE_SIZE);
		employeeWorkMappingForm.getPstEmployeeWorkMapping().setPagging(
				employeeWorkMappingForm.getPaging());
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
		model.addAttribute("employeeWorkMappingForm", employeeWorkMappingForm);
		model.addAttribute("message", message);
		model.addAttribute("message_class", message_class);
		model.addAttribute("pstRoadPumpNos", pstService.listPstRoadPumpNo());
		model.addAttribute("pstEmployeeStatuses",
				pstService.listPstEmployeeStatuses());
		return "backoffice/template/employee_check";
	}
}
