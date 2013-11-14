package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstTitle;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstTitleService {
	@SuppressWarnings("rawtypes")
	public  List searchPstTitle(PstTitle persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstTitle()throws DataAccessException  ;
}
