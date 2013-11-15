package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstCustomerDivisionService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomerDivision(PstCustomerDivision persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
