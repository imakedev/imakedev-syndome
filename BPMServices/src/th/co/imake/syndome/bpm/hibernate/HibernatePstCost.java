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
import th.co.imake.syndome.bpm.hibernate.bean.PstCost;
import th.co.imake.syndome.bpm.managers.PstCostService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

@Repository
@Transactional
public class HibernatePstCost  extends HibernateCommon implements PstCostService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstCost instance) throws Exception{
		try {
			String pcUid=instance.getPcUid();
			String pcName=instance.getPcName();
			String pcType=instance.getPcType();
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstCost) from PstCost pstCost ");
			
			boolean iscriteria = false;
			
			if(pcUid !=null && pcUid.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstCost.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstCost.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pcType !=null && pcType.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and pstCost.pcType='"+pcType.trim()+"'"):(" where pstCost.pcType='"+pcType.trim()+"'"));
				  iscriteria = true;
			}
			if(pcName !=null && pcName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstCost.pcName) like '%"+pcName.trim().toLowerCase()+"%'"):(" where lcase(pstCost.pcName) like '%"+pcName.trim().toLowerCase()+"%'"));
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
	 public List searchPstCost(PstCost instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String pcUid=instance.getPcUid();
				String pcName=instance.getPcName();	
				String pcType=instance.getPcType();
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstCost from PstCost pstCost ");
				
				boolean iscriteria = false;
				
				if(pcUid !=null && pcUid.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstCost.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstCost.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pcType !=null && pcType.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and pstCost.pcType='"+pcType.trim()+"'"):(" where pstCost.pcType='"+pcType.trim()+"'"));
					  iscriteria = true;
				}
				if(pcName !=null && pcName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstCost.pcName) like '%"+pcName.trim().toLowerCase()+"%'"):(" where lcase(pstCost.pcName) like '%"+pcName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstCost."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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
