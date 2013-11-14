package th.co.aoe.imake.pst.hibernate;

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

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.hibernate.bean.PstDepartment;
import th.co.aoe.imake.pst.managers.PstDepartmentService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
@Repository
@Transactional
public class HibernatePstDepartment  extends HibernateCommon implements PstDepartmentService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstDepartment instance) throws Exception{
		try {
			/*String pcUid=instance.getPcUid(); */
			String pdName=instance.getPdName();
			
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstDepartment) from PstDepartment pstDepartment ");
			
			boolean iscriteria = false;
			
			/*if(pcUid !=null && pcUid.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstDepartment.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstDepartment.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			*/
			if(pdName !=null && pdName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstDepartment.pdName) like '%"+pdName.trim().toLowerCase()+"%'"):(" where lcase(pstDepartment.pdName) like '%"+pdName.trim().toLowerCase()+"%'"));
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
	 public List searchPstDepartment(PstDepartment instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				/*String pcUid=instance.getPcUid();
				String pcName=instance.getPcName();*/
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstDepartment from PstDepartment pstDepartment ");
				String pdName=instance.getPdName();
				/* */boolean iscriteria = false;
				
				/*if(pcUid !=null && pcUid.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstDepartment.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstDepartment.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}*/
				if(pdName !=null && pdName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstDepartment.pdName) like '%"+pdName.trim().toLowerCase()+"%'"):(" where lcase(pstDepartment.pdName) like '%"+pdName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstDepartment."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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
	 @SuppressWarnings("rawtypes")
	@Override
	public List listPstDepartment() throws DataAccessException {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstDepartment from PstDepartment pstDepartment ");
			 query =session.createQuery(sb.toString());
			// set pagging.
			 
			 List l = query.list();   
			return l;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return null;
	}


}
