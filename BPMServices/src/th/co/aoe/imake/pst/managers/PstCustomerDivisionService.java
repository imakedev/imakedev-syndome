package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstCustomerDivision;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstCustomerDivisionService {
	@SuppressWarnings("rawtypes")
	public  List searchPstCustomerDivision(PstCustomerDivision persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
