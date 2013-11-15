package th.co.imake.syndome.bpm.hibernate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import th.co.imake.syndome.bpm.hibernate.bean.RoleType;
import th.co.imake.syndome.bpm.managers.RoleTypeService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
@Repository
@Transactional
public class HibernateRoleType  extends HibernateCommon implements RoleTypeService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public RoleType findRoleTypeById(Long mmId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		RoleType roleType = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
	//	Query query=session.createQuery(" select roleType from RoleType roleType where roleType.mmId=:mmId");
		Query query=session.createQuery(" select roleType from RoleType roleType where roleType.missSery.msId=:msId");
		query.setParameter("msId", mmId);
		Object obj=query.uniqueResult(); 	 
		if(obj!=null){
			roleType=(RoleType)obj;
		}
	  return roleType;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Long saveRoleType(RoleType transientInstance)
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
	
/*	

	private int getSize(Session session, RoleType instance) throws Exception{
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
	 @SuppressWarnings({ "rawtypes" })
	 @Transactional(readOnly=true)
	 public List searchRoleType(RoleType instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			/*Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				 
					Long msId=(instance.getMissSery()!=null && instance.getMissSery().getMsId()!=null 
							 && instance.getMissSery().getMsId().intValue()!=0 )?(instance.getMissSery().getMsId()):null;
				
					StringBuffer sb =new StringBuffer(" select roleType from RoleType roleType ");
					
					boolean iscriteria = false;
					if(msId !=null && msId.intValue()!=0){  
						//criteria.add(Expression.eq("mcaStatus", mcaStatus));	
						 sb.append(iscriteria?(" and roleType.missSery.msId="+msId.intValue()+""):(" where roleType.missSery.msId="+msId.intValue()+""));
						  iscriteria = true;
					}
					
					
					if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
							sb.append( " order by roleType."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
					}			
					Query query =session.createQuery(sb.toString());
					// set pagging.
					 String size = String.valueOf(getSize(session, instance)); 
					 logger.info(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
					 
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
	public int updateRoleType(RoleType transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		
		/*RoleType roleType = null;
		Session session=sessionAnnotationFactory.getCurrentSession();
		
		Query query=session.createQuery(" select roleType from RoleType roleType " +
				" where roleType.missSery.msId=:msId ");
		query.setParameter("msId", transientInstance.getMissSery().getMsId());
		List list=query.list();
		logger.debug(" attach size="+list.size());
		if(list.size()>0){
			 roleType=(RoleType)list.get(0);
			 roleType.setMmFileName(transientInstance.getMmFileName());
			 roleType.setMmHotlink(transientInstance.getMmHotlink());
			 roleType.setMmPath(transientInstance.getMmPath());
			 roleType.setMatRef(Long.parseLong(id));
			 roleType.setMatModule(module);
		//	BeanUtils.copyProperties(ntcCalendarReturn,xntcCalendarReturn);					
			return update(session, roleType);
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
	public int deleteRoleType(RoleType persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List listRoleTypeByRcId(Long rcId) throws DataAccessException {
		// TODO Auto-generated method stub
		//RoleType roleType = null;
		List<th.co.imake.syndome.bpm.xstream.RoleType> roles=new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>();
		Session session=sessionAnnotationFactory.getCurrentSession();
	//	Query query=session.createQuery(" select roleType from RoleType roleType where roleType.mmId=:mmId");
		Query query=session.createQuery(" select roleMapping from RoleMapping roleMapping where roleMapping.id.rcId=:rcId");
		logger.debug("rcId="+rcId);
		query.setParameter("rcId", rcId);
		List<th.co.imake.syndome.bpm.hibernate.bean.RoleMapping> list=query.list();
		Map<String,th.co.imake.syndome.bpm.hibernate.bean.RoleMapping> map =new HashMap();
		if(list!=null && list.size()>0){
			for (th.co.imake.syndome.bpm.hibernate.bean.RoleMapping roleMapping : list) {
				map.put(roleMapping.getId().getRtId()+"", roleMapping);
			}
			// mapping =(th.co.aoe.makedev.missconsult.hibernate.bean.RoleMapping)
		}
		if(map.size()>0){
			 
			for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
				String rtId_key = (String) iterator.next();
				query=session.createQuery(" select roleType from RoleType roleType where roleType.rtId="+rtId_key);
				Object obj=query.uniqueResult();
				if(obj!=null){
					th.co.imake.syndome.bpm.hibernate.bean.RoleType  type=(th.co.imake.syndome.bpm.hibernate.bean.RoleType)obj;
					th.co.imake.syndome.bpm.xstream.RoleType  xtype=new th.co.imake.syndome.bpm.xstream.RoleType();
					BeanUtils.copyProperties(type, xtype);
					xtype.setPagging(null);
					logger.debug(" xtype="+xtype.getRole());
					roles.add(xtype);
				}
			}
		}
		return roles;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List listRoleTypes(Long maId) throws DataAccessException {
		// TODO Auto-generated method stub
		//String exclude="where roleType.rtId !=1 ";
		String exclude="where roleType.type !=1 ";
		//String exclude="";
		Session session=sessionAnnotationFactory.getCurrentSession();
		Query query=null;
		if(maId!=null && maId.intValue()!=0){
			 /* query=session.createQuery(" select missAccount from MissAccount missAccount where missAccount.maId=:maId ");
			  query.setParameter("maId",maId);
			 Object obj= query.uniqueResult();
			 th.co.aoe.imake.pst.hibernate.bean.MissAccount missAccount=null;
			 if(obj!=null){
				 missAccount=(th.co.aoe.imake.pst.hibernate.bean.MissAccount)obj;
				 logger.debug("maType="+missAccount.getMaType());
				 if(missAccount.getMaType()!=null && missAccount.getMaType().equals("1"))
				 	exclude="";
			 }*/
		}
		 logger.debug("exclude="+exclude);
			  query=session.createQuery(" select roleType from RoleType roleType "+exclude +" order by roleType.order ");
			List<th.co.imake.syndome.bpm.hibernate.bean.RoleType> list=query.list();
			List<th.co.imake.syndome.bpm.xstream.RoleType> roles=new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>(list.size());
			for (th.co.imake.syndome.bpm.hibernate.bean.RoleType type : list) {
				th.co.imake.syndome.bpm.xstream.RoleType xrole=new th.co.imake.syndome.bpm.xstream.RoleType();
				BeanUtils.copyProperties(type, xrole);
				xrole.setPagging(null);
				roles.add(xrole);
			}
			return roles;
	}
}
