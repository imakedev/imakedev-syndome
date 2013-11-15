package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstConcrete;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstConcreteService {
//	@SuppressWarnings("rawtypes")
	public  List searchPstConcrete(PstConcrete persistentInstance,	Pagging pagging)throws DataAccessException  ;
	//@SuppressWarnings("rawtypes")
	public  List listPstConcretes()throws DataAccessException  ;
}
