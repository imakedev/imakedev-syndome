package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstRoadPumpStatus;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstRoadPumpStatusService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPumpStatus(PstRoadPumpStatus persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpStatus()throws DataAccessException  ;
}
