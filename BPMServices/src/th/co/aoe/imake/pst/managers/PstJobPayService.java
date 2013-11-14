package th.co.aoe.imake.pst.managers;

import java.util.List;

public interface PstJobPayService {
	@SuppressWarnings("rawtypes")
	public  List listPstJobPays(Long pjId,Long pcId);
} 