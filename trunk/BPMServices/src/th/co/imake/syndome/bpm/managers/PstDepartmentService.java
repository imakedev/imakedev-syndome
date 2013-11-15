package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstDepartment;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstDepartmentService {
	@SuppressWarnings("rawtypes")
	public  List searchPstDepartment(PstDepartment persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstDepartment()throws DataAccessException  ;
}
