package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstPosition;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstPositionService {
	@SuppressWarnings("rawtypes")
	public  List searchPstPosition(PstPosition persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstPosition()throws DataAccessException  ;
}
