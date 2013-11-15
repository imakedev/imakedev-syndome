package th.co.imake.syndome.bpm.managers;

import java.util.List;

public interface PstJobWorkService {
	@SuppressWarnings("rawtypes")
	public  List listPstJobWorks(Long pjId,Long prpId);
} 
