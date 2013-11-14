package th.co.aoe.imake.pst.managers;

import java.util.List;

public interface PstJobEmployeeService {
	@SuppressWarnings("rawtypes") 
	public  List listPstJobEmployees( Long pjId, Long peId,Long prpId);
}
