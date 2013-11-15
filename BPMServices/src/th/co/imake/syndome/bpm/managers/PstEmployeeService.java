package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstEmployee;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstEmployeeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployee(PstEmployee persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
