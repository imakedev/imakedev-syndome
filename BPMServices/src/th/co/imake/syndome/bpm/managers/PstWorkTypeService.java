package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstWorkType;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstWorkTypeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstWorkType(PstWorkType persistentInstance,	Pagging pagging)throws DataAccessException  ;
/*	@SuppressWarnings("rawtypes")
	public  List listPstWorkType()throws DataAccessException  ;*/
}
