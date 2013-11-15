package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstEmployeeStatusService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployeeStatus(PstEmployeeStatus persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstEmployeeStatuses();
}
