package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstCustomer;
import th.co.aoe.imake.pst.xstream.common.Pagging;
//import th.co.aoe.imake.pst.hibernate.bean.PstCustomer;

public interface PstCustomerService{
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomer(PstCustomer persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
