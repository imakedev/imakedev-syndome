package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstEmployee;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstEmployeeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployee(PstEmployee persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
