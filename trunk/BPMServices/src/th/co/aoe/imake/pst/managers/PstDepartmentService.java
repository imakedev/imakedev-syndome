package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstDepartment;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstDepartmentService {
	@SuppressWarnings("rawtypes")
	public  List searchPstDepartment(PstDepartment persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstDepartment()throws DataAccessException  ;
}
