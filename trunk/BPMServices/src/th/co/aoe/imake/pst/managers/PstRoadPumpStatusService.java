package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstRoadPumpStatusService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPumpStatus(PstRoadPumpStatus persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpStatus()throws DataAccessException  ;
}
