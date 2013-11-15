package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstJob;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstJobService {
	@SuppressWarnings("rawtypes")
	public  List searchPstJob(PstJob persistentInstance,String prpNo,	Pagging pagging)throws DataAccessException  ;
	
}
