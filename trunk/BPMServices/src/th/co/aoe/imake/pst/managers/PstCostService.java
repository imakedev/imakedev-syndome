package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstCost;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstCostService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCost(PstCost persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
