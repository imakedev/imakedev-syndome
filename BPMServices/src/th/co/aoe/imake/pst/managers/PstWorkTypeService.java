package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstWorkType;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstWorkTypeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstWorkType(PstWorkType persistentInstance,	Pagging pagging)throws DataAccessException  ;
/*	@SuppressWarnings("rawtypes")
	public  List listPstWorkType()throws DataAccessException  ;*/
}
