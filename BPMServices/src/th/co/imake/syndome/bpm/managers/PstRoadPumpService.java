package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstRoadPump;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstRoadPumpService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPump(PstRoadPump persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpNo();
}
