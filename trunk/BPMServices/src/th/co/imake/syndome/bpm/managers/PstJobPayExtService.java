package th.co.imake.syndome.bpm.managers;

import java.util.List;

public interface PstJobPayExtService {
	@SuppressWarnings("rawtypes")
	public  List listPstJobPayExts( Long pjId,Long pjpeNo);
	public  Long  getNextPjpeNo( Long pjId );
} 
