package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstBreakDown;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstBreakDownService {
	@SuppressWarnings("rawtypes")
	public  List searchPstBreakDown(PstBreakDown persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
