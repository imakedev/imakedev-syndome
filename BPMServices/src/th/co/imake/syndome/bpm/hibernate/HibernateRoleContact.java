package th.co.imake.syndome.bpm.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.hibernate.bean.RoleContact;
import th.co.imake.syndome.bpm.managers.RoleContactService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
@Repository
@Transactional
public class HibernateRoleContact  extends HibernateCommon implements RoleContactService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public RoleContact findRoleContactById(Long mmId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		RoleContact roleContact = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
	//	Query query=session.createQuery(" select roleContact from RoleContact roleContact where roleContact.mmId=:mmId");
		Query query=session.createQuery(" select roleContact from RoleContact roleContact where roleContact.missSery.msId=:msId");
		query.setParameter("msId", mmId);
		Object obj=query.uniqueResult(); 	 
		if(obj!=null){
			roleContact=(RoleContact)obj;
		}
	  return roleContact;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Long saveRoleContact(RoleContact transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		Long returnId  = null;
	//	String password=new BigInteger(40, random).toString(32);
		//73gqqnghrkvfq202q6696gc35o
		//String big=new String(130, random).toString(32);
	 
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
	
	

	/*private int getSize(Session session, RoleContact instance) throws Exception{
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
	 public List searchRoleContact(RoleContact instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			/*Session session = sessionAnnotationFactory.getCurrentSession();
			try {
		
					Long msId=(instance.getMissSery()!=null && instance.getMissSery().getMsId()!=null 
							 && instance.getMissSery().getMsId().intValue()!=0 )?(instance.getMissSery().getMsId()):null;
				
					StringBuffer sb =new StringBuffer(" select roleContact from RoleContact roleContact ");
					
					boolean iscriteria = false;
					if(msId !=null && msId.intValue()!=0){  
						//criteria.add(Expression.eq("mcaStatus", mcaStatus));	
						 sb.append(iscriteria?(" and roleContact.missSery.msId="+msId.intValue()+""):(" where roleContact.missSery.msId="+msId.intValue()+""));
						  iscriteria = true;
					}
					
					
					if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
							sb.append( " order by roleContact."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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
	public int updateRoleContact(RoleContact transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.error("transientInstance getRcName="+transientInstance.getRcName()+"," +
				"transientInstance.getRcId()"+transientInstance.getRcId());
		/*RoleContact roleContact = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
		
		Query query=session.createQuery(" select roleContact from RoleContact roleContact " +
				" where roleContact.missSery.msId=:msId ");
		query.setParameter("msId", transientInstance.getMissSery().getMsId());
		List list=query.list();
		logger.debug(" attach size="+list.size());
		if(list.size()>0){
			 roleContact=(RoleContact)list.get(0);
			 roleContact.setMmFileName(transientInstance.getMmFileName());
			 roleContact.setMmHotlink(transientInstance.getMmHotlink());
			 roleContact.setMmPath(transientInstance.getMmPath());
			 roleContact.setMatRef(Long.parseLong(id));
			 roleContact.setMatModule(module);
		//	BeanUtils.copyProperties(ntcCalendarReturn,xntcCalendarReturn);					
			return update(session, roleContact);
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
		//return 0;
		return update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int deleteRoleContact(RoleContact persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List listRoleContactBymaId(Long maId) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession(); 
			Query query=session.createQuery(" select roleContact from RoleContact roleContact where roleContact.maId=:maId");
			query.setParameter("maId", maId);
			@SuppressWarnings("unchecked")
			List<th.co.imake.syndome.bpm.hibernate.bean.RoleContact> list=query.list();
			List<th.co.imake.syndome.bpm.xstream.RoleContact> roles=new ArrayList<th.co.imake.syndome.bpm.xstream.RoleContact>(list.size());
			for (th.co.imake.syndome.bpm.hibernate.bean.RoleContact type : list) {
				th.co.imake.syndome.bpm.xstream.RoleContact xrole=new th.co.imake.syndome.bpm.xstream.RoleContact();
				BeanUtils.copyProperties(type, xrole);
				xrole.setPagging(null);
				roles.add(xrole);
			}
			return roles;
	}
	 

}
