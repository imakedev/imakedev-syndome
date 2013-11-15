package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstCustomerContact;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstCustomerContactService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomerContact(PstCustomerContact persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
