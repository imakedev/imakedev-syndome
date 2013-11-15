package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.RoleType;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface RoleTypeService {
	public Long saveRoleType(RoleType transientInstance) throws DataAccessException;
	public int updateRoleType(RoleType transientInstance) throws DataAccessException ;
	public int deleteRoleType(RoleType persistentInstance) throws DataAccessException ;	
	public RoleType findRoleTypeById(Long mmId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchRoleType(RoleType persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listRoleTypeByRcId(Long rcId) throws DataAccessException ;
	@SuppressWarnings("rawtypes")
	public  List listRoleTypes(Long maId) throws DataAccessException ;	
	
}
