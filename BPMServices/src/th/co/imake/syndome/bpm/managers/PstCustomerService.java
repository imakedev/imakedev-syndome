package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstCustomer;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstCustomerService{
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomer(PstCustomer persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
