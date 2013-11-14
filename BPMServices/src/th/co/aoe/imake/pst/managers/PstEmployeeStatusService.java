package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstEmployeeStatus;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstEmployeeStatusService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployeeStatus(PstEmployeeStatus persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstEmployeeStatuses();
}
