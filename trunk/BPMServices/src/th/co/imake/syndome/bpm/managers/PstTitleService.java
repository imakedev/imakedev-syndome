package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstTitle;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstTitleService {
	@SuppressWarnings("rawtypes")
	public  List searchPstTitle(PstTitle persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listPstTitle()throws DataAccessException  ;
}
