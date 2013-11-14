package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstEmployeeWorkMappingService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployeeWorkMapping(PstEmployeeWorkMapping persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
	public  int setPstEmployeeWorkMapping( Long[] peIds ,Long[] pesIds,String[] prpNos,java.util.Date pewmDateTime);
}
