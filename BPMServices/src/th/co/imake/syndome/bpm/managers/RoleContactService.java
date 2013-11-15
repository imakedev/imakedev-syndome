package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.RoleContact;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface RoleContactService {
	public Long saveRoleContact(RoleContact transientInstance) throws DataAccessException;
	public int updateRoleContact(RoleContact transientInstance) throws DataAccessException ;
	public int deleteRoleContact(RoleContact persistentInstance) throws DataAccessException ;	
	public RoleContact findRoleContactById(Long mmId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchRoleContact(RoleContact persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listRoleContactBymaId(Long maId) throws DataAccessException ;
}
