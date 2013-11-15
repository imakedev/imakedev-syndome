package th.co.imake.syndome.bpm.managers;

import java.util.List;

public interface PstJobPayService {
	@SuppressWarnings("rawtypes")
	public  List listPstJobPays(Long pjId,Long pcId);
} 