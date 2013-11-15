package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstRoadPumpDeactiveMapping;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstRoadPumpDeactiveMappingService {
	@SuppressWarnings("rawtypes")
	public  List searchPstRoadPumpDeactiveMapping(PstRoadPumpDeactiveMapping persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
