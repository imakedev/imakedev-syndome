package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstRoadPump;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstRoadPumpService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPump(PstRoadPump persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpNo();
}
