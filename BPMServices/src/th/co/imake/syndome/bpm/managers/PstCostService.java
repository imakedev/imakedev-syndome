package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstCost;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstCostService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCost(PstCost persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
