package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstModel;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstModelService {
	@SuppressWarnings("rawtypes")
	public  List searchPstModel(PstModel persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
