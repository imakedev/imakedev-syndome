package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.RoleMapping;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface RoleMappingService {
	public Long saveRoleMapping(RoleMapping transientInstance) throws DataAccessException;
	public int updateRoleMapping(Long rcId,String[] rtIds) throws DataAccessException ;
	public int deleteRoleMapping(RoleMapping persistentInstance) throws DataAccessException ;	
	public RoleMapping findRoleMappingById(Long mmId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchRoleMapping(RoleMapping persistentInstance,	Pagging pagging)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List listRoleMappingByrcId(Long rcId) throws DataAccessException ;
}
