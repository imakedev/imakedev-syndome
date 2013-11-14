package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstPosition;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstPositionService {
	@SuppressWarnings("rawtypes")
	public  List searchPstPosition(PstPosition persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstPosition()throws DataAccessException  ;
}
