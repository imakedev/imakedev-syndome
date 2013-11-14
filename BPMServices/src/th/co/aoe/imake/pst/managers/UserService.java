package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.User;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface UserService {
	@SuppressWarnings("rawtypes")
	public  List searchUser(User persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
