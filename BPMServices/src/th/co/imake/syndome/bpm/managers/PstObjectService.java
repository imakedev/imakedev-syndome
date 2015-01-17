package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.xstream.common.VResultMessage;
 


public interface PstObjectService { 
	@SuppressWarnings("rawtypes")
	public  VResultMessage searchObject(String query)throws DataAccessException  ;

	public  VResultMessage executeQuery(String[] query)throws DataAccessException  ;
	public  VResultMessage executeQueryWithValues(String[] query,List<String[]> values) throws DataAccessException  ;
//	public  int executeQueryUpdate(String[] queryDelete,String[] queryUpdate)throws DataAccessException  ;
	 
}
