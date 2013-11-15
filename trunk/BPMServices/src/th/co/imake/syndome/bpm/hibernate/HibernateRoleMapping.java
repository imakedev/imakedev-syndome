package th.co.imake.syndome.bpm.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.hibernate.bean.RoleMapping;
import th.co.imake.syndome.bpm.hibernate.bean.RoleMappingPK;
import th.co.imake.syndome.bpm.managers.RoleMappingService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
@Repository
@Transactional
public class HibernateRoleMapping  extends HibernateCommon implements RoleMappingService {

	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public RoleMapping findRoleMappingById(Long mmId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		RoleMapping roleMapping = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
	//	Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping where roleMapping.mmId=:mmId");
		Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping where roleMapping.missSery.msId=:msId");
		query.setParameter("msId", mmId);
		Object obj=query.uniqueResult(); 	 
		if(obj!=null){
			roleMapping=(RoleMapping)obj;
		}
	  return roleMapping;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Long saveRoleMapping(RoleMapping transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		Long returnId  = null;
	//	String password=new BigInteger(40, random).toString(32);
		//73gqqnghrkvfq202q6696gc35o
		//String big=new String(130, random).toString(32);
		//System.out.println(big);
		try{
			Object obj = session.save(transientInstance);
		
			if(obj!=null){
				returnId =(Long) obj;
			}
		} finally {
				if (session != null) {
					session = null;
				} 
		}
		return returnId; 
		
		
	}
	
	

	/*private int getSize(Session session, RoleMapping instance) throws Exception{
		try {
			 
			return 0;
				 
		 
		} catch (HibernateException re) {
			logger.error("HibernateException",re);
			throw re;
		} catch (Exception e) {
			logger.error("Exception",e);
			throw e;
		}
	}*/
	 @SuppressWarnings({ "rawtypes"})
	 @Transactional(readOnly=true)
	 public List searchRoleMapping(RoleMapping instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			/*Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				 
					Long msId=(instance.getMissSery()!=null && instance.getMissSery().getMsId()!=null 
							 && instance.getMissSery().getMsId().intValue()!=0 )?(instance.getMissSery().getMsId()):null;
				
					StringBuffer sb =new StringBuffer(" select roleMapping from RoleMapping roleMapping ");
					
					boolean iscriteria = false;
					if(msId !=null && msId.intValue()!=0){  
						//criteria.add(Expression.eq("mcaStatus", mcaStatus));	
						 sb.append(iscriteria?(" and roleMapping.missSery.msId="+msId.intValue()+""):(" where roleMapping.missSery.msId="+msId.intValue()+""));
						  iscriteria = true;
					}
					
					
					if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
							sb.append( " order by roleMapping."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
					}			
					Query query =session.createQuery(sb.toString());
					// set pagging.
					 String size = String.valueOf(getSize(session, instance)); 
					 logger.debug(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
					 
					 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
					 query.setMaxResults(pagging.getPageSize());
					 
					 List l = query.list();   
					 transList.add(l); 
				 	 transList.add(size);
				return transList;
			} catch (Exception re) {
				//re.printStackTrace();
				logger.error("find by property name failed", re);
				 
			}*/
			return transList;
		}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int updateRoleMapping(RoleMapping transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		
		/*RoleMapping roleMapping = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
		
		Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping " +
				" where roleMapping.missSery.msId=:msId ");
		query.setParameter("msId", transientInstance.getMissSery().getMsId());
		List list=query.list();
		logger.debug(" attach size="+list.size());
		if(list.size()>0){
			 roleMapping=(RoleMapping)list.get(0);
			 roleMapping.setMmFileName(transientInstance.getMmFileName());
			 roleMapping.setMmHotlink(transientInstance.getMmHotlink());
			 roleMapping.setMmPath(transientInstance.getMmPath());
			 roleMapping.setMatRef(Long.parseLong(id));
			 roleMapping.setMatModule(module);
		//	BeanUtils.copyProperties(ntcCalendarReturn,xntcCalendarReturn);					
			return update(session, roleMapping);
		}else{
			Long returnId  = null;
			try{
				Object obj = session.save(transientInstance);
			
				if(obj!=null){
					returnId =(Long) obj;
				}
			} finally {
					if (session != null) {
						session = null;
					} 
			}
			return returnId.intValue(); 
		}*/
		return 0;
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int deleteRoleMapping(RoleMapping persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List listRoleMappingByrcId(Long rcId) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
			Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping where roleMapping.id.rcId=:rcId");
			query.setParameter("rcId", rcId);
			@SuppressWarnings("unchecked")
			List<th.co.imake.syndome.bpm.hibernate.bean.RoleMapping> list=query.list();
			List<th.co.imake.syndome.bpm.xstream.RoleMapping> roles=new ArrayList<th.co.imake.syndome.bpm.xstream.RoleMapping>(list.size());
			for (th.co.imake.syndome.bpm.hibernate.bean.RoleMapping type : list) {
				th.co.imake.syndome.bpm.xstream.RoleMapping xrole=new th.co.imake.syndome.bpm.xstream.RoleMapping();
				th.co.imake.syndome.bpm.hibernate.bean.RoleMappingPK pk= type.getId();
				xrole.setRcId(pk.getRcId());
				xrole.setRtId(pk.getRtId());
				xrole.setPagging(null);
				roles.add(xrole);
			}
			return roles;
	}
	@Override
	public int updateRoleMapping(Long rcId, String[] rtIds)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		//	Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping where roleMapping.mmId=:mmId");
		Query query=session.createQuery("delete RoleMapping roleMapping where roleMapping.id.rcId ="+rcId.intValue());
		int result = query.executeUpdate();
		if(rtIds!=null && rtIds.length>0)
		for (String rtid : rtIds) {
			RoleMapping mapping =new RoleMapping();
			RoleMappingPK pk =new RoleMappingPK();
			pk.setRcId(rcId);
			pk.setRtId(Long.parseLong(rtid));
			mapping.setId(pk);
			session.save(mapping); 
		}
		//int canUpdate = 0;
		return result;
	}
	 

}
