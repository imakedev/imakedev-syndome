package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstBreakDownService {
	@SuppressWarnings("rawtypes")
	public  List searchPstBreakDown(PstBreakDown persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
