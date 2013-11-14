package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstJob;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstJobService {
	@SuppressWarnings("rawtypes")
	public  List searchPstJob(PstJob persistentInstance,String prpNo,	Pagging pagging)throws DataAccessException  ;
	
}
