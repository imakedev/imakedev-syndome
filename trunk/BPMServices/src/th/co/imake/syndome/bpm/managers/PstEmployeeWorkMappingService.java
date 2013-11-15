package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstEmployeeWorkMappingService {
	@SuppressWarnings("rawtypes")
	public  List searchPstEmployeeWorkMapping(PstEmployeeWorkMapping persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
	public  int setPstEmployeeWorkMapping( Long[] peIds ,Long[] pesIds,String[] prpNos,java.util.Date pewmDateTime);
}
