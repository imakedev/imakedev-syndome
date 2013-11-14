package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstConcrete;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstConcreteService {
//	@SuppressWarnings("rawtypes")
	public  List searchPstConcrete(PstConcrete persistentInstance,	Pagging pagging)throws DataAccessException  ;
	//@SuppressWarnings("rawtypes")
	public  List listPstConcretes()throws DataAccessException  ;
}
