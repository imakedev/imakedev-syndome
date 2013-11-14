package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstCustomerContactService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomerContact(PstCustomerContact persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
