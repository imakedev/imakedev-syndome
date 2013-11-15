package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstRoadPumpType;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstRoadPumpTypeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPumpType(PstRoadPumpType persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpType()throws DataAccessException  ;
}
