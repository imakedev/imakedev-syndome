package th.co.imake.syndome.bpm.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown;
import th.co.imake.syndome.bpm.managers.PstBreakDownService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

@Repository
@Transactional
public class HibernatePstBreakDown  extends HibernateCommon implements PstBreakDownService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstBreakDown instance) throws Exception{
		try {
			String pbdUid=instance.getPbdUid();
			String pbdName=instance.getPbdName();
			
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstBreakDown) from PstBreakDown pstBreakDown ");
			
			boolean iscriteria = false;
			
			if(pbdUid !=null && pbdUid.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstBreakDown.pbdUid) like '%"+pbdUid.trim().toLowerCase()+"%'"):(" where lcase(pstBreakDown.pbdUid) like '%"+pbdUid.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pbdName !=null && pbdName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstBreakDown.pbdName) like '%"+pbdName.trim().toLowerCase()+"%'"):(" where lcase(pstBreakDown.pbdName) like '%"+pbdName.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			
			
			  query =session.createQuery(sb.toString());
			 
				 return ((Long)query.uniqueResult()).intValue(); 
		} catch (HibernateException re) {
			logger.error("HibernateException",re);
			throw re;
		} catch (Exception e) {
			logger.error("Exception",e);
			throw e;
		}
	}
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 @Transactional(readOnly=true)
	 public List searchPstBreakDown(PstBreakDown instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String pbdUid=instance.getPbdUid();
				String pbdName=instance.getPbdName();
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstBreakDown from PstBreakDown pstBreakDown ");
				
				boolean iscriteria = false;

				if(pbdUid !=null && pbdUid.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstBreakDown.pbdUid) like '%"+pbdUid.trim().toLowerCase()+"%'"):(" where lcase(pstBreakDown.pbdUid) like '%"+pbdUid.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pbdName !=null && pbdName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstBreakDown.pbdName) like '%"+pbdName.trim().toLowerCase()+"%'"):(" where lcase(pstBreakDown.pbdName) like '%"+pbdName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstBreakDown."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
				}			
				 query =session.createQuery(sb.toString());
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
				 
			}
			return transList;
		}

}
