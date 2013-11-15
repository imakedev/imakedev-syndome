package th.co.imake.syndome.bpm.managers;

import java.util.List;

public interface PstJobEmployeeService {
	@SuppressWarnings("rawtypes") 
	public  List listPstJobEmployees( Long pjId, Long peId,Long prpId);
}
