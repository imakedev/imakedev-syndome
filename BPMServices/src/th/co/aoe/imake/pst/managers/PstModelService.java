package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstModel;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstModelService {
	@SuppressWarnings("rawtypes")
	public  List searchPstModel(PstModel persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
