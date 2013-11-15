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
import th.co.imake.syndome.bpm.hibernate.bean.PstWorkType;
import th.co.imake.syndome.bpm.managers.PstWorkTypeService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

@Repository
@Transactional
public class HibernatePstWorkType  extends HibernateCommon implements PstWorkTypeService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstWorkType instance) throws Exception{
		try {
			Long pdId=(instance.getPstDepartment()!=null && instance.getPstDepartment().getPdId()!=null && 
					instance.getPstDepartment().getPdId().intValue()!=-1)?instance.getPstDepartment().getPdId():null;
			String pwtName=instance.getPwtName();
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstWorkType) from PstWorkType pstWorkType ");
			
			boolean iscriteria = false;
			if(pdId !=null ){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and pstWorkType.pstDepartment.pdId="+pdId+""):(" where pstWorkType.pstDepartment.pdId="+pdId+""));
				  iscriteria = true;
			}
			if(pwtName !=null && pwtName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstWorkType.pwtName) like '%"+pwtName.trim().toLowerCase()+"%'"):(" where lcase(pstWorkType.pwtName) like '%"+pwtName.trim().toLowerCase()+"%'"));
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
	 public List searchPstWorkType(PstWorkType instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				Long pdId=(instance.getPstDepartment()!=null && instance.getPstDepartment().getPdId()!=null && 
						instance.getPstDepartment().getPdId().intValue()!=-1)?instance.getPstDepartment().getPdId():null;
				String pwtName=instance.getPwtName();
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstWorkType from PstWorkType pstWorkType ");
				
				boolean iscriteria = false;
				
				if(pdId !=null ){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and pstWorkType.pstDepartment.pdId="+pdId+""):(" where pstWorkType.pstDepartment.pdId="+pdId+""));
					  iscriteria = true;
				}
				if(pwtName !=null && pwtName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstWorkType.pwtName) like '%"+pwtName.trim().toLowerCase()+"%'"):(" where lcase(pstWorkType.pwtName) like '%"+pwtName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstWorkType."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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
	/* @SuppressWarnings("rawtypes")
	@Override
	public List listPstWorkType() throws DataAccessException {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstWorkType from PstWorkType pstWorkType ");
			 query =session.createQuery(sb.toString());
			// set pagging.
			 
			 List l = query.list();   
			return l;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return null;
	}*/

}
