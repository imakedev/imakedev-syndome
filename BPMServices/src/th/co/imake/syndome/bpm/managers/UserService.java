package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.User;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface UserService {
	@SuppressWarnings("rawtypes")
	public  List searchUser(User persistentInstance,	Pagging pagging)throws DataAccessException  ;
	
}
