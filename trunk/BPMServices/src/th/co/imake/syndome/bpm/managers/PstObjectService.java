package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;
 


public interface PstObjectService { 
	@SuppressWarnings("rawtypes")
	public  List searchObject(String query)throws DataAccessException  ;

	public  int executeQuery(String[] query)throws DataAccessException  ;
	public  int executeQueryWithValues(String[] query,List<String[]> values) throws DataAccessException  ;
//	public  int executeQueryUpdate(String[] queryDelete,String[] queryUpdate)throws DataAccessException  ;
	 
}
