package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstRoadPumpTypeService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPumpType(PstRoadPumpType persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstRoadPumpType()throws DataAccessException  ;
}
